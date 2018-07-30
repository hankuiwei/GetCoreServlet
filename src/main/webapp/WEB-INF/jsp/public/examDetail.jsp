<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>小测试详情</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input id="contextPath" value="${pageContext.request.contextPath }" style="display:none;"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsp/css/commonProblremInfo.css"/>
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/global.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/header.css">
        <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/publicCourse.css">
    <link rel="stylesheet" href="${path }/jsp/css/publicCSS/css/courseList.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/courseDetail.css">
	<style type="text/css">
		.user-submit {
			padding-top: 1%;
			width: 100%;
			overflow: auto;
		}
		
		.user-submit span {
			display: block;
			float: right;
			color: #fff;
			margin-right: 5%;
			padding: 1% 5%;
			background: rgb(92, 184, 92);
			border-radius: 5px;
			border: 1px solid rgba(92, 184, 92, 0.64);
	}
	</style>
<script src="${path}/jsp/js/publicJS/rem.js"></script>
<script src="${pageContext.request.contextPath}/jsp/js/jquery.1.10.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script >
    	var contextpath = $('#contextPath').val();
    	//获取视频时长
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
    <script src="${path}/jsp/js/publicJS/mediaElementPlayer.js"></script>
    
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

            <div >
                <div >
                	<strong>${exam.etclass}${exam.etclassify}${gsubject}小测验</strong>
                </div>
                <div class="newsdetails-content-date">
                  <!-- 章节测试题 -->
					<h4 style="color:#5CB85C;" id="h4_tip"> 测试题加载中...</h4>
					<div id="unitTest_div" style="display:none;text-align:left;"></div>
                </div>
               <c:if test="${not empty exam.etimg&&exam.etimg==1}">
                <div class="">
                   <c:forEach items="${exam.imgList}" var="e">
                    <c:if test="${e.type==0}">
                		<img src="${e.examUrl}" style="width: 7.5rem;height: 15rem;"/>
                	</c:if>
           			</c:forEach>
                </div>
                <c:if test="${not empty exam.pdf}">
	                <div class="user-submit" onclick="dowbLoad('${exam.pdf}')" >
						<span>下载测验题</span>
					</div>
				</c:if>
               </c:if> 
            </div>
            
         <c:if test="${not empty exam.etimg&&exam.etimg==1}">
            <div class="exam-fenei">
           		<span class="exam-btn show-answer">显示答案</span>
           		<span class="exam-btn hide-answer">隐藏答案</span>
           	</div>
            <div class="newsdetails-content-bottom exam-btn-fenei">
				<strong>测验答案：</strong>
				 <div class="newsdetails-content-top">
				 <div class="newsdetails-content-date">
					 <c:forEach items="${exam.imgList}" var="e">
					  <c:if test="${e.type==1}">
						<br>
						<span><img src=" ${e.answerUrl}" style="width: 7.5rem;height: 30rem;"></span>
		                <br>
	                  </c:if>
	                </c:forEach>
                </div>
                <c:if test="${not empty exam.answerPdf}">
	                <div class="user-submit" onclick="dowbLoad('${exam.answerPdf}')">
						<span>下载答案解析</span>
				    </div>
			    </c:if>
                </div>
        	</div>
         </c:if>

	<!-- 添加推荐视频 -->
	<div style="padding-left: 0.3rem;">
	    <strong>常规课程推荐视频：</strong>
		<div class="model model_flex">
			<c:forEach items="${glist }" var="g">
				<div class="every_info thisv">
				<input class="no" type="hidden" value="${g.gid}">
				<input id="isMore_${g.gid}" type="hidden" value="${g.isMore==null?0:g.isMore}">
					<a>
						<c:if test="${g.gvimg==null||g.gvimg.length()==0 }">
							<img src="${pageContext.request.contextPath}/jsp/img/class5.jpg" class="info_img"/>
						</c:if>	
						 <c:if test="${g.gvimg!=null&&g.gvimg.length()>0 }">
							 <img src="${g.gvimg}" class="info_img"/>
						</c:if>
						<h6>${g.gclass}${g.gsbuject}${not empty g.gclassify2?g.gclassify2:(g.gclass=='新概念'?g.gname:g.gclassify)}</h6>
						<p class="name" style="display:none;">${g.gname}</p>
		                 <p class="name1" >主讲教师:${g.teacherName}</p>
						<c:if test="${g.gmoney=='0'}">
							<div class="study">免费
						</div>
						</c:if>
						<c:if test="${g.gmoney!='0'&&g.gmoney!=null}">
						<div class="study">
						     ￥${g.gmoney}
						</div>
						</c:if>
					</a>
				</div>
			</c:forEach>
		</div>
		<strong>竞赛课程推荐视频：</strong>
			<div class="model model_flex">
				<c:forEach items="${clist }" var="g">
					<div class="every_info  thisc">
					<input class="cno" type="hidden" value="${g.cid}">
						<a>
							<c:if test="${g.cvimg==null||g.cvimg.length()==0 }">
								<img src="${pageContext.request.contextPath}/jsp/img/class1.jpg" class="info_img"/>
							</c:if>	
							 <c:if test="${g.cvimg!=null&&g.cvimg.length()>0 }">
								 <img src="${g.cvimg}" class="info_img"/>
							</c:if>
								<h6>${g.cclass}${g.competitionName}${g.cclassify}</h6>
								<p class="cname" style="display:none;">${g.cname}</p>
					            <p class="cname1" >主讲教师:${g.teacherName}</p>
							<c:if test="${g.cmoney=='0'||g.cmoney==null}">
								<div class="study">免费</div>
							</c:if>
							<c:if test="${g.cmoney!='0'&&g.cmoney!=null}">
							<div class="study">￥${g.cmoney}</div>
							</c:if>
						</a>
					</div>
				</c:forEach>
			</div>
			<p></p>
	</div>
    
