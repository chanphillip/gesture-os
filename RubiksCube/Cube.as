package RubiksCube {
	
	public class Cube {

		private static var vertexs:Array = [[10,-10,10],[10,10,10],[-10,10,10],[-10,-10,10],[10,-10,-10],[10,10,-10],[-10,10,-10],[-10,-10,-10]];
		public var faces:Array = [[0,4,5,1],[1,5,6,2],[2,6,7,3],[3,7,4,0],[4,5,6,7],[0,1,2,3]];
		
		/*public var theta:Number = 0;
		public var phi:Number = 0;*/
		
		private var pos:Array = [0, 0, 0];
		
		public var dcm:Array = [[1, 0, 0], [0, 1, 0], [0, 0, 1]];
		public var dcmOut:Array = [[1, 0, 0], [0, 1, 0], [0, 0, 1]];
		public var faceColor:Array = [];

		public var vertexsNew:Array = [];
		public var vertexsDis:Array = [];
		public var posReal:Array = [0, 0, 0];
		
		private var par:RubiksCube = null;
		
		public function Cube(pa:RubiksCube, p:Array, clr:Array) {
			par = pa;
			faceColor = clr;
			pos = p;
		}
		/*public function Cube(t:Number, p:Number, clr:Array) {
			faceColor = clr;
			theta = t * Math.PI / 180;
			phi = p * Math.PI / 180;
		}*/
		
		public function Update() {
			for (var i:Number = 0; i < 8; ++i) {
				vertexsNew[i] = CalVertex(vertexs[i]);
				vertexsDis[i] = [par.fLen/(par.fLen-vertexsNew[i][0])*vertexsNew[i][1], -par.fLen/(par.fLen-vertexsNew[i][0])*vertexsNew[i][2]];
			}
		}
		
		private function CalVertex(v:Array) {
			
			//dcmOut = RotateDCM(rox, roy, roz);
			
			var arr:Array = [0, 0, 0];
			var arr2:Array = [0, 0, 0];
			arr[0] = v[0]*dcm[0][0] + v[1]*dcm[1][0] + v[2]*dcm[2][0];
			arr[1] = v[0]*dcm[0][1] + v[1]*dcm[1][1] + v[2]*dcm[2][1];
			arr[2] = v[0]*dcm[0][2] + v[1]*dcm[1][2] + v[2]*dcm[2][2];
			
			posReal[0] = pos[0]*dcm[0][0] + pos[1]*dcm[1][0] + pos[2]*dcm[2][0];
			posReal[1] = pos[0]*dcm[0][1] + pos[1]*dcm[1][1] + pos[2]*dcm[2][1];
			posReal[2] = pos[0]*dcm[0][2] + pos[1]*dcm[1][2] + pos[2]*dcm[2][2];
			
			arr[0] = (pos[0]*dcm[0][0] + pos[1]*dcm[1][0] + pos[2]*dcm[2][0]) * 10.8 + arr[0];
			arr[1] = (pos[0]*dcm[0][1] + pos[1]*dcm[1][1] + pos[2]*dcm[2][1]) * 10.8 + arr[1];
			arr[2] = (pos[0]*dcm[0][2] + pos[1]*dcm[1][2] + pos[2]*dcm[2][2]) * 10.8 + arr[2];
			
			var cy:Number = Math.cos(par.roz);
            var sy:Number = Math.sin(par.roz);
            var cr:Number = Math.cos(par.roy);
            var sr:Number = Math.sin(par.roy);
            var cp:Number = Math.cos(par.rox);
            var sp:Number = Math.sin(par.rox);

            var m00:Number = cy * cp;
            var m01:Number = sy * cp;
            var m02:Number = -sp;
            var m10:Number = -sy * cr + cy * sp * sr;
            var m11:Number = cy * cr + sy * sp * sr;
            var m12:Number = cp * sr;
            var m20:Number = -sy * -sr + cy * sp * cr;
            var m21:Number = cy * -sr + sy * sp * cr;
            var m22:Number = cp * cr;
			
			/*arr2[0] = arr[0]*Math.cos(rox)*Math.sin(roy)+arr[1]*Math.sin(rox)*Math.sin(roy)+arr[2]*Math.cos(roy);
			arr2[1] = -arr[0]*Math.sin(rox)+arr[1]*Math.cos(rox);
			arr2[2] = -arr[0]*Math.cos(rox)*Math.cos(roy)-arr[1]*Math.sin(rox)*Math.cos(roy)+arr[2]*Math.sin(roy);*/
			
			arr2[0] = m00*arr[0] + m10*arr[1] + m20*arr[2];
			arr2[1] = m01*arr[0] + m11*arr[1] + m21*arr[2];
			arr2[2] = m02*arr[0] + m12*arr[1] + m22*arr[2];
			
			return arr2;
		}
		
		function vec_dot(v1:Array, v2:Array) {
			var r:Number = 0;
			for (var i:Number = 0; i < 3; ++i) {
				r = r + v1[i]*v2[i];
			}
			return r;
		}
		
		function vec_cross(v1:Array, v2:Array) {
			var vo:Array = [];
			vo[0] = (v1[1]*v2[2]) - (v1[2]*v2[1]);
			vo[1] = (v1[2]*v2[0]) - (v1[0]*v2[2]);
			vo[2] = (v1[0]*v2[1]) - (v1[1]*v2[0]);
			return vo;
		}

		function vec_scale(v1:Array, sc:Number) {
			var vo:Array = [];
			for (var i:Number = 0; i < 3; ++i) {
				vo[i] = v1[i]*sc;
			}
			return vo;
		}

		function vec_add(v1:Array, v2:Array) {
			var vo:Array = [];
			for (var i:Number = 0; i < 3; ++i) {
				vo[i] = v1[i]+v2[i];
			}
			return vo;
		}

		function matrix_mul(a:Array, b:Array) {
			var t:Array = [0, 0, 0];
			var m:Array = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
			for (var i:Number = 0; i < 3; ++i) {
				for (var j:Number = 0; j < 3; ++j) {
					for (var k:Number = 0; k < 3; ++k) {
						t[k] = a[i][k]*b[k][j];
					}
					m[i][j] = t[0]+t[1]+t[2];
				}
			}
			return m;
		}
		
		public function RotateXYZ(rx:Number, ry:Number, rz:Number) {
			rx = rx * Math.PI / 180;
			ry = -ry * Math.PI / 180;
			rz = -rz * Math.PI / 180;
			
			dcm = RotateDCM(rx, ry, rz);
		}
		
		private function RotateDCM(rx:Number, ry:Number, rz:Number) {
			var dcmr:Array = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
			
			var upm:Array = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
			upm[0][0]= 0;
			upm[0][1]= -rz;//-z
			upm[0][2]= ry;//y
			upm[1][0]= rz;//z
			upm[1][1]= 0;
			upm[1][2]= -rx;//-x
			upm[2][0]= -ry;//-y
			upm[2][1]= rx;//x
			upm[2][2]= 0;
			
			var m:Array = matrix_mul(dcm, upm);
			dcmr[0][0] = dcm[0][0] + m[0][0];
			dcmr[0][1] = dcm[0][1] + m[0][1];
			dcmr[0][2] = dcm[0][2] + m[0][2];
			dcmr[1][0] = dcm[1][0] + m[1][0];
			dcmr[1][1] = dcm[1][1] + m[1][1];
			dcmr[1][2] = dcm[1][2] + m[1][2];
			dcmr[2][0] = dcm[2][0] + m[2][0];
			dcmr[2][1] = dcm[2][1] + m[2][1];
			dcmr[2][2] = dcm[2][2] + m[2][2];
			//---------------------
			var error:Number = -vec_dot(dcmr[0], dcmr[1]) / 2; //eq.19

			m[0] = vec_scale(dcmr[1], error); //eq.19
			m[1] = vec_scale(dcmr[0], error); //eq.19

			m[0] = vec_add(m[0], dcmr[0]);//eq.19
			m[1] = vec_add(m[1], dcmr[1]);//eq.19

			m[2] = vec_cross(m[0], m[1]); // c= a x b //eq.20

			var renorm:Number = (3 - vec_dot(m[0], m[0])) / 2; //eq.21
			dcmr[0] = vec_scale(m[0], renorm);

			renorm = (3 - vec_dot(m[1], m[1])) / 2; //eq.21
			dcmr[1] = vec_scale(m[1], renorm);

			renorm = (3 - vec_dot(m[2], m[2])) / 2; //eq.21
			dcmr[2] = vec_scale(m[2], renorm);
			
			return dcmr;
		}
		
		public function Round() {
			for (var i:Number = 0; i < 3; ++i) {
				for (var j:Number = 0; j < 3; ++j) {
					var tmp:Number = dcm[i][j];
					dcm[i][j] = Math.round(dcm[i][j]);
					//trace("R: "+tmp+' = '+dcm[i][j]);
				}
			}
		}

	}
	
}
