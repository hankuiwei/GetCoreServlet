<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>常规课</title>
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
	        <input type="text" id="search_key" class="ipt">
        </form>
    </div>
</header>
	<style>
		.main nav ul li.active{
	    	width:17rem;
			margin:2.5rem 2rem;
		}
	</style>
<div  class="main">
<nav >
    <ul >
        <li class="active " subject="chinese">语文</li>
        <li class="cur active " subject="math">数学</li>
        <li class="active " subject="english">英语</li>
        <li class="active " subject="science">科学</li>
    </ul>
</nav>

	<div class="modelbox">
	<!-- 语文 -->
	    <div class="model">
	    <ul>
	        
	        <li class="info_img bg_img_yellow">
	            <h3 class="info_name_cclass"> 四年级 </h3>
	            <h3 class="info_name_cclassify"> 长期班 </h3>
	        </li>
	        <li class="info_img bg_img_green">
	            <h3 class="info_name_cclass"> 五年级 </h3>
	            <h3 class="info_name_cclassify"> 长期班 </h3>
	       </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 小升初 </h3>
	            <h3 class="info_name_cclassify"> 各学校真题分析 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 古诗 </h3>
	            <h3 class="info_name_cclassify"> 品古诗 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 阅读 </h3>
	            <h3 class="info_name_cclassify"> 阅读专题 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 写作 </h3>
	            <h3 class="info_name_cclassify"> 写作专题 </h3>
	        </li>
        </ul>
	    </div>
	<!-- 数学 -->
	    <div class="model content">
	    <ul>
	        <li class="info_img bg_img_yellow">
	            <h3 class="info_name_cclass"> 四年级 </h3>
	            <h3 class="info_name_cclassify"> 专题课 </h3>
	        </li>
	        <li class="info_img bg_img_yellow">
	            <h3 class="info_name_cclass"> 四年级 </h3>
	            <h3 class="info_name_cclassify"> 长期班 </h3>
	        </li>
	        <li class="info_img bg_img_green">
	            <h3 class="info_name_cclass"> 五年级 </h3>
	            <h3 class="info_name_cclassify"> 专题课 </h3>
	        </li>
	        <li class="info_img bg_img_green">
	            <h3 class="info_name_cclass"> 五年级 </h3>
	            <h3 class="info_name_cclassify"> 长期班 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 六年级 </h3>
	            <h3 class="info_name_cclassify"> 专题课 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 六年级 </h3>
	            <h3 class="info_name_cclassify"> 长期班 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 小升初 </h3>
	            <h3 class="info_name_cclassify"> 入学考 </h3>
	        </li>
	        
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 小升初 </h3>
	            <h3 class="info_name_cclassify"> 分班考 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 初一年级 </h3>
	            <h3 class="info_name_cclassify"> 专题课 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 初一年级 </h3>
	            <h3 class="info_name_cclassify"> 长期班 </h3>
	        </li>
	       </ul>
	    </div>
	<!-- 英语 -->   
	    <div class="model">
    	<ul>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 新概念 </h3>
	            <h3 class="info_name_cclassify"> 第一册 </h3>
	        </li>
	       <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 新概念 </h3>
	            <h3 class="info_name_cclassify"> 第二册 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 其他 </h3>
	            <h3 class="info_name_cclassify"> KET考试 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 其他 </h3>
	            <h3 class="info_name_cclassify"> PET考试 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 流利英语 </h3>
	            <h3 class="info_name_cclassify"> 流利英语 </h3>
	        </li>
	        <li class="info_img bg_img_blue">
	            <h3 class="info_name_cclass"> 语法 </h3>
	            <h3 class="info_name_cclassify"> 语法专项 </h3>
	        </li>
	     </ul>
	    </div>
	<!-- 科学 -->
		<div class="model">
			<ul>
				<li class="info_img bg_img_blue">
					<h3 class="info_name_cclass"> 小升初 </h3>
					<h3 class="info_name_cclassify"> 衔接班 </h3>
				</li>
			</ul>
		</div>
	</div>
</div>
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

<%@include file="../commonFoot.jsp" %>
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
    /* 
    	修改cookie
    */
    function updateCookie(name,value){
    	let exp = new Date();
    	exp.setTime(exp.getTime()-1);
    	let currentValue = getCookie(name);
    	if(currentValue != null){
    		document.cookie = name+ "="+escape(value)+ ";expires="+exp.toGMTString();
    	}
    }
  
    let load=getCookie('load');
    $(".active").on("click",function (e) {
    	setCookie('load',true);
        menuClick(this);
        switch($(this).attr("subject")){
       	 case 'chinese': setCookie('flg',0);
       	 break;
       	 case 'math' : setCookie('flg',1);
       	 break;
       	 case 'english' : setCookie('flg',2);
         break;
		 case 'science' : setCookie('flg',3);
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