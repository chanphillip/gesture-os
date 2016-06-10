package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.filters.GlowFilter;
	
	public class DialogApp4 extends Dialog {
		
		private var n:Number = 0;
		
		public function DialogApp4() {
			
		}
		
		override public function Ready() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.addEventListener(Event.ENTER_FRAME, Updating);
		}
		
		override public function CleanUp() {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.removeEventListener(Event.ENTER_FRAME, Updating);
		}
		
		private function KeyDown(e:KeyboardEvent) {
			if (!IsFocus()) return;
			
			switch (e.keyCode) {
				case 65: txtDis.text = "金錢\nMoney"; break;
				case 66: txtDis.text = "流星\nShooting star"; break;
				case 67: txtDis.text = "開心\nHappy"; break;
				case 68: txtDis.text = "父母\nParent"; break;
				case 69: txtDis.text = "可樂\nCoca Cola"; break;
			}
			if (e.keyCode >= 65 && e.keyCode <= 69) {
				n = 10;
				(root as MovieClip).UiSound('notify1');
			}
		}
		
		private function Updating(e:Event) {
			txtDis.scaleX = 1 + .5 * n / 10;
			txtDis.scaleY = txtDis.scaleX;
			txtDis.x = -txtDis.width / 2;
			txtDis.y = -txtDis.height / 2;
			if (n > 0) {
				--n;
			}
		}
	}
	
}
