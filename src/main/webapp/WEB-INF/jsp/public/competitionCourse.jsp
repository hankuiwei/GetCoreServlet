<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport"  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"> -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>竞赛课</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <%-- <script src="${ path}/jsp/js/publicJS/rem.js"></script> --%>
    <script src="${ path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${ path}/jsp/js/publicJS/menuFun.js"></script>
    <%--  <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/global.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/header.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/css/publicCourse.css"> --%>
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
<div class="main">
<nav >
    <ul >
        <li class="cur active" subject="america">美国大联盟杯</li>
        <li class="active"  subject="springcup">迎春杯</li>
        <li class="active" subject="NC">华杯</li>
    </ul>
</nav>
<div class="modelbox">
<!-- 美国大联盟杯 -->
    <div class="model content">
        <ul>
        	<li class="info_img bg_img_yellow">
	            <h3 class="info_name_cclass"> 三四年级 </h3>
	            <h3 class="info_name_cclassify"> 真题 </h3>
            </li>
        	<li class="info_img bg_img_yellow">
	            <h3 class="info_name_cclass"> 三四年级 </h3>
	            <h3 class="info_name_cclassify"> 专题 </h3>
            </li>

	        <li class="info_img bg_img_green">
	            <h3 class="info_name_cclass"> 五六年级 </h3>
	            <h3 class="info_name_cclassify"> 真题 </h3>
	        </li>
	        <li class="info_img bg_img_green">
	            <h3 class="info_name_cclass"> 五六年级 </h3>
	            <h3 class="info_name_cclassify"> 专题 </h3>
	        </li>
	    </ul>
    </div>

    <!-- 迎春杯 -->
    <div class="model">
      <ul>
       	<li class="info_img bg_img_yellow">
            <h3 class="info_name_cclass"> 三年级 </h3>
            <h3 class="info_name_cclassify"> 历史真题 </h3>
        </li>
        <li class="info_img bg_img_yellow">
            <h3 class="info_name_cclass"> 三年级 </h3>
            <h3 class="info_name_cclassify"> 历史专题 </h3>
        </li>
        <li class="info_img bg_img_yellow">
            <h3 class="info_name_cclass"> 四年级 </h3>
            <h3 class="info_name_cclassify"> 历史真题 </h3>
        </li>
        <li class="info_img bg_img_yellow">
            <h3 class="info_name_cclass"> 四年级 </h3>
            <h3 class="info_name_cclassify"> 历史专题 </h3>
        </li>
        <li class="info_img bg_img_green">
            <h3 class="info_name_cclass"> 五年级 </h3>
            <h3 class="info_name_cclassify"> 历史真题 </h3>
        </li>
        <li class="info_img bg_img_green">
            <h3 class="info_name_cclass"> 五年级 </h3>
            <h3 class="info_name_cclassify"> 历史专题 </h3>
        </li>
        <li class="info_img bg_img_blue">
            <h3 class="info_name_cclass"> 六年级 </h3>
            <h3 class="info_name_cclassify"> 历史真题 </h3>
        </li>
        <li class="info_img bg_img_blue">
            <h3 class="info_name_cclass"> 六年级 </h3>
            <h3 class="info_name_cclassify"> 历史专题 </h3>
        </li>
     </ul>
    </div>

    <!-- 华杯 -->
    <div class="model">
   	<ul>
        <li class="info_img bg_img_yellow">
            <h3 class="info_name_cclass"> 三四年级 </h3>
            <h3 class="info_name_cclassify"> 专题课 </h3>
        </li>
        <li class="info_img bg_img_green">
            <h3 class="info_name_cclass"> 五六年级 </h3>
            <h3 class="info_name_cclassify"> 专题课 </h3>
        </li>
    </ul>
    </div>
</div>
</div>

<%@include file="../commonFoot.jsp" %>

<form action="" id="subFrom" method="post">
     <!-- 常规视频菜单 -->
     <input type="hidden" name="gsbuject" id="gsbuject">
     <input type="hidden" name="gclass" id="gclass">
     <input type="hidden" name="gclassify" id="gclassify">
      <!-- 常规单个 -->
     <input type="hidden" name="className" id="className">
     <input type="hidden" name="classNo" id="classNo">
      <!-- 竞赛视频菜单 -->
     <input type="hidden" name="competitionName" id="competitionName">
     <input type="hidden" name="cclassify" id="cclassify">
     <input type="hidden" name="cclass" id="cclass">
     <!-- 小测验菜单 -->
     <input type="hidden" name="etsubject" id="etsubject">
     <input type="hidden" name="etclassify" id="etclassify">
     <input type="hidden" name="etclass" id="etclass">
     <!-- 分页参数 -->
     <input type="hidden" name="pageNo" id="pageNo">
</form>

</body>
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
        /*
        设置cookie
        */
        function setCookie(cname,cvalue,exdays){
                let d=new Date();
                d.setTime(d.getTime()+exdays*24*60*60*1000);
                let expires = "expires="+d.toUTCString();
                document.cookie=cname+'='+cvalue+";"+expires + d.toGMTString() + ";path=/";
                return true;
        }
        /*
        获取cookie
        */
        function getCookie(cname){
                let name = cname + "=";
                let ca = document.cookie.split(";");
                for(var i=0;i<ca.length;i++){
                        let c=ca[i];
                        while(c.charAt(0)== " ") c=c.substring(1);
                                if(c.indexOf(name) != -1){
                                        return c.substring(name.length,c.length);
                                }
                        }
                return "";
        }
        /*
        删除cookie
        */
        function clearCookie(name){
                setCookie(name,"",-1);
        }
        let load=getCookie('load');
        $(".active").on("click",function (e) {
                setCookie('load',true);
    	        menuClick(this);
                switch($(this).attr("subject")){
                        case 'america': setCookie('flg',0);
                        break;
                        case 'springcup' : setCookie('flg',1);
                        break;
                        case 'NC' : setCookie('flg',2);
                        break;
                }
        })
        if(load==="true"){
                $(".model").removeClass("content");
                $(".active").removeClass("cur");
                let a=getCookie("flg");
                $($(".model")[a]).addClass("content");
                $($(".active")[a]).addClass("cur");
                for(var i=0;i<$(".model").length;i++){
                        var f=getCookie("flg");

                        if(i == f){
                                $($(".model")[i]).addClass("content");
                                $($(".active")[i]).addClass("cur");
                        }
                }
        }
    })
</script>