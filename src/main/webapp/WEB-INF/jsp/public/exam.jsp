<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>小测试</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <script src="${ path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${ path}/jsp/js/publicJS/menuFun.js"></script>
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/newPublic.css">
    
    <style type="text/css">
    .bg_img_yellow{
    	background: url(/GetCoreServlet/image/yellow.png) no-repeat;
    }
    .bg_img_green{
    	background: url(/GetCoreServlet/image/green.png) no-repeat;
    }
    .bg_img_blue{
    	background: url(/GetCoreServlet/image/blue.png) no-repeat;
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
<div class="main" >
    <nav >
        <ul>
            <li class="cur active">语文测验</li>
            <li class="active">数学测验</li>
            <li class="active">英语测验</li>
        </ul>
    </nav>
    <div class="modelbox">
        <div class="model content">
        <ul>
        	<li class="info_img bg_img_yellow">
                <h3 class="info_name_cclass">四年级 </h3>
                <h3 class="info_name_cclassify">上/下学期</h3>
            </li>
            <li class="info_img bg_img_green">
                <h3 class="info_name_cclass"> 五年级 </h3>
                <h3 class="info_name_cclassify">上/下学期 </h3>
            </li>
            <li class="info_img bg_img_blue">
                <h3 class="info_name_cclass"> 六年级 </h3>
                <h3 class="info_name_cclassify">上/下学期</h3>
            </li>
         </ul>
        </div>
        
        
        <div class="model ">
          <ul>
        	<li class="info_img bg_img_yellow">
                <h3 class="info_name_cclass"> 三年级 </h3>
                <h3 class="info_name_cclassify"> 上学期 </h3>
            </li>
            <li class="info_img bg_img_yellow">
                <h3 class="info_name_cclass"> 三年级 </h3>
                <h3 class="info_name_cclassify"> 下学期 </h3>
            </li>
            <li class="info_img bg_img_yellow">
                <h3 class="info_name_cclass"> 四年级 </h3>
                <h3 class="info_name_cclassify"> 上学期 </h3>
            </li>
            <li class="info_img bg_img_yellow">
                <h3 class="info_name_cclass"> 四年级 </h3>
                <h3 class="info_name_cclassify"> 下学期 </h3>
            </li>
            <li class="info_img bg_img_green">
                <h3 class="info_name_cclass"> 五年级 </h3>
                <h3 class="info_name_cclassify"> 上学期 </h3>
            </li>
            <li class="info_img bg_img_green">
                <h3 class="info_name_cclass"> 五年级 </h3>
                <h3 class="info_name_cclassify"> 下学期 </h3>
            </li>
            <li class="info_img bg_img_blue">
                <h3 class="info_name_cclass"> 六年级 </h3>
                <h3 class="info_name_cclassify"> 上学期 </h3>
            </li>
            <li class="info_img bg_img_blue">
                <h3 class="info_name_cclass"> 六年级 </h3>
                <h3 class="info_name_cclassify"> 下学期 </h3>
            </li>
         </ul>
        </div>
        
        
        <div class="model">
            <ul>
	        	<li class="info_img bg_img_blue">
	                <h3 class="info_name_cclass"></h3>
	                <h3 class="info_name_cclassify">三至六年级</h3>
	            </li>
            </ul>
        </div>
    </div>
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

</html>
<script>
$(function () {
    function menuClick(_element) {
    	//图标 变动
        $(".active").removeClass("cur");
        $(_element).addClass("cur");
        //内容变动
        var index = $(_element).index(".active");
        $(".model").removeClass("content");
        $($(".model")[index]).addClass("content");
    }

    $(".active").on("click",function (e) {
        menuClick(this);
    })
})
</script>