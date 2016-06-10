package  {
	
	import flash.display.MovieClip;
	
	public class LevelContainerApp0 extends LevelContainer {

		public var dialog:DialogApp0 = new DialogApp0();
		
		public function LevelContainerApp0() {
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
