package  {
	
	import flash.display.MovieClip;
	import RubiksCube.RubiksCube;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class DialogApp1 extends Dialog {
		
		public var rbc:RubiksCube;
		
		public function DialogApp1() {
			rbc = new RubiksCube(this);
			this.addChild(rbc.spBoard);
			rbc.RenderView();
		}
		
		override public function Ready() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.addEventListener(Event.ENTER_FRAME, UpdatingRbc);
		}
		
		override public function CleanUp() {
			super.CleanUp();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.removeEventListener(Event.ENTER_FRAME, UpdatingRbc);
			
			this.removeChild(rbc.spBoard);
			rbc = null;
		}
		
		private function UpdatingRbc(e:Event) {
			if (!IsFocus()) return;
			
			//rbc.RotateWhole([stage.mouseY*360/100, stage.mouseX*360/100, 0]);
			
			rbc.Rotating();
			rbc.RenderView();
		}
		
		private function KeyDown(e:KeyboardEvent) {
			if (!IsFocus()) return;
			
			switch (e.charCode) {
				case 102: rbc.RotateFace([1, 0, 0], true); break;		// F
				case 114: rbc.RotateFace([0, 1, 0], false); break;		// R
				case 117: rbc.RotateFace([0, 0, 1], false); break;		// U
				case 100: rbc.RotateFace([0, 0, -1], false); break;		// D
				case 120: rbc.RotateFace([0, 0, -2], true); break;		// x
				case 121: rbc.RotateFace([0, -2, 0], true); break;		// y
				case 122: rbc.RotateFace([-2, 0, 0], false); break;		// z
				
				case 70: rbc.RotateFace([1, 0, 0], false); break;		// F'
				case 82: rbc.RotateFace([0, 1, 0], true); break;		// R'
				case 85: rbc.RotateFace([0, 0, 1], true); break;		// U'
				case 68: rbc.RotateFace([0, 0, -1], true); break;		// D'
				case 88: rbc.RotateFace([0, 0, -2], false); break;		// x'
				case 89: rbc.RotateFace([0, -2, 0], false); break;		// y'
				case 90: rbc.RotateFace([-2, 0, 0], true); break;		// z'
				
				case 48: rbc.FocusFace([0, 0, 0]); break;	// null
				case 49: rbc.FocusFace([1, 0, 0]); break;	// F
				case 50: rbc.FocusFace([0, 1, 0]); break;	// R
				case 51: rbc.FocusFace([0, 0, 1]); break;	// U
				case 52: rbc.FocusFace([0, 0, -1]); break;	// D
				case 53: rbc.FocusFace([0, 0, 2]); break;	// whole
				
				case 112: rbc.Randomize(); break;		// p
					
				/*case 55: rbc.RotateWhole([1, 0, 0]); break;
				case 56: rbc.RotateWhole([0, 1, 0]); break;
				case 57: rbc.RotateWhole([0, 0, 1]); break;*/
			}
		}
		
	}
	
}
