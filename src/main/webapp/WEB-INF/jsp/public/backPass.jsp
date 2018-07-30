<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>密码重置</title>
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/css/publicCSS/css/register.css">
	<script type="text/javascript">
	  var path_ctx="${pageContext.request.contextPath}";
	</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jsp/js/jquery.1.10.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jsp/js/reg.js?v=1"></script>
	<style type="text/css">
	span,input[type=submit],input[type=button],button{ cursor: pointer;}
	</style>
    <script>
        (function (doc, win) {
            var docEl = doc.documentElement,
                    resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                    recalc = function () {
                        var clientWidth = docEl.clientWidth;
                        if (!clientWidth) return;
                        if (clientWidth >= 640) {
                            docEl.style.fontSize = '100px';
                        } else {
                            docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                        }
                    };

            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window);
    </script>
</head>
<body>
<div id="register_form">
    密码重置
    <form id="subbtn" action="${pageContext.request.contextPath}/reg/backPass" method="post" onsubmit="return chekLogin(1)">
        <div><input type="text" name="phoneNo" class="phone" placeholder="手机号"></div>
        <div class="register_yz">
        	<input type="text" name="ycode" placeholder="获取验证码" class="yanzhengma">
            <button class="btn_yz" id="ycode" type="button" onclick="sendYZM(0)">获取验证码</button>
        </div>
        <div style="text-align:center;">
			<span style="color:green;" id="span_ok"></span>
		</div>
        <div><input type="password" class="password"  name="passWord"  placeholder="密码"></div>
        <div><input type="password" class="password2" name="password2"  placeholder="再次输入密码"></div>
        <div class="other_sit"><a href="${pageContext.request.contextPath }/public/login">已有账号登录</a></div>
        <div>
            <button class="btn_register" id="rregbutton" value="密码重置" >密码重置</button>
        </div>
    </form>
</div>

<%-- <%@include file="../commonFoot.jsp" %> --%>
</body>
<script type="text/javascript">
	$(function(){
		var regError="${regError}";
		if(regError.length>0&&regError!="null"){
			alert(regError);
		}
		$("#rregbutton").removeAttr("disabled");
	});
	
	 $("#rregbutton").on("click",function(){
		 $("#submit").submit();
	 });
	</script>
</html>