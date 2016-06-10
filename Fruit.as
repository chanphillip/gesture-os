package  {
	
	import flash.display.MovieClip;
	//import flash.filters.GlowFilter;
	
	public class Fruit extends Animation {
		
		private static var GRAVITY:Number = 0.2;
		//public var filterArray:Array = [new GlowFilter(0xFFFFFF, 1, 0, 0, 1, 1, false)];
		
		private static var soundN:Number = 0;
		
		public var spdX:Number = 0;
		public var spdY:Number = 0;
		public var spdR:Number = 0;
		public var id:Number = 0;
		public var alive:Boolean = true;
		public var removed:Boolean = false;
		
		public function Fruit() {
			
		}
		
		public function Set(sx:Number, sy:Number, sr:Number) {
			id = Math.floor(Math.random() * this.totalFrames) + 1;
			this.gotoAndStop(id);
			spdX = sx;
			spdY = sy;
			spdR = sr;
		}
		
		public function Update() {
			this.x += spdX;
			this.y += spdY;
			spdY += GRAVITY;
			this.rotation += spdR;
			/*if (!alive) {
				aniI++;
				this.alpha = Math.pow(30 - aniI, 3)/27000;	// in
				this.scaleX = (2 - this.alpha) * 3;	// in
				this.scaleY = this.scaleX;
				
				if (aniI >= 30) {
					parent.removeChild(this);
					return true;
				}
			}
			if (this.y >= 300) {
				parent.removeChild(this);
				return true;
			}*/
			
			if (this.y >= 300) {
				removed = true;
			}
			
			if (alive && this.hitTestObject((parent as MovieClip).shapeHit)) {
				alive = false;
				
				(root as MovieClip).UiSound('fruithit'+(soundN + 1));
				soundN = (soundN + 1) % 4;
				
				AddAnimation(30, function(proc, obj) {
					obj.alpha = Math.pow(100 - proc, 3)/1000000;	// in
					obj.scaleX = (2 - obj.alpha) * 3;	// in
					obj.scaleY = obj.scaleX;
					if (proc == 100) {
						removed = true;
						obj.CleanUp();
					}
				});
				(parent as MovieClip).AddScore();
			}
		}
	}
	
}
