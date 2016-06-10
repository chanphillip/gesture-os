package  {
	
	import flash.display.MovieClip;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	
	public class LevelContainer extends Animation {

		public var isReady:Boolean = true;
		
		public var dep:Number = 0;
		public var depTar:Number = 0;
		public var filterArray:Array = [new BlurFilter(0, 0, 1)];
		public var filterEnable:Array = [false];
		
		public function LevelContainer() {
			
		}
		
		public function Init() {
			
		}
		
		override public function CleanUp() {
			super.CleanUp();
		}
		
		public function Die() {
			isReady = false;
		}

		public function MoveDepth(d:Number) {
			if (!isReady) {
				return;
			}
			
			isReady = false;
			depTar = d;
			if (depTar >= 0 && dep < 0) {
				this.visible = true;
			}
			AddAnimation(14, function(proc, obj) { 
				obj.scaleX = 1 - .2 * ((depTar - dep) * (1 - Math.pow(100 - proc, 3)/1000000) + dep);	// in
				obj.scaleY = obj.scaleX;
				
				filterArray[0].blurX = Math.abs(6 * ((depTar - dep) * (1 - Math.pow(100 - proc, 3)/1000000) + dep));	// in
				filterArray[0].blurY = filterArray[0].blurX;
				UpdateFilters();
				
				var a:Number = (depTar - dep) * (1 - Math.pow(100 - proc, 3)/1000000) + dep;
				if (a < 0) {
					a = -a * 3.5;
				}
				obj.alpha = Math.max(0, 1 - .3 * a);	// in
				
				if (proc == 100) {
					dep = depTar;
					isReady = true;
					if (dep < 0) {
						obj.visible = false;
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
