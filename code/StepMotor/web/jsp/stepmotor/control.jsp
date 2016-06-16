<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv=Cache-Control content=no-cache>
<META http-equiv=Expires content=0>
<title>基于龙芯的远程实时安全控制系统</title>
<script language="JavaScript">
        function modify(mw,ms)
        {    
            //var mw = document.getElementById("mw").value ;
            //var ms = document.getElementById("ms").value
             document.getElementById("hide").src="http://localhost:8080/StepMotor/SpeedControl?which="+mw+"&speed="+ms ;
             temp=mw;
            setTimeout("win_go()",300) ;
        }

        function win_go(){
          var url=document.getElementById("hide").src;
          var which=url.substring(url.indexOf("?")+1).substring(6,7)
          document.getElementById(which+"speed").src=which+"speed.jsp?"+Math.random() ;
        
        }

	var  flag=0;
	

function setUp() {
    if(location.href.indexOf("?")==-1 || location.href.indexOf(which+'=')==-1)
    {
        return '';
    }
  
    // 获取链接中参数部分
  //  var queryString = location.href.substring(location.href.indexOf("?")+1);
    // 分离参数对 ?key=value&key2=value2
  //  var which=queryString.substring(queryString.indexOf("which")+6,queryString.indexOf("which")+7)
  //  var mode=queryString.substring(queryString.indexOf("mode")+5,queryString.indexOf("mode")+6)
   // if(which=='x')
  //      document.datax.mode[mode].checked=true
  //  else if(which=='z')
   //     document.dataz.mode[mode].checked=true
    
}

var isIE = (document.all) ? true : false;

var $ = function (id) {
	return "string" == typeof id ? document.getElementById(id) : id;
};

var Class = {
	create: function() {
		return function() { this.initialize.apply(this, arguments); }
	}
}

var Extend = function(destination, source) {
	for (var property in source) {
		destination[property] = source[property];
	}
}

var Bind = function(object, fun) {
	var args = Array.prototype.slice.call(arguments).slice(2);
	return function() {
		return fun.apply(object, args);
	}
}

var BindAsEventListener = function(object, fun) {
	return function(event) {
		return fun.call(object, Event(event));
	}
}

function Event(e){
	var oEvent = isIE ? window.event : e;
	if (isIE) {
		oEvent.pageX = oEvent.clientX + document.documentElement.scrollLeft;
		oEvent.pageY = oEvent.clientY + document.documentElement.scrollTop;
		oEvent.preventDefault = function () { this.returnValue = false; };
		oEvent.detail = oEvent.wheelDelta / (-40);
		oEvent.stopPropagation = function(){ this.cancelBubble = true; };
	}
	return oEvent;
}

var CurrentStyle = function(element){
	return element.currentStyle || document.defaultView.getComputedStyle(element, null);
}

function addEventHandler(oTarget, sEventType, fnHandler) {
	if (oTarget.addEventListener) {
		oTarget.addEventListener(sEventType, fnHandler, false);
	} else if (oTarget.attachEvent) {
		oTarget.attachEvent("on" + sEventType, fnHandler);
	} else {
		oTarget["on" + sEventType] = fnHandler;
	}
};

function removeEventHandler(oTarget, sEventType, fnHandler) {
    if (oTarget.removeEventListener) {
        oTarget.removeEventListener(sEventType, fnHandler, false);
    } else if (oTarget.detachEvent) {
        oTarget.detachEvent("on" + sEventType, fnHandler);
    } else {
        oTarget["on" + sEventType] = null;
    }
};


