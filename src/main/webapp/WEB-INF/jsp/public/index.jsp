<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input id="contextPath" value="${path }" style="display:none;"/>
    <script src="${ path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${ path}/jsp/js/MobilePhoneAdapters.js"></script>
    <script src="${ path}/jsp/js/swiper.js"></script>
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/swiper.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/style.css">
    <link rel="stylesheet" href="${ path}/jsp/css/publicCSS/hpindex.css">
    <title>厚朴教育</title>
</head>
<body>
<div class="content">
    <div id="banner">
        <ul class="swiper-container">
            <li class="swiper-wrapper">
            <c:forEach items="${blist }" var="banner">
                <div class="swiper-slide">
                	<img src="${banner.imgUrl }" alt="">
                	<input class="content" value="${banner.content }" style="display:none;"/>
                	<input class="category" value="${banner.category }" style="display:none;"/>
                	<input class="subject" value="${banner.subject }" style="display:none;"/>
                	<input class="grade" value="${banner.grade }" style="display:none;"/>
                	<input class="classify" value="${banner.classify }" style="display:none;"/>
                </div>
            </c:forEach>
            </li>
        </ul>
    </div>
    <script type="text/javascript">
    	$(".swiper-slide").on("click",function(){
    		var webLinked = $(this).children(".content").val() ;
    		if(webLinked != ""){
    			window.location.href = webLinked ;
    		}else{
    			var category = $(this).children(".category").val();
        		var subject = $(this).children(".subject").val();
        		var grade = $(this).children(".grade").val();
        		var classify = $(this).children(".classify").val();
        		if(category == '常规课'){
    				var url="";
    				if(subject=='数学'&&classify=='专题课'){
    					 url="/public/generalCourseList_zt";
    				}else{
    					 url="/public/generalCourseList";
    				}
    				general_list(url,subject,grade,classify);
    			}else if(category == '竞赛课'){
    				var url="/public/competitionCourseList";
    				contest_list(url,subject,grade,classify);
    			}
    		}
    	})
