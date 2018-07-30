<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>教师信息</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input style="display:none;" id="path" value="${path }" />
    <script src="${path }/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${path}/jsp/js/publicJS/menuFun.js"></script>
    <script src="${path}/jsp/js/publicJS/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="${path}/jsp/js/publicJS/videoList.js" type="text/javascript" charset="utf-8"></script>
	<%-- <link rel="stylesheet" href="${path}/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/global.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/header.css"> --%>
	
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/teacher-info.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/newPublic.css">
<style type="text/css">
#person_info {
    width: 93.1rem;
    padding: 0.3rem 0.2rem;
}
.person_img {
    flex: 1;
    height: 45rem;
}
.personal_info {
    box-sizing: border-box;
    flex: 2;
    height: 3rem;
    padding: 4.4rem 0.2rem 0.2rem;
    font-size: 4.2rem;
    line-height: 9.5rem;
}
.info_header {
    font-size: 4.3rem;
    color: #309bee;
    margin: 3rem;
}
.intrduce {
    font-size: 3.25rem;
    background-color: #f7f7f7;
    line-height: 6.4rem;
    text-indent: 1em;
    padding: 1.1rem;
}
.intrduce span{
	font-size: 34px!important;
}


</style>
<script type="text/javascript">
var path = $("#path").val();

setChangeTimeStatus(false);
	function pageSize(num){
   var nameType=$("#nameType_select").val();
   var sort=$("#sort_select").val();
   general_list("public/generalCourseList","${gsbuject}","${gclass}","${gclassify}",num,nameType,sort);
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
	 	   				$(item).parents(".thisv").find(".date").text(result);	
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


<div class="content">
	<div id="person_info">
	    <div class="person_info_first">
	        <div class="person_img">
	        	<img src="${teacher.timgUrl }" alt="" >
	        </div>
	        <div class="personal_info">
	            <p>${teacher.tname }</p>
	            <p>${teacher.subject }</p>
	        </div>
	    </div>
	    <div class="experence">
	        <h2 class="info_header">教师荣誉</h2>
	        <div class="intrduce">${teacher.tintro }
	      	</div>
		</div>
		
		<div class="experence">
	        <h2 class="info_header">教授课程</h2>
	        <%-- <div class="intrduce">
			  <c:forEach items="${courseList}" var="map" varStatus="status"> 
		  			<input value="${map.id}" type="hidden" />
		  			<p>${ status.index + 1}.${map.name}</p>
			  </c:forEach>
	      	</div> --%>
		</div>
    </div>
</div>


<div class="specific">
		<ul>
			<li>
				<div class="title" id="specific">
					<h3 style="width: 6rem;left: 27rem;">竞赛课</h3>
				</div>
				<ul>
				<c:if test="${competitionCourseList.size() > 0}">
					<c:forEach items="${competitionCourseList}" var="cv">
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
						<video src="${cv.cvideoUrl }" controls class="videoHide"  hidden="hidden" ></video>
					</li>
					</c:forEach>
				</c:if>
				</ul>
		</ul>
	</div>
	<div style="width:100%;overflow: hidden;">
	
	<div class="specific">	
		<ul>	
			<li>
				<div class="title" id="specific">
					<h3>常规课</h3>
				</div>
				<ul>
				<c:if test="${generalCourseList.size() > 0}">
				<c:forEach items="${generalCourseList}" var="gv">
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
						<video src="${gv.gvideoUrl }" class="videoHide" hidden="hidden" >浏览器不支持，换个牛逼点的吧</video>
					</li>
				</c:forEach>
				</c:if>
				</ul>
			</li>
		</ul>
		<div style="clear:both" class="both"></div>
	</div>
	<form action="" id="subFrom" method="post">
	    <!-- 常规视频菜单 -->
	     <input type="hidden" name="gsbuject" id="gsbuject">
	     <input type="hidden" name="gclass" id="gclass">
	     <input type="hidden" name="gclassify" id="gclassify">
	      <!-- 常规单个 -->
	     <input type="hidden" name="className" id="className">
	     <input type="hidden" name="classNo" id="classNo">
	     <input type="hidden" name="nameType" id="nameType">
	     <input type="hidden" name="sort" id="sort">
	     <!-- 分页参数 -->
	     <input type="hidden" name="pageNo" id="pageNo">
	</form>	
<%@include file="../commonFoot.jsp" %>
</body>
</html>