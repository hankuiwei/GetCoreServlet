<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
	<input id="contextPath" style="display:none;" value="${path }"/>
	<title>考试页</title>
	<!-- 
		<%-- <%=session.getAttribute("user").headImgUrl %>
		<%=session.getAttribute("user").userName %> --%>
	 -->
</head>
<script src="${path }/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${ path}/jsp/css/publicCSS/newPublic.css">

<body>
	<div class="modelbox">
	   <div class="pic">
		<c:if test="${not empty user.headImgUrl}">
			<img alt="" src="${user.headImgUrl }">
		</c:if>
		<c:if test="${ empty user.headImgUrl}">
			<img src="${path }/image/headportrait.png">
		</c:if>
	</div>
	<p class="name">
		<c:if test="${not empty user.userName}">
			<b><em style="font-style:normal;">${user.userName}</em></b>
		</c:if>
		<c:if test="${empty user.userName}">
			<b><em style="color: red;font-style:normal;">某某某</em></b>
		</c:if>
	</p>
	<div class="line"><span></span></div>
	<p>选择考试年级</p>
	<div class="select" id="select">
		<select class="grade" id="grade">
			<option value="">请选择年级</option>
		</select>
	</div>
	<p style="margin-top: 20rem;">考试时长</p>
	<p class="min"><span><img src="${path }/image/shape.png" alt=""></span>20分</p>
	<p class="start" onclick="goTestPage()">考试开始</p>
	</div>
	<%@include file="../commonFoot.jsp" %>
</body>
<script type="text/javascript">
var contextPath = $("#contextPath").val();
$(function(){

$.ajax({
	url:"${pageContext.request.contextPath}/getAllGrade",
	type:"post",
	dataType:"json",
	success:function(result){
		var options = "" ;
		for(var i =0 ;i < result.length ; i++){
			options += "<option value= '"+result[i]+"'  >"+result[i]+"</option>"
		}
		$("#grade").append(options);
	}
});

})

function goTestPage(){
	var grade = $("#grade").val();
	if(grade==""){
		alert("未选择年级");
		return false ;
	}
	var user = "${user.uid}";
	if(user=="" || user=="null"){
		if(confirm("您还没登录,要登录吗？")){
  	      window.location.href=encodeURI(contextPath+"/public/login");//跳转登录页
  	    }
		return false ;
	}
	window.location.href = encodeURI(contextPath+"/goTest?grade="+encodeURI(grade)); 
	
}
</script>
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
			color: #1faec8;
		}
		.line{
			margin: 5.5rem auto 0;
			background-color: #e4e4e4;
			width: 70%;
			height: 0.25rem;
			border-radius: 0.25rem;
			position: relative;
		}
		.line span{
			position: absolute;
			display: inline-block;
			height: 0.25rem;
			width: 20%;
			left: 40%;
			background-color: #fff;
		}
		p.name{
			color: #333;
		}
		p.start{
			color: #fff;
			background-color: #34d9f7;
			width: 37rem;
			height: 10rem;
			line-height: 10rem;
			margin: 4rem auto;
			border-radius: 1rem;
		}
		p.grade{
			margin: 0 auto;
			margin-top: 3rem;
			margin-bottom: 11.5rem;
			background: url('GetCoreServlet/image/selectbg.png') no-repeat;
			width: 676px;
			height: 87px;
			line-height: 87px;
		}
		p.min{
			margin-top: 3rem;
		}
		p.min span{
			margin-right: 1rem;
		}
		div.select{
			position: relative;
			/* background-color: red; */
			text-align: center;
		}
		div.select select{
			position: absolute;
			width: 676px;
			height:87px;
			left: 202px;
			top: 87px;
			font-size: 4rem;
			/* display: none;  */
		}
		div.select select option{
			border: 1px solid #333;
			line-width: 676px;
			height: 87px;
			line-height: 87px;
			font-size: 2rem;
			background-color: #fff;
		}
		div.nav{
		    line-height:0;
		    padding-top:1rem;
		}
		div.nav .nav-main p{
		    font-size:2rem;
		    color:#333;
		}
	</style>
</html>