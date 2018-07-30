<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    --%>
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>购买记录</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input id="contextPath" value="${pageContext.request.contextPath }" style="display:none;"/>
    <input id="msg" value="${msg}" style="display:none;"/>
    <script src="${ path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${ path}/jsp/js/publicJS/menuFun.js"></script>
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/newPublic.css">
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
		.box{
			margin-top: 4.5rem;
			width: 100%;
		}
		.box li{
			margin: 0 3rem 2.5rem;
			border-radius: 2rem;
			border: 0.5rem solid #e4e4e4;
			padding-bottom: 2rem;
		}
		.box li p{
			margin: 2.5rem 2rem 0;
			color: #66666;
		}
		.box li p span{
			color: #333;
		}
		.box li p.money span{
			color: #fb1212;
		}
	</style>
</head>
<body>
<header >
    <div class="logo">
        <img src="${ path}/image/logo.png" alt="">
    </div>
    <div class="search">
    	<form>
	        <img src="${ path}/image/search.png" alt=""  onclick="searchVideo('search_key')">
	        <input type="text" id="search_key">
        </form>
    </div>
</header>


<div class="content">
<c:if test="${empty olist }">
	<ul class="box">
		<li>
			<p>序号：<span></span></p>
			<p>订单编号：<span></span></p>
			<p>购买视频名称：<span></span></p>
			<p>视频类型：<span></span></p>
			<p  class="money">支付金额：<span></span></p>
			<p>是否到期：
			<span>
				<c:if test="${p.isUsed==1}">
           			<td>否</td>
         		</c:if>
			</span></p>
			<p>支付时间：<span></span></p>
		</li>
	</ul>
</c:if>
<c:if test="${not empty olist && olist.size() > 0}">
<c:forEach items="${olist}" var="p" varStatus="pp">
    <ul>
		<li>
			<p>序号：<span>${pp.index+1}</span></p>
			<p>订单编号：<span>${p.orderNo}</span></p>
			<p>购买视频名称：<span>${p.vclassify==0?p.gname:p.cname}</span></p>
			<p>视频类型：<span>${p.vclassify==0?'常规':'竞赛'}</span></p>
			<p  class="money">支付金额：<span>${p.omoney}</span></p>
			<p>是否到期：
			<span>
				<c:if test="${p.isUsed==1}">
           			<td>否</td>
         		</c:if>
			</span></p>
			<p>支付时间：<span>${p.opayTime}</span></p>
		</li>
	</ul>
</c:forEach>
</c:if>
<form action="" id="subFrom" method="post">
     <!-- 小测验菜单 -->
     <input type="hidden" name="etsubject" id="etsubject">
     <input type="hidden" name="etclassify" id="etclassify">
     <input type="hidden" name="etclass" id="etclass">
     <!-- 分页参数 -->
     <input type="hidden" name="pageNo" id="pageNo">
</form>
</div>
<%@include file="../commonFoot.jsp" %>
</body>
<script type="text/javascript">
	var contextpath = $('#contextPath').val();
	var msg = $('#msg').val();
	$(function(){
		if(msg != ""){
			if(confirm("您还没登录,确定登录吗？")){
	  	    	window.location.href=encodeURI(contextpath+"/public/login");//跳转登录页
	  	     }
		}
	})

</script>
</html>
