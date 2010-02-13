﻿/********************************************************************** Software License Agreement (BSD License)**  Copyright (c) 2008, University of Illinois at Urbana-Champaign*  All rights reserved.**  Redistribution and use in source and binary forms, with or without*  modification, are permitted provided that the following conditions*  are met:**   * Redistributions of source code must retain the above copyright*     notice, this list of conditions and the following disclaimer.*   * Redistributions in binary form must reproduce the above*     copyright notice, this list of conditions and the following*     disclaimer in the documentation and/or other materials provided*     with the distribution.*   * Neither the name of the University of Illinois nor the names of its*     contributors may be used to endorse or promote products derived*     from this software without specific prior written permission.**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE*  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;*  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER*  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT*  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN*  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE*  POSSIBILITY OF SUCH DAMAGE.*********************************************************************//***** Author: Alexander Sorokin, Department of Computer Science,*                                  University of Illinois at Urbana-Champaign.* Advised by: David Forsyth.*****/package vision{	import flash.display.*;	import fl.controls.Label;	import flash.text.TextField;	import flash.events.MouseEvent;	import flash.events.Event;	import flash.ui.Mouse;	import flash.geom.Point;	import flash.geom.Rectangle;	import flash.text.*;	import vision.ResizeMarker;	import vision.ClickArea;	dynamic public class PolygonalDisplay extends MovieClip	{		static const IDLE:String = "idle";		static const EDITING:String = "edit";		static const READY:String = "ready";		static const DISPLAY:String = "display";		static const SELECTION:String = "select";		var ptsX:Array;		var ptsY:Array;		var ptsTime:Array;		var ptTags:Array;		var numPts:Number;		var thePolygon:Sprite;		var thePS:Sprite;		var hitTime:Number;		var now:Date;		var makeActive;		var lineColor;				var allow_edit;		var allow_selection;				var rootObj;		var tag=null;		var Mode=READY;		var object_name;		var object_sqn;		var number_control_points:Boolean;		var tag_font_size:Number;		//lblRemoveLast.visible=true;		var colors;		var show_tag:Boolean;				var resize_markers;		//btnRemoveLast.visible=false;		//var pdClickArea:vision.ClickArea;						function PolygonalDisplay() {			now = new Date();			hitTime=now.getTime();						m_edit_ctrl.btnRemoveLast.visible=false;			m_edit_ctrl.btnCancel.visible=false;						allow_edit=false;			rootObj=null;			ptsX=new Array();			ptsY=new Array();			ptsTime = new Array();			ptTags=new Array();			numPts=0;			thePolygon=new Sprite();			this.addChild(thePolygon);			this.show_tag=true;			this.m_edit_ctrl.m_label.visible=this.show_tag;			this.m_edit_ctrl.m_label2.visible=false;			this.m_edit_ctrl.m_label3.visible=false;			this.m_edit_ctrl.btnDone.visible=false;			this.allow_edit=true;			this.allow_selection=false;			this.default_mode = PolygonalDisplay.IDLE;			btnFinishShape.addEventListener(MouseEvent.CLICK, onFinishShapeClick);			btnFinishShape.visible=false;			pdClickArea.addEventListener(MouseEvent.CLICK, handleRegularClick);			this.pdClickArea.visible=false;						//pdClickArea.x=pdClickArea.x+Math.round(Math.random()*30);			m_edit_ctrl.btnRemoveLast.addEventListener(MouseEvent.CLICK, onRemoveLastSegmentClick);			m_edit_ctrl.btnCancel.addEventListener(MouseEvent.CLICK, onCancelClick);			m_edit_ctrl.btnCancel.visible=true;			/*			pdClickArea.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);			            pdClickArea.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);			*/			//cursor = new CustomCursor();			//addChild(cursor);			m_mark_cursor.visible=false;			pdClickArea.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);			//pdClickArea.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);			resize_markers=new Array();			number_control_points=false;			tag_font_size=55;			colors=[0x157FE7,0x0004F3,0xF0AE40,0x39ECA2			,0x4FE6EB,0x5617E9,0x5A6E6E,0x6A9B82			,0xE649D6,0x8387DD,0x4DBF93,0xA7650D			,0xE5C82E,0xB46EA4,0x5BB4A3,0xF9C76B			,0xC0F32E,0x3CFE2E,0xFF0F8C,0x659F72			,0x1D9001,0x43627F,0xFCCACF,0x8187D6			,0xF5C5F2,0x624ACC,0x2D7516,0x88EAB9			,0xF1AFD2,0x7CA082,0x3087CB,0xF9E2F2			,0xA10EB0,0x1183BB,0xF43FE3,0x3EF24D			,0x1A68EC,0x40CA6A,0xF7137D,0x7CE5B6			,0xC9DB5A,0x61F51F,0xEACBD7,0x14A19F			,0x9825ED,0xAAA840,0x55ED5E,0x9E7421			,0x9C0989,0x23FAD1,0xA4CF04,0x3872C1			,0xD7ABB4,0xC4745A,0x8F4971,0xDFDF7D			,0x5D0161,0x52FB8A,0x4AB3B1,0x645C84			,0x5B9AC1,0xE17486,0x8CDA5E,0xA4C3E7			,0xFE8F0B,0x40FC3D,0x0D2CF2,0x786878			,0x98788B,0xD17D54,0x9CBFD0,0x0399A4			,0xB466EF,0xF9205A,0x77ECB0,0xEADE31			,0x0DD124,0x7E2A5C,0x64AFC6,0x4ED5A5			,0xCC4F32,0x11541B,0x3F4299,0xD47BB1			,0x22F163,0x000662,0x3C61C7,0x994FB9			,0x64A88D,0x34191B,0xD01379,0xD13827			,0x261DCC,0xD25FB3,0x824F23,0x09957B			,0x55E1A4,0x4A46B3,0x4F1764,0x3BDC8C];		}		public function setMode(new_mode:String) {			this.Mode=new_mode;			if (this.Mode == PolygonalDisplay.DISPLAY || this.Mode==PolygonalDisplay.SELECTION) {				m_edit_ctrl.visible=false;			} else {				m_edit_ctrl.visible=true;			}		}		private function mouseOverHandler(event:MouseEvent):void {			if (this.Mode == this.DISPLAY) {				return;			}			//trace("mouseOverHandler");			//Mouse.hide();			//if(m_mark_cursor!=null){			//m_mark_cursor.visible=true;			//}			//pdClickArea.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);		}		private function mouseOutHandler(event:MouseEvent):void {			if (this.Mode == this.DISPLAY) {				return;			}			//trace("mouseOutHandler");			//Mouse.show();			//if(m_mark_cursor!=null){			//m_mark_cursor.visible=false;			//}			//pdClickArea.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);			//cursor.visible = false;		}		private function mouseLeaveHandler(event:Event):void {			if (this.Mode == this.DISPLAY) {				return;			}			//trace("mouseLeaveHandler");			mouseOutHandler(new MouseEvent(MouseEvent.MOUSE_MOVE));		}		private function mouseMoveHandler(event:MouseEvent):void {			if (this.Mode == this.DISPLAY) {				return;			}			//trace("mouseMoveHandler");			var p2:Point=pdClickArea.globalToLocal(new Point(event.stageX,event.stageY));			m_mark_cursor.move(p2.x,p2.y);			event.updateAfterEvent();			m_mark_cursor.visible = true;		}		public function set_root(newRootObj):void {			this.rootObj=newRootObj;			var do_numbers_str=this.rootObj.getParameters().getParam_Boolean("/taskdef/polygonal_display/number_control_points",false);			this.show_tag=this.rootObj.getParameters().getParam_Boolean("/taskdef/polygonal_display/show_object_tag",true);			if (this.tag) {				tag.visible=show_tag;			}			this.m_edit_ctrl.m_label.visible=this.show_tag;			tag_font_size=Number(this.rootObj.getParameters().getParam("/taskdef/polygonal_display/tag_font_size","55"));		}		public function enable_edit():void {			pdClickArea.visible=true;			if (allow_edit==false) {				setMode(PolygonalDisplay.EDITING);				allow_edit=true;				m_edit_ctrl.btnCancel.visible=false;				thePolygon.addEventListener(MouseEvent.CLICK,onBoxDoubleClick);				btnFinishShape.addEventListener(MouseEvent.CLICK, onFinishShapeClick);				pdClickArea.addEventListener(MouseEvent.CLICK, handleRegularClick);				m_edit_ctrl.btnRemoveLast.addEventListener(MouseEvent.CLICK, onRemoveLastSegmentClick);				m_edit_ctrl.btnCancel.addEventListener(MouseEvent.CLICK, onCancelClick);				pdClickArea.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);				pdClickArea.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);			}		}		public function enable_edit2():void {			disable_edit();			this.allow_edit=true;			this.allow_selection=true;			this.default_mode = PolygonalDisplay.SELECTION;			setMode(PolygonalDisplay.SELECTION);			thePolygon.addEventListener(MouseEvent.CLICK,onBoxDoubleClick);			//pdClickArea.removeListener(MouseEvent.CLICK, handleRegularClick);			pdClickArea.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);			pdClickArea.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);		}				public function disable_edit():void {			pdClickArea.visible=false;			allow_edit=false;			try {				Mouse.show();				if (m_mark_cursor!=null) {					m_mark_cursor.visible=false;				}				m_edit_ctrl.btnCancel.visible=false;				thePolygon.removeEventListener(MouseEvent.CLICK,onBoxDoubleClick);				btnFinishShape.removeEventListener(MouseEvent.CLICK, onFinishShapeClick);				pdClickArea.removeEventListener(MouseEvent.CLICK, handleRegularClick);				m_edit_ctrl.btnRemoveLast.removeEventListener(MouseEvent.CLICK, onRemoveLastSegmentClick);				m_edit_ctrl.btnCancel.removeEventListener(MouseEvent.CLICK, onCancelClick);				pdClickArea.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);				pdClickArea.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);				thePolygon.removeEventListener(MouseEvent.CLICK,onBoxDoubleClick);				pdClickArea.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);			} catch (e) {			}		}		function onBoxDoubleClick(event:MouseEvent):void {			if (!allow_edit) {				return;			}			if (rootObj.active_marker!=null) {				rootObj.active_marker.removeEditMode();				rootObj.active_marker=null;			}			this.setEditMode();			rootObj.active_marker=this;		}				public function setEditMode():void {			m_edit_ctrl.visible=true; 						this.m_edit_ctrl.btnDone.visible=true;			this.m_edit_ctrl.btnDone.addEventListener(MouseEvent.CLICK,onDoneClick);						//btnFinishShape.addEventListener(MouseEvent.CLICK, onFinishShapeClick);			//btnCancel.addEventListener(MouseEvent.CLICK, onCancelClick);						resize_markers=new Array();			for (var iPt=1; iPt<=this.numPts; iPt++) {				var m1=new vision.ResizeMarker();				m1.x=ptsX[iPt];				m1.y=ptsY[iPt];				m1.idx=iPt;				resize_markers.push(m1);				m1.addEventListener("my_resize_marker_move", on_resize_marker_move);				this.thePolygon.parent.addChild(m1);			}			var start_edit_event:Event = new Event("my_start_edit_mode");			this.dispatchEvent(start_edit_event);		}				public function removeEditMode():void {			pdClickArea.visible=false;			m_edit_ctrl.visible=false;			this.m_edit_ctrl.btnDone.visible=false;			this.m_edit_ctrl.btnDone.removeEventListener(MouseEvent.CLICK,onDoneClick);			btnFinishShape.removeEventListener(MouseEvent.CLICK, onFinishShapeClick);			m_edit_ctrl.btnCancel.removeEventListener(MouseEvent.CLICK, onCancelClick);						var l=this.resize_markers.length;			for (var iPt=0; iPt<l; iPt++) {				this.thePolygon.parent.removeChild(resize_markers.pop());			}			var finish_edit_event:Event = new Event("my_finish_edit_mode");			this.dispatchEvent(finish_edit_event);		}		public function on_resize_marker_move(event:Event):void {			var m=vision.ResizeMarker(event.target);			ptsX[m.idx]=m.x;			ptsY[m.idx]=m.y;			redraw_this();			if (number_control_points) {				movePointTag(m.idx);			}		}		function redraw_this():void {			this.thePolygon.graphics.clear();			var lw=this.rootObj.get_default_line_width();			this.thePolygon.graphics.lineStyle(lw, lineColor, 1, false, LineScaleMode.VERTICAL,			                               CapsStyle.NONE, JointStyle.MITER, 10);			this.thePolygon.graphics.moveTo(ptsX[1], ptsY[1]);			if (number_control_points) {				movePointTag(1);			}			if (this.numPts>1) {				for (var i=2; i<=this.numPts; i++) {					this.thePolygon.graphics.lineTo(this.ptsX[i], this.ptsY[i]);					if (number_control_points) {						movePointTag(i);					}				}			}			thePolygon.graphics.beginFill(lineColor, 0);			this.thePolygon.graphics.moveTo(ptsX[1], ptsY[1]);			if (this.numPts>1) {				for (var i=2; i<=this.numPts; i++) {					this.thePolygon.graphics.lineTo(this.ptsX[i], this.ptsY[i]);				}			}			//this.thePolygon.graphics.moveTo(ptsX[1], ptsY[1]);			thePolygon.graphics.endFill();			thePolygon.graphics.beginFill(0, 0);			thePolygon.graphics.endFill();			if (tag!=null) {				tag.x=ptsX[1];				tag.y=ptsY[1];				tag.visible=show_tag;			}		}				function onFinishShapeClick(event:MouseEvent):void {			this.pdClickArea.visible=false;						//numPts++;			//ptsX[numPts]=event.localX;			//ptsY[numPts]=event.localY;			var now:Date = new Date();			this.hitTime=now.getTime();			thePolygon.graphics.lineTo(ptsX[1], ptsY[1]);			if (this.allow_selection) {				this.Mode=SELECTION;			} else {				this.Mode=IDLE;			}			btnFinishShape.visible=false;			this.visible=false;						m_edit_ctrl.btnRemoveLast.visible=false;			//lblRemoveLast.visible=false;			pdClickArea.visible=false;			//this.visible=false;			rootObj.clear_error();			var done_event:Event = new Event("my_input_finished");			this.dispatchEvent(done_event);			redraw_this();			disable_edit();			//event.updateAfterEvent();			trace(event.currentTarget.toString() + "Finish");		}				function onCancelClick(event:MouseEvent):void {			rootObj.clear_error();			if (this.allow_selection) {				this.Mode=SELECTION;			} else {				this.Mode=IDLE;			}			btnFinishShape.visible=false;						m_edit_ctrl.btnRemoveLast.visible=false;			m_edit_ctrl.btnCancel.visible=false;			var done_event:Event = new Event("my_input_cancelled");			this.dispatchEvent(done_event);			redraw_this();			disable_edit();			//event.updateAfterEvent();			trace(event.currentTarget.toString() + "Cancel");		}		public function onDoneClick(event:MouseEvent):void{			var done_event:Event = new Event("my_input_finished");    		this.dispatchEvent(done_event);					disable_edit();			removeEditMode();			if (this.allow_selection) {				enable_edit2();				this.Mode=SELECTION;			}					}		function handleRegularClick(event:MouseEvent):void {			if (this.Mode==IDLE) {				trace("Idle");			} else if (this.Mode==READY) {				pdClickArea.addChild(btnFinishShape);				btnFinishShape.x=event.localX;				btnFinishShape.y=event.localY;				btnFinishShape.visible=true;								m_edit_ctrl.btnRemoveLast.visible=true;				//lblRemoveLast.visible=true;				this.Mode=EDITING;				thePolygon.graphics.clear();				var lw=this.rootObj.get_default_line_width();				thePolygon.graphics.lineStyle(lw, lineColor, 1, false, LineScaleMode.VERTICAL,				                               CapsStyle.NONE, JointStyle.MITER, 10);				numPts++;				ptsX[numPts]=event.localX;				ptsY[numPts]=event.localY;				var now:Date = new Date();				ptsTime[numPts]=now.getTime();				thePolygon.graphics.moveTo(event.localX, event.localY);				if (number_control_points) {					addPointTag();				}			} else if (this.Mode==SELECTION) {			} else {				numPts++;				ptsX[numPts]=event.localX;				ptsY[numPts]=event.localY;				var now:Date = new Date();				ptsTime[numPts]=now.getTime();				if (number_control_points) {					addPointTag();				}				thePolygon.graphics.lineTo(event.localX, event.localY);				trace(event.currentTarget.toString() + 				" dispatches MouseEvent. Local coords [" + 				event.localX + "," + event.localY + "] Stage coords [" + 				event.stageX + "," + event.stageY + "]");			}			trace(event.currentTarget.toString() + 			" dispatches MouseEvent. Local coords [" + 			event.localX + "," + event.localY + "] Stage coords [" + 			event.stageX + "," + event.stageY + "]");			var now:Date = new Date();			this.hitTime=now.getTime();		}		function onRemoveLastSegmentClick(event:MouseEvent):void {			if (this.Mode == EDITING) {				var now:Date = new Date();				this.hitTime=now.getTime();				this.thePolygon.graphics.clear();				var lw=this.rootObj.get_default_line_width();				thePolygon.graphics.lineStyle(lw, lineColor, 1, false, LineScaleMode.VERTICAL,				                               CapsStyle.NONE, JointStyle.MITER, 10);				if (this.numPts>1) {					this.numPts--;					this.thePolygon.graphics.moveTo(ptsX[1], ptsY[1]);					if (this.numPts>1) {						for (var i=2; i<=this.numPts; i++) {							this.thePolygon.graphics.lineTo(this.ptsX[i], this.ptsY[i]);						}					}					if (number_control_points) {						removePointTag(this.numPts-1);					}				} else if (this.numPts==1) {					this.numPts=0;					this.Mode=READY;				}			}		}		public function read_xml_annotation(annotation:XML):void {			var pts=annotation.pt;			ptsX=new Array();			ptsY=new Array();			ptsTime = new Array();			numPts=0;			thePolygon= new Sprite();			var iC=Math.floor(Math.random()*colors.length);			var lineColor=colors[iC];			var lw=this.rootObj.get_default_line_width();			thePolygon.graphics.lineStyle(lw, lineColor, 1, false, LineScaleMode.VERTICAL,			   CapsStyle.NONE, JointStyle.MITER, 10);			this.addChild(thePolygon);			for (var p in pts) {				numPts++;				ptsX[numPts]=parseFloat(pts[p].@x);				ptsY[numPts]=parseFloat(pts[p].@y);								ptsTime[numPts]=pts[p].ct;				if (p=="0") {					thePolygon.graphics.moveTo(ptsX[numPts], ptsY[numPts]);				} else {					thePolygon.graphics.lineTo(ptsX[numPts], ptsY[numPts]);				}				if (number_control_points) {					addPointTag();				}			}			thePolygon.graphics.lineTo(ptsX[1], ptsY[1]);			var tag:TextField=new TextField();			this.object_sqn = annotation.@sqn;			this.set_object_name(annotation.@name);			tag.text=annotation.@name;			tag.opaqueBackground=0xFFFFFF;			//this is ok			//tag.opaqueBackground=lineColor;			//tag.textColor=0xFFFFFF ^ lineColor;			//this is really bad			//tag.borderColor=lineColor;			//tag.border=true;			//tag.border			tag.autoSize=TextFieldAutoSize.RIGHT;			//poly_input.tag=tag;			var lx=ptsX[1];			var ly=ptsY[1];			tag.visible=this.show_tag;			this.addChild(tag);			tag.x=lx-tag.width/2;			tag.y=ly-tag.height/2;		}		public function movePointTag(i:Number):void {			var tmptag:TextField=ptTags[i];			if (tmptag==null) {				return;			}			tmptag.x=ptsX[i];			tmptag.y=ptsY[i];		}		public function removePointTag(i:Number):void {			var tmptag:TextField=ptTags[i];			if (tmptag==null) {				return;			}			this.pdClickArea.removeChild(tmptag);			ptTags.pop();		}		public function addPointTag():void {			var tmptag:TextField=new TextField();			tmptag.text=String(numPts);			tmptag.x=ptsX[numPts];			tmptag.y=ptsY[numPts];			var fmt=new TextFormat();			fmt.size=tag_font_size;			fmt.color=colors[numPts % colors.length];			tmptag.setTextFormat(fmt);			this.pdClickArea.addChild(tmptag);			tmptag.doubleClickEnabled;			ptTags[numPts]=tmptag;		}		public function get_xml_annotation():String {			var object_name=this.get_object_name();			var object_sqn=this.object_sqn;			var xmlStr:String="";			xmlStr='<polygon name="'+object_name+'" sqn="'+ object_sqn +'" >';			for (var iPt=1; iPt<=this.numPts; iPt++) {				var lx=ptsX[iPt];				var ly=ptsY[iPt];				var t=ptsTime[iPt];								xmlStr +='\t<pt x="'+lx+'" y="'+ly+'" ct="'+t+'"/>\n';			}			xmlStr+="</polygon>";			return xmlStr;		}		public function get_object_name():String {			if (this.m_edit_ctrl.m_label) {				return this.m_edit_ctrl.m_label.text;			}			return this.object_name;		}		public function set_object_name(new_name:String):void {			this.object_name=new_name;			this.m_edit_ctrl.m_label.text=new_name;			this.m_edit_ctrl.m_label.visible=this.show_tag;		}		//lx=(lx-rootObj.oX)*rootObj.ratio;		//ly=(ly-rootObj.oY)*rootObj.ratio;		//function makeDisplayActive(holder){		//}		//makeActive=makeDisplayActive;	}}