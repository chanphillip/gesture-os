package  {
	
	import flash.display.MovieClip;
	
	public class LevelContainerApp2 extends LevelContainer {

		public var dialog:DialogApp2 = new DialogApp2();
		
		public function LevelContainerApp2() {
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
