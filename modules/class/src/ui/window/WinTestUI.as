/**Created by the LayaAirIDE,do not modify.*/
package ui.window {
	import laya.ui.*;
	import laya.display.*; 
	import view.window.view.WinItem;

	public class WinTestUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":200,"height":200},"child":[{"type":"Label","props":{"y":116,"x":42,"text":"分包成功789788","fontSize":20}},{"type":"Image","props":{"y":17,"x":11,"skin":"comp/bg.png"}},{"type":"WinItem","props":{"y":14,"x":101,"runtime":"view.window.view.WinItem"}}]};
		override protected function createChildren():void {
			View.regComponent("view.window.view.WinItem",WinItem);
			super.createChildren();
			createView(uiView);

		}

	}
}