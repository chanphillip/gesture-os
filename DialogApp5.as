package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.filters.GlowFilter;
	
	public class DialogApp5 extends Dialog {
		
		private var sounds:Array = [new DrumSetNote0(), new DrumSetNote1(), new DrumSetNote2(), new DrumSetNote3()];
		private var soundsChl:Array = [];
		
		private var drums:Array = [];
		private var drumsI:Array = [2, 3, 1, 0];
		private var isDown:Boolean = false;
		
		public function DialogApp5() {
			for (var i:Number = 0; i < sounds.length; ++i) {
				soundsChl[i] = new SoundChannel();
			}
			for (i = 0; i < drumsI.length; ++i) {
				drums[i] = this['drum'+drumsI[i]];
			}
		}
		
		override public function Ready() {
			this.addEventListener(Event.ENTER_FRAME, Updating);
		}
		
		override public function CleanUp() {
			this.removeEventListener(Event.ENTER_FRAME, Updating);
		}
		
		private function Updating(e:Event) {
			drumLine.x = (760 * (stage.mouseX / stage.stageWidth - .5) - drumLine.x) * .3 + drumLine.x;
			drumPoint.x = drumLine.x;
			
			for (var i:Number = 0; i < drums.length; ++i) {
				if (drumPoint.x < drums[i].x) {
					if (i == 0) {
						drumPoint.y = drums[0].y;
					} else {
						drumPoint.y = (drums[i].y - drums[i-1].y) * (drumPoint.x - drums[i-1].x) / (drums[i].x - drums[i-1].x) + drums[i-1].y;
					}
					break;
				}
			}
			if (drumPoint.x >= drums[drums.length - 1].x) {
				drumPoint.y = drums[drums.length - 1].y;
			}
			
			var sc:Number = stage.mouseY / stage.stageHeight - .5;
			drumPoint.scaleX = sc * sc * 130 + 1;
			drumPoint.scaleY = drumPoint.scaleX;
			drumPoint.alpha = 1 - Math.max(0, Math.min(sc * sc * 2.5, 1));
			
			if (sc > 0) {
				if (!isDown) {
					isDown = true;
					drumPoint.gotoAndStop(2);
					
					for (i = 0; i < drums.length; ++i) {
						var dx:Number = drums[i].x - drumPoint.x;
						var dy:Number = drums[i].y - drumPoint.y;
						if (Math.sqrt(dx*dx + dy*dy) < drums[i].width/2) {
							soundsChl[drumsI[i]] = sounds[drumsI[i]].play();
							drums[i].gotoAndPlay(2);
							break;
						}
					}
				}
			} else {
				if (isDown) {
					isDown = false;
					drumPoint.gotoAndStop(1);
				}
			}
		}
	}
	
}
