<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"> -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>课程列表</title>
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
	<!-- <style>
		.thisvbox .thisv .price .oldPrice{
			color: #949494;
			text-decoration: line-through;
			margin-left: 2rem;
		}
	</style> -->
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
			<c:choose>
			    <c:when test="${gclass!='古诗'&&gclass!='阅读'&&gclass!='写作'&&gclass!='流利英语'&&gclass!='语法'&&gclass!='其他'}">
				  <h3 >${gsbuject}${gclass}${gclassify}</h3>
				</c:when>
				<c:otherwise>
				 <h3 >${gsbuject}${gclassify}</h3>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${page.totalCount==0}">
			<br/> <br/>
			 <h4 style="color:#5CB85C;"> 即将上线，敬请期待</h4>
			</c:if>
			
		</div>
			<c:if test="${page.totalCount>0 && gclass=='新概念'}">
				<div style="padding:20px 0 0 10px;">
				 <table style="width: 100%;">
				 	<tr style="display: flex;justify-content: space-around;">
				 		<td>
						  <select id="nameType_select"   style="width:240px;height:80px;line-height:34px;font-size:2rem;border-radius:10px;">
						      <option value="">--请选择课程区间--</option>
					          <option value="1-50" <c:if test="${nameType=='1-50' }">selected="selected"</c:if>>1-50</option>
					          <option value="51-100" <c:if test="${nameType=='51-100' }">selected="selected"</c:if>>51-100</option>
					          <option value="101-144" <c:if test="${nameType=='101-144' }">selected="selected"</c:if>>101-144</option>
					      </select>
					    </td>
				      <td>
				        <select id="sort_select"   style="width:240px;height:80px;line-height:34px;font-size:3rem;border-radius: 10px;padding-left: 40px; ">
					       <option value="desc" <c:if test="${sort=='desc' }">selected="selected"</c:if>>倒序</option>
					       <option value="asc" <c:if test="${sort=='asc' }">selected="selected"</c:if>>正序</option>
				      	</select>
				      </td>
			      		<td>&nbsp;
			      			<input type="button" class="btn btn-primary" id="btn" value="查询" onclick="pageSize(1)" style="font-size:3rem;padding:0 1rem;border-radius: 10px;height:80px;width:200px;background:#0ad7f1;color:#fff;">
			      		</td>
			       </tr>
			     </table>
			    </div>   
			</c:if>
    <!-- 正文 --> 
   	 	<ul class="thisvbox">  
	        <c:forEach items="${page.result}" var="gv">
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
			<div class="clear"></div>
		</ul>
		
	</li>
	</ul>
	<div style="clear:both" class="both"></div>
		
    </div>
    
    <%-- 
    <div style="text-align:center;list-style-type:none;" class="page">
		<ul class="pagination">
			<li ><a>共${page.getTotalPages()}页</a></li>
			<li><a onclick="pageSize(1)">首页</a></li>
			<li ><a onclick="pageSize(${page.getPrePage()})">上一页</a></li>
			<li ><a onclick="pageSize(${page.getNextPage()})">下一页</a></li>
			<li><a onclick="pageSize(${page.getTotalPages()})">尾页</a></li>
			<li ><a>共${page.totalCount}条</a></li>
			<li><a>当前第${page.pageNo}页</a></li>
		</ul>
	</div> 
	--%>
	 
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
	     <input type="hidden" name="nameType" id="nameType">
	     <input type="hidden" name="sort" id="sort">
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