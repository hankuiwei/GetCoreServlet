<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    
   <!--  <meta name="viewport" content="width=device-width, user-scalable=no,
     initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"> -->
    
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>课程列表</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input style="display:none;" id="path" value="${path }" />
    <script src="${path }/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${path}/jsp/js/publicJS/menuFun.js"></script>
    <script src="${path}/jsp/js/publicJS/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="${path}/jsp/js/publicJS/videoList.js" type="text/javascript" charset="utf-8"></script>
	
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/newPublic.css">
    <script type="text/javascript">
	    //setChangeTimeStatus(false);
        var contextpath = $('#path').val();
        $(function(){
	   		var videos = $(".videoHide");
   		    for (var i=0;i<videos.length;i++) {
   		    	var item = videos[i];
   				getVideoTimeLength(item);
   		    }
   		//设置文字宽度  自适应
   			 var titles = document.getElementById('title').getElementsByTagName('h3');
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
	 	   				$(item).parents(".thisc").find(".date").text(result);	
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

<!--具体课程-->
	<div class="specific">
		<ul>
			<li>
				<c:if test="${clist.size() > 0}">
				<div class="title" id="title" >
					<h3>竞赛课程视频</h3>
				</div>
				<ul>
					<c:forEach items="${clist}" var="cv">
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
	
					<div style="clear:both"></div>
				</ul>
				</c:if>
				
			</li>
			
			<br>
			<br>
			<br>
			
			<li>
				<c:if test="${glist.size() > 0}">
				<div class="title" id="title">
					<h3>常规课程视频</h3>
				</div>
				
				<ul>
					<c:forEach items="${glist}" var="gv">
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
	
					<div style="clear:both"></div>
				</ul>
				</c:if>
			</li>
			
			<li>
				<c:if test="${empty clist && empty glist}">
				<div class="title" id="title">
					<h3 >未查询到视频</h3>
				</div>	
				</c:if>
			</li>
			<div style="clear:both" class="both"></div>
		</ul>
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
<script type="text/javascript">
</script>
</html>