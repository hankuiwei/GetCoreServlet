
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>最新课程</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input style="display:none;" id="path" value="${path }" />
    <script src="${path }/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${path}/jsp/js/publicJS/menuFun.js"></script>
    <script src="${path}/jsp/js/publicJS/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="${path}/jsp/js/publicJS/videoList.js" type="text/javascript" charset="utf-8"></script>
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
<div class="specific" id="specific">
	<ul>
		<li>
        
		<ul>
			<c:if test="${ contestList.size() == 0}">
				<div class="title">
					<h3 style="color:#5CB85C;">最新竞赛课即将上线，敬请期待</h3>
				</div>
			</c:if>
			<c:if test="${ contestList.size() > 0}">
				<div class="title">
					<h3>竞赛课</h3>
				</div>
			</c:if>
			<c:forEach items="${contestList}" var="cv">
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
					<input type="hidden" class="isKill" value="${cv.isKill }"/>
					<input type="hidden" class="killStartTime" value="${cv.killStartTime }"/>
					<input type="hidden" class="killEndTime" value="${cv.killEndTime }"/>
					<span style="display:none;" class="newPrice">￥${cv.killMoney}</span>
					<span  class="oldPrice">￥${cv.cmoney}</span>
				</p>
				<p class="time">时长：<span class="date"></span></p>
				<video src="${cv.cvideoUrl }" controls class="videoHide" ></video>
			</li>
			</c:forEach>

			<div style="clear:both" ></div>
			
			<br/>
			<c:if test="${ generalList.size() == 0}">
				<div class="title">
					<h3 style="color:#5CB85C;">最新常规课即将上线，敬请期待</h3>
				</div>
			</c:if>
			<c:if test="${ generalList.size() > 0}">
				<div class="title">
					<h3>常规课</h3>
				</div>
			</c:if>
			<!-- 常规课 -->
			<c:forEach items="${generalList}" var="gv">
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
				<p class="price">价格：
				    <input type="hidden" class="isKill" value="${gv.isKill }"/>
					<input type="hidden" class="killStartTime" value="${gv.killStartTime }"/>
					<input type="hidden" class="killEndTime" value="${gv.killEndTime }"/>
					<span style="display:none;" class="newPrice">￥${gv.killMoney}</span>
					<span  class="oldPrice">￥${gv.gmoney}</span>
					
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
$(function(){
	$(".price").each(function(thisItem){
		thisItem = $(this) ;
		var isKill = thisItem.children(".isKill").val();
		
		if(isKill==1){//有优惠
			var killStartTime = thisItem.children(".killStartTime").val();
			var killEndTime = thisItem.children(".killEndTime").val();
			var startArr = killStartTime.split(/[- :]/);
			var endArr = killEndTime.split(/[- :]/);
			var timeStart,timeEnd,now;
			try{
				timeStart = Date.parse(new Date(startArr[0],startArr[1]-1,startArr[2],startArr[3],startArr[4],startArr[5]));
				timeEnd = Date.parse(new Date(endArr[0],endArr[1]-1,endArr[2],endArr[3],endArr[4],endArr[5]));
				now = Date.parse(new Date());
				if(timeStart < now && now < timeEnd ){//优惠活动进行中,显示优惠价,原价下划线
					thisItem.children(".newPrice").prop("style","color:#e25b58;")
					thisItem.children(".oldPrice").attr("style","text-decoration:line-through;color:#5f5f5f;")
				}
			}catch(err){
			}
		} 
	});
})								
</script>
</html>