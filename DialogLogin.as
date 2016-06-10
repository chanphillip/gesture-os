package {
	
	import flash.display.MovieClip;
	
	public class DialogLogin extends Dialog {
		
		public function DialogLogin() {
			isDefaultDialog = false;
			msg1.alpha = 0;
			msg2.alpha = 0;
			img1.alpha = 0;
			img1.scaleX = 1.2;
			img1.scaleY = img1.scaleX;
			icon1.alpha = 0;
		}
		
		override public function PopIn() {
			super.PopIn();
			AddAnimation(20, function(proc, obj) {
				obj.img1.alpha = 1 - Math.pow(100 - proc, 3)/1000000;	// in
				obj.msg1.alpha = 1 - Math.pow(100 - proc, 3)/1000000;	// in
				if (proc == 0) {
					obj.root.UiSound('startup');
				}
			});
			/*AddAnimation(10, function(proc, obj) {
				obj.icon1.alpha = 1 - Math.pow(100 - proc, 3)/1000000;	// in
			});*/
			AddAnimation(0, function(proc, obj) {
				obj.icon1.isShown = true;
			});
		}
		
		public function Jump() {
			
			AddAnimation(10, function(proc, obj) {
				obj.img1.scaleX = Math.pow(100 - proc, 3)/1000000 * .2 + 1;
				obj.img1.scaleY = obj.img1.scaleX;
				obj.msg1.alpha = Math.pow(100 - proc, 3)/1000000;	// out
			});
			AddAnimation(10, function(proc, obj) {
				obj.msg2.alpha = 1 - Math.pow(100 - proc, 3)/1000000;	// in
				if (proc == 0) {
					obj.icon1.isShown = false;
					obj.root.UiSound('success');
				}
			});
			
			AddAnimation(20, function(proc, obj) {
				if (proc == 100) {
					obj.PopOut();
					obj.parent.AllPopIn();
					//obj.root.cursor.visible = true;
					obj.root.stageState = 1;
				}
			});
			
		}
		
	}
	
}