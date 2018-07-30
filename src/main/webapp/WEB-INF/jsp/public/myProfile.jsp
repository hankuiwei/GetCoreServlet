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
    <title>我的资料</title>
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
			border: 1.5rem solid #f3f3f3;
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
		.line{
			margin: 5.5rem auto 0;
			background-color: #e4e4e4;
			width: 70%;
			height: 0.2rem;
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
		.line-list li .line{
			width: 55%;
			margin-top: 6.5rem;
		}
	</style>
</head>
<body>
<div>
<div>
	<a href="updateMyProfile" style="color:#8fdcfc;float:right;margin-right:5rem;">修改资料</a>
</div>

	<div class="pic">
		<c:if test="${not empty user.headImgUrl}">
			<img alt="" src="${user.headImgUrl }">
		</c:if>
		<c:if test="${ empty user.headImgUrl}">
			<img src="${path }/image/headportrait.png">
		</c:if>
	</div>
	<p>
		<c:if test="${not empty user.userName}">
			<b><em style="font-style:normal;">${user.userName}</em></b>
		</c:if>
		<c:if test="${empty user.userName}">
			<b><em style="color: red;font-style:normal;">某某某</em></b>
		</c:if>
	</p>
	<div class="line"><span></span></div>
	<ul class="line-list">
		<li>
			<p>
				<c:if test="${not empty user.email}">
					邮箱:<span>${user.email}</span>
				</c:if>
				<c:if test="${ empty user.email}">
					邮箱:<b><em style="color: red;font-style:normal;">待完善</em></b>
				</c:if>
			</p>
			<div class="line"></div>
		</li>
		<li>
			<p>注册时间：<span>${user.regTime}</span></p>
			<div class="line"></div>
		</li>
		
		<c:if test="${user.isVip==1}">
		<li>
			<p>VIP到期时间:<span>${user.endTime}</span></p>
			<div class="line"></div>
		</li>
		</c:if>
		
		<li>
			<p>邀请码：<span><img alt="无法显示" src="${user.yqCodeUrl}" /></span></p>
			<div class="line"></div>
		</li>
		<li>
			<p>学习等级：<span>
							<c:if test="${leval!=null&&leval>0}">
							  <c:forEach  begin="1" end="${leval }" >
							    <img  src="${pageContext.request.contextPath}/jsp/img/starh.png">
							  </c:forEach>
							</c:if>
						</span>
			</p>
		</li>
	</ul>
</div>
<div style="width:100%;height:40px;"></div>	
<%@include file="../commonFoot4.jsp" %>
</body>

<form action="" id="subFrom" method="post">
     <!-- 小测验菜单 -->
     <input type="hidden" name="etsubject" id="etsubject">
     <input type="hidden" name="etclassify" id="etclassify">
     <input type="hidden" name="etclass" id="etclass">
     <!-- 分页参数 -->
     <input type="hidden" name="pageNo" id="pageNo">
</form>
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

</script>
</html>
