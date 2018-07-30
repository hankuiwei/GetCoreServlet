<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>微友圈</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <script src="${ path}/jsp/js/publicJS/rem.js"></script>
    <script src="${ path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${ path}/jsp/js/publicJS/menuFun.js"></script>
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/global.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/header.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/publicCourse.css">
</head>
<body>
<header id="header">
    <div class="header clearfix">
        <div class="logo">
            <img src="${ path}/image/logo.png" alt="">
        </div>
        <div class="searchbox">
            <input type="text" class="search">
            <i class="search_icon icon iconfont icon-2fangdajing"></i>
        </div>
    </div>
</header>
<div class="content">
    <span>敬请期待!</span>
</div>
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
