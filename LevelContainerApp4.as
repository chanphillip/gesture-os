package  {
	
	import flash.display.MovieClip;
	
	public class LevelContainerApp4 extends LevelContainer {

		public var dialog:DialogApp4 = new DialogApp4();
		
		public function LevelContainerApp4() {
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
