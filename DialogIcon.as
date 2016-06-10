package  {
	import flash.events.Event;
	import flash.display.MovieClip;
	import fl.motion.AdjustColor;
	import flash.filters.ColorMatrixFilter;
	import flash.events.KeyboardEvent;
	
	public class DialogIcon extends Dialog {
		
		private var colorFilter:AdjustColor = new AdjustColor();
		private var colorMatrix:ColorMatrixFilter = new ColorMatrixFilter();
		
		public var isOver:Boolean = false;
		private var overI:Number = 0;
		
		public var isSelected:Boolean = false;
		private var selectedI:Number = 0;
		
		public function DialogIcon() {
			isDefaultDialog = false;
			
			colorFilter.hue = 0;
			colorFilter.saturation = 0;
			colorFilter.brightness = 0;
			colorFilter.contrast = 0;
			
			colorMatrix = new ColorMatrixFilter(colorFilter.CalculateFinalFlatArray());
			filterArray.push(colorMatrix);
			filterEnable.push(true);
			UpdateFilters();
		}
		
		override public function EnterFrame(e:Event) {
			super.EnterFrame(e);
			
			if (isReady) {
				var changed:Boolean = false;
				if (isOver) {
					if (overI < 100) {
						overI += 25;
						changed = true;
					}
				} else {
					if (overI > 0) {
						overI -= 25;
						changed = true;
					}
				}
				
				if (changed) {
					colorFilter.brightness = overI * .7;
					colorMatrix = new ColorMatrixFilter(colorFilter.CalculateFinalFlatArray());
					filterArray[3] = colorMatrix;
					
					filterArray[0].blurX = (overI / 100) * 20 + 16;
					filterArray[0].blurY = filterArray[0].blurX;
					filterArray[1].blurX = (overI / 100) * 12 + 4;
					filterArray[1].blurY = filterArray[1].blurX;
					UpdateFilters();
				}
				
				changed = false;
				if (isSelected) {
					if (selectedI < 100) {
						selectedI += 25;
						if (selectedI == 50) {
							this.parent.setChildIndex(this, this.parent.numChildren-1);
						}
						changed = true;
					}
				} else {
					if (selectedI > 0) {
						selectedI -= 25;
						changed = true;
					}
				}
				
				if (changed) {
					this.scaleX = 1 + selectedI * .2 / 100;
					this.scaleY = this.scaleX;
				}
			}
		}
		
		public function ChangeOver(b:Boolean) {
			isOver = b;
		}
		
		public function ChangeSelected(b:Boolean) {
			if (isSelected != b) {
				(root as MovieClip).UiSound('click');
			}
			isSelected = b;
		}
		
		/*public function OpenIn() {
			isReady = false;
			xTmp = this.x;
			yTmp = this.y;
			
			var par:MovieClip = (this.parent as MovieClip);
			var myIndex:Number = par.getChildIndex(this);
			for (var i:Number = 0; i < 12; ++i) {
				var oIndex:Number = par.getChildIndex(par.dmain[i]);
				if (oIndex > myIndex) {
					par.swapChildrenAt(oIndex, myIndex);
					myIndex = oIndex;
				}
			}
			
			AddAnimation(-20, function(proc, obj) {
				obj.x = xTmp + (427 - xTmp) * (1 - Math.pow(100 - proc, 3)/1000000);	// in
				obj.y = yTmp + (240 - yTmp) * (1 - Math.pow(100 - proc, 3)/1000000);	// in
				if (proc > 20) {
					obj.scaleX = 1.1 + (1 - Math.pow(100 - (proc - 20) / .8, 3)/1000000) * 2.9;
					obj.scaleY = obj.scaleX;
				}
			});
		}*/
		
	}
	
}