//滑动条程序
var Slider = Class.create();
Slider.prototype = {
  //容器对象，滑块
  initialize: function(container, bar, options) {
	this.Bar = $(bar);
	this.Container = $(container);
	this._timer = null;//自动滑移的定时器
	this._ondrag = false;//解决ie的click问题
	//是否最小值、最大值、中间值
	this._IsMin = this._IsMax = this._IsMid = false;
	//实例化一个拖放对象，并限定范围
	this._drag = new Drag(this.Bar, { Limit: true, mxContainer: this.Container,
		onStart: Bind(this, this.DragStart), onStop: Bind(this, this.DragStop), onMove: Bind(this, this.Move)
	});

	this.SetOptions(options);

	this.WheelSpeed = Math.max(0, this.options.WheelSpeed);
	this.KeySpeed = Math.max(0, this.options.KeySpeed);

	this.MinValue = this.options.MinValue;
	this.MaxValue = this.options.MaxValue;

	this.RunTime = Math.max(1, this.options.RunTime);
	this.RunStep = Math.max(1, this.options.RunStep);

	this.Ease = !!this.options.Ease;
	this.EaseStep = Math.max(1, this.options.EaseStep);

	this.onMin = this.options.onMin;
	this.onMax = this.options.onMax;
	this.onMid = this.options.onMid;

	this.onDragStart = this.options.onDragStart;
	this.onDragStop = this.options.onDragStop;

	this.onMove = this.options.onMove;

	this._horizontal = !!this.options.Horizontal;//一般不允许修改

	//锁定拖放方向
	this._drag[this._horizontal ? "LockY" : "LockX"] = true;

	//点击控制
	addEventHandler(this.Container, "click", BindAsEventListener(this, function(e){ this._ondrag || this.ClickCtrl(e);}));
	//取消冒泡，防止跟Container的click冲突
	addEventHandler(this.Bar, "click", BindAsEventListener(this, function(e){ e.stopPropagation(); }));

	//设置鼠标滚轮控制
	this.WheelBind(this.Container);
	//设置方向键控制
	this.KeyBind(this.Container);
	//修正获取焦点
	var oFocus = isIE ? (this.KeyBind(this.Bar), this.Bar) : this.Container;
	addEventHandler(this.Bar, "mousedown", function(){ oFocus.focus(); });
	//ie鼠标捕获和ff的取消默认动作都不能获得焦点，所以要手动获取
	//如果ie把focus设置到Container，那么在出现滚动条时ie的focus可能会导致自动滚屏
  },
  //设置默认属性
  SetOptions: function(options) {
	this.options = {//默认值
		MinValue:	1,//最小值
		MaxValue:	10,//最大值
		WheelSpeed: 5,//鼠标滚轮速度,越大越快(0则取消鼠标滚轮控制)
		KeySpeed: 	50,//方向键滚动速度,越大越慢(0则取消方向键控制)
		Horizontal:	true,//是否水平滑动
		RunTime:	20,//自动滑移的延时时间,越大越慢
		RunStep:	2,//自动滑移每次滑动的百分比
		Ease:		false,//是否缓动
		EaseStep:	5,//缓动等级,越大越慢
		onMin:		function(){},//最小值时执行
		onMax:		function(){},//最大值时执行
		onMid:		function(){},//中间值时执行
		onDragStart:function(){},//拖动开始时执行
		onDragStop:	function(){},//拖动结束时执行
		onMove:		function(){}//滑动时执行
	};
	Extend(this.options, options || {});
  },
  //开始拖放滑动
  DragStart: function() {
  	this.onDragStart();
	this._ondrag = true;
  },
  //结束拖放滑动
  DragStop: function() {
        var temp=document.getElementById("saveTemp").src
        var which=temp.substring(temp.length-1,temp.length)
	setTimeout(Bind(this, function(){ this._ondrag = false; }), 10);        
       modify(which,Math.round(this.MinValue + this.GetPercent() * (this.MaxValue - this.MinValue)));
},
  //滑动中
  Move: function() {
  	this.onMove();

	var percent = this.GetPercent();
	//最小值判断
	if(percent > 0){
		this._IsMin = false;
	}else{
		if(!this._IsMin){ this.onMin(); this._IsMin = true; }
	}
	//最大值判断
	if(percent < 1){
		this._IsMax = false;
	}else{
		if(!this._IsMax){ this.onMax(); this._IsMax = true; }
	}
	//中间值判断
	if(percent > 0 && percent < 1){
		if(!this._IsMid){ this.onMid(); this._IsMid = true; }
	}else{
		this._IsMid = false;
	}
  },/*
  //鼠标点击控制
  ClickCtrl: function(e) {
	var o = this.Container, iLeft = o.offsetLeft, iTop = o.offsetTop;
	while (o.offsetParent) { o = o.offsetParent; iLeft += o.offsetLeft; iTop += o.offsetTop; }
	//考虑有滚动条，要用pageX和pageY
	this.EasePos(e.pageX - iLeft - this.Bar.offsetWidth / 2, e.pageY - iTop - this.Bar.offsetHeight / 2);
  },
  //鼠标滚轮控制
  WheelCtrl: function(e) {
	var i = this.WheelSpeed * e.detail;
	this.SetPos(this.Bar.offsetLeft + i, this.Bar.offsetTop + i);
	//防止触发其他滚动条
	e.preventDefault();
  },

  //绑定鼠标滚轮
  WheelBind: function(o) {
  	//鼠标滚轮控制
	addEventHandler(o, isIE ? "mousewheel" : "DOMMouseScroll", BindAsEventListener(this, this.WheelCtrl));
  },
  //方向键控制
  KeyCtrl: function(e) {
	if(this.KeySpeed){
		var iLeft = this.Bar.offsetLeft, iWidth = (this.Container.clientWidth - this.Bar.offsetWidth) / this.KeySpeed
			, iTop = this.Bar.offsetTop, iHeight = (this.Container.clientHeight - this.Bar.offsetHeight) / this.KeySpeed;
		//根据按键设置值
		switch (e.keyCode) {
			case 37 ://左
				iLeft -= iWidth; break;
			case 38 ://上
				iTop -= iHeight; break;
			case 39 ://右
				iLeft += iWidth; break;
			case 40 ://下
				iTop += iHeight; break;
			default :
				return;//不是方向按键返回
		}
		this.SetPos(iLeft, iTop);
		//防止触发其他滚动条
		e.preventDefault();
	}
  },
  //绑定方向键
  KeyBind: function(o) {
	addEventHandler(o, "keydown", BindAsEventListener(this, this.KeyCtrl));
	//设置tabIndex使设置对象能支持focus
	o.tabIndex = -1;
	//取消focus时出现的虚线框
	isIE || (o.style.outline = "none");
  },
  */
  //获取当前值
  GetValue: function() {
	//根据最大最小值和滑动百分比取值
	return this.MinValue + this.GetPercent() * (this.MaxValue - this.MinValue);
  },
  //设置值位置
  SetValue: function(value) {
	//根据最大最小值和参数值设置滑块位置
	this.SetPercent((value- this.MinValue)/(this.MaxValue - this.MinValue));
  },
  //获取百分比
  GetPercent: function() {
	//根据滑动条滑块取百分比
	return this._horizontal ? this.Bar.offsetLeft / (this.Container.clientWidth - this.Bar.offsetWidth)
		: this.Bar.offsetTop / (this.Container.clientHeight - this.Bar.offsetHeight)
  },
  //设置百分比位置
  SetPercent: function(value) {
	//根据百分比设置滑块位置
	this.EasePos((this.Container.clientWidth - this.Bar.offsetWidth) * value, (this.Container.clientHeight - this.Bar.offsetHeight) * value);
  },
  //自动滑移(是否递增)
  Run: function(bIncrease) {
	this.Stop();
	//修正一下bIncrease
	bIncrease = !!bIncrease;
	//根据是否递增来设置值
	var percent = this.GetPercent() + (bIncrease ? 1 : -1) * this.RunStep / 100;
	this.SetPos((this.Container.clientWidth - this.Bar.offsetWidth) * percent, (this.Container.clientHeight - this.Bar.offsetHeight) * percent);
	//如果没有到极限值就继续滑移
	if(!(bIncrease ? this._IsMax : this._IsMin)){
		this._timer = setTimeout(Bind(this, this.Run, bIncrease), this.RunTime);
	}
  },
  //停止滑移
  Stop: function() {
	clearTimeout(this._timer);
        modify(temp,Math.round(this.MinValue + this.GetPercent() * (this.MaxValue - this.MinValue)));
  },
  //缓动滑移
  EasePos: function(iLeftT, iTopT) {
	this.Stop();
	//必须是整数，否则可能死循环
	iLeftT = Math.round(iLeftT); iTopT = Math.round(iTopT);
	//如果没有设置缓动
	if(!this.Ease){ this.SetPos(iLeftT, iTopT); return; }
	//获取缓动参数
	var iLeftN = this.Bar.offsetLeft, iLeftS = this.GetStep(iLeftT, iLeftN)
	, iTopN = this.Bar.offsetTop, iTopS = this.GetStep(iTopT, iTopN);
	//如果参数有值
	if(this._horizontal ? iLeftS : iTopS){
		//设置位置
		this.SetPos(iLeftN + iLeftS, iTopN + iTopS);
		//如果没有到极限值则继续缓动
		if(this._IsMid){ this._timer = setTimeout(Bind(this, this.EasePos, iLeftT, iTopT), this.RunTime); }
	}
  },
  //获取步长
  GetStep: function(iTarget, iNow) {
    var iStep = (iTarget - iNow) / this.EaseStep;
    if (iStep == 0) return 0;
    if (Math.abs(iStep) < 1) return (iStep > 0 ? 1 : -1);
    return iStep;
  },
  //设置滑块位置
  SetPos: function(iLeft, iTop) {
	this.Stop();
	this._drag.SetPos(iLeft, iTop);
  }
};
</script>
<script type="text/javascript" src="Drag.js"></script>
</head>

