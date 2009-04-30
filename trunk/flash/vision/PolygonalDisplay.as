﻿/********************************************************************** Software License Agreement (BSD License)**  Copyright (c) 2008, University of Illinois at Urbana-Champaign*  All rights reserved.**  Redistribution and use in source and binary forms, with or without*  modification, are permitted provided that the following conditions*  are met:**   * Redistributions of source code must retain the above copyright*     notice, this list of conditions and the following disclaimer.*   * Redistributions in binary form must reproduce the above*     copyright notice, this list of conditions and the following*     disclaimer in the documentation and/or other materials provided*     with the distribution.*   * Neither the name of the University of Illinois nor the names of its*     contributors may be used to endorse or promote products derived*     from this software without specific prior written permission.**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE*  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;*  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER*  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT*  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN*  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE*  POSSIBILITY OF SUCH DAMAGE.*********************************************************************//***** Author: Alexander Sorokin, Department of Computer Science,*                                  University of Illinois at Urbana-Champaign.* Advised by: David Forsyth.*****/package vision{	import flash.display.*;	import fl.controls.Label;	import flash.events.MouseEvent;	import flash.events.Event;	import vision.ResizeMarker;	//dynamic private class PolySprite extends Sprite{	//	}			dynamic public class PolygonalDisplay extends MovieClip	{				const IDLE:String = "idle";		const EDITING:String = "edit";		const READY:String = "ready";		var ptsX:Array;		var ptsY:Array;		var ptsTime:Array;						var numPts:Number;		var thePolygon:Sprite;		var thePS:Sprite;		var hitTime:Number;		var now:Date;		var makeActive;		var lineColor;		var allow_edit;		var rootObj;		var tag=null;		var Mode=READY;		//lblRemoveLast.visible=true;		//btnRemoveLast.visible=false;				function PolygonalDisplay()		{			now = new Date();			hitTime=now.getTime();			btnFinishShape.addEventListener(MouseEvent.CLICK, onFinishShapeClick);			pdClickArea.addEventListener(MouseEvent.CLICK, handleRegularClick);			btnRemoveLast.addEventListener(MouseEvent.CLICK, onRemoveLastSegmentClick);			btnRemoveLast.visible=false;			btnFinishShape.visible=false;			allow_edit=false;						rootObj=null;		}		public function set_root(newRootObj):void{			 this.rootObj=newRootObj;		 }		public function enable_edit():void{			if(allow_edit==false){				allow_edit=true;				thePolygon.addEventListener(MouseEvent.CLICK,onBoxDoubleClick);			}		}		public function disable_edit():void{			allow_edit=false;			try			{				thePolygon.removeEventListener(MouseEvent.CLICK,onBoxDoubleClick);								}catch(e){			}		}				function onBoxDoubleClick(event:MouseEvent):void{			if(!allow_edit){				return;			}			if(rootObj.active_marker!=null){				rootObj.active_marker.removeEditMode();				rootObj.active_marker=null;			}						this.setEditMode();						rootObj.active_marker=this;					}						var resize_markers;		public function setEditMode():void{			resize_markers=new Array();			 			for(var iPt=1;iPt<=this.numPts;iPt++){				var m1=new vision.ResizeMarker();			 	m1.x=ptsX[iPt];			 	m1.y=ptsY[iPt];				m1.idx=iPt;				resize_markers.push(m1);			 	m1.addEventListener("my_resize_marker_move", on_resize_marker_move);			 	this.thePolygon.parent.addChild(m1);			}			 var start_edit_event:Event = new Event("my_start_edit_mode");			 this.dispatchEvent(start_edit_event);		}			 		public function removeEditMode():void{			var l=this.resize_markers.length;				for(var iPt=0;iPt<l;iPt++){					this.thePolygon.parent.removeChild(resize_markers.pop());				}								var finish_edit_event:Event = new Event("my_finish_edit_mode");				this.dispatchEvent(finish_edit_event);		}		public function on_resize_marker_move(event:Event):void		{			var m=vision.ResizeMarker(event.target);							ptsX[m.idx]=m.x;			ptsY[m.idx]=m.y;			redraw_this();		}				function redraw_this():void		{									this.thePolygon.graphics.clear();			this.thePolygon.graphics.lineStyle(2, lineColor, 1, false, LineScaleMode.VERTICAL,				                               CapsStyle.NONE, JointStyle.MITER, 10);			this.thePolygon.graphics.moveTo(ptsX[1], ptsY[1]);			if (this.numPts>1) {				for (var i=2; i<=this.numPts; i++) {					this.thePolygon.graphics.lineTo(this.ptsX[i], this.ptsY[i]);				}			}			thePolygon.graphics.beginFill(lineColor, 0.1);  						this.thePolygon.graphics.moveTo(ptsX[1], ptsY[1]);      			if (this.numPts>1) {				for (var i=2; i<=this.numPts; i++) {					this.thePolygon.graphics.lineTo(this.ptsX[i], this.ptsY[i]);				}			}			//this.thePolygon.graphics.moveTo(ptsX[1], ptsY[1]);  			 thePolygon.graphics.endFill();   						thePolygon.graphics.beginFill(0, 0);  			thePolygon.graphics.endFill();  						if(tag!=null){				tag.x=ptsX[1];				tag.y=ptsY[1];			}					}				function onFinishShapeClick(event:MouseEvent):void {			//numPts++;			//ptsX[numPts]=event.localX;			//ptsY[numPts]=event.localY;			var now:Date = new Date();			this.hitTime=now.getTime();			thePolygon.graphics.lineTo(ptsX[1], ptsY[1]);			this.Mode=IDLE;			btnFinishShape.visible=false;			btnRemoveLast.visible=false;			//lblRemoveLast.visible=false;			var done_event:Event = new Event("my_input_finished");    		this.dispatchEvent(done_event);					redraw_this();			enable_edit();			trace(event.currentTarget.toString() + "Finish");		}		function handleRegularClick(event:MouseEvent):void {			if (this.Mode==IDLE) {				trace("Idle");			} else if (this.Mode==READY) {				btnFinishShape.x=event.localX;				btnFinishShape.y=event.localY;				btnFinishShape.visible=true;				btnRemoveLast.visible=true;				//lblRemoveLast.visible=true;				this.Mode=EDITING;				ptsX=new Array();				ptsY=new Array();				ptsTime = new Array();				numPts=0;				thePolygon=new Sprite();								thePolygon.graphics.lineStyle(2, lineColor, 1, false, LineScaleMode.VERTICAL,				                               CapsStyle.NONE, JointStyle.MITER, 10);				numPts++;				ptsX[numPts]=event.localX;				ptsY[numPts]=event.localY;				var now:Date = new Date();				ptsTime[numPts]=now.getTime();								thePolygon.graphics.moveTo(event.localX, event.localY);				event.currentTarget.addChild(thePolygon);			} else {				numPts++;				ptsX[numPts]=event.localX;				ptsY[numPts]=event.localY;				var now:Date = new Date();				ptsTime[numPts]=now.getTime();								thePolygon.graphics.lineTo(event.localX, event.localY);				trace(event.currentTarget.toString() + 				" dispatches MouseEvent. Local coords [" + 				event.localX + "," + event.localY + "] Stage coords [" + 				event.stageX + "," + event.stageY + "]");			}			trace(event.currentTarget.toString() + 			" dispatches MouseEvent. Local coords [" + 			event.localX + "," + event.localY + "] Stage coords [" + 			event.stageX + "," + event.stageY + "]");			var now:Date = new Date();			this.hitTime=now.getTime();		}		function onRemoveLastSegmentClick(event:MouseEvent):void {			if (this.Mode == EDITING) {				var now:Date = new Date();				this.hitTime=now.getTime();				this.thePolygon.graphics.clear();				thePolygon.graphics.lineStyle(2, lineColor, 1, false, LineScaleMode.VERTICAL,				                               CapsStyle.NONE, JointStyle.MITER, 10);				if (this.numPts>1) {					this.numPts--;					this.thePolygon.graphics.moveTo(ptsX[1], ptsY[1]);					if (this.numPts>1) {						for (var i=2; i<=this.numPts; i++) {							this.thePolygon.graphics.lineTo(this.ptsX[i], this.ptsY[i]);						}					}				} else if (this.numPts==1) {					this.numPts=0;					this.Mode=READY;				}			}		}				public function read_xml_annotation(annotation:XML):void{			var pts=annotation.pt;			ptsX=new Array();			ptsY=new Array();			ptsTime = new Array();			numPts=0;			thePolygon= new Sprite();			var colors=[0x157FE7,0x0004F3,0xF0AE40,0x39ECA2,0x4FE6EB,0x5617E9,0x5A6E6E,0x6A9B82,0xE649D6,0x8387DD,0x4DBF93,0xA7650D,0xE5C82E,0xB46EA4,0x5BB4A3,0xF9C76B,0xC0F32E,0x3CFE2E,0xFF0F8C,0x659F72,0x1D9001,0x43627F,0xFCCACF,0x8187D6,0xF5C5F2,0x624ACC,0x2D7516,0x88EAB9,0xF1AFD2,0x7CA082,0x3087CB,0xF9E2F2,0xA10EB0,0x1183BB,0xF43FE3,0x3EF24D,0x1A68EC,0x40CA6A,0xF7137D,0x7CE5B6,0xC9DB5A,0x61F51F,0xEACBD7,0x14A19F,0x9825ED,0xAAA840,0x55ED5E,0x9E7421,0x9C0989,0x23FAD1,0xA4CF04,0x3872C1,0xD7ABB4,0xC4745A,0x8F4971,0xDFDF7D,0x5D0161,0x52FB8A,0x4AB3B1,0x645C84,0x5B9AC1,0xE17486,0x8CDA5E,0xA4C3E7,0xFE8F0B,0x40FC3D,0x0D2CF2,0x786878,0x98788B,0xD17D54,0x9CBFD0,0x0399A4,0xB466EF,0xF9205A,0x77ECB0,0xEADE31,0x0DD124,0x7E2A5C,0x64AFC6,0x4ED5A5,0xCC4F32,0x11541B,0x3F4299,0xD47BB1,0x22F163,0x000662,0x3C61C7,0x994FB9,0x64A88D,0x34191B,0xD01379,0xD13827,0x261DCC,0xD25FB3,0x824F23,0x09957B,0x55E1A4,0x4A46B3,0x4F1764,0x3BDC8C];						var iC=Math.floor(Math.random()*colors.length);			var lineColor=colors[iC];			thePolygon.graphics.lineStyle(2, lineColor, 1, false, LineScaleMode.VERTICAL,										   CapsStyle.NONE, JointStyle.MITER, 10);						pdClickArea.addChild(thePolygon);									for(var p in pts){				numPts++;				ptsX[numPts]=parseFloat(pts[p].@x);				ptsY[numPts]=parseFloat(pts[p].@y);				ptsTime[numPts]=pts[p].ct;				if(p=="0"){					thePolygon.graphics.moveTo(ptsX[numPts], ptsY[numPts]);				}else{					thePolygon.graphics.lineTo(ptsX[numPts], ptsY[numPts]);				}							}			thePolygon.graphics.lineTo(ptsX[1], ptsY[1]);		}		public function get_xml_annotation():String		{					var object_name=this.label.split('_')[0];			var object_sqn=this.label.split('_')[1];			var xmlStr:String="";						xmlStr='<polygon name="'+object_name+'" sqn="'+ object_sqn +'" >';			for(var iPt=1;iPt<=this.numPts;iPt++){				var lx=ptsX[iPt];				var ly=ptsY[iPt];				var t=ptsTime[iPt];								xmlStr +='\t<pt x="'+lx+'" y="'+ly+'" ct="'+t+'"/>\n';			}			xmlStr+="</polygon>";						return xmlStr;		}							//lx=(lx-rootObj.oX)*rootObj.ratio;			//ly=(ly-rootObj.oY)*rootObj.ratio;					//function makeDisplayActive(holder){		//}		//makeActive=makeDisplayActive;	}}