package {
	
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	
	public class Dialog extends Animation {
		
		public var isReady:Boolean = false;
		public var isDefaultDialog:Boolean = true;
		
		private static var aniSpeed:Number = 5;
		public var filterArray:Array = [new GlowFilter(0xFFFFFF, .7, 16, 16, 2, 1, false), new GlowFilter(0xFFFFFF, 1, 4, 4, 1, 1, true), new BlurFilter(0, 0, 1)];
		public var filterEnable:Array = [false, false, false];
		
		public function Dialog() {
			this.alpha = 0;
			this.x = 0;
			this.y = 0;
			UpdateFilters();
		}
		
		public function IsFocus() {
			var par:MovieClip = (this.parent as MovieClip);
			if (!par) return false;
			return (par.isReady && par.dep == 0);
		}
		
		public function Die() {
			AddAnimation(0, function(proc, obj) {
				CleanUp();
				obj.parent.CleanUp();
			});
		}
		
		override public function CleanUp() {
			super.CleanUp();
			
			for (var i:Number = 0; i < filterArray.length; ++i) {
				filterArray[i] = null;
			}
			filterArray.length = 0;
		}
		
		public function MoveTo(x:Number, y:Number) {
			this.x = x - 427;
			this.y = y - 240;
		}
		
		public function Ready() {
			
		}
		
		public function FadeIn() {
			AddAnimation(20, function(proc, obj) {
				obj.alpha = 1 - Math.pow(100 - proc, 3)/1000000;	// in

				obj.filterArray[2].blurX = (Math.pow(100 - proc, 3)/1000000)*5;
				obj.filterArray[2].blurY = obj.filterArray[2].blurX;
				UpdateFilters();
				if (proc == 100) {
					isReady = true;
					Ready();
				}
			});
		}
		
		public function FadeOut() {
			isReady = false;
			AddAnimation(20, function(proc, obj) {
				obj.alpha = Math.pow(100 - proc, 3)/1000000;	// out
			});
		}
		
		public function PopIn() {
			this.scaleX = .02;
			this.scaleY = this.scaleX;
			AddAnimation(3, function(proc, obj) {
				obj.alpha = 1 - Math.pow(100 - proc, 3)/1000000;	// in
			});
			AddAnimation(8, function(proc, obj) {
				obj.scaleX = .98 * (1 - Math.pow(100 - proc, 3)/1000000) + .02;
				if (proc == 100) {
					if (isDefaultDialog) {
						obj.root.UiSound('opening');
					}
				}
			});
			AddAnimation(8, function(proc, obj) {
				obj.scaleY = .98 * (1 - Math.pow(100 - proc, 3)/1000000) + .02;
				if (proc == 100) {
					isReady = true;
					Ready();
				}
			});
		}
		
		public function PopOut() {
			isReady = false;
			AddAnimation(20, function(proc, obj) {
				obj.alpha = Math.pow(100 - proc, 3)/1000000;	// out
				obj.scaleX = .2 * Math.pow(proc, 3)/1000000 + 1;
				obj.scaleY = obj.scaleX;
				
				obj.filterArray[2].blurX = (1 - Math.pow(100 - proc, 3)/1000000)*2;
				obj.filterArray[2].blurY = obj.filterArray[2].blurX;
				obj.filters = obj.filterArray;
				UpdateFilters();
				
				if (proc == 0) {
					if (isDefaultDialog) {
						obj.root.UiSound('closing');
					}
				}
			});
		}
		
		public function UpdateFilters() {
			var arr:Array = [];
			for (var i:Number = 0; i < filterArray.length; ++i) {
				if (filterEnable[i]) {
					arr.push(filterArray[i]);
				}
			}
			this.filters = arr;
		}
		
	}
	
}
