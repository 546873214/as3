/**Created by the LayaAirIDE,do not modify.*/
package ui.window.view {
	import laya.ui.*;
	import laya.display.*; 

	public class WinItemUI extends View {
		public var lblTest:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":100,"height":100},"child":[{"type":"Label","props":{"y":21,"x":17,"var":"lblTest","text":"label","fontSize":20}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}