<body bgcolor="lightblue" onload="setUp()">
<!--	<p align="center"><font size="20" color="green"><b>步进电机控制中心
</b></font></p>  -->
<table width="1000" align="center">
	<tr align="left">
		<td align="center">电机控制</td>
                <td align="center">步进电机</td>
                <td align="center">实时数据</td>
	</tr>
	</table>
	<hr>

        <!--motor x-->
	<form name="datax">
            <table width="1000" align="center">
	<tr align="left">
	<td>
<!--		<input type="radio" name="turn" value="s" onclick="changeTurn(document.datax.turn[0].value,'x')" checked="checked"/>

启动
		<input type="radio" name="turn" value="e"

onclick="changeTurn(document.datax.turn[1].value,'x')"/>停止
		<br/><br/>
		<input type="radio" name="mode" value="0"

onclick="changeMode(document.datax.mode[0].value,'x')"checked="checked"/>

模式1
		<input type="radio" name="mode" value="1"

onclick="changeMode(document.datax.mode[1].value,'x')"/>模式2
		<input type="radio" name="mode" value="2"

onclick="changeMode(document.datax.mode[2].value,'x')"/>模式3
		<br/>
		<input type="radio" name="mode" value="3"

onclick="changeMode(document.datax.mode[3].value,'x')"/>模式4
		<input type="radio" name="mode" value="4"

onclick="changeMode(document.datax.mode[4].value,'x')"/>模式5
		<input type="radio" name="mode" value="5"

onclick="changeMode(document.datax.mode[5].value,'x')"/>模式6
-->
<iframe  frameborder="0"  border="0" name="xmode" id="xmode" scrolling="no" height="50" src="./xmode.jsp">
</iframe>


<br/>

<table><tr><td>
&nbsp;速度：</td>

<!--滑动条设置--><td>
<style type="text/css">
.sliderX{height:19px; width:270px; background-color:#eee; border:2px solid #EAE6DD; margin:10px 0;}
.barX {height:15px; width:10px; border:2px outset buttonhighlight; background-color:#D4D0C8;_font-size:0; }
</style>
        
        <div id="idSliderX" class="sliderX">
  <div id="idBarX" class="barX"></div>
</div></td></tr><tr><td>
<div id="idShow"></div> &nbsp;当前值：<span id="idCurrentValueX"></span><br />
      </td>  </tr></table>
<!--  &nbsp;&nbsp;当前百分比：<span id="idCurrentPercentX"></span>%<br />
  &nbsp;&nbsp;状态：<span id="idCurrentStateX">未开始</span><br />
  移动到：
  <input id="txtMoveX" type="text" value="50" size="5" />
  <input id="btnMoveVX" type="button" value="按实际值" />
  <input id="btnMovePX" type="button" value="按百分比" />
  <br />
-->
<iframe  frameborder="0"  border="0" name="xmode" id="xmode" scrolling="no" height="30" src="./xturn.jsp">
</iframe>
  <br>
 
</div>

<script language="JavaScript">
var sldX = new Slider("idSliderX", "idBarX", {
	onMin: function(){ $("idCurrentStateX").innerHTML = "到达开始值"; },
	onMax: function(){ $("idCurrentStateX").innerHTML = "到达结束值"; },
	onMid: function(){ $("idCurrentStateX").innerHTML = "滑动中"; },
	onMove: function(){
            document.getElementById("saveTemp").src="x"
		$("idCurrentValueX").innerHTML = Math.round(this.GetValue());
		$("idCurrentPercentX").innerHTML = Math.round(this.GetPercent() * 100);
	}
});

sldX.onMove();

$("btnMoveVX").onclick = function(){ sldX.SetValue(parseInt($("txtMoveX").value, 10)); }
$("btnMovePX").onclick = function(){ sldX.SetPercent(parseInt($("txtMoveX").value, 10) / 100); }

$("btnEaseX").onclick = function(){
	if(sldX.Ease){
		sldX.Ease = false;
		this.value = "设置缓动";
	}else{
		sldX.Ease = true;
		this.value = "取消缓动";
	}
}
</script>
                <br>
        </td>
	<td><image src="../../image/motor.jpg"></td>
<!--	<td align="right"><image src="xspeed.jpg"></td>-->
        <td align="right">
            <iframe  frameborder="0"  border="0" name="xspeed" id="xspeed" scrolling="no" height="220" src="./xspeed.html">
            </iframe>
         </td>
	</tr>
	</table>
	</form>
	<hr>







        <!--motor y -->
	<form name="datay" >
            <table width="1000" align="center">
	<tr align="left">
	<td>
<!--		<input type="radio" name="turn" value="s"

onclick="changeTurn(document.datax.turn[0].value,'y')" checked="checked"/>

启动
		<input type="radio" name="turn" value="e"

onclick="changeTurn(document.datax.turn[1].value,'y')"/>停止
		<br/><br/>
		<input type="radio" name="mode" value="0"

onclick="changeMode(document.datay.mode[0].value,'y')"checked="checked"/>

模式1
		<input type="radio" name="mode" value="1"

onclick="changeMode(document.datay.mode[1].value,'y')"/>模式2
		<input type="radio" name="mode" value="2"

onclick="changeMode(document.datay.mode[2].value,'y')"/>模式3
		<br/>
		<input type="radio" name="mode" value="3"

onclick="changeMode(document.datay.mode[3].value,'y')"/>模式4
		<input type="radio" name="mode" value="4"

onclick="changeMode(document.datay.mode[4].value,'y')"/>模式5
		<input type="radio" name="mode" value="5"

onclick="changeMode(document.datay.mode[5].value,'y')"/>模式6
-->

<iframe  frameborder="0"  border="0" name="ymode" id="ymode" scrolling="no" height="50" src="./ymode.jsp">
</iframe>

		<br/><table><tr><td>
		&nbsp;速度：</td><td>
                <!--滑动条设置-->
<style type="text/css">
.sliderY{height:19px; width:270px; background-color:#eee; border:2px solid #EAE6DD; margin:10px 0;}
.barY {height:15px; width:10px; border:2px outset buttonhighlight; background-color:#D4D0C8;_font-size:0; }
</style>

        <div id="idSliderY" class="sliderY">
  <div id="idBarY" class="barY"></div>
</div></td></tr>
<tr><td><div id="idShow">
 &nbsp;当前值：<span id="idCurrentValueY"></span><br /></td></tr></table>
<!--  &nbsp;&nbsp;当前百分比：<span id="idCurrentPercentY"></span>%<br />
 &nbsp;&nbsp;状态：<span id="idCurrentStateY">未开始</span><br />
 移动到：
  <input id="txtMoveY" type="text" value="50" size="5" />
  <input id="btnMoveVY" type="button" value="按实际值" />
  <input id="btnMovePY" type="button" value="按百分比" />
-->  <br />
 <iframe  frameborder="0"  border="0" name="ymode" id="ymode" scrolling="no" height="30" src="./yturn.jsp">
</iframe>
</div>

<script language="JavaScript">
var sldY = new Slider("idSliderY", "idBarY", {
	onMin: function(){ $("idCurrentStateY").innerHTML = "到达开始值"; },
	onMax: function(){ $("idCurrentStateY").innerHTML = "到达结束值"; },
	onMid: function(){ $("idCurrentStateY").innerHTML = "滑动中"; },
	onMove: function(){
                document.getElementById("saveTemp").src="y";
		$("idCurrentValueY").innerHTML = Math.round(this.GetValue());
		$("idCurrentPercentY").innerHTML = Math.round(this.GetPercent() * 100);
	}
});

sldY.onMove();

$("btnMoveVY").onclick = function(){ sld3.SetValue(parseInt($("txtMoveY").value, 10)); }
$("btnMovePY").onclick = function(){ sld3.SetPercent(parseInt($("txtMoveY").value, 10) / 100); }

$("btnEaseY").onclick = function(){
	if(sldY.Ease){
		sldY.Ease = false;
		this.value = "设置缓动";
	}else{
		sldY.Ease = true;
		this.value = "取消缓动";
	}
}
</script>
	</td>
        <td><image src="../../image/motor.jpg"></td>
<!--	<td align="right"><image src="yspeed.jpg"></td> -->
<!--iframe used for refresh the speed of y motor-->
        <td align="right">
            <iframe  frameborder="0" id="yspeed" name="yspeed" border="0" scrolling="no" height="220" src="./yspeed.html">
            </iframe>
         </td>
	</tr>
	</table>
	</form>
	<hr>

        <!--motor z-->
	<form name="dataz">
            <table width="1000" align="center">
	<tr align="left">
	<td>
	<!--	<input type="radio" name="turn" value="s"

onclick="changeTurn(document.datax.turn[0].value,'z')"checked="checked"/>

启动
		<input type="radio" name="turn" value="e"

onclick="changeTurn(document.datax.turn[1].value,'z')"/>停止
		<br/><br/>
		<input type="radio" name="mode" value="0"

onclick="changeMode(document.dataz.mode[0].value,'z')"checked="checked"/>

模式1
		<input type="radio" name="mode" value="1"

onclick="changeMode(document.dataz.mode[1].value,'z')"/>模式2
		<input type="radio" name="mode" value="2"

onclick="changeMode(document.dataz.mode[2].value,'z')"/>模式3
		<br/>
		<input type="radio" name="mode" value="3"

onclick="changeMode(document.dataz.mode[3].value,'z')"/>模式4
		<input type="radio" name="mode" value="4"

onclick="changeMode(document.dataz.mode[4].value,'z')"/>模式5
		<input type="radio" name="mode" value="5"

onclick="changeMode(document.dataz.mode[5].value,'z')"/>模式6
 -->
 <iframe  frameborder="0"  border="0" name="zmode" id="zmode" scrolling="no" height="50" src="./zmode.jsp">
</iframe>
 <table><tr><td>
             &nbsp;速度：</td><td>
                <!--滑动条设置-->
<style type="text/css">
.sliderZ{height:19px; width:270px; background-color:#eee; border:2px solid #EAE6DD; margin:10px 0;}
.barZ {height:15px; width:10px; border:2px outset buttonhighlight; background-color:#D4D0C8;_font-size:0; }
</style>

        <div id="idSliderZ" class="sliderZ">
  <div id="idBarZ" class="barZ"></div>
</div></td></tr><tr><td>
<div id="idShow">
   &nbsp;当前值：<span id="idCurrentValueZ"></span></td></tr></table>
<!--    &nbsp;&nbsp;当前百分比：<span id="idCurrentPercentZ"></span>%<br />
   &nbsp;&nbsp;状态：<span id="idCurrentStateZ">未开始</span><br />
 移动到：
  <input id="txtMoveZ" type="text" value="50" size="5" />
  <input id="btnMoveVZ" type="button" value="按实际值" />
  <input id="btnMovePZ" type="button" value="按百分比" />
  <br />  -->
</div>
<iframe  frameborder="0"  border="0" name="zmode" id="zmode" scrolling="no" height="30" src="./zturn.jsp">
</iframe>


<script language="JavaScript">
var sldZ = new Slider("idSliderZ", "idBarZ", {
	onMin: function(){ $("idCurrentStateZ").innerHTML = "到达开始值"; },
	onMax: function(){ $("idCurrentStateZ").innerHTML = "到达结束值"; },
	onMid: function(){ $("idCurrentStateZ").innerHTML = "滑动中"; },
	onMove: function(){
            document.getElementById("saveTemp").src="z"
		$("idCurrentValueZ").innerHTML = Math.round(this.GetValue());
		$("idCurrentPercentZ").innerHTML = Math.round(this.GetPercent() * 100);
	}
});

sldZ.onMove();

$("btnMoveVZ").onclick = function(){ sldZ.SetValue(parseInt($("txtMoveZ").value, 10)); }
$("btnMovePZ").onclick = function(){ sldZ.SetPercent(parseInt($("txtMoveZ").value, 10) / 100); }

$("btnEaseZ").onclick = function(){
	if(sldZ.Ease){
		sldZ.Ease = false;
		this.value = "设置缓动";
	}else{
		sldZ.Ease = true;
		this.value = "取消缓动";
	}
}
</script>
	</td>
	<td><image src="../../image/motor.jpg"></td>
<!--	<td align="right"><image src="zspeed.jpg"></td> -->
        <td align="right">
            <iframe  frameborder="0"  id="zspeed" name="zspeed" border="0" scrolling="no" height="220" src="./zspeed.html">
            </iframe>
         </td>
	</tr>
	</table>
	</form>
        <iframe  frameborder="0"  width="0" height="0" id="hide" name="hide" border="0" scrolling="no" src="">
        </iframe>
        <input type="hidden" id="saveTemp" name="saveTemp" src="" />

  </body>
</html>