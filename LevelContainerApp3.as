package  {
	
	import flash.display.MovieClip;
	
	public class LevelContainerApp3 extends LevelContainer {

		public var dialog:DialogApp3 = new DialogApp3();
		
		public function LevelContainerApp3() {
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
