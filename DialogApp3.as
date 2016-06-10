package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.display.Shape;
	import flash.filters.GlowFilter;
	
	public class DialogApp3 extends Dialog {
		
		private var gameState:Number = 0;
		private var gameScore:Number = 0;
		private var gameRound:Number = 0;
		private var gameScoreMul:Number = 0;
		private var gameLastDate:Date = new Date();
		private var fruits:Array = [];
		private var genTime:Number = 0;
		
		private var scoreAniI:Number = 0;
		private var scoreFilter:Array = [new GlowFilter(0x8B86A2, 1, 0, 0, 1, 1, false)];
		
		private var shape:Shape = new Shape();
		public var shapeHit:Shape = new Shape();
		private var lineArray:Array = [];
		
		public function DialogApp3() {
			addChild(shape);
			shape.filters = [];//[new GlowFilter(0xFFFFFF, 1, 16, 16, 2, 1, false)];
			addChild(shapeHit);
		}
		
		override public function Ready() {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, MouseMove);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.addEventListener(Event.ENTER_FRAME, UpdatingFruit);
			
			GenFruit();
		}
		
		override public function CleanUp() {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			//stage.removeEventListener(MouseEvent.MOUSE_MOVE, MouseMove);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			this.removeEventListener(Event.ENTER_FRAME, UpdatingFruit);
			
			for (var i:Number = 0; i < fruits.length; ++i) {
				if (fruits[i]) {
					removeChild(fruits[i]);
				}
				fruits[i] = null;
			}
			
			removeChild(shape);
			removeChild(shapeHit);
			
			for (i = 0; i < lineArray.length; ++i) {
				lineArray[i] = null;
			}
			
			scoreFilter[0] = null;
			fruits.length = 0;
			scoreFilter.length = 0;
			lineArray.length = 0;
			shape = null;
			shapeHit = null;
			gameLastDate = null;
		}
		
		private function KeyDown(e:KeyboardEvent) {
			if (!IsFocus()) return;
			
			if (gameState == 0 && e.keyCode == 65) {				// A
				gameState = 1;
				gameScore = 0;
				gameRound = 0;
				
				scoreDis.text = "Score: 0";
				
				(root as MovieClip).UiSound('fruitstart');
			}
		}
		
		private function GenFruit() {
			var sx:Number;
			var sy:Number;
			var sr:Number;
			var dx:Number;
			var dy:Number;
			var j:Number;
			for (var i:Number = 0; i < 10; ++i) {
				sx = Math.random() * 4 - 2;
				sy = -Math.random() * 4.5 - 11;
				sr = Math.random() * 20 - 10;
				
				dx = Math.random() * 500 - 250;
				dy = Math.random() * 30;
				
				j = fruits.length;
				fruits[j] = new Fruit();
				fruits[j].Set(sx, sy, sr);
				addChild(fruits[j]);
				fruits[j].x = dx;
				fruits[j].y = 280 + dy;
			}
		}
		
		private function MouseDown(e:MouseEvent) {
			//gameState = 1;
		}
		
		private function UpdatingFruit(e:Event) {
			if (IsFocus()) {
				if (gameState == 1) {
					if (fruits.length) {
						for (var i:Number = 0; i < fruits.length; ++i) {
							if (!fruits[i].removed) {
								fruits[i].Update();
							} else {
								removeChild(fruits[i]);
								fruits[i] = null;
								fruits.splice(i, 1);
								--i;
							}
						}
						if (fruits.length == 0) {
							genTime = Math.floor(Math.random() * 20) + 10;
						}
					} else {
						--genTime;
						if (genTime == 0) {
							GenFruit();
							if (++gameRound >= 8) {
								(root as MovieClip).UiSound('fruitend');
								scoreDis.text = "Got "+gameScore+"!";
								gameState = 0;
								genTime = Math.floor(Math.random() * 20) + 10;
							} else {
								(root as MovieClip).UiSound('fruitsend'+Math.floor(Math.random()*3 + 1));
							}
						}
					}
				}
				
				//-------
				lineArray.push([mouseX, mouseY]);
				if (lineArray.length < 7) {
					for (i = 1; i < 7; ++i) {
						lineArray.push([mouseX, mouseY]);
					}
				} else {
					lineArray.shift();
				}
				
				var dis:Number;
				var b:Boolean = false;
				shape.graphics.clear();
				for (i = 1; i < 7; ++i) {
					dis = Math.sqrt(Math.pow(lineArray[i][0] - lineArray[i-1][0], 2)+Math.pow(lineArray[i][1] - lineArray[i-1][1], 2));
					
					if (dis > 30) {
						shape.graphics.lineStyle((i <= 4 ? i : (8-i)), 0xFFFFFF, 1);
						shape.graphics.moveTo(lineArray[i-1][0], lineArray[i-1][1]);
						shape.graphics.lineTo(lineArray[i][0], lineArray[i][1]);
						if (i == 6) {
							b = true;
						}
					}
				}
				
				shapeHit.graphics.clear();
				if (b) {
					shapeHit.graphics.lineStyle(3, 0xFF0000, 0);
					shapeHit.graphics.moveTo(lineArray[6][0], lineArray[6][1]);
					shapeHit.graphics.lineTo(lineArray[5][0], lineArray[5][1]);
					//shapeHit.graphics.moveTo(lineArray[5][0], lineArray[5][1]);
					//shapeHit.graphics.lineTo(lineArray[4][0], lineArray[4][1]);
				}
				
				//-----
				if (scoreAniI > 0) {
					--scoreAniI;
					
					//scoreFilter[0].blurX = scoreAniI * 9;
					//scoreFilter[0].blurY = scoreFilter[0].blurX;
					//scoreDis.filters = scoreFilter;
					scoreDis.scaleX = 1 + scoreAniI / 10;
					scoreDis.scaleY = scoreDis.scaleX;
				}
			}
		}
		
		public function AddScore() {
			var d:Date = new Date();
			var td:Number = d.valueOf()-gameLastDate.valueOf();
			gameLastDate = d;
			
			if (td == 0) {
				++gameScoreMul;
			} else {
				gameScoreMul = 0;
			}
			
			var scoreAniITmp:Number = Math.min(1 + gameScoreMul, 5);
			if (scoreAniITmp > scoreAniI) {
				scoreAniI = scoreAniITmp;
			}
			
			gameScore += 1 * (1 + gameScoreMul);
			scoreDis.text = "Score: "+gameScore;
		}
	}
	
}
