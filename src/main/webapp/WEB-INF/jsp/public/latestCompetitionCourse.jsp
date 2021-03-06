<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"> -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>最新竞赛课程</title>
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
	    //setChangeTimeStatus(false);
        function pageSize(num){
        	latestCourse_list("public/latestCompetitionCourse",num);
		}
        var contextpath = $('#path').val();
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
	 	   			url:contextpath+"/getVideoTimeLength",	
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
<div class="specific">
	<ul>
		<li>
			<div class="title" id="specific">
				<h3>最新竞赛课</h3>
				<c:if test="${pages.totalCount==0}">
				<br/><br/>
				<h4 style="color:#5CB85C;">即将上线，敬请期待</h4>
				</c:if>
			</div>
        
        <c:if test="${pages.totalCount > 0}">
		<ul>
			<c:forEach items="${pages.result}" var="cv">
			<li class="thisc">
				<input class="cno" type="hidden" value="${cv.cid}">
				
				<p class="num">学习人数<span>${cv.cplayNo}</span><br></p>
				
				<c:if test="${not empty cv.cvimg }">
					<img src="${cv.cvimg}"/>
				</c:if> 
				<c:if test="${empty cv.cvimg }">
					<img src="${pageContext.request.contextPath}/jsp/img/class3.jpg"/>
				</c:if>
				
				<div class="line"></div>
				<p>主讲教师：${cv.teacherName}</p>
				<p class="price">价格：
					<c:if test="${cv.cmoney=='0'}">
						免费
					</c:if> 
					<c:if test="${cv.cmoney!='0'}">
						￥${cv.cmoney}
					</c:if>
				</p>
				<p class="time">时长：<span class="date"></span></p>
				<video src="${cv.cvideoUrl }" controls class="videoHide" ></video>
			</li>
			</c:forEach>

			<div style="clear:both" ></div>
		</ul>
		</c:if>
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