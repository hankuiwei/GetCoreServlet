<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学生信息</title>
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
     <script src="${path }/jsp/js/publicJS/rem.js"></script>
    <script src="${path }/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${path}/jsp/js/publicJS/menuFun.js"></script>
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/global.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/header.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/students.css">
<style>
.studdent_img {
	width:
}

pre {
	white-space: pre-wrap !important;
	word-wrap: break-word !important;
	*white-space: normal !important;
}

h2 {
	color: #309bee;
}
</style>
</head>
<body>

<header id="header">
    <div class="header clearfix">
        <div class="logo">
            <img src="${path}/image/logo.png" alt="">
        </div>
        <div class="searchbox">
            <input type="text" class="search" id="search_key">
            <i class="search_icon icon iconfont icon-2fangdajing"   onclick="searchVideo('search_key')"></i>
        </div>
    </div>
</header>



<div class="content">
<div id="person_info" style="margin: 0 0.2rem;">
    <div class="person_info_first">
        <div class="studdent_img">
	        <img src="${student.pimgUrl }" alt="" class="person_img" style="width:5rem;height:5rem;margin-left:1.2rem;">
        </div>
        <div class="student_name" >
        	<%-- --%>
        	<p>${student.title}</p>
			<p>${student.heartContent}</p>
			<p>${student.info}</p> 
			
        </div>
    </div>
    <br>
    <div class="experence">
        <h2 class="info_header">成长故事</h2>
        <div class="intrduce">
        <c:if test="${not empty student.pintro}">${student.pintro}</c:if>
        <c:if test="${empty student.pintro}">暂无!</c:if>
        </div>
    </div>
    <br>
    <div>
        <h2 class="info_header">学员风采</h2>
        <ul class="medals">
            <c:if test="${not empty student.stuList}">
	           	<c:forEach items="${student.stuList}" var="ss">
			 	 <li >
			 	 	<img src="${ss.stUrl}" style="height:4rem;margin:0.8rem" />
			 	 </li>
				</c:forEach>
            </c:if>
            <c:if test="${empty student.stuList}"></c:if>
        </ul>
    </div>
</div>
</div>

<%@include file="../commonFoot2.jsp" %>
</body>
</html>