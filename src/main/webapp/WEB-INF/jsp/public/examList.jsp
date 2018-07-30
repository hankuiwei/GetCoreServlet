<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>小测试列表</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input display="none" id="path" value="${path }" />
    <script src="${path }/jsp/js/publicJS/rem.js"></script>
    <script src="${path }/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${path}/jsp/js/publicJS/menuFun.js"></script>
    <script src="${path}/jsp/js/publicJS/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="${path}/jsp/js/publicJS/videoList.js" type="text/javascript" charset="utf-8"></script>
	
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/global.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/header.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/publicCourse.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/courseList.css">
    
    
	<script type="text/javascript">
	    //setChangeTimeStatus(false);
        function pageSize(num){
        	contest_list("public/examList","${etsubject}","${etclass}","${etclassify}",num);
		}
        var contextpath = $('#path').val();
        $(function(){
	   		var videos = $(".videoHide");
   		    for (var i=0;i<videos.length;i++) {
   		    	var item = videos[i];
   				getVideoTimeLength(item);
   		    }
	   	})
	   	
	   	function getVideoTimeLength(item){
	   		if(item != null && item != 'undefined'){
	   			var source = $(item).attr("src");
	    		$.ajax({
	 	   			url:contextpath+"/getVideoTimeLength",	
	 	   			type:"post",
	 	   			data:{"source":source},
	 	   			dataType:"json",
	 	   			success:function(result){
	 	   				$(item).parents(".every_info").find(".date").text(result);	
	 	   			}
	    		});
	   		}else {
	   			alert("异常 : 资源不存在 或 未定义:" + item)
	   		}
	   	}
	</script>
	<style type="text/css">
	.page{
    	width: 100%;
   		position: fixed;
    	bottom: 36px;
    	margin-top: 1px;
    	background-color: #fff;
    	text-align: center;
    	list-style-type: none;
    	font-size: 10px
    }
	
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
			padding: 2px 15px;
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
		.videoHide {
	        display:none;
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
    <div class="List">
    	<div>
    		<h3  class="course_name">${etsubject}${etclass}${etclassify}</h3>
	        <c:if test="${pages.totalCount==0}">
			 <h4 style="color:#5CB85C;">即将上线，敬请期待</h4>
			</c:if>
    	</div>
        
        <div class="model model_flex">
        <c:forEach items="${pages.result}" var="et">
			<div class="every_info thisexam">
				<input class="eno" type="hidden" value="${et.etid}">
				 <a href="javaScript:void(0);" > 
				 	<c:if test="${not empty et.fmImg }">
				  	 <img src="${et.fmImg}" class="info_img"/>
				    </c:if>
				    <c:if test="${ empty et.fmImg }">
						<img src="${pageContext.request.contextPath}/jsp/img/class3.jpg"/>
					</c:if>
					<h6>${et.etclassify}</h6>
					<p class="ename">${et.etname}</p> 
					<p class="study">
						<span>${et.etestNo}</span>人学习
					</p>
				</a>
			</div>
		</c:forEach> 
    </div>
    
    
	
  </div>
  
  <%-- <div style="text-align:center;list-style-type:none;" class="page">
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
	<form action="" id="subFrom" method="post">
	     <!-- 小测验菜单 -->
	     <input type="hidden" name="etsubject" id="etsubject">
	     <input type="hidden" name="etclassify" id="etclassify">
	     <input type="hidden" name="etclass" id="etclass">
	     <!-- 分页参数 -->
	     <input type="hidden" name="pageNo" id="pageNo">
	     <!-- 小测验单个 -->
	     <input type="hidden" name="etid" id="etid">
	     <input type="hidden" name="name" id="name">
	</form>
	
	<%@include file="../commonFoot2.jsp" %>
</body>
<script type="text/javascript">
</script>
</html>