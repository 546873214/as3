/*[COMPILER OPTIONS:ForcedCompile]*/
package core
{
	import other.UserUI;
	
	import utils.GameUtil;

	public class HelloWorld
	{
		public function HelloWorld()
		{
			trace("子模块已加载");
			var ret:int = GameUtil.add(3333,4444);
			trace("运算结果",ret);
			var user:UserUI = new UserUI();
			//user.init();
			Laya.stage.addChild(user);
		}
	}
}