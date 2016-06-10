package  {
	
	import flash.system.fscommand;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import fl.motion.AdjustColor;
	import flash.filters.ColorMatrixFilter;
	import flash.display.StageQuality;
	import flash.utils.getQualifiedClassName;
	import flash.ui.Mouse;
	import flash.display.StageDisplayState;
	import RubiksCube.RubiksCube;

	public class Main extends MovieClip {

		public var level:Array = [];
		public var stageState:Number = 0;
		public var DEBUG:Boolean = false;
		
		public var cursor:MovieClip;

		private var sounds:Array = [new UiStartUp(), new UiOpening(), new UiClosing(), new UiOk(), new UiSuccess(), new UiLogin(), new UiSwitching(), new UiClick(), new UiFruitStart(), new UiFruitSend1(), new UiFruitSend2(), new UiFruitSend3(), new UiFruitHit1(), new UiFruitHit2(), new UiFruitHit3(), new UiFruitHit4(), new UiFruitEnd(), new UiNotify1(), new UiCubeMove1(), new UiCubeMove2(), new UiCubeRotate1(), new UiCubeRotate2()];
		private var soundsChl:Array = [];

		public function SwapToFront(obj:MovieClip) {
			/*var myIndex:Number = root.getChildIndex(obj);
			for (var i:Number = 0; i < numChildren; ++i) {
				var oIndex:Number = par.getChildIndex(par.dmain[i]);
				if (oIndex > myIndex) {
					par.swapChildrenAt(oIndex, myIndex);
					myIndex = oIndex;
				}
			}*/
			obj.parent.setChildIndex(obj, obj.parent.numChildren-1);
		}

		public function SwitchLevelDepth(d:Number) {
			for (var i:Number = 0; i < level.length; ++i) {
				level[i].MoveDepth(level[i].dep + d);
			}
		}

		public function AddLevel(lcn:MovieClip) {
			addChild(lcn);
			lcn.Init();
			
			for (var i:Number = 0; i < level.length; ++i) {
				if (level[i].dep < 0) {
					--level[i].dep;
					this.swapChildren(lcn, level[i]);
				}
			}
			level.push(lcn);
			lcn.dep = -1;
			lcn.x = 427;
			lcn.y = 240;
		}

		public function FindLevel(str:String) {
			for (var i:Number = 0; i < level.length; ++i) {
				var myClass:Class = Object(level[i]).constructor;
				if (getQualifiedClassName(myClass).substr(14) == str) {
					return level[i];
				}
			}
			trace("#FindLevel not found: "+str);
			return null;
		}
		
		public function UiSound(str:String) {
			switch (str) {
				case 'startup':
					soundsChl[0] = sounds[0].play();
					break;
				case 'opening':
					soundsChl[1] = sounds[1].play();
					break;
				case 'closing':
					soundsChl[2] = sounds[2].play();
					break;
				case 'ok':
					soundsChl[3] = sounds[3].play();
					break;
				case 'success':
					soundsChl[4] = sounds[4].play();
					break;
				case 'login':
					soundsChl[5] = sounds[5].play();
					break;
				case 'switching':
					soundsChl[6] = sounds[6].play();
					break;
				case 'click':
					soundsChl[7] = sounds[7].play();
					break;
				case 'fruitstart':
					soundsChl[8] = sounds[8].play();
					break;
				case 'fruitsend1':
					soundsChl[9] = sounds[9].play();
					break;
				case 'fruitsend2':
					soundsChl[10] = sounds[10].play();
					break;
				case 'fruitsend3':
					soundsChl[11] = sounds[11].play();
					break;
				case 'fruithit1':
					soundsChl[12] = sounds[12].play();
					break;
				case 'fruithit2':
					soundsChl[13] = sounds[13].play();
					break;
				case 'fruithit3':
					soundsChl[14] = sounds[14].play();
					break;
				case 'fruithit4':
					soundsChl[15] = sounds[15].play();
					break;
				case 'fruitend':
					soundsChl[16] = sounds[16].play();
					break;
				case 'notify1':
					soundsChl[17] = sounds[17].play();
					break;
				case 'cubemove1':
					soundsChl[18] = sounds[18].play();
					break;
				case 'cubemove2':
					soundsChl[19] = sounds[19].play();
					break;
				case 'cuberotate1':
					soundsChl[20] = sounds[20].play();
					break;
				case 'cuberotate2':
					soundsChl[21] = sounds[21].play();
					break;
			}
		}

		public function Main() {
			
			stage.displayState = StageDisplayState.FULL_SCREEN;
			stage.quality = StageQuality.BEST;// StageQuality.BEST;
			
			/*var rbc:RubiksCube = new RubiksCube();
			rbc.spBoard.scaleX = 4.5;
			rbc.spBoard.scaleY = 4.5;
			rbc.spBoard.x = 427;
			rbc.spBoard.y = 240;
			this.addChild(rbc.spBoard);
			
			stage.addEventListener(Event.ENTER_FRAME, function() {
				rbc.Rotating();
				rbc.RenderView();
			});
			
			stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent) {
				switch (e.charCode) {
					case 49: rbc.RotateFace([1, 0, 0], true); break;
					case 50: rbc.RotateFace([0, 1, 0], true); break;
					case 51: rbc.RotateFace([0, 0, 1], true); break;
					case 52: rbc.RotateFace([-2, 0, 0], true); break;
					case 53: rbc.RotateFace([0, -2, 0], true); break;
					case 54: rbc.RotateFace([0, 0, -2], true); break;
					
					case 55: rbc.RotateWhole([1, 0, 0]); break;
					case 56: rbc.RotateWhole([0, 1, 0]); break;
					case 57: rbc.RotateWhole([0, 0, 1]); break;
				}
			});
			
			return;*/
			cursor = new Cursor();
			addChild(cursor);
			cursor.visible = false;
			
			AddLevel(new LevelContainerIndex());
			level[0].dep = 0;

			FindLevel("Index").dLogin.PopIn();
			/*FindLevel("Index").dLogin.AddAnimation(0, function(proc, obj) {
				obj.root.UiSound('startup');
			});*/

			stage.addEventListener(MouseEvent.CLICK, function(e:Event) {
				
			});
			stage.addEventListener(MouseEvent.MOUSE_MOVE, function(e:Event) {
				Mouse.hide();
				cursor.x = root.mouseX;
				cursor.y = root.mouseY;
				SwapToFront(cursor);
			});
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent) {
				if (e.charCode == 43) {
					SwitchLevelDepth(1);
				} else if (e.charCode == 44) {
					SwitchLevelDepth(-1);
				} else if (e.charCode == 27) {
					fscommand("quit");
				}
				
				if (stageState == 0) {
					if (e.charCode == 110) {			// N
						FindLevel("Index").dLogin.Jump();
						++stageState;
						trace("Stage="+stageState);
					}
				} else if (stageState == 1) {
					if (e.charCode == 110) {			// N
						DEBUG = false;
						
						trace('#SEL='+FindLevel("Index").selectIndex);
						if (FindLevel("Index").selectIndex == -1) {
							//stageState = 1;
							return;
						}

						switch (FindLevel("Index").selectIndex) {
						case 0:		AddLevel(new LevelContainerApp0());		break;
						case 1:		AddLevel(new LevelContainerApp1());		break;
						case 2:		AddLevel(new LevelContainerApp2());		break;
						case 3:		AddLevel(new LevelContainerApp3());		break;
						case 4:		AddLevel(new LevelContainerApp4());		break;
						case 5:		AddLevel(new LevelContainerApp5());		break;
						}
						
						SwitchLevelDepth(1);
						level[level.length-1].dialog.AddAnimation(10, function(proc, obj) { });
						level[level.length-1].dialog.PopIn();
						
						UiSound('switching');
					}
				}
				
				if (e.charCode == 113) {			// Q
					for (var i:Number = 1; i < level.length; ++i) {
						if (level[i].dep == 0 && level[i].isReady) {
							trace("Kill Level:"+i);
							level[i].Die();
							SwitchLevelDepth(-1);
							level.splice(i, 1);
							break;
						}
					}
					cursor.visible = false;
				}
			});
		}
	}	
}
