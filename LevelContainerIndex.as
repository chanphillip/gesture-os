package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class LevelContainerIndex extends LevelContainer {
	
		public const indexN = 12;
		public var dLogin:DialogLogin = new DialogLogin();
		public var dIcon:Array = [];
		
		public var selectIndex:Number = -1;

		public function LevelContainerIndex() {
			addChild(dLogin);
			for (var i:Number = 0; i < indexN; ++i) {
				dIcon[i] = new DialogIcon();
				dIcon[i].MoveTo((i % 4) * 205 + 119.5, (Math.floor(i / 4) + .5) * 140);
				dIcon[i].gotoAndStop(i+1);
				addChild(dIcon[i]);
			}
		}
		
		public function AllPopIn() {
			for (var i:Number = 0; i < dIcon.length; ++i) {
				dIcon[i].AddAnimation(3 * i + 1, function(proc, obj) {
					if (proc == 100) {
						obj.PopIn();
					}
				});
			}
			dIcon[2].AddAnimation(1, function(proc, obj) {
				if (proc == 0) {
					obj.root.UiSound('login');  
				}
			});
		}

		override public function Init() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, MouseMove);
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
		}
		
		private function KeyDown(e:KeyboardEvent) {
			if (!IsFocus()) return;
			
			if (e.charCode >= 97 && e.charCode <= 108 && e.charCode - 97 < indexN) {
				var sel:Boolean = dIcon[e.charCode - 97].isOver;
				if (sel) {
					selectIndex = e.charCode - 97;
				}
				for (var i:Number = 0; i < indexN; ++i) {
					if (sel) {
						dIcon[i].ChangeSelected(e.charCode-97 == i);
					} else {
						dIcon[i].ChangeOver(e.charCode-97 == i);
					}
				}
			}
		}
		
		private function MouseMove(e:MouseEvent) {
			if (!IsFocus()) return;
			
			var x:Number = Math.floor(4 * root.mouseX / stage.stageWidth);
			var y:Number = Math.floor(3 * root.mouseY / stage.stageHeight);
			var s:Number = y * 4 + x;
			for (var i:Number = 0; i < indexN; ++i) {
				dIcon[i].ChangeOver(s == i);
			}
		}
		
		private function MouseDown(e:MouseEvent) {
			if (!IsFocus()) return;
			
			var x:Number = Math.floor(4 * root.mouseX / stage.stageWidth);
			var y:Number = Math.floor(3 * root.mouseY / stage.stageHeight);
			var s:Number = y * 4 + x;
			selectIndex = s;
			for (var i:Number = 0; i < indexN; ++i) {
				dIcon[i].ChangeSelected(s == i);
			}
		}
		
		public function IsFocus() {
			return (isReady && dep == 0) && (dIcon[indexN-1].isReady);
		}

	}
	
}
