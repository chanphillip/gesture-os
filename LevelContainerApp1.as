package  {
	
	import flash.display.MovieClip;
	
	public class LevelContainerApp1 extends LevelContainer {

		public var dialog:DialogApp1 = new DialogApp1();
		
		public function LevelContainerApp1() {
			addChild(dialog);
		}
		
		override public function Die() {
			super.Die();
			dialog.PopOut();
			dialog.Die();
		}
		
		override public function CleanUp() {
			super.CleanUp();
			
			removeChild(dialog);
			dialog = null;
		}

	}
	
}
