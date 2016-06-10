package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.system.System;
	import flash.net.LocalConnection;
	import flash.display.StageQuality;
	
	public class SystemMon extends MovieClip {
		
		private var frames:Number = 0;
		private var timer:Number = 0;
		private var timerLast:Number = 0;
		public var fps:Number = 30;
		
		private var fpsAvg:Number = 30;
		private var fpsAvgs:Array = [30, 30, 30, 30];
		private var fpsAvgI:Number = 0;
		
		private var qual:Number = 0;
		private var qualTxt:Array = ['L', 'M', 'H', 'B'];
		
		private var cnt:Number = 0;
		
		public function SystemMon() {
			this.addEventListener(Event.ENTER_FRAME, Cal);
		}
		
		private function Cal(e:Event) {
			++frames;
			
			timer = getTimer();
			Animation.nowTime = timer;
			
			if (timer - timerLast >= 1000) {
				fps = Math.round(frames * 1000 / (timer - timerLast));
				timerLast = timer;
				frames = 0;
				
				fpsAvgs[fpsAvgI] = fps;
				fpsAvg = 0;
				for (var i:Number = 0; i < 4; ++i) {
					fpsAvg += fpsAvgs[i];
				}
				fpsAvg = fpsAvg/4;
				fpsAvgI = (fpsAvgI + 1) % 4;
				
				if ((cnt % 3) == 0) {
					/*if (fps < 15) {
						stage.quality = StageQuality.LOW;
						qual = 'L';
					} else if (fps < 22) {
						stage.quality = StageQuality.MEDIUM;
						qual = 'M';
					} else if (fps < 26) {
						stage.quality = StageQuality.HIGH;
						qual = 'H';
					} else {
						stage.quality = StageQuality.BEST;
						qual = 'B';
					}*/
					if (fpsAvg >= 30) {
						++qual;
						if (qual > 3) {
							qual = 3;
						}
					} else if (fpsAvg < 25) {
						--qual;
						if (qual < 0) {
							qual = 0;
						}
					}
					
					if (qual == 0) {
						stage.quality = StageQuality.LOW;
					} else if (qual == 1) {
						stage.quality = StageQuality.MEDIUM;
					} else if (qual == 2) {
						stage.quality = StageQuality.HIGH;
					} else {
						stage.quality = StageQuality.BEST;
					}
				}
				if ((cnt % 5) == 0) {
					ForceGC();
				}
				
				++cnt;
				
				fpsDis.text = "FPS: "+Math.round(fpsAvg)+" ("+qualTxt[qual]+")";
				memDis.text = "MEM: "+(Math.round(10 * System.totalMemory / 1048576) / 10)+"MB";
				//LevelDis.text = (root as MovieClip).level.length;
				LevelDis.text = '';
				
			}
		}
		
		public function ForceGC() {
    		try {
        		new LocalConnection().connect('foo');
        		new LocalConnection().connect('foo');
    		}
    		catch (e:*) { }
			//trace("Force GC!!");
		}
	}
	
}
