<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学员展示</title>
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
     <script src="${path }/jsp/js/publicJS/rem.js"></script>
    <script src="${path }/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${path}/jsp/js/publicJS/menuFun.js"></script>
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/global.css">
    <%--<link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/header.css">--%>
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/teachers.css">
    <style type="text/css">
		ul.pagination {
			display: inline-block;
			padding: 0;
			margin: 0;
		}
		
		ul.pagination li {
			display: inline;
		}
		
		ul.pagination li a {
			color: black;
			float: left;
			padding: 8px 16px;
			text-decoration: none;
			transition: background-color .3s;
			border: 1px solid #ddd;
		}
		
		.pagination li:first-child a {
			border-top-left-radius: 5px;
			border-bottom-left-radius: 5px;
		}
		
		.pagination li:last-child a {
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
		}
		
		ul.pagination li a.active {
			background-color: #4CAF50;
			color: white;
			border: 1px solid #4CAF50;
		}
		
		ul.pagination li a:hover:not (.active ) {
			background-color: #ddd;
		}
	#header {
	width: 7.5rem;
	height: 1.17rem;
	border-bottom: 0.05rem solid #dfdfdf;
	}

	#header .logo {
	width: 2.33rem;
	height: 1rem;
	float: left;
	margin-left: 0.38rem;
	margin-top: 0.17rem;
	}

	#header .logo img {
	width: 2.25rem;
	}

	#header .search {
	float: right;
	width: 4.79rem;
	height: 100%;
	}

	#header .search form {
	width: 100%;
	height: 100%;
	position: relative;
	}

	#header .search form img {
	height: 0.54rem;
	margin: 0.42rem 0 0 0.25rem;
	}

	#header .search form input {
	height: 0.38rem;
	width: 3.14rem;
	line-height: 0.38rem;
	font-size: 12px;
	position: absolute;
	top: 0.49rem;
	left: 0.45rem;
	border-style: none;
	}
	</style>
</head>
<body>

<header id="header">
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


<div class="content">
	<div id="person_show" class="model">
	    <header>
	        <h4 class="model_head_second"><span class="underline">学员展示</span></h4>
	    </header>
	    <div id="person_show_body" class="model_body_flex" style="margin-bottom:1rem">
	    	<c:forEach items="${ students}" var="student">
	    	 	<div class="every_person" style="height:6.2rem">
	    	 		<input class="pid" value="${student.pid }" style="display:none;"/>
		            <a href="javascript:void(0);" class="person_img">
		            	<img src="${student.pimgUrl}" class="info_img" alt="">
		            </a>
		            <p class="person_name_char" style="margin-top:0.1rem;">${student.pname}</p>
		            <a href="javascript:void(0);" class="kmore_small">了解更多</a>
	        	</div>
	    	</c:forEach>
	    </div>
	</div>
	
	<%-- <div style="text-align:center;list-style-type:none;">
		<ul class="pagination">
			<li ><a>共${pages.getTotalPages()}页</a></li>
			<li><a onclick="pageSize(1)">首页</a></li>
			<li ><a onclick="pageSize(${pages.getPrePage()})">上一页</a></li>
			<li ><a onclick="pageSize(${pages.getNextPage()})">下一页</a></li>
			<li><a onclick="pageSize(${pages.getTotalPages()})">尾页</a></li>
			<li ><a>共${pages.totalCount}条</a></li>
			<li><a>当前第${pages.pageNo}页</a></li>
		</ul>
	</div> --%>	
</div>

<%@include file="../commonFoot2.jsp" %>
</body>
<form action="" id="subFrom" method="post">

	<input type="hidden" name="pid" id="pid" />
     <!-- 分页参数 -->
     <input type="hidden" name="pageNo" id="pageNo">
</form>
<script type="text/javascript">
	/* function pageSize(num){
		student_list("public/students",num);
	} */
	
	$(".kmore_small").on("click",function(){
		var url = "public/student-info";
		getOneStudent(url,$(this).siblings(".pid").val());
	})
	
	
</script>
</html>