<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%--<meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
 --%>   
 	<meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>修改资料</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input id="contextPath" value="${pageContext.request.contextPath }" style="display:none;"/>
    <!-- 控制器中返回的信息. -->
    <input id="msg" value="${msg}" style="display:none;"/>
    <script src="${ path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
	<link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/publicCourse.css">
<style>
		*{
			padding: 0;
			margin: 0;
		}
		ol, ul, li{
			list-style: none;
		}
		a{
			text-decoration: none;
		}
		html{
			font-size: 12px;
		}
		body{
			width: 90rem;
			font-size: 3rem;
			padding-bottom:18rem;
		}
		.pic{
			/* background-color: red; */
			width: 22rem;
			height: 22rem;
			margin: 9rem auto 0;
			border-radius: 100%;
			border: 1rem solid #f3f3f3;
		}
		.pic img{
			width: 100%;
			height: 100%;
		}
		p{
			margin: 6.5rem 0 0 0;
			text-align: center;
			font-size: 4rem;
			color: #333;
		}
		p input{
			font-size: 3rem;
			bord
		}
		.line{
			margin: 5.5rem auto 0;
			background-color: #e4e4e4;
			width: 70%;
			height: 0.5rem;
			border-radius: 0.25rem;
			position: relative;
		}
		.line span{
			position: absolute;
			display: inline-block;
			height: 0.5rem;
			width: 20%;
			left: 40%;
			background-color: #fff;
		}
		.line-list{
			width: 100%;
		}
		.line-list li{
			width: 100%;
			margin-top: 6rem;
		}
		.line-list li p{
			color: #66666;
			text-align: left;
			width: 60%;
			margin-left: 20%;
		}
		.line-list li p>span{
	        color:red;
		}
		.line-list li p input{
		    padding:0 1rem;
		    margin-left:1rem;
		    border:0;
		    border-bottom:0.3rem solid #e4e4e4;
		}
		.subbtn{
		    padding:1rem;
		}
	    .timgUrl1{
		    display:none;
		} 
	</style>
</head>
<body>
<form action="${pageContext.request.contextPath }/user/updateUserProfile" 
 onsubmit="return sub()" method="POST" enctype="multipart/form-data"><!--   enctype="multipart/form-data" -->
<div >
	<div class="pic">
		<img id="preview" name="pic" src="${user.headImgUrl }" >
		<!-- 添加修改图片功能 -->
	</div>
	<ul class="line-list">
	   <li>
	     <p>
	                      选择图片: <span id="clickMe">点击选择图片</span>
	             <input type="file" id="f" value="上传图片" class="timgUrl1" name="timgUrl1" onchange="change()">
	     </p>
	   </li>
	   <li>
	      <p>
		              昵称:<input type="text" name="userName" value="${user.userName}" required="required"  />
	      </p>
	   </li>
	   <li>
	      <p>
		            邮箱:<input type="text" name="email" value="${user.email}" required="required"  />
	      </p>
	   </li>
	</ul>
	<p><input class="subbtn" type="submit" id="subbtn"  value="提交" /></p>
</div>
</form>

<div style="width:100%;height:40px;"></div>	
<%@include file="../commonFoot4.jsp" %>
</body>

<script type="text/javascript">
	var contextpath = $('#contextPath').val();
	var msg =  $('#msg').val();
	$(function(){
		if(msg != "" ){
			if(confirm("您还没登录,确定登录吗？")){
	  	    	window.location.href=encodeURI(contextpath+"/public/login");//跳转登录页
	  	     }
		}
	})
	
	function sub(){
		 $("#subbtn").val("修改提交中...");
		 $("#subbtn").attr("disabled","disabled");
	   return true;
	}
	function change() {
		var pic = document.getElementById("preview"), file = document
				.getElementById("f");
		
		var ext = file.value.substring(file.value.lastIndexOf(".") + 1)
				.toLowerCase();

		// gif在IE浏览器暂时无法显示
		if (ext != 'png' && ext != 'jpg' && ext != 'jpeg') {
			alert("图片的格式必须为png或者jpg或者jpeg格式！");
			return;
		}
		var isIE = navigator.userAgent.match(/MSIE/) != null, isIE6 = navigator.userAgent
				.match(/MSIE 6.0/) != null;

		if (isIE) {
			file.select();
			var reallocalpath = document.selection.createRange().text;

			// IE6浏览器设置img的src为本地路径可以直接显示图片
			if (isIE6) {
				pic.src = reallocalpath;
			} else {
				// 非IE6版本的IE由于安全问题直接设置img的src无法显示本地图片，但是可以通过滤镜来实现
				pic.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='image',src=\""
						+ reallocalpath + "\")";
				// 设置img的src为base64编码的透明图片 取消显示浏览器默认图片
				pic.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==';
			}
		} else {
			html5Reader(file);
		}
	}
	
	function html5Reader(file) {
		var file = file.files[0];
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e) {
			var pic = document.getElementById("preview");
			pic.src = this.result;
		}
	}
	
	$("#clickMe").click(function(){
		$("#f").click();
	})
	$("#preview").click(function(){
		$("#f").click();
	})
</script>
</html>
