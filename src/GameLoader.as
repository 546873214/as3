package {
	import laya.net.Loader;
	import laya.utils.Handler;

	public class GameLoader {
		private var moduleFileName:String = "maingame.js";
		public function GameLoader() {
			//初始化引擎
			Laya.init(1136, 640);
			
			trace("准备加载子模块");
			
			Laya.loader.load("js/"+moduleFileName,Handler.create(this,onLoaded),null,Loader.TEXT);
		}		
		
		private function onLoaded(data:*):void
		{
			__JS__('window.eval(data + "//# sourceURL=" + this.moduleFileName )');
			//上面这句包含			//# sourceURL=文件别名      		 的语法，是为了方便调试，否则在Chrome中看不到子模块的源码且不能断点调试

			
			var hellowWorld:* = __JS__('new core.HelloWorld()');
		}
	}
}

