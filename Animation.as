package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Animation extends MovieClip {

		private var aniI:Number = 0;
		private var aniTime:Array = [];
		private var aniFunction:Array = [];
		
		private var startTime:Number = 0;
		public static var nowTime:Number = 0;

		public function Animation() {
			this.addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		
		public function CleanUp() {
			this.removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		
		public function AddAnimation(t:Number, func:Function) {
			if ((this.root as MovieClip).DEBUG) {
				if (t > 0) {
					t = 1;
				} else {
					t = -t;
				}
			}
			if (aniTime.length == 0) {
				startTime = nowTime;
			}
			aniTime.push(t);
			aniFunction.push(func);
		}
		
		public function EnterFrame(e:Event) {
			if (aniFunction.length) {
				aniI = Math.max(0, Math.floor((nowTime - startTime) / 30)-1);
				if (aniI > aniTime[0]) {
					aniI = aniTime[0];
				}
				aniFunction[0](aniI * 100 / aniTime[0], this);
				if (aniI >= aniTime[0]) {
					aniI = 0;
					aniTime.shift();
					aniFunction.shift();
					startTime = nowTime;
				}
			}
		}

	}
	
}
