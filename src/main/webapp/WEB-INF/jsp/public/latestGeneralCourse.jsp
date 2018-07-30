<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"> -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>最新常规课程</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input style="display:none;" id="path" value="${path }" />
    <%-- <script src="${path }/jsp/js/publicJS/rem.js"></script> --%>
    <script src="${path }/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${path}/jsp/js/publicJS/menuFun.js"></script>
    <script src="${path}/jsp/js/publicJS/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="${path}/jsp/js/publicJS/videoList.js" type="text/javascript" charset="utf-8"></script>
	<%-- 
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/global.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/header.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/publicCourse.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/courseList.css">
     --%>
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/newPublic.css">
    
    
	<script type="text/javascript">
		var path = $("#path").val();
		
		setChangeTimeStatus(false);
	   	function pageSize(num){
	   		latestCourse_list("public/latestGeneralCourse",num);
		}
	   	$(function(){
	   		var videos = $(".videoHide");
   		    for (var i=0;i<videos.length;i++) {
   		    	var item = videos[i];
   				getVideoTimeLength(item);
   		    }
   		 //设置文字宽度  自适应
   			var titles = document.getElementById('specific').getElementsByTagName('h3');
   			for (var i = 0; i < titles.length; i++) {
   				var title = titles[i].innerHTML;
   				var wid = (title.length + 2) * 3
   				titles[i].style['width'] = wid + 'rem';
   				titles[i].style['left'] = (60 - wid) / 2 + 'rem';
   			}
	   	})
	   	
	   	function getVideoTimeLength(item){
	   		if(item != null && item != 'undefined'){
	   			var source = $(item).attr("src");
	    		$.ajax({
	 	   			url:path+"/getVideoTimeLength",	
	 	   			type:"post",
	 	   			data:{"source":source},
	 	   			dataType:"json",
	 	   			success:function(result){
	 	   				$(item).siblings(".time").find(".date").text(result);	
	 	   			}
	    		});
	   		}else {
	   			alert("异常 : 资源不存在 或 未定义:" + item)
	   		}
	   		
	   	}
	</script>
	
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
<div  class="specific">
	<ul>
		<li>
    <!-- 标题 -->
    	<div class="title" id="specific">
			<h3 >最新常规课</h3>
			<c:if test="${page.totalCount==0}">
			<br/> <br/>
			 <h4 style="color:#5CB85C;"> 即将上线，敬请期待</h4>
			</c:if>
			
		</div>
    <!-- 正文 -->    
    <ul>
        <c:forEach items="${pages.result}" var="gv">
			<li class="thisv">
				<input class="no" type="hidden" value="${gv.gid}">
				<input id="isMore_${gv.gid}" type="hidden" value="${gv.isMore==null?0:gv.isMore}">
				<p class="num">学习人数<span>${gv.gplayNo}</span><br></p>
				
				<c:if test="${not empty gv.gvimg }">
			     	<img src="${gv.gvimg}" />
			     </c:if>
			     <c:if test="${empty gv.gvimg }">
					<img src="${pageContext.request.contextPath}/jsp/img/class3.jpg" />
				 </c:if>
				<div class="line"></div>
				
				<p>${not empty gv.gclassify2?gv.gclassify2:(gv.gclass=='新概念'?gv.gname:gv.gclassify)}</p>
				
			    <p class="info_name_class" style="display:none;">${gv.gname}</p>
				<p >主讲老师：${gv.teacherName}</p> 
				<p class="price">
				    <c:if test="${gv.gmoney=='0'}">
						免费
					</c:if> 
					<c:if test="${gv.gmoney!='0'}">
						￥${gv.gmoney}
					</c:if>
				</p>
				<p class="time">时长：<span class="date"></span></p>
				<video src="${gv.gvideoUrl }" class="videoHide" >浏览器不支持，换个牛逼点的吧</video>
			</li>
		</c:forEach> 
	</ul>
 </li>
 <div style="clear:both" class="both"></div>
 </ul> 

 
   <%--  <div style="text-align:center;list-style-type:none;" class="page">
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
		<input type="hidden" name="className" id="className">
	     <input type="hidden" name="classNo" id="classNo">
	     <!-- 分页参数 -->
	     <input type="hidden" name="pageNo" id="pageNo">
	</form>
	
	<%@include file="../commonFoot.jsp" %>
</body>
<script type="text/javascript">
</script>
</html>