<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport"  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"> -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>课程列表</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input id="contextPath" value="${pageContext.request.contextPath }" style="display:none;"/>
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
	var contextpath = $('#contextPath').val();
	
	/* function pageSize(num){
	   var nameType=$("#nameType_select").val();
	   var sort=$("#sort_select").val();
	   general_list("public/generalCourseList","${gsbuject}","${gclass}","${gclassify}",num,nameType,sort);
	} */
	
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


</head>

	<style>
		.thisvbox .thisv .price .oldPrice{
			color: #949494;
			text-decoration: line-through;
			margin-left: 2rem;
		}
	</style>
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
<div  class="specific" id="specific">
	<ul>
	<li>
	    <div class="title">
			<c:choose>
			    <c:when test="${gclass!='古诗'&&gclass!='阅读'&&gclass!='写作'&&gclass!='流利英语'&&gclass!='语法'&&gclass!='其他'}">
				  <h3 >${gsbuject}${gclass}${gclassify}</h3>
				</c:when>
				<c:otherwise>
				 <h3 >${gsbuject}${gclassify}</h3>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${totalCount==0}">
			<br/> <br/>
			<h4 style="color:#5CB85C;"> 即将上线，敬请期待</h4>
			</c:if>
		</div>
     <!-- 内容 -->   
        <c:if test="${jisuan.size() > 0 }"> 
        <ul>
         <div >
		   <h3 >计算</h3> 
		    <c:forEach items="${jisuan}" var="gv"> 
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
				<p class="price">价格:
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
		    </div>
		   </ul>
		  </c:if>

		<c:if test="${shulun.size()>0 }">
		<ul>
		<div  >
		<h3>数论</h3>
		<c:forEach items="${shulun}" var="gv">
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
				<p class="price">价格:
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
		</div>
		</ul>
		</c:if>

		<c:if test="${jihe.size()>0 }">
		<ul>
		<div >
		<h3>几何</h3>
		<c:forEach items="${jihe}" var="gv">
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
				<p class="price">价格:
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
		</div>
		</ul>
		</c:if>

		<c:if test="${jishu.size()>0 }">
		<ul>
		<div >
		<h3>计数</h3>
		<c:forEach items="${jishu}" var="gv">
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
				<p class="price">价格:
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
		</div>
		</ul>
		</c:if>


			<c:if test="${yingyongti.size()>0 }">
			<ul>
			<div >
				<h3>应用题</h3>
				<c:forEach items="${yingyongti}" var="gv">
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
				<p class="price">价格:
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
		</div>
		</ul>
		</c:if>


		<c:if test="${fangcheng.size()>0 }">
		<ul>
			<div >
			<h3>方程</h3>
			<c:forEach items="${fangcheng}" var="gv">
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
				<p class="price">价格:
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
		</div>
		</ul>
		</c:if>


		<c:if test="${xingcheng.size()>0 }">
		<ul>
		<div >
		<h3>行程</h3>
		<c:forEach items="${xingcheng}" var="gv">
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
				<p class="price">价格:
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
		</div>
		</ul>
		</c:if>

	<c:if test="${qita.size()>0 }">
	<ul>
	<div >
	<h3>专题其他</h3>
	<c:forEach items="${qita}" var="gv">
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
				<p class="price">价格:
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
	</div>
	</ul>
	</c:if>
	
  </li>
  </ul>
</div>
<div style="clear:both;height:10rem;"></div>>
	<form action="" id="subFrom" method="post">
	     <!-- 常规视频菜单 -->
	     <input type="hidden" name="gsbuject" id="gsbuject">
	     <input type="hidden" name="gclass" id="gclass">
	     <input type="hidden" name="gclassify" id="gclassify">
	      <!-- 常规单个 -->
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