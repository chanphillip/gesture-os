package  {
	
	//import main papervision assets
	/*import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.cameras.FreeCamera3D;

	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	//

	import org.papervision3d.objects.parsers.Collada;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.events.FileLoadEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import flash.display.Stage;
	import flash.events.MouseEvent;*/
	
	public class DialogApp1 extends Dialog {
		
		/*private var scene:Scene3D;
		private var viewport:Viewport3D;
		private var camera:FreeCamera3D;
		private var renderer:BasicRenderEngine;

		//other things needed for dae

		public var car:DisplayObject3D;
		public var carframe:DAE;
		public var carframe2:DAE;
		public var wheelfl:DAE;
		public var wheelfr:DAE;
		public var wheelbl:DAE;
		public var wheelbr:DAE;
		public var seat:DAE;*/
		
		public function DialogApp1() {
			
		}
		
		/*override public function Ready() {
			Init3D();
		}
		
		public function test1() {
			scene.removeChild(car);
		}
		
		public function test2() {
			scene.addChild(car);
		}
		
		private function Init3D()
		{
			//Setup viewport, add to stage
			viewport = new Viewport3D(760, 440, false, false, true);
			addChild(viewport);
			viewport.x = -380;
			viewport.y = -220;

			//Setup renderer
			renderer = new BasicRenderEngine();

			camera = new FreeCamera3D(1, 500);
			camera.moveUp(200);

			//Setup scene
			scene = new Scene3D();

			car = new DisplayObject3D();
			car.scale = 80;
			car.y = 120;
			
			//------
			var carMatList:MaterialsList = new MaterialsList();

			var carMat:BitmapFileMaterial = new BitmapFileMaterial("Images/vehicle_texture_1.jpg");
			carMat.doubleSided = true;
			carMatList.addMaterial(carMat, "car_SG");
			
			carframe = new DAE();
			carframe2 = new DAE();
			wheelfl = new DAE();
			wheelfr = new DAE();
			wheelbl = new DAE();
			wheelbr = new DAE();
			seat = new DAE();
			
			carframe.load("Images/car_shell_001.dae", carMatList);
			carframe2.load("Images/car_frame_001.dae");
			wheelfl.load("Images/car_wheel_001.dae", carMatList);
			wheelfr.load("Images/car_wheel_001.dae", carMatList);
			wheelbl.load("Images/car_wheel_001.dae", carMatList);
			wheelbr.load("Images/car_wheel_001.dae", carMatList);
			seat.load("Images/car_seat.dae");
			
			carframe.y = -1.1;
			
			wheelfl.x = 3.2;
			wheelbl.x = 3.2;
			wheelfr.x = -3.2;
			wheelbr.x = -3.2;
			
			wheelfl.z = -6;
			wheelfr.z = -6;
			wheelbl.z = 4.6;
			wheelbr.z = 4.6;
			wheelfl.rotationY = 180;
			wheelbl.rotationY = 180;
		
			seat.scale = 0.007;
			seat.moveBackward(3.7);
			seat.moveLeft(3.4);
		
			carframe2.scale = 0.06;
			carframe2.moveBackward(12.8);
			carframe2.moveLeft(15);
			//carframe2.moveUp(1);
			//carframe2.x = -2000;
			//carframe2.z = -100;
			
			car.addChild(carframe);
			car.addChild(carframe2);
			car.addChild(wheelfl);
			car.addChild(wheelfr);
			car.addChild(wheelbl);
			car.addChild(wheelbr);
			car.addChild(seat);
			
			scene.addChild(car);
			//------
			
			addEventListener(Event.ENTER_FRAME, Render3D);
		}
		
		public function DrawCar(d:String) {
			
			if (car.numChildren > 0) {
    			car.removeChild(carframe);
			}
			
			var carMatList:MaterialsList = new MaterialsList();
			
			var carMat:BitmapFileMaterial = new BitmapFileMaterial("Images/vehicle_texture"+d+".jpg");
			carMat.doubleSided = true;
			carMatList.addMaterial(carMat, "car_SG");
			
			carframe = new DAE();
			carframe.load("Images/car_shell_001.dae", carMatList);
			
			car.addChild(carframe);
		}
		
		private function Render3D(e:Event):void
		{
			var mx:Number = Math.min(200, root.mouseX);
			var my:Number = Math.min(200, root.mouseY);
			car.rotationX = (mx / 200 - .5) * 180;
			car.rotationZ = (my / 200 - .5) * 180;
			
			trace(mx+', '+my);
			
			var d:Number = mouseX * 5 / stage.stageWidth + 3.2;
			wheelfl.x = d;
			wheelbl.x = d;
			wheelfr.x = -d;
			wheelbr.x = -d;
			
			d = mouseX * 5 / stage.stageWidth - 1.1;
			carframe.y = d;
			
			d = mouseX * 3 / stage.stageWidth;
			seat.y = d;
			
			camera.lookAt(car);
			
			renderer.renderScene(scene, camera, viewport);

		}
		*/
	}
	
}
