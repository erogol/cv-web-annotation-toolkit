﻿/********************************************************************** Software License Agreement (BSD License)**  Copyright (c) 2008, University of Illinois at Urbana-Champaign*  All rights reserved.**  Redistribution and use in source and binary forms, with or without*  modification, are permitted provided that the following conditions*  are met:**   * Redistributions of source code must retain the above copyright*     notice, this list of conditions and the following disclaimer.*   * Redistributions in binary form must reproduce the above*     copyright notice, this list of conditions and the following*     disclaimer in the documentation and/or other materials provided*     with the distribution.*   * Neither the name of the University of Illinois nor the names of its*     contributors may be used to endorse or promote products derived*     from this software without specific prior written permission.**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE*  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;*  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER*  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT*  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN*  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE*  POSSIBILITY OF SUCH DAMAGE.*********************************************************************//***** Author: Alexander Sorokin, Department of Computer Science,*                                  University of Illinois at Urbana-Champaign.* Advised by: David Forsyth.*****/package vision{					import flash.display.*;		//import flash.display.Shape;	import fl.controls.Label;	import flash.events.MouseEvent;	import flash.events.Event;	import flash.geom.Rectangle;	import flash.text.*;	 	 dynamic public class BBox2InputToken extends MovieClip	 {		var all_colors:Array=new Array();		var box_points:Array=new Array();		 		 		 //public var m_lbl;		 //var last_object_id;		 var rootObj;		 		 public var min_size:int;		 public var all_controls:Array;		 		 function BBox2InputToken()		 {						all_colors.push(0xFFD700);			all_colors.push(0x0000CC);			all_colors.push(0xFF0000);			all_colors.push(0x00FFD7);			m_input_btn.addEventListener(MouseEvent.CLICK, this.shapeADD);			min_size=-1;						all_controls=new Array();		 }		public function enable_edit():void{		}		public function disable_edit():void{			for(var iC=0;iC<all_controls.length;iC++){				all_controls[iC].disable_edit();							} 		}		 public function set_root(newRootObj):void{			 this.rootObj=newRootObj;		 }		 		 function shapeADD(event:Event):void		 {			 //clear active marker			if(rootObj.active_marker!=null){				rootObj.active_marker.removeEditMode();				rootObj.active_marker=null;			}			this.parent.visible=false;			rootObj.last_object_id=rootObj.last_object_id+1;			var newShape:BBox2Input= new BBox2Input();			newShape.set_root(rootObj);			newShape.lineColor=this.all_colors[rootObj.last_object_id % all_colors.length];			newShape.x=0;//the_sites_holder.x;			newShape.y=0;//the_sites_holder.y;			var shapeLabel=m_input_btn.label+"_"+rootObj.last_object_id.toString();			newShape.label=shapeLabel;			newShape.data=shapeLabel;			newShape.bbox=null;			newShape.min_size=min_size;						rootObj.the_sites_holder.addChild(newShape);			if(this.parent==rootObj.m_input_specs){				rootObj.shapesListBox.addItem(newShape);			}			rootObj.all_shapes.push(newShape);			newShape.baseImage=rootObj.the_image;			//makeActive(newShape);			newShape.addEventListener("my_input_finished", onBox_InputFinished);			newShape.detail_object=null;									all_controls.push(newShape);		}				var bX,bY,bW,bH;		function onBox_InputFinished(event:Event):void		{			this.parent.visible=true;					}				 public function set_name(obj_name:String)		 {			 m_input_btn.label=obj_name;		 }			 public function get_xml_annotation():String		{			var xmlStr:String="";			xmlStr+="<bbox2tk name='"+ m_input_btn.label +"'>";			for(var iC=0;iC<all_controls.length;iC++){				xmlStr+=all_controls[iC].get_xml_annotation();							}			xmlStr+="</bbox2tk>";			return xmlStr;		}		 		public function add_xml_annotation(definition:XML):void{			var bbox2xml=definition.bbox2;			for each(var o in bbox2xml){				var newShape:BBox2Input= new BBox2Input();				newShape.set_xml_annotation(o);								rootObj.the_sites_holder.addChild(newShape);				if(this.parent==rootObj.m_input_specs){					rootObj.shapesListBox.addItem(newShape);				}				newShape.baseImage=rootObj.the_image;				newShape.setDisplayMode();				newShape.detail_object=null;										all_controls.push(newShape);			}		}	 } }