</div>

<%@include file="../commonFoot3.jsp" %>
</body>
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
	</form>
</html>
<script src="${pageContext.request.contextPath}/jsp/js/jquery.1.10.1.min.js" type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/jsp/js/public.js" type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/jsp/js/publicJS/menuFun.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

$(".show-answer").click(function(){
	$(this).hide();
	$(".hide-answer").show();
	$(".exam-btn-fenei").show(10);
	
});
$(".hide-answer").click(function(){
	$(this).hide();
	$(".show-answer").show();
	$(".exam-btn-fenei").hide(10);
});
setChangeTimeStatus(false);

var vid="${exam.etid}";
var etimg="${exam.etimg}";
var imgsize="${exam.imgList.size()}";
function checkBox(This,hide_id){
    var val_h=$("#"+hide_id).val();
    var arr=[];
    if(val_h.length>0){
    	arr=val_h.split(",");
    }
	if($(This).is(":checked")){//勾选
		arr.push($(This).val());
	}else{//去除勾选
		arr.splice($.inArray($(This).val(),arr),1);
	}
	$("#"+hide_id).val(arr.join(","));
}
function dowbLoad(url){//下载答案
  window.open("${pageContext.request.contextPath}/download/file?url="+url);
}
//初始化章节测验html
function initUnitTests(vid,type,isRedo){
	isRedo=isRedo?1:0;
	 //加载章节测试题
	  $.post("${pageContext.request.contextPath}/back/getUnitTestsHtmlByVid",{vid:vid,utype:type,isRedo:isRedo,vname:"${exam.etname}"},function(res){
		  res=eval("("+res+")");
		  if(res.status=="ok"){
			  if(res.data.length>0){
				 if(isRedo==1){//重做
					 $("#unit_testAll").html(res.data);
				 }else{//初始化
					 $("#unitTest_div").html(res.data);
				 }
				  $("#unitTest_div").show();
				  $("#h4_tip").hide();
			  }else{
				  if(etimg==1&&imgsize>0){
					  changeHtml("","#5CB85C");
				  }else{
					  changeHtml("即将上线，敬请期待！","#5CB85C");
				  }
			  }
		  }else{
			  changeHtml("测试题加载失败,请联系管理员！","red");
		  }
	  });
}
function changeHtml(html,color){
	  $("#h4_tip").show();
	  $("#unitTest_div").hide();
	  $("#unitTest_div").html("");
	  $("#h4_tip").css("color",color);
	  $("#h4_tip").html(html);
}
//展开全部测验题
function slideDown_div2(This){
    if(islogin==0){
    	alert("您还没有登录！");
    }else{
    	 if($("#more_div").is(":hidden")){
    		  $("#more_div").slideDown();
    		  $(This).val("隐藏");
    	  }else{
    		  $("#more_div").slideUp();
    		  $(This).val("展开全部");
    	  }
    }
}
var islogin="${sessionScope.user==null?0:1}";
//提交打分
function submitAnswer(){
	if(islogin==0){
    	if(confirm("您还未登录,确定登录吗?")){
    		//登录
    		alert("登录未完成!")
    	}
    	return;
    }
    $("#submitAnswer_btn").attr("disabled",true);
       var right_answer=[];
       var user_answer=[];
       var score=[];
       var ids=[];
       $("input[name='right_answer']").each(function(){
           var val=$(this).val();
           if(val.length>0){
           	val=val.split(",").sort().join(",");
           }
       	right_answer.push(val);
       });
       $("input[name='user_answer']").each(function(){
       	var val=$(this).val();
           if(val.length>0){
           	val=val.split(",").sort().join(",");
           }
       	user_answer.push(val);
       	ids.push($(this).attr("id").replace("hide_",""));
       });
       $("input[name='score']").each(function(){
       	score.push($(this).val());
       });
       //判断计分
       var totalScore=0;
       var right_num=0;
       var error_num=0;
       for(var i in ids){
       	var right_a=right_answer[i];
       	var user_a=user_answer[i];
       	var score_a=score[i];
       	if(right_a==user_a&&right_a.length>0){
       		++right_num;
       		totalScore+=parseInt(score_a);
       		$("#sp_"+ids[i]).hide();
       		$("#hideDiv_"+ids[i]).hide();
       	}else{
       		++error_num;
       		$("#sp_"+ids[i]).show();
       		$("#hideDiv_"+ids[i]).show();
       	}
       }
       
       var isHasJDT=$("#isHasJDT").val();
       var  an_html="";
       if(isHasJDT!=1){
           var prev_text="";
       	if(isHasJDT==2){
       		prev_text="选择题";
       	}
       	an_html=prev_text+'答对'+right_num+'题，答错'+error_num+'题，总共得分：<font style="color:#CE0221;font-size:25px;font-weight:bold;">'+totalScore+'</font><br>';
       }
       var JDT_answer=[];
       if(isHasJDT!=0){
       	 an_html+="<font style=\"color:green;font-weight:bold;\">简答题已提交，等待老师打分。查看方式：个人信息-编辑|查看-历史分数</font>";
       	  $("textarea[name='JDT_answer']").each(function(){
       	     var jdt_answer=$(this).val();
       	     var jdt_id=$(this).attr("id").replace("JDT_","");
       	     var obj={};
       	     obj.jdt_answer=jdt_answer;
       	     obj.jdt_id=jdt_id;
       	     JDT_answer.push(obj);
       	     $("#sp_"+jdt_id).show();
        		 $("#hideDiv_"+jdt_id).show();
             });
       }
    $("#result_tests").html(an_html);
	$("#result_tests").show();
	//将学生成绩入库
	$.post("${pageContext.request.contextPath}/back/addUserScore",{vid:vid,utype:4,score:totalScore,rightNum:right_num,errorNum:error_num,
		isHasJDT:isHasJDT,totalNums:$("#nums_hide").val(),totalScores:$("#scores_hide").val(),teacherName:"${exam.teacherName}",JDT_answer:JSON.stringify(JDT_answer)},function(res){});
}
function redo(){
	initUnitTests(vid,4,1);
}
$(function(){
	initUnitTests(vid,4);
});
</script>