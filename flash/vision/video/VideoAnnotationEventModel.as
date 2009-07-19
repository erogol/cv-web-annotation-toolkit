﻿/********************************************************************** Software License Agreement (BSD License)**  Copyright (c) 2008, University of Illinois at Urbana-Champaign*  All rights reserved.**  Redistribution and use in source and binary forms, with or without*  modification, are permitted provided that the following conditions*  are met:**   * Redistributions of source code must retain the above copyright*     notice, this list of conditions and the following disclaimer.*   * Redistributions in binary form must reproduce the above*     copyright notice, this list of conditions and the following*     disclaimer in the documentation and/or other materials provided*     with the distribution.*   * Neither the name of the University of Illinois nor the names of its*     contributors may be used to endorse or promote products derived*     from this software without specific prior written permission.**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE*  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;*  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER*  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT*  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN*  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE*  POSSIBILITY OF SUCH DAMAGE.*********************************************************************//***** Author: Alexander Sorokin, Department of Computer Science,*                                  University of Illinois at Urbana-Champaign.* Advised by: David Forsyth.*****/package vision.video{	import flash.events.Event;	import fl.data.DataProvider;	dynamic public class VideoAnnotationEventModel	{		var ref_id;		var event_xml:XML;		function VideoAnnotationEventModel()		{			ref_id=null;			event_xml=XML(<event/>);		}				public function get_xml():XML{			return event_xml;		}		public function set_xml(xml:XML):void{			event_xml=xml;		}				public function set_start_time(st):void{			event_xml.start_time.@time[0]=st;		}		public function set_end_time(et):void{			event_xml.end_time.@time[0]=et;		}		public function set_annotation(a:XML):void{			event_xml.annotation[0]=a;		}		public function get_annotation():XML{			return event_xml.annotation[0];		}		public function get_start_time():Number{			return Number(event_xml.start_time.@time[0]);		}		public function get_end_time():Number{			return Number(event_xml.end_time.@time[0]);		}				public function get_ref_id():Object{			return ref_id;		}		public function set_ref_id(o:Object):void{			ref_id=o;		}				public function is_active(t:Number):Boolean{			if(t<get_start_time())				return false;			if(t>get_end_time())				return false;			return true;		}	}}