﻿/********************************************************************** Software License Agreement (BSD License)**  Copyright (c) 2008, University of Illinois at Urbana-Champaign*  All rights reserved.**  Redistribution and use in source and binary forms, with or without*  modification, are permitted provided that the following conditions*  are met:**   * Redistributions of source code must retain the above copyright*     notice, this list of conditions and the following disclaimer.*   * Redistributions in binary form must reproduce the above*     copyright notice, this list of conditions and the following*     disclaimer in the documentation and/or other materials provided*     with the distribution.*   * Neither the name of the University of Illinois nor the names of its*     contributors may be used to endorse or promote products derived*     from this software without specific prior written permission.**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE*  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;*  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER*  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT*  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN*  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE*  POSSIBILITY OF SUCH DAMAGE.*********************************************************************//***** Author: Alexander Sorokin, Department of Computer Science,*                                  University of Illinois at Urbana-Champaign.* Advised by: David Forsyth.*****/package vision{	import flash.display.*;	import fl.controls.CheckBox;	import fl.controls.List;	import fl.controls.Button;	import fl.data.DataProvider;	//import flash.display.Shape;	import fl.controls.Label;	import flash.events.MouseEvent;	import flash.events.Event;	import flash.xml.XMLDocument;	import flash.xml.XMLNode;	import flash.text.*;		import vision.BBoxInputToken;	import vision.BBox2InputToken;	import vision.PolygonalDisplay;	import vision.MarkSymbol2;	import vision.TwoLevelInputToken;	//import vision.CheckBox2;	dynamic public class InputSpecsControl extends MovieClip	{		var presence_targets:Array;		var bbox_targets:Array;		var polygon_targets:Array;		var segment_targets:Array;		var all_controls:Array;		var all_controls_by_name:Array;				var offsetY;		var rootObj;				var finishBtn:Button;				function InputSpecsControl() {						presence_targets=new Array();			bbox_targets=new Array();			polygon_targets=new Array();			segment_targets=new Array();						all_controls=new Array();						all_controls_by_name=new Array();						finishBtn=null;		}		public function get_input_control_by_name(name:String):Object{			return all_controls_by_name[name];		}		public function read_task(task_definition:XML,newRootObj,bViewOnly:Boolean=false):void{			//var c:XMLNode;			this.rootObj=newRootObj;						var targets:XMLList=task_definition.targets.target;			for each(var c in targets){				if(c.annotation.@type=="presence"){					presence_targets.push(new Array(c));				}else if((c.annotation.@type=="bbox") || (c.annotation.@type=="bbox2")|| (c.annotation.@type=="2level")){					bbox_targets.push(c);				}else if(c.annotation.@type=="outline"){					polygon_targets.push(c);				}else if(c.annotation.@type=="segmentation"){					segment_targets.push(c);				}else{					trace('Unknown');				}				trace(c.@name);					trace(c.annotation.@type);				}			setup_lists(bViewOnly);		}		public function read_task_w_annotation(task_definition:XML,annotations:XML,newRootObj):void{			//var c:XMLNode;			read_task(task_definition,newRootObj,true);						read_xml_annotation(annotations);		}				public function read_xml_annotation(annotations:XML):void{			//return;			//var offsetY:Number=0;			var binary_decisions:Array=new Array();			var absent_tgts:XMLList=annotations.annotation.absent;			var present_tgts:XMLList=annotations.annotation.present;			var o;			for each( o in absent_tgts){				binary_decisions[o.@name]=0;							}						for each( o in present_tgts){				binary_decisions[o.@name]=1;							}			for each(var oA in presence_targets){					var ctl:CheckBox=oA[1];					var o = oA[0];					ctl.selected=binary_decisions[o.@name];					oA[2]=o.@ct;								}			var bboxes:XMLList=annotations.annotation.bbox;			for each( o in bboxes){								var lx,ly,lw,lh,bX,bY,bW,bH;				lx=o.@left;				ly=o.@top;				lw=o.@width;				lh=o.@height;				bX=lx/rootObj.ratio+rootObj.oX;				bY=ly/rootObj.ratio+rootObj.oY;				bW=lw/rootObj.ratio;				bH=lh/rootObj.ratio;								var thePolygon= new Shape();    				var lineColor=0x0000FF;				thePolygon.graphics.lineStyle(2, lineColor, 1, false, LineScaleMode.VERTICAL,												CapsStyle.NONE, JointStyle.MITER, 10);					thePolygon.graphics.moveTo(bX,bY);				thePolygon.graphics.lineTo(bX+bW,bY);				thePolygon.graphics.lineTo(bX+bW,bY+bH);				thePolygon.graphics.lineTo(bX,bY+bH);				thePolygon.graphics.lineTo(bX,bY);				rootObj.the_sites_holder.addChild(thePolygon);								var tag:TextField=new TextField();								tag.text=o.@sqn+" "+o.@name;								tag.background=false;				tag.autoSize=TextFieldAutoSize.RIGHT;								rootObj.the_sites_holder.addChild(tag);				tag.x=bX+bW/2-tag.width/2;				tag.y=bY+bH/2-tag.height/2;										tag=new TextField();								tag.text=o.@sqn+" "+o.@name;								tag.background=false;				tag.autoSize=TextFieldAutoSize.RIGHT;								rootObj.the_sites_holder.addChild(tag);				tag.x=bX+bW/2-tag.width/2+2;				tag.y=bY+bH/2-tag.height/2+2;				tag.textColor=0xFFFFFF;								}			var bboxes2:XMLList=annotations.annotation.bbox2;			for each( o in bboxes2){				var bbox2Input:BBox2Input=new BBox2Input();				bbox2Input.set_root(rootObj);				bbox2Input.set_xml_annotation(o);								bbox2Input.setDisplayMode();				rootObj.the_sites_holder.addChild(bbox2Input);			}						var polygons:XMLList=annotations.annotation.polygon;			for each( o in polygons){				var polyDisplay:vision.PolygonalDisplay=new vision.PolygonalDisplay();				polyDisplay.read_xml_annotation(o);				polyDisplay.Mode = polyDisplay.IDLE;				polyDisplay.btnRemoveLast.visible=false;				polyDisplay.m_cover.visible=false;				rootObj.the_sites_holder.addChild(polyDisplay);				var tag:TextField=new TextField();								tag.text=o.@sqn+" "+o.@name;								tag.background=false;				tag.autoSize=TextFieldAutoSize.RIGHT;								rootObj.the_sites_holder.addChild(tag);				tag.x=polyDisplay.ptsX[1];				tag.y=polyDisplay.ptsY[1];										tag=new TextField();								tag.text=o.@sqn+" "+o.@name;								tag.background=false;				tag.autoSize=TextFieldAutoSize.RIGHT;								rootObj.the_sites_holder.addChild(tag);				tag.x=polyDisplay.ptsX[1]+2;				tag.y=polyDisplay.ptsY[1]+2;									tag.textColor=0xFFFFFF;								var m:vision.MarkSymbol2 = new vision.MarkSymbol2;				rootObj.the_sites_holder.addChild(m);				m.x=polyDisplay.ptsX[1];				m.y=polyDisplay.ptsY[1];								}			var segmentations:XMLList=annotations.annotation.segmentation;			for each( o in segmentations ){				var seg_input:SegmentationInput=new SegmentationInput();				var sh=rootObj.the_sites_holder;				var bgim=sh.getBG();								seg_input.set_background_image_inline(bgim);				seg_input.load_segmentation(o.@url);				seg_input.setDisplayMode();				rootObj.the_sites_holder.addChildAt(seg_input,2);				//rootObj.the_sites_holder.addChild(seg_input);			}						var twoLevel:XMLList=annotations.annotation.twoLevel;			for each( o in twoLevel){				var tgtControl=get_input_control_by_name(o.@name);				tgtControl.add_xml_annotation(o);			}						var bbox2token_xml:XMLList=annotations.annotation.bbox2tk;			for each( o in bbox2token_xml){				var tgtControl=get_input_control_by_name(o.@name);				tgtControl.add_xml_annotation(o);			}										}		function add_finish_button():void{			finishBtn=new Button()			finishBtn.label="finish";			this.addChild(finishBtn);			finishBtn.y=this.height-finishBtn.height;			finishBtn.x=(this.width-finishBtn.width)/2;						finishBtn.addEventListener(MouseEvent.CLICK,onFinish);		}		function onFinish(event:Event):void{			var done_event:Event = new Event("my_input_finished");    		this.dispatchEvent(done_event);				}		public function enable_edit():void{			for each(var oS:Object in all_controls){				if (oS is BBoxInput)				{					var bboxInput:BBoxInput=BBoxInput(oS);											}else if (oS is TwoLevelInputToken)				{					var twoLvl:TwoLevelInputToken=TwoLevelInputToken(oS);					twoLvl.enable_edit();									}else if (oS is BBox2InputToken)				{					var bbox2Input:BBox2InputToken=BBox2InputToken(oS);					bbox2Input.enable_edit();								}else if (oS is SegmentationInputToken){					var segInput:SegmentationInputToken=SegmentationInputToken(oS);					segInput.enable_edit();									}else if(oS is PolygonInputToken)				{					var outlineInput:PolygonInputToken=PolygonInputToken(oS);					outlineInput.enable_edit();								}else if (oS is CheckBox)				{					var chkBox:CheckBox=CheckBox(oS);					chkBox.enabled=true;				}else if (oS is TwoLevelInputToken)				{					var twoLvl:TwoLevelInputToken=TwoLevelInputToken(oS);				}			}						/*if(finishBtn!=null){				finishBtn.visible=false;			}*/		}		public function disable_edit():void{			for each(var oS:Object in all_controls){				if (oS is BBoxInput)				{					var bboxInput:BBoxInput=BBoxInput(oS);				}else if (oS is TwoLevelInputToken)				{					var twoLvl:TwoLevelInputToken=TwoLevelInputToken(oS);												twoLvl.disable_edit();									}else if (oS is BBox2InputToken)				{					var bbox2Input:BBox2InputToken=BBox2InputToken(oS);					bbox2Input.disable_edit();								}else if (oS is SegmentationInputToken){					var segInput:SegmentationInputToken=SegmentationInputToken(oS);					segInput.disable_edit();									}else if(oS is PolygonInputToken)				{					var outlineInput:PolygonInputToken=PolygonInputToken(oS);					outlineInput.disable_edit();													}else if (oS is CheckBox)				{					var chkBox:CheckBox=CheckBox(oS);					chkBox.enabled=false;				}else if (oS is TwoLevelInputToken)				{					var twoLvl:TwoLevelInputToken=TwoLevelInputToken(oS);				}			}					}				function record_checkbox_time(event:Event):void {			var now:Date=new Date();				var click_time=now.getTime();			for each(var oA in presence_targets){				if(oA[1]==event.target){					oA[2]=click_time;					break;				}			}		}		function setup_lists(bViewOnly:Boolean=false):void		{ 			offsetY=0;						if(presence_targets.length>0){				var l:Label=new Label();				l.text="Attributes";				l.x=0;				l.y=offsetY;				this.addChild(l);				offsetY+=l.height;				for each(var oA in presence_targets){					//var ctl =new CheckBox2();					var ctl:CheckBox=new CheckBox();					if(bViewOnly){						ctl.enabled=false;					}					ctl.width=160;					//ctl.name=o.@name;					var o = oA[0];										ctl.label=o.@name;					oA.push(ctl);					ctl.x=0;					ctl.y=offsetY;					oA.push(-1);					ctl.addEventListener(Event.CHANGE, this.record_checkbox_time);					this.addChild(ctl);					offsetY+=ctl.height;					all_controls.push(ctl);					all_controls_by_name[o.@name]=ctl;				}			}			var HBox=27;			if(bbox_targets.length>0){				var l:Label=new Label();				l.text="Object boxes";				l.x=0;				l.y=offsetY;				this.addChild(l);				offsetY+=l.height;				for each(var o in bbox_targets){					if(o.annotation.@type=="bbox"){						var ctlBox:BBoxInputToken=new BBoxInputToken();						if(bViewOnly){							ctlBox.m_input_btn.enabled=false;						}						//ctl.name=o.@name;						ctlBox.set_name(o.@name);						ctlBox.set_root(this.rootObj);						o.ctl=ctlBox;						ctlBox.x=0;						ctlBox.y=offsetY;						this.addChild(ctlBox);						offsetY+=HBox;					}else if(o.annotation.@type=="bbox2"){						var ctlBox2:BBox2InputToken=new BBox2InputToken();						if(bViewOnly){							ctlBox2.m_input_btn.enabled=false;						}						//ctl.name=o.@name;						ctlBox2.set_name(o.@name);						ctlBox2.set_root(this.rootObj);						try{							ctlBox2.min_size=parseInt(o.annotation.@min_size);						}finally{						}						o.ctl=ctlBox2;						ctlBox2.x=0;						ctlBox2.y=offsetY;						this.addChild(ctlBox2);						offsetY+=HBox;												all_controls.push(ctlBox2);						all_controls_by_name[o.@name]=ctlBox2;						//offsetY+=ctlBox.height;					}else if(o.annotation.@type=="2level"){						var ctlTwoLvl:TwoLevelInputToken=new TwoLevelInputToken();						if(bViewOnly){							ctlTwoLvl.m_input_btn.enabled=false;						}						//ctl.name=o.@name;						ctlTwoLvl.set_name(o.@name);						ctlTwoLvl.set_root(this.rootObj);						try{							ctlTwoLvl.min_size=parseInt(o.annotation.@min_size);						}finally{						}						o.ctl=ctlTwoLvl;												ctlTwoLvl.x=0;						ctlTwoLvl.y=offsetY;						this.addChild(ctlTwoLvl);						all_controls.push(ctlTwoLvl);						all_controls_by_name[o.@name]=ctlTwoLvl;												ctlTwoLvl.read_task(o.annotation.level2[0],this.rootObj,this,bViewOnly)						offsetY+=HBox;					}				}			}			var HBox=27;			if(polygon_targets.length>0){				var l:Label=new Label();				l.text="Outlines";				l.x=0;				l.y=offsetY;				this.addChild(l);				offsetY+=l.height;				for each(var o in polygon_targets){					var ctlBoxPoly:PolygonInputToken=new PolygonInputToken();					if(bViewOnly){						ctlBoxPoly.m_input_btn.enabled=false;					}										//ctl.name=o.@name;					ctlBoxPoly.set_name(o.@name);					ctlBoxPoly.set_root(this.rootObj);					o.ctl=ctlBoxPoly;					ctlBoxPoly.x=0;					ctlBoxPoly.y=offsetY;					this.addChild(ctlBoxPoly);					//offsetY+=ctlBox.height;					offsetY+=HBox;					all_controls.push(ctlBoxPoly);					all_controls_by_name[o.@name]=ctlBoxPoly;				}							}			var HBox=27;			if(segment_targets.length>0){				var l:Label=new Label();				l.text="Segmentation";				l.x=0;				l.y=offsetY;				this.addChild(l);				offsetY+=l.height;				for each(var o in segment_targets){					var ctlSegment:SegmentationInputToken=new SegmentationInputToken();					if(bViewOnly){							ctlSegment.m_input_btn.enabled=false;					}					//ctl.name=o.@name;					ctlSegment.set_name(o.@name);					ctlSegment.set_root(this.rootObj);					o.ctl=ctlSegment;					ctlSegment.x=0;					ctlSegment.y=offsetY;					this.addChild(ctlSegment);					//offsetY+=ctlBox.height;					offsetY+=HBox;					all_controls.push(ctlSegment);					all_controls_by_name[o.@name]=ctlSegment;				}			}					}		public function get_xml_annotation():String		{			return collect_results();		}		public function collect_results():String		{			var xmlStr:String="";			/*for each(var oA:Object in this.presence_targets){				//var chkBox = oA[1];				var chkBox:CheckBox=oA[1];				var ct = oA[2];				if (chkBox.selected){					xmlStr+='<present name="'+chkBox.label+'" explicit="1" ct="'+ct+'"/>\n';				}else{					xmlStr+='<absent name="'+chkBox.label+'" explicit="0" ct="'+ct+'"/>\n';							}			}			var inpData:DataProvider=this.rootObj.shapesListBox.dataProvider;			var dataElements:Array=inpData.toArray();			for each(var oS:Object in dataElements){				trace(oS);			}*/						for each(var oS:Object in all_controls){				if (oS is BBoxInput)				{					var bboxInput:BBoxInput=BBoxInput(oS);					xmlStr+=bboxInput.get_xml_annotation() ;						}else if (oS is BBox2InputToken)				{					var bbox2Input:BBox2InputToken=BBox2InputToken(oS);					xmlStr+=bbox2Input.get_xml_annotation() ;						}else if (oS is SegmentationInputToken){					var segInput:SegmentationInputToken=SegmentationInputToken(oS);					xmlStr+=segInput.get_xml_annotation();				}else if(oS is PolygonInputToken)				{					var outlineInput:PolygonInputToken=PolygonInputToken(oS);					xmlStr+=outlineInput.get_xml_annotation() ;						}else if (oS is TwoLevelInputToken)				{					var twoLvl:TwoLevelInputToken=TwoLevelInputToken(oS);					xmlStr+=twoLvl.get_xml_annotation() ;						}else if (oS is CheckBox)				{					var chkBox:CheckBox=CheckBox(oS);					var ct = 0;					if (chkBox.selected){						xmlStr+='<present name="'+chkBox.label+'" explicit="1" ct="'+ct+'"/>\n';					}else{						xmlStr+='<absent name="'+chkBox.label+'" explicit="0" ct="'+ct+'"/>\n';								}				}else if (oS is TwoLevelInputToken)				{					var twoLvl:TwoLevelInputToken=TwoLevelInputToken(oS);					xmlStr+=twoLvl.get_xml_annotation() ;						}			}			var w=rootObj.originalW;			var h=rootObj.originalH;			var size_str="<size><width>"+w+"</width><height>"+h+"</height></size>\n";			return "<annotation>\n"+size_str+xmlStr+"</annotation>\n";		}	}}