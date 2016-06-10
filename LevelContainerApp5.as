package  {
	
	import flash.display.MovieClip;
	
	public class LevelContainerApp5 extends LevelContainer {

		public var dialog:DialogApp5 = new DialogApp5();
		
		public function LevelContainerApp5() {
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
