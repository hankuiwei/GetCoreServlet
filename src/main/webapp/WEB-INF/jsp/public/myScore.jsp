<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"> -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>我的分数</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input id="contextpath" value="${path}" style="display:none;"/>
    <!-- 控制器中返回的信息. -->
    <input id="msg" value="${msg}" style="display:none;"/>
    <%-- <script src="${ path}/jsp/js/publicJS/rem.js"></script> --%>
    <script src="${ path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${ path}/jsp/js/publicJS/menuFun.js"></script>
    <%-- 
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/global.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/header.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/publicCourse.css">
     --%>
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/newPublic.css">
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

<div >
<c:if test="${pages.result.size() > 0 }" >
	<c:forEach items="${pages.result }" var="p" varStatus="pp">
	<ul>
		<li>
			<p>序号:${pp.index+1}</p>
			<div class="line"></div>
		</li>
		<li>
			<p>测试类型：
				<span>
					<c:choose>
			          <c:when test="${p.utype==0 ||p.utype==2}">
			          	常规
			          </c:when>
			          <c:when test="${p.utype==1 ||p.utype==3}">
			          	竞赛
			          </c:when>
			          <c:when test="${p.utype==4}">
			         	 小测验
			          </c:when>
	         		</c:choose>
				</span>
			</p>
			<div class="line"></div>
		</li>
		<li>
			<p>测试名称：<span>${p.gname}</span></p>
			<div class="line"></div>
		</li>
		<li>
			<p>总分数：${p.totalScores}</p><div class="line"></div>
		</li>
		<li>
			<p>选择题得分：${p.score}</p><div class="line"></div>
		</li>
		<li>
			<p>简答题得分：
		<%-- 
          <c:if test="${p.JDTscore!=null&&(p.isHasJDT==1||p.isHasJDT==2)}">
	          <td>
			  <a href="${pageContext.request.contextPath}/checUnitTestJDTDetail.html?usid=${p.usid}&gname=${p.gname}" target="_blank" style="text-decoration: underline;color:blue;">${p.JDTscore}</a>
			  </td>
          </c:if>
        --%>
           <c:if test="${p.JDTscore==null||(p.JDTscore!=null&&p.isHasJDT!=1&&p.isHasJDT!=2)}">
            <td>${p.JDTscore}</td>
           </c:if>
			
			</p><div class="line"></div>
		</li>
		<li>
			<p>总得分：
			<c:if test="${p.gotScore==null&&(p.isHasJDT==1||p.isHasJDT==2)}">
           		<td style="color:red;">批改中</td>
          	</c:if>
          
          	<c:if test="${p.gotScore!=null||(p.gotScore==null&&(p.isHasJDT!=1&&p.isHasJDT!=2))}">
          		<td style="color:green;">${p.gotScore}</td>
          	</c:if>
			</p><div class="line"></div>
		</li>
		<li>
			<p>做题日期：${p.createTime}</p><div class="line"></div>
		</li>
	</ul>
	</c:forEach>
</c:if>

<c:if test="${pages.result.size() == 0 }" >
<p>没有得分记录</p>
</c:if>
</div>

<%@include file="../commonFoot.jsp" %>
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
var contextpath = $("#contextpath").val();
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
