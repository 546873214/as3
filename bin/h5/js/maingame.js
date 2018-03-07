
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Label=laya.ui.Label,Text=laya.display.Text,View=laya.ui.View;
//class core.HelloWorld
var HelloWorld=(function(){
	function HelloWorld(){
		console.log("子模块已加载");
		var ret=GameUtil.add(3333,4444);
		console.log("运算结果",ret);
		var user=new UserUI();
		Laya.stage.addChild(user);
	}

	__class(HelloWorld,'core.HelloWorld');
	return HelloWorld;
})()


//class utils.GameUtil
var GameUtil=(function(){
	function GameUtil(){}
	__class(GameUtil,'utils.GameUtil');
	GameUtil.add=function(a,b){
		return a+b;
	}

	return GameUtil;
})()


//class ui.window.WinTestUI extends laya.ui.View
var WinTestUI=(function(_super){
	function WinTestUI(){
		WinTestUI.__super.call(this);;
	}

	__class(WinTestUI,'ui.window.WinTestUI',_super);
	var __proto=WinTestUI.prototype;
	__proto.createChildren=function(){
		View.regComponent("view.window.view.WinItem",WinItem);
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(WinTestUI.uiView);
	}

	__static(WinTestUI,
	['uiView',function(){return this.uiView={"type":"View","props":{"width":200,"height":200},"child":[{"type":"Label","props":{"y":116,"x":42,"text":"分包成功789788","fontSize":20}},{"type":"Image","props":{"y":17,"x":11,"skin":"comp/bg.png"}},{"type":"WinItem","props":{"y":14,"x":101,"runtime":"view.window.view.WinItem"}}]};}
	]);
	return WinTestUI;
})(View)


//class ui.window.view.WinItemUI extends laya.ui.View
var WinItemUI=(function(_super){
	function WinItemUI(){
		this.lblTest=null;
		WinItemUI.__super.call(this);
	}

	__class(WinItemUI,'ui.window.view.WinItemUI',_super);
	var __proto=WinItemUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(WinItemUI.uiView);
	}

	__static(WinItemUI,
	['uiView',function(){return this.uiView={"type":"View","props":{"width":100,"height":100},"child":[{"type":"Label","props":{"y":21,"x":17,"var":"lblTest","text":"label","fontSize":20}}]};}
	]);
	return WinItemUI;
})(View)


//class other.UserUI extends ui.window.WinTestUI
var UserUI=(function(_super){
	function UserUI(){
		UserUI.__super.call(this);
		this.init();
	}

	__class(UserUI,'other.UserUI',_super);
	var __proto=UserUI.prototype;
	__proto.init=function(){
		console.log("I am user.");
		var t=new Text();
		t.text="55分包成功66666666666";
		t.color="#ffffff";
		t.pos(33,33);
		t.fontSize=24;
	}

	return UserUI;
})(WinTestUI)


/**
*...
*@author
*/
//class view.window.view.WinItem extends ui.window.view.WinItemUI
var WinItem=(function(_super){
	function WinItem(){
		WinItem.__super.call(this);
	}

	__class(WinItem,'view.window.view.WinItem',_super);
	return WinItem;
})(WinItemUI)



})(window,document,Laya);

if (typeof define === 'function' && define.amd){
	define('laya.core', ['require', "exports"], function(require, exports) {
        'use strict';
        Object.defineProperty(exports, '__esModule', { value: true });
        for (var i in Laya) {
			var o = Laya[i];
            o && o.__isclass && (exports[i] = o);
        }
    });
}