function general_list(url,gsbuject,gclass,gclassify){
	 $("#subFrom").attr("action",contextPath+url);
     $("#gsbuject").val(gsbuject);
     $("#gclassify").val(gclassify);
     $("#gclass").val(gclass);
     
     $("#subFrom").submit();
}
function contest_list(url,competitionName,cclass,cclassify){
	$("#subFrom").attr("action",contextPath+url);
    $("#competitionName").val(competitionName);
    $("#cclassify").val(cclassify);
    $("#cclass").val(cclass);
   
    $("#subFrom").submit();
}
    	
    	
    </script>
    <div id="newClass">
        <div class="title">
            <div>
                <h2>推荐课程</h2>
            </div>
        </div>
        <ul class="classContent">
            <li class="classItem four">
                <a href="javascript:void(0);">
                    <div class="text">
                        <span class="info_name_cclass">四年级</span>
                        <span class="info_name_cclassify">专题课</span>
                    </div>
                </a>
            </li>
            <li class="classItem four">
                <a href="javascript:void(0);">
                    <div class="text">
                        <span class="info_name_cclass">四年级</span>
                        <span class="info_name_cclassify">长期班</span>
                    </div>
                </a>
            </li>
            <li class="classItem five">
                <a href="javascript:void(0);">
                    <div class="text">
                        <span class="info_name_cclass">五年级</span>
                        <span class="info_name_cclassify">专题课</span>
                    </div>
                </a>
            </li>
            <li class="classItem five">
                <a href="javascript:void(0);">
                    <div class="text">
                        <span class="info_name_cclass">五年级</span>
                        <span class="info_name_cclassify">长期班</span>
                    </div>
                </a>
            </li>
        </ul>
        <div class="more">
            <a href="generalCourse">查看更多</a>
        </div>
    </div>
    <div id="teacher">
        <div class="title">
            <div>
                <h2>名师推荐</h2>
            </div>
        </div>
        <ul class="teacherContent">
        <c:forEach items="${tlist }" var="teacher">
            <li class="teacherItem">
            	<input class="tid" value="${teacher.tid }" style="display:none;"/>
                <img src="${teacher.timgUrl }" alt="">
                <span>${teacher.tname }</span>
                <a href="javascript:void(0);" class="kmore_small">了解更多</a>
            </li>
         </c:forEach>   
        </ul>
        <div class="more">
            <a href="teachers">查看更多</a>
        </div>
    </div>
    <script type="text/javascript">
	    $(".kmore_small").on("click",function(){
			var url = "/public/teacher-info";
			getOneTeacher(url,$(this).siblings(".tid").val());
		})
		function getOneTeacher(url,tid){
			$("#subFrom").attr("action",contextPath+url);
			$("#tid").val(tid);
		    $("#subFrom").submit();
		}
    </script>
    
    <div id="openCourse" style="padding-bottom:1.1rem">
        <div class="title">
            <div>
                <h2>免费课</h2>
            </div>
        </div>
        <ul class="courseContent">
        
 	<!-- 免费竞赛课 -->
        	<c:forEach items="${clist }" var="competitionCourse">
            <li class="courseItem thisc">
            <input class="cno" type="hidden" value="${competitionCourse.cid}">
                <a href="javascript:void(0);">
                	<!-- 左边栏 -->
                    <div class="img">
                        <img src="${path }/image/ejbg.png" alt="">
                        <div class="course">
                            <div class="main">
                                <img src="${competitionCourse.cvimg }">
                                <div class="courseBody">
                                    <p class="courseTitle name">${competitionCourse.cname }</p>
                                    <p class="courseTitle">主讲老师：${competitionCourse.teacherName }</p>
                                    <p class="price">价格：
										<input type="hidden" class="isKill" value="${competitionCourse.isKill }"/>
										<input type="hidden" class="killStartTime" value="${competitionCourse.killStartTime }"/>
										<input type="hidden" class="killEndTime" value="${competitionCourse.killEndTime }"/>
										<span style="display:none;" class="newPrice">￥${competitionCourse.killMoney}</span>
										<span  class="oldPrice">￥${competitionCourse.cmoney}</span>
										<script type="text/javascript">
											$(function(){
												$(".price").each(function(thisItem){
													thisItem = $(this) ;
													var isKill = thisItem.children(".isKill").val();
													if(isKill==1){//有优惠
														var killStartTime = thisItem.children(".killStartTime").val();
														var killEndTime = thisItem.children(".killEndTime").val();
														var timeStart,timeEnd,now;
														try{
															timeStart = Date.parse(new Date(killStartTime));
															timeEnd = Date.parse(new Date(killEndTime));
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
                                    </p>
                                    <p class="time" 时长：><span class="data">00:00:00</span></p>
                                    <video src="${competitionCourse.cvideoUrl }" style="display:none;" controls class="videoHide" ></video>
                                </div>
                            </div>
                        </div>
                        <div class="courseLabel">
                        		学<br/>习<br/>人<br/>数<br/>
                            <span class="people">${competitionCourse.cplayNo }</span>
                        </div>
                    </div>
                </a>
            </li>
        	</c:forEach>
    <style>
    #openCourse .courseBody .price span{
    color:#E25B58;
    }
    #openCourse .courseBody .price span.oldPrce{
    color: #949494;
    text-decoration: line-through;
    margin-left: 2rem;
    }

    </style>
            <!-- 免费常规课 -->
            <c:forEach items="${glist }" var="generalCourse">
            <li class="courseItem thisg">
	            <input class="no" type="hidden" value="${generalCourse.gid}">
	            <input id="isMore_${generalCourse.gid}" type="hidden" value="${generalCourse.isMore==null?0:generalCourse.isMore}">
                <a href="javascript:void(0);">
                	<!-- 左边栏 -->
                    <div class="img">
                        <img src="${path }/image/ejbg.png" alt="">
                        <div class="course">
                            <div class="main">
                                <img src="${generalCourse.gvimg }">
                                <div class="courseBody">
                                    <p class="courseTitle name">${generalCourse.gname }</p>
                                    <p class="courseTitle">主讲老师：${generalCourse.teacherName }</p>
	                                <p class="price">价格：
										<input type="hidden" class="isKill" value="${generalCourse.isKill }"/>
										<input type="hidden" class="killStartTime" value="${generalCourse.killStartTime }"/>
										<input type="hidden" class="killEndTime" value="${generalCourse.killEndTime }"/>
										<span style="display:none;" class="newPrice">￥${generalCourse.killMoney}</span>
										<span  class="oldPrice">￥${generalCourse.gmoney}</span>
										<script type="text/javascript">
											$(function(){
												$(".price").each(function(thisItem){
													thisItem = $(this) ;
													var isKill = thisItem.children(".isKill").val();
													if(isKill==1){//有优惠
														var killStartTime = thisItem.children(".killStartTime").val();
														var killEndTime = thisItem.children(".killEndTime").val();
														var timeStart,timeEnd,now;
														try{
															timeStart = Date.parse(new Date(killStartTime));
															timeEnd = Date.parse(new Date(killEndTime));
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
	                                </p>
                                    <p class="time" 时长：><span class="data">00:00:00</span></p>
                                    <video src="${generalCourse.gvideoUrl }" style="display:none;" controls class="videoHide" ></video>
                                </div>
                            </div>
                        </div>
                        <div class="courseLabel">
                        	学<br/>习<br/>人<br/>数<br/>
                            <span class="people">${generalCourse.gplayNo }</span>
                        </div>
                    </div>
                </a>
            </li>
        	</c:forEach>
        </ul>
        <script type="text/javascript">
        $('.thisg').on('click',function(){
			var vid = $(this).children('.no').val();
			var name=$(this).children('a').children().find(".name").html().trim();
			var isMore=$("#isMore_"+vid).val();
			var url="";
			if(isMore==0){
				url="/public/generalCourseDetail";
			}else{
				url="/public/generalCourseDetail_more";
			}
		    $("#subFrom").attr("action",contextPath+url);
	        $("#className").val(name);
	        $("#classNo").val(vid);
	        $("#subFrom").submit();
		});
		$('.thisc').on('click',function(){
			var cid = $(this).children('.cno').val();
			var name=$(this).children('a').children().find(".name").html().trim();//好像不太重要...
			var url="/public/competitionCourseDetail";
			$("#subFrom").attr("action",contextPath+url);
	        $("#className").val(name);
	        $("#classNo").val(cid);
	        $("#subFrom").submit();
		})
        </script>
    </div>
</div>
<!-- 提供页面跳转功能. -->
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
     <!-- 教师参数 -->
     <input type="hidden" name="tid" id="tid" />
</form>
<%@include file="../commonFoot2.jsp" %>
</body>
</html>
<script>
let mySwiper = new Swiper(".swiper-container", {
    autoplay: true,
    loop: true,
    direction : 'horizontal',
    speed:10000
})
    var contextPath = $("#contextPath").val() ; 
    
    /**推荐课跳转方法*/
    function toCommendableCourse(item){
    	var gsbuject = "数学";
		var gclassify = $(item).children().find(".info_name_cclassify").html().trim(); 
		var gclass = $(item).children().find(".info_name_cclass").html().trim(); 
		var url="";
		if(gclassify=='专题课'){
			 url="/public/generalCourseList_zt";
		}else{
			 url="/public/generalCourseList";
		}
		
		$("#subFrom").attr("action",contextPath + url);
        $("#gsbuject").val(gsbuject);
        $("#gclassify").val(gclassify);
        $("#gclass").val(gclass);
        $("#subFrom").submit();
    }
   	 	
    
   $(".classItem").on("click",function(){
	   toCommendableCourse(this) ;
   }) 
   
    $(function(){
   		var videos = $(".videoHide");
  		    for (var i=0;i<videos.length;i++) {
  		    	var item = videos[i];
  				getVideoTimeLength(item);
  		    }
  		//设置文字宽度  自适应
   	}) 
	   	
	   	function getVideoTimeLength(item){
	   		if(item != null && item != 'undefined'){
	   			var source = $(item).attr("src");
	    		$.ajax({
	 	   			url:contextPath+"/getVideoTimeLength",	
	 	   			type:"post",
	 	   			data:{"source":source},
	 	   			dataType:"json",
	 	   			success:function(result){
	 	   				$(item).parents(".courseBody").find(".data").text(result);	
	 	   			}
	    		});
	   		}else {
	   			alert("异常 : 资源不存在 或 未定义:" + item)
	   		}
	   	}
   
</script>