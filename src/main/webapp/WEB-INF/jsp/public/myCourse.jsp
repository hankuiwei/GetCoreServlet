<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>我的课程</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input id="contextpath" value="${path}" style="display:none;"/>
    <input id="msg" value="${msg}" style="display:none;"/>
    <script src="${ path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${ path}/jsp/js/publicJS/menuFun.js"></script>
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

<div class="specific">
	<ul>
	<li>
    <c:if test="${pages.result.size() > 0 }">
    	<ul>
    		<c:forEach items="${pages.result }" var="video" >
				<li  onclick="getVideo('${video.vid}','${video.vname}','${video.vctype}','${video.isMore==null ? 0 : video.isMore}')">
					<input class="no" type="hidden" value="${video.vid}">
					<input id="isMore_${video.vid}" type="hidden" value="${video.isMore==null?0:video.isMore}">
					<p class="num">学习人数<span>${video.playno}</span><br></p>
					
					<c:if test="${not empty video.img }">
				     	<img src="${video.img}" />
				     </c:if>
				     <c:if test="${empty video.img }">
						<img src="${pageContext.request.contextPath}/jsp/img/class3.jpg" />
					 </c:if>
					<div class="line"></div>
					
					<p>${not empty video.classify2 ? video.classify2 : (video.gclass=='新概念'?video.vname : video.classify)}</p>
					
				    <p class="info_name_class" style="display:none;">${video.vname}</p>
					<p >主讲老师：${video.teacherName}</p> 
					<p class="price">
					    <c:if test="${video.money=='0'}">
							免费
						</c:if> 
						<c:if test="${video.money!='0'}">
							￥${video.money}
						</c:if>
					</p>
					<p class="time">时长：<span class="date"></span></p>
					<video src="${video.videoUrl }" class="videoHide" >浏览器不支持，换个牛逼点的吧</video>
				</li>
			</c:forEach>
			<div style="clear:both" class="both"></div>
		</ul>
    </c:if>
    
    </li>
    </ul>
    
   
    
</div>

 <c:if test="${pages.result.size() == 0 }">
    <!-- 需要修改的地方. -->
    	
    	<div class="course">
    	 <img src="${ path}/image/course.png" style="width:100%;height100%">
    	 </div>
    	 <h3 style="text-align: center;">您还没有相关的课程</h3>
    	 <p style="text-align: center;">看看有什么想买的课程吧</p>
    </c:if>

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
	
	var videos = $(".videoHide");
    for (var i=0;i<videos.length;i++) {
    	var item = videos[i];
		getVideoTimeLength(item);
    }
	
})

function pageSize(num){
	window.location.href="${pageContext.request.contextPath}/public/myCourse?pageNo="+num;
}
function getVideo(vid,name,vctype,isMore){
	if(vctype==0){
		if(isMore==0){
			window.location.href="generalCourseDetail?className="+name+"&"+"classNo="+vid;
		}else{
			window.location.href="generalCourseDetail_more?className="+name+"&"+"classNo="+vid;
		}
	}else{
		window.location.href="competitionCourseDetail?className="+name+"&"+"classNo="+vid;	
	}
}

function getVideoTimeLength(item){
		if(item != null && item != 'undefined'){
			var source = $(item).attr("src");
		$.ajax({
	   			url:contextpath+"/getVideoTimeLength",	
	   			type:"post",
	   			data:{"source":source},
	   			dataType:"json",
	   			success:function(result){
	   				$(item).parents("li").find(".date").text(result);	
	   			}
		});
		}else {
			alert("异常 : 资源不存在 或 未定义:" + item)
		}
	}
</script>
</html>
