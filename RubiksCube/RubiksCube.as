package RubiksCube {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Shape;
	
	public class RubiksCube {

		public const fLen:Number = 100;

		public var spBoard:Sprite = new Sprite();
		public var shCube:Shape = new Shape();
		public var par:MovieClip;
		
		public static const RED:Number = 0xDD0000;
		public static const YELLOW:Number = 0xEEEE00;
		public static const ORANGE:Number = 0xEE9900;
		public static const GREEN:Number = 0x00DD00;
		public static const BLUE:Number = 0x0000DD;
		public static const WHITE:Number = 0xFFFFFF;
		public static const BLACK:Number = 0x333333;
		
		private var rotatingI:Number = -1;
		private var rotatingCw:Boolean = false;
		private var rotatingPos:Array = [];
		private var rotatingCubes:Array = [];
		private var rotatingRandomArr:Array = [];
		private var focusPos:Array = [0, 0, 0];

		public var rox:Number = 20 * Math.PI / 180;
		public var roy:Number = 0;
		public var roz:Number = -20 * Math.PI / 180;

		public var cubes:Array = [];

		public function RubiksCube(obj:MovieClip) {
			par = obj;
			
			spBoard.addChild(shCube);
			spBoard.scaleX = 5;
			spBoard.scaleY = 5;
			
			cubes.push(new Cube(this, [1, 1, 1], [GREEN, ORANGE, BLACK, BLACK, BLACK, YELLOW]));
			cubes.push(new Cube(this, [1, 1, -1], [GREEN, ORANGE, BLACK, BLACK, WHITE, BLACK]));
			cubes.push(new Cube(this, [1, -1, 1], [GREEN, BLACK, BLACK, RED, BLACK, YELLOW]));
			cubes.push(new Cube(this, [1, -1, -1], [GREEN, BLACK, BLACK, RED, WHITE, BLACK]));
			cubes.push(new Cube(this, [-1, 1, 1], [BLACK, ORANGE, BLUE, BLACK, BLACK, YELLOW]));
			cubes.push(new Cube(this, [-1, 1, -1], [BLACK, ORANGE, BLUE, BLACK, WHITE, BLACK]));
			cubes.push(new Cube(this, [-1, -1, 1], [BLACK, BLACK, BLUE, RED, BLACK, YELLOW]));
			cubes.push(new Cube(this, [-1, -1, -1], [BLACK, BLACK, BLUE, RED, WHITE, BLACK]));
		}
		
		public function RenderView() {
			var faces:Array = [];
			var distArr:Array = [];
			
			var midPoint:Array = [0, 0, 0];
			var dist:Number = 0;
			for (var i:Number = 0; i < cubes.length; ++i) {
				cubes[i].Update();
				
				for (var j:Number = 0; j < 6; ++j) {
					midPoint[0] = (cubes[i].vertexsNew[cubes[i].faces[j][0]][0]+cubes[i].vertexsNew[cubes[i].faces[j][1]][0]+cubes[i].vertexsNew[cubes[i].faces[j][2]][0]+cubes[i].vertexsNew[cubes[i].faces[j][3]][0])/4;
					midPoint[1] = (cubes[i].vertexsNew[cubes[i].faces[j][0]][1]+cubes[i].vertexsNew[cubes[i].faces[j][1]][1]+cubes[i].vertexsNew[cubes[i].faces[j][2]][1]+cubes[i].vertexsNew[cubes[i].faces[j][3]][1])/4;
					midPoint[2] = (cubes[i].vertexsNew[cubes[i].faces[j][0]][2]+cubes[i].vertexsNew[cubes[i].faces[j][1]][2]+cubes[i].vertexsNew[cubes[i].faces[j][2]][2]+cubes[i].vertexsNew[cubes[i].faces[j][3]][2])/4;
					
					dist = Math.sqrt(Math.pow(fLen-midPoint[0],2)+Math.pow(midPoint[1],2)+Math.pow(midPoint[2],2));
					distArr.push([dist, i, j]);
				}
			}
			distArr.sort(Sorting);
			
			shCube.graphics.clear();
			var cu:Cube;
			var fa:Array;
			for (i = 0; i < cubes.length*6; ++i) {
				
				cu = cubes[distArr[i][1]];
				fa = cu.faces[distArr[i][2]];
				
				if (Math.abs(focusPos[0]+focusPos[1]+focusPos[2]) > 0 && ((Math.abs(focusPos[0]+focusPos[1]+focusPos[2]) > 1.5) || Math.abs(cu.posReal[0] - focusPos[0]) < 0.1 || Math.abs(cu.posReal[1] - focusPos[1]) < 0.1 || Math.abs(cu.posReal[2] - focusPos[2]) < 0.1)) {
					shCube.graphics.lineStyle(2, 0x888888, 0.6); 
					shCube.graphics.beginFill(cu.faceColor[distArr[i][2]], 1);
				} else {
					shCube.graphics.lineStyle(1, 0x666666);
					shCube.graphics.beginFill(cu.faceColor[distArr[i][2]], 1);
				}
				
				shCube.graphics.moveTo(cu.vertexsDis[fa[0]][0], cu.vertexsDis[fa[0]][1]);
				shCube.graphics.lineTo(cu.vertexsDis[fa[1]][0], cu.vertexsDis[fa[1]][1]);
				shCube.graphics.lineTo(cu.vertexsDis[fa[2]][0], cu.vertexsDis[fa[2]][1]);
				shCube.graphics.lineTo(cu.vertexsDis[fa[3]][0], cu.vertexsDis[fa[3]][1]);
				shCube.graphics.lineTo(cu.vertexsDis[fa[0]][0], cu.vertexsDis[fa[0]][1]);
				shCube.graphics.endFill();
			}
		}
	
		private function Sorting(v1:Array, v2:Array) {
			return (v1[0] < v2[0] ? 1 : (v1[0] > v2[0] ? -1 : 0));
		}
		
		public function RotateFace(pos:Array, cw:Boolean) {
			if (rotatingI != -1) {
				return;
			}
			
			if (rotatingRandomArr.length > 0) {
				rotatingI = 4;
			} else {
				rotatingI = 8;
			}
			rotatingPos = pos;
			rotatingCw = cw;
			
			if (Math.abs(pos[0]+pos[1]+pos[2]) > 1.5) {
				(par.root as MovieClip).UiSound('cuberotate'+Math.floor(Math.random()*2 + 1));
				rotatingPos = [rotatingPos[0]/2, rotatingPos[1]/2, rotatingPos[2]/2];
			} else {
				(par.root as MovieClip).UiSound('cubemove'+Math.floor(Math.random()*2 + 1));
			}
			
			rotatingCubes = [];
			for (var i:Number = 0; i < 8; ++i) {
				/*trace('--------- '+i);
				trace(cubes[i].posReal[0]+' ~ '+pos[0]);
				trace(cubes[i].posReal[1]+' ~ '+pos[1]);
				trace(cubes[i].posReal[2]+' ~ '+pos[2]);*/
				if ((Math.abs(pos[0]+pos[1]+pos[2]) > 1.5) || Math.abs(cubes[i].posReal[0] - pos[0]) < 0.1 || Math.abs(cubes[i].posReal[1] - pos[1]) < 0.1 || Math.abs(cubes[i].posReal[2] - pos[2]) < 0.1) {
					rotatingCubes.push(i);
				}
			}
		}
		
		public function RotateWhole(pos:Array) {
			rox = pos[0] * Math.PI / 180;
			roy = pos[1] * Math.PI / 180;
			roz = pos[2] * Math.PI / 180;
		}
		
		public function FocusFace(pos:Array) {
			focusPos = pos;
		}
		
		public function Rotating() {
			if (rotatingI >= 0) {
				var a:Number = 0;
				if (rotatingRandomArr.length > 0) {
					a = 24.107 - 24.107 * (4 - rotatingI) / 30;		// u = 90/(t-t^2/60); a = -u/30
				} else {
					a = 13 - 13 * (8 - rotatingI) / 30;
				}
				for (var i:Number = 0; i < rotatingCubes.length; ++i) {
					if (rotatingCw) {
						cubes[rotatingCubes[i]].RotateXYZ(rotatingPos[0]*a, rotatingPos[1]*a, rotatingPos[2]*a);
					} else {
						cubes[rotatingCubes[i]].RotateXYZ(-rotatingPos[0]*a, -rotatingPos[1]*a, -rotatingPos[2]*a);
					}
				}
				
				--rotatingI;
				if (rotatingI == -1) {
					for (i = 0; i < 8; ++i) {
						cubes[i].Round();
					}
					rotatingRandomArr.splice(0, 1);
				}
			} else if (rotatingRandomArr.length > 0) {
				RotateFace(rotatingRandomArr[0], true);
			}
		}
		
		public function Randomize() {
			var pos:Array = [0, 0, 0];
			rotatingRandomArr = [];
			for (var i:Number = 0; i < 12; ++i) {
				pos = [0, 0, 0];
				pos[Math.floor(Math.random()*3)] = (Math.random() < 0.2 ? 2 : 1)*(Math.random() < 0.5 ? -1 : 1);
				rotatingRandomArr.push(pos);
			}
			//RotateFace([0, 0, 1], true);
		}

	}
	
}
