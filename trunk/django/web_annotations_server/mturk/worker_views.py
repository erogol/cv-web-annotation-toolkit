#***********************************************************
#* Software License Agreement (BSD License)
#*
#*  Copyright (c) 2008, Willow Garage, Inc.
#*  All rights reserved.
#*
#*  Redistribution and use in source and binary forms, with or without
#*  modification, are permitted provided that the following conditions
#*  are met:
#*
#*   * Redistributions of source code must retain the above copyright
#*     notice, this list of conditions and the following disclaimer.
#*   * Redistributions in binary form must reproduce the above
#*     copyright notice, this list of conditions and the following
#*     disclaimer in the documentation and/or other materials provided
#*     with the distribution.
#*   * Neither the name of the Willow Garage nor the names of its
#*     contributors may be used to endorse or promote products derived
#*     from this software without specific prior written permission.
#*
#*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
#*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
#*  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
#*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
#*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#*  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#*  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
#*  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
#*  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#*  POSSIBILITY OF SUCH DAMAGE.
#***********************************************************

import numpy
import datetime
from decimal import Decimal

from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render_to_response,get_object_or_404 

from models import *
from common import *

import ros_integration


def advance_next_check_time(training_progress):
    """Compute, when the next validation item will be shown"""
    if training_progress.next_check>=0 and training_progress.next_check < training_progress.num_normal_submissions:
        return

    position=numpy.random.poisson(training_progress.gold_qual.random_check_frequency)
    if training_progress.next_check == -1: #unset
        training_progress.next_check = position;
    else:
        training_progress.next_check += position;
    training_progress.save()


def select_workitem_from_gold(session,worker):
    """Pick the gold workitem if necessary. There are two reasons to pick a gold item: 
        * The worker hasn't done minimum required gold items
        * It's time to show the random sampled work item
    """

    gold_workitem=None
    if session.gold_standard_qualification is None:
        print "No gold standard qualification"
        return None

    gold_qual = session.gold_standard_qualification

    (training_progress,created)=WorkerTrainingProgress.objects.get_or_create(worker=worker,gold_qual=gold_qual);
    if created:
        advance_next_check_time(training_progress);
        training_progress.save();

    if training_progress.num_gold_submissions < gold_qual.num_gold_initial:
        print "Picking initial tasks"
        return pick_random_workitem_for_worker(gold_qual.gold_session,worker)
    else:
        if training_progress.next_check <= training_progress.num_normal_submissions:
            advance_next_check_time(training_progress);
            return pick_random_workitem_for_worker(gold_qual.gold_session,worker)

    return None

def pick_random_workitem_for_worker(gold_session,worker):
    return select_new_gold_workitem(gold_session.id,worker.worker);


def substitute_workitem(worker,task,gold_workitem):
    ttl=datetime.datetime.now()+datetime.timedelta(seconds=2*gold_workitem.session.task_def.duration)
    item_sub=ItemSubstitution(worker=worker,requested_item=task,shown_item=gold_workitem,expires=ttl,state=1);
    item_sub.save();

def finalize_item_substitution(workitem,worker):
    item_substitutions=ItemSubstitution.objects.filter(worker=worker,shown_item=workitem,state=1);
    if len(item_substitutions)==0:
        return 
    item_sub=item_substitutions[0];
    item_sub.state=2;
    item_sub.save();

def grade_submission_with_gold(gold_session,submission,worker):
    te=gold_session.task_def.type.get_engine();
    submission_grade = te.grade(submission,gold_session);
    rcd=GoldStandardGradeRecord(gold_session=gold_session,worker=worker,workitem=submission.hit,submission=submission,grade=str(submission_grade));
    rcd.save();

    qual=GoldStandardQualification.objects.get(gold_session=gold_session);

    (training_progress,created)=WorkerTrainingProgress.objects.get_or_create(worker=worker,gold_qual=qual);
    if created:
        advance_next_check_time(training_progress);

    training_progress.num_gold_submissions += Decimal("1.0")
    training_progress.grade_total += Decimal(str(submission_grade))
    training_progress.grade_average = training_progress.grade_total / training_progress.num_gold_submissions

    if qual.passing_submission_grade<=submission_grade:
        training_progress.num_passing_submissions += 1

    training_progress.save();

def check_submission_for_progress(session,submisison,worker):
    qual=session.gold_standard_qualification
    if qual is None:
        return

    (training_progress,created)=WorkerTrainingProgress.objects.get_or_create(worker=worker,gold_qual=qual);
    if created:
        advance_next_check_time(training_progress);

    training_progress.num_normal_submissions += 1
    training_progress.save();

