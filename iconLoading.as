package  {
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class iconLoading extends MovieClip {
		
		public var isShown:Boolean = true;
		
		public function iconLoading() {
			this.addEventListener(Event.ENTER_FRAME, function() {
				rotation = rotation + 5;
				if (isShown) {
					if (alpha < 1) {
						alpha += .05;
					}
				} else {
					if (alpha > 0) {
						alpha -= .05;
					}
				}
			});
		}
	}
	
}
