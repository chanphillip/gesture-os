package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filters.GlowFilter;
	import flash.media.Sound;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	
	public class DialogApp2 extends Dialog {
		
		public var filterSel:Array = [new GlowFilter(0xFFFFFF, 1, 16, 16, 2, 1, false)];
		public var selNote:Number = 0;
		private var downNote:Array = [];
		private var downKey:Array = [false, false, false, false, false];
		
		private var sounds:Array = [new PianoNote0(), new PianoNote1(), new PianoNote2(), new PianoNote3(), new PianoNote4(), new PianoNote5(), new PianoNote6(), new PianoNote7(), new PianoNote8(), new PianoNote9(), new PianoNote10(), new PianoNote11(), new PianoNote12(), new PianoNote13()];
		private var soundsChl:Array = [];
		
		public function DialogApp2() {
			for (var i:Number = 0; i < 14; ++i) {
				this['k'+i].alpha = 0;
				this['kw'+i].alpha = 0;
				
				soundsChl[i] = new SoundChannel();
			}
		}
		
		override public function Ready() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.addEventListener(Event.ENTER_FRAME, UpdatingKey);
		}
		
		override public function CleanUp() {
			super.CleanUp();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.removeEventListener(Event.ENTER_FRAME, UpdatingKey);
			
			for (var i:Number = 0; i < sounds.length; ++i) {
				sounds[i] = null;
			}
			for (i = 0; i < soundsChl.length; ++i) {
				soundsChl[i] = null;
			}
			
			filterSel.length = 0;
			sounds.length = 0;
		}
		
		private function UpdatingKey(e:Event) {
			if (!IsFocus()) return;
			
			var tar:Number = 0;
			var tar2:Number = 0;
			for (var i:Number = 0; i < 14; ++i) {
				
				if (i >= selNote && i <= selNote+4) {
					tar = .7;			// - ((2 - Math.abs(i - selNote - 2)) * .15);
					//this['k'+i].filters = filterSel;
					
					if (downKey[i-selNote] && !downNote[i]) {
						downNote[i] = true;
						soundsChl[i] = sounds[i].play();
					} else if (!downKey[i-selNote] && downNote[i]) {
						downNote[i] = false;
					}
					
					if (downNote[i]) {
						tar2 = .5;
					} else {
						tar2 = 1;
					}
				} else {
					
					if (downNote[i]) {
						downNote[i] = false;
					}
					
					tar = 0;
					this['k'+i].filters = [];
					tar2 = 1;
				}
				
				if (tar > this['k'+i].alpha) {
					this['k'+i].alpha += Math.max(.01, (tar - this['k'+i].alpha) / 5);
					if (this['k'+i].alpha > tar) this['k'+i].alpha = tar;
				} else if (tar < this['k'+i].alpha) {
					this['k'+i].alpha -= Math.max(.01, (this['k'+i].alpha - tar) / 5);
					if (this['k'+i].alpha < tar) this['k'+i].alpha = tar;
				}
				
				if (tar2 > this['k'+i].scaleX) {
					this['k'+i].scaleX += Math.max(.01, (tar2 - this['k'+i].scaleX) / 2);
					if (this['k'+i].scaleX > tar2) this['k'+i].scaleX = tar2;
					this['k'+i].scaleY = this['k'+i].scaleX;
				} else if (tar2 < this['k'+i].scaleX) {
					this['k'+i].scaleX -= Math.max(.01, (this['k'+i].scaleX - tar2) / 2);
					if (this['k'+i].scaleX < tar2) this['k'+i].scaleX = tar2;
					this['k'+i].scaleY = this['k'+i].scaleX;
				}
				
				this['kw'+i].alpha = (1 - tar2) * 2;
				
			}
			
			//---------
			if (!downKey[0] && !downKey[1] && !downKey[2] && !downKey[3] && !downKey[4]) {
				selNote = Math.max(-4, Math.min(Math.floor(stage.mouseX / 10) - 4, 13));
			}
		}
		
		private function KeyDown(e:KeyboardEvent) {
			if (!IsFocus()) return;
			
			if (e.charCode >= 49 && e.charCode <= 53) {
				var k:Number = e.charCode - 49;
				var n:Number = k + selNote;
				
				if (!downKey[k]) {
					if (n >= 0 && n <= 13 && !downNote[n]) {
						downNote[n] = true;
						soundsChl[n] = sounds[n].play();
					}
				} else {
					if (n >= 0 && n <= 13) {
						downNote[n] = false;
				}
					}
				downKey[k] = !downKey[k];
			}
		}
		
	}
	
}
