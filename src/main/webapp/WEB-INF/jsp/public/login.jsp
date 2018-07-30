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
    <title>登陆</title>
    <script>
		var contextpath = $('#contextPath').val();
		var prevLink = document.referrer;
	</script>
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
	#phoneNo,#passWord{
	font-size: 12px;
	padding-left: 20px;
	}
	</style>
<body>
<div class="login">
    <div class="loginContent">
        <div class="loginHeader">
            <div class="loginTitle">登录厚朴教育</div>
            <div class="loginTab">未注册，<a href="register">立即注册</a></div>
        </div>
        <div class="loginMain">
            <form action="" method="post">
                <p><span>手机号</span><input type="text" name="phoneNo" id="phoneNo"  required="required" value="${user.phoneNo}" placeholder="输入手机号"></p>
                <p><span>输入密码</span><input type="password" name="passWord"  id="passWord"  required="required"  value="${user.passWord}"></p>
                <p class="loginBtnBox">
                    <a href="register" class="reg">注册</a>
                    <a href="backPass" class="forget">忘记密码</a>
                </p>
                <input class="submit" type="button" id="subbtn" value="立即登录">
                <input style="display:none;" name="prevLink" />
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
    
    $(function(){
		var loginError="${loginError}";
	 	if(loginError!="null"&&loginError!="undefined"&&loginError.length>0){
			alert(loginError);
		}
	 	//如果请求登录的页面 不是登录页 也不是 注册页, 将其保存到session中,命名为prevLink ,方便登录完成后跳转回原页面.
	 	if(prevLink.indexOf("login", 0)==-1 && prevLink.indexOf("register", 0) ==-1 ){
	 		$.ajax({
		 		url:contextpath+"/public/setSession",
		 		data:{"prevLink":prevLink},
		 		type:"post",
		 		success:function(){}
		 	});
	 	}
	 	
	 });
	 function checkLogin2(){
		 var flag=false;
		 var phoneNo=$("#phoneNo").val();
		 var passWord=$("#passWord").val();
		 if(phoneNo.length==0){
			 alert("手机号不能为空");
		 }else if(passWord.length==0){
			 alert("密码不能为空");
		 }else{
			 $("#subbtn").val("登录中...");
			 $("#subbtn").attr("disabled","disabled");
			 $("#subbtn").css("background","gray");
			 flag=true;
		 }
		 return flag;
	 }
	 
	 $("#subbtn").on("click",function(){
		 if(checkLogin2()){
			 $.ajax({
				 url:contextpath+"/user/tologin",
				 type:"post",
				 data:{"phoneNo":$("#phoneNo").val(),"passWord":$("#passWord").val()
					 ,"prevLink":document.referrer},
				 dataType:"json",
				 success:function(result){
					 if(result.user != null){
						 //如果用户存在,跳转请求登录的页面.
						 if($.trim(prevLink)==''){  
						     location.href = 'http://www.houpuclass.com/GetCoreServlet/public/myProfile';  
						 }else if($.trim(prevLink)!=null && prevLink.indexOf("login", 0) == -1 
								 && prevLink.indexOf("register", 0) == -1 ){  
						     if(prevLink.indexOf('www.houpuclass.com')==-1){    //来自其它站点  
						         location.href = 'http://www.houpuclass.com/GetCoreServlet/public/myProfile';  
						     }  
						     location.href = prevLink;  
						 }else{
							 /**防止直接跳转登录页..
								不可能有直接跳转登录页的情况--当前设定不存在这种情况							 
							 */
							 prevLink = "<%=session.getAttribute("prevLink")%>";
							 if(prevLink!="" && prevLink!="null"){
								 location.href = prevLink; 
							 }else {
						         location.href = 'http://www.houpuclass.com/GetCoreServlet/public/myProfile';  
						     }
						 }
					 }else{
						 location.reload();  
					 }				 
				 }
			 });
		 }else{
			 return false ;
		 }
		 
	 });
    
    
</script>