def get_task_page(request,session_code):
    session = get_object_or_404(Session,code=session_code)

    task_id=None
    try:
        if 'ExtID' in request.REQUEST:
            task_id=request.REQUEST['ExtID']
        else:
            task_id=request.REQUEST['extid']
    except:
        if 'extid' in request.REQUEST:
            task_id=request.REQUEST['extid']

    workitem = get_object_or_404(MTHit,ext_hitid=task_id)

    if "workerId" in request.REQUEST:
        worker_id=request.REQUEST["workerId"]
        print worker_id
        (worker,created)=Worker.objects.get_or_create(session=None,worker=worker_id)
        if created:
            worker.save();
        if worker.utility<settings.MTURK_BLOCK_WORKER_MIN_UTILITY:
            return render_to_response('mturk/not_available.html');

        exclusions=check_session_exclusions(worker,session);
        if len(exclusions)>0:
            reasons="";
            for e in exclusions:
                reasons += e[1];
                break;
            return render_to_response('mturk/not_available_excluded.html',{'reason':reasons} );
    else:
        worker=None

    if workitem is None:
    	return render_to_response('mturk/not_available.html');

    #See, if we need to use the gold task
    if worker:
        gold_workitem=select_workitem_from_gold(session,worker);
        if gold_workitem:
            substitute_workitem(worker,workitem,gold_workitem);
            workitem=gold_workitem;

    te=workitem.session.task_def.type.get_engine();
    url=te.get_task_page_url(workitem,request);

    for k,v in request.GET.items():	
        if k=='ExtID' or k=='extid':
            v=workitem.ext_hitid
        url=url+"&"+k+"="+v

    if worker:
        url+="&feedback_url=/mt/gpa/%s/%s/" % (session.code,worker.worker);

    final_url=url;
    return HttpResponseRedirect(final_url)	



def submit_result(request):

    try:
        task_id=""
        if 'ExtID' in request.REQUEST:
            task_id=request.REQUEST['ExtID']
        if task_id=="" and 'extid' in request.REQUEST:
            task_id=request.REQUEST['extid']
    except:
        if 'extid' in request.REQUEST:
            task_id=request.REQUEST['extid']

    workitem = get_object_or_404(MTHit,ext_hitid=task_id)

    #The HIT can belong to some other session
    session = workitem.session;
    session_code=session.code;

    workerId=request.REQUEST['workerId'];
    if workerId=="":
        workerId=request.user.username;
    assignmentId=request.REQUEST['assignmentId'];

    postS=pickler.dumps((request.GET,request.POST))    
    submission=SubmittedTask(hit=workitem,session_id=session.id,worker=workerId,assignment_id=assignmentId, response=postS);
    submission.save();


    if 'hitId' in request.REQUEST:
        mturk_hit_id=request.REQUEST['hitId']
        try:
            mthit=MechTurkHit.object.get(mechturk_hit_id=mturk_hit_id);
        except:
            mthit=None;
        if mthit:
            mthit.state=2; #Review
            mthit.save();

    session.task_def.type.get_engine().on_submit(submission);

    #num_possibly_valid_submissions=SubmittedTask.objects.filter(hit=workitem,valid=True).count();
    #if num_possibly_valid_submissions>=workitem.get_num_required_submissions():
    workitem.state=2; #Submitted
    workitem.save()

    print "ROS ON SUBMISSION"
    ros_integration.on_submission(submission)

    (worker,created)=Worker.objects.get_or_create(session=None,worker=workerId)
    if created:
        worker.save();
        
    print "GOLD?",session.is_gold,session.code

    if session.is_gold:
        print "GOLD"
        finalize_item_substitution(workitem,worker)
        grade_submission_with_gold(session,submission,worker)
    else:
        check_submission_for_progress(session,submission,worker)
            

    if session.standalone_mode:
        return HttpResponseRedirect("/mt/get_task/"+session.code+"/" );

    if session.sandbox:
	submit_target="http://workersandbox.mturk.com/mturk/externalSubmit"
    else:
	submit_target="http://www.mturk.com/mturk/externalSubmit"
	
    return render_to_response('mturk/after_submit.html',
	{'submit_target':submit_target,
  	'extid': workitem.ext_hitid, 'workerId':workerId,
	'assignmentId':assignmentId   });


def get_submission_data_xml(request,id=None,ext_hitid=None):
    submission = get_object_or_404(SubmittedTask,id=int(id))
	
    str_response=submission.get_xml_str();

    return HttpResponse(str_response,mimetype="text/xml");


def get_task_parameters(request,task_name):
    task = get_object_or_404(Task,name=task_name)
    return HttpResponse(task.interface_xml,mimetype="text/xml");

def send_hit_parameters(request,ext_id):
    hit = get_object_or_404(MTHit,ext_hitid=ext_id)
    if hit.parameters.startswith("<?xml"):
        return HttpResponse(hit.parameters,mimetype="text/xml");
    else:
        return HttpResponse(hit.parameters,mimetype="text/plain");

def show_worker_gpa(request,session_code,worker_id):
    session = get_object_or_404(Session,code=session_code)

    qual=session.gold_standard_qualification
    if qual is None:
        return render_to_response('mturk/gpa/inline_blank.html')

    (worker,worker_created)=Worker.objects.get_or_create(session=None,worker=worker_id)
    if worker_created:
        return render_to_response('mturk/gpa/inline_blank.html')

    (progress,progress_created)=WorkerTrainingProgress.objects.get_or_create(worker=worker,gold_qual=qual);
    if progress_created:
        return render_to_response('mturk/gpa/inline_blank.html')

    try:
        last_grade=GoldStandardGradeRecord.objects.filter(gold_session=qual.gold_session, worker=worker).order_by('-id')[0];
    except IndexError:
        last_grade=None

    return render_to_response('mturk/gpa/inline_worker_gpa.html',{'progress':progress,'last_grade':last_grade,'qualification':qual})

