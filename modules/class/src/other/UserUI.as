package other
{
	import laya.display.Text;
	
	import ui.window.WinTestUI;

	public class UserUI extends WinTestUI
	{
		public function UserUI()
		{
			super();
			init();
		}
		public function init():void{
			trace("I am user.");
			
			var t:Text = new Text();
			t.text = "55分包成功66666666666";
			t.color = "#ffffff";
			t.pos(33,33);
			t.fontSize = 24;
			//addChild(t);
			//Laya.stage.addChild(t);
		}
	}
}