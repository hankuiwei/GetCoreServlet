<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input id="contextPath" value="${path }" style="display:none;"/>
    <script src="${path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/style.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/login.css">
    <script type="text/javascript" src="${path}/jsp/js/reg.js?v=1"></script>
	<script>
		var path_ctx = $('#contextPath').val();
		var prevLink = document.referrer;
	</script>
    <title>注册</title>
</head>
    <style>
    [contenteditable = "true"], input, textarea {
    -webkit-user-select: auto!important;
    -khtml-user-select: auto!important;
    -moz-user-select: text!important;
    -ms-user-select: text!important;
    -o-user-select: auto!important;
    user-select: text!important;
    }
    input{
    margin: 0px;
    }
    input.phoneNo,input.yanzhengma,input.passWord,input.passWord2,#usedCode,#vipUser,#user{
    width:50%;
    font-size: 12px;
    padding-left: 20px;
    }
    .loginContent .regMain p .btn{
    margin-left:0;
    }
    .loginContent .regMain p.verify input.yanzhengma{
    width:25%;
    line-height:normal;
    }
    .loginContent .regMain p .radio{
    width:3%;
    height:auto;
    margin-right:2%;
    }
    </style>
<body>
<div class="login">
    <div class="loginContent">
        <div class="loginHeader">
            <div class="loginTitle">注册厚朴教育</div>
            <div class="loginTab">已注册，<a href="login">立即登录</a></div>
        </div>
        <div class="regMain">
            <form action="${pageContext.request.contextPath}/reg/user" method="post" onsubmit="return chekLogin(0)" id="submit">
                <p><span>手机号</span><input type="text" name="phoneNo" class="phoneNo" placeholder="输入手机号"></p>
                <p class="verify">
	                <span>短信验证码</span>
	                <input type="button" class="btn button" id="ycode" type="button" onclick="sendYZM(0)" value="获取验证码">
                    <!-- <button class="btn">获取验证码</button> -->
                    <input type="text" name="ycode"  class="yanzhengma">
                </p>
               <!--  <p><span style="color:green;" id="span_ok"></span></p> -->
                
                <p><span>输入密码</span><input type="password" name="passWord" class="passWord"></p>
                <p><span>确认密码</span><input type="password" name="password2" class="passWord2"></p>
                
                <p><span>输入邀请码</span><input type="text" id="usedCode" name="usedCode"></p>
                
                <p class="regRadio">
                    <input class="radio" id="vipUser" type="radio" name="type" value="1">
                    <label for="vipUser">VIP用户</label>
                    <input class="radio" id="user" type="radio" name="type" checked="checked" value="0">
                    <label for="user">普通用户</label>
                </p>
                <input type="button" class="submit" id="rregbutton" value="立即注册">
            </form>
        </div>
    </div>
</div>

<%@include file="../commonFoot2.jsp" %>
</body>
</html>
<script>
    (function (doc, win) {
        let docEl = doc.documentElement,
            resizeEvt = "orientationchange" in window ? "orientationchange" : "resize",
            recalc = function () {
                var clientWidth = docEl.clientWidth;
                if (!clientWidth) return;
                docEl.style.fontSize = 100 * (clientWidth / 1080) + "px";
            };
        recalc();
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
    })(document, window)
    
     $(function () {
		var regError="${regError}";
		if(regError.length>0&&regError!="null"){
			alert(regError);
		}
		$("#rregbutton").removeAttr("disabled");
		
		$("#rregbutton").on("click",function(){
			 $("#submit").submit();
		 });
	
	});
</script>