package  {
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.filters.GlowFilter;
	
	public class DialogApp0 extends Dialog {
		
		public var photoArray:Array = ["Chrysanthemum", "Desert", "Hydrangeas", "Jellyfish", "Koala", "Lighthouse", "Penguins", "Tulips"];
		
		private var ldrs:Array = [];
		private var ldrsI:Number = 0;
		private var loadedN:Number = 0;
		public var photos:Array = [];
		
		private var draggingPhoto:MovieClip = null;
		private var focusPhoto:MovieClip = null;
		
		private var draggingX:Number = 0;
		private var draggingY:Number = 0;
		
		private var isRotate:Boolean = false;
		private var isIgnored:Boolean = false;
		
		public var IsPhotoReady:Boolean = false;
		
		public function DialogApp0() {
			for (var i:Number = 0; i < photoArray.length; ++i) {
				ldrs[ldrsI] = new Loader();
				ldrs[ldrsI].load(new URLRequest("Images/photo/"+photoArray[i]+".jpg"));
				ldrs[ldrsI].contentLoaderInfo.addEventListener(Event.COMPLETE, LoadedBmp);
				++ldrsI;
			}
		}
		
		override public function Ready() {
			stage.addEventListener(Event.ENTER_FRAME, DraggingPhoto);
			stage.addEventListener(MouseEvent.MOUSE_UP, UndragPhoto);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			
			for (var i:Number = 0; i < photoArray.length; ++i) {
				photos[i].AddAnimation(i*4 + 1, function(proc, obj) {
					
				});
				photos[i].AddAnimation(20, function(proc, obj) {
					obj.alpha = 1 - Math.pow(100 - proc, 3)/1000000;	// in
				});
				if (i == photoArray.length - 1) {
					photos[i].AddAnimation(0, function(proc, obj) {
						obj.parent.icon1.isShown = false;
						obj.root.cursor.visible = true;
					});
				}
			}
		}
		
		override public function CleanUp() {
			super.CleanUp();
			stage.removeEventListener(Event.ENTER_FRAME, DraggingPhoto);
			stage.removeEventListener(MouseEvent.MOUSE_UP, UndragPhoto);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, KeyUp);
			
			for (var i:Number = 0; i < ldrs.length; ++i) {
				ldrs[i] = null;
			}
			
			for (i = 0; i < photoArray.length; ++i) {
				//photos[i].removeEventListener(MouseEvent.MOUSE_DOWN, DragPhoto);
				photos[i].CleanUp();
				removeChild(photos[i]);
			}
			
			photoArray.length = 0;
			ldrs.length = 0;
			photos.length = 0;
			draggingPhoto = null;
		}
		
		public function LoadedBmp(e:Event) {
			++loadedN;
			if (loadedN >= photoArray.length) {
				LoadAllBmp();
			}
		}
		
		public function LoadAllBmp() {
			for (var i:Number = 0; i < photoArray.length; ++i) {
				photos[i] = new Animation();
				
				var ldrBmp:Bitmap = ldrs[i].content as Bitmap;
 				var showBmp1:Bitmap = new Bitmap(ldrBmp.bitmapData);
 				showBmp1.x = -showBmp1.width / 2;
 				showBmp1.y = -showBmp1.height / 2;
				
 				photos[i].addChild(showBmp1);
				
				addChild(photos[i]);
				photos[i].scaleX = .08;
				photos[i].scaleY = photos[i].scaleX;
				photos[i].x = -330;
				photos[i].y = -180 + i * 50;
				photos[i].alpha = 0;
				
				//photos[i].addEventListener(MouseEvent.MOUSE_DOWN, DragPhoto);
				photos[i].addEventListener(MouseEvent.MOUSE_MOVE, FocusPhoto);
			}
			IsPhotoReady = true;
		}
		
		private function FocusPhoto(e:MouseEvent) {
			var obj:MovieClip = (e.target as MovieClip);
			if (focusPhoto != null) {
				focusPhoto.filters = [];
			}
			
			focusPhoto = obj;
			focusPhoto.filters = [new GlowFilter(0xFFFFFF, .7, 16, 16, 2, 1, false)];
		}
		
		/*private function DragPhoto(e:MouseEvent) {
			if (!IsFocus()) return;
			
			var obj:MovieClip = (e.target as MovieClip);
			draggingPhoto = obj;
			this.setChildIndex(obj, this.numChildren - 1);
		}*/
		
		private function DraggingPhoto(e:Event) {
			if (!IsFocus()) {
				draggingPhoto = null;
				isRotate = false;
				return;
			}
			
			if (draggingPhoto != null) {
				if (isRotate) {
					draggingX += (draggingPhoto.parent.mouseX - draggingX) / 3;
					draggingY += (draggingPhoto.parent.mouseY - draggingY) / 3;
					
					draggingPhoto.scaleX = Math.min(Math.max(.08, Math.sqrt(Math.pow(draggingX - draggingPhoto.x, 2)+Math.pow(draggingY - draggingPhoto.y, 2))/200), .5);
					draggingPhoto.scaleY = draggingPhoto.scaleX;
					
					draggingPhoto.rotation = -Math.atan2(draggingPhoto.y - draggingY, draggingX - draggingPhoto.x) * 180 / Math.PI;
				} else {
					draggingPhoto.x += (draggingPhoto.parent.mouseX - draggingPhoto.x) / 3;
					draggingPhoto.y += (draggingPhoto.parent.mouseY - draggingPhoto.y) / 3;
				}
			} else {
				var disMin:Number = 100000;
				var obj:MovieClip = photos[0];
				for (var i:Number = 0; i < photoArray.length; ++i) {
					var dis:Number = Math.sqrt(Math.pow(this.mouseX-photos[i].x, 2)+Math.pow(this.mouseY-photos[i].y, 2));
					if (dis < disMin) {
						disMin = dis;
						obj = photos[i];
					}
				}
				this.setChildIndex(obj, this.numChildren - 1);
			}
		}
		
		private function UndragPhoto(e:MouseEvent) {
			if (!IsFocus()) return;
			
			draggingPhoto = null;
		}
		
		private function KeyDown(e:KeyboardEvent) {
			if (!IsFocus()) return;
			
			if (e.keyCode == 65) {				// A
				if (!isRotate) {
					isRotate = true;
					draggingX = draggingPhoto.parent.mouseX;
					draggingY = draggingPhoto.parent.mouseY;
				}
			} else if (e.keyCode == 77) {		// M
				if (isIgnored) {
					isIgnored = false;
				} else {
					if (draggingPhoto != null) {
						focusPhoto.filters = [];
						focusPhoto = null;
						draggingPhoto = null;
						isRotate = false;
					} else {
						if (focusPhoto == null) {
							isIgnored = true;
						} else {
							draggingPhoto = focusPhoto;
							this.setChildIndex(draggingPhoto, this.numChildren - 1);
						}
					}
				}
			}
		}
		
		private function KeyUp(e:KeyboardEvent) {
			if (!IsFocus()) return;
			
			if (e.keyCode == 65) {
				isRotate = false;
			}
		}
		
	}
	
}
