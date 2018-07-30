<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>课程详情</title>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
    <input id="contextPath" value="${pageContext.request.contextPath }" style="display:none;"/>
    <script src="${path}/jsp/js/publicJS/rem.js"></script>
    <script src="${path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
    <script src="${path}/jsp/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/jsp/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/iconfont/iconfont.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/global.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/header.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/courseList.css">
    <link rel="stylesheet" href="${path}/jsp/css/publicCSS/css/courseDetail.css">
    <%
	    String basePath = request.getScheme() + "://www.houpuclass.com" + request.getContextPath()+ "/";
		String currentUrl = basePath + session.getAttribute("requestUrl")  + "?" + session.getAttribute("queryString");
		session.setAttribute("lastUrl", currentUrl);
	%>
    <script >
    	var contextpath = $('#contextPath').val();
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
<style type="text/css">
.video-every {
	margin-top: 0.1rem;
	border-bottom: 1px solid #ccc;
	overflow: auto;
}

.video-every div {
	float: left;
}

.video-every div:nth-child(1) {
	width: 1rem;
	float: left;
}

.video-every div:nth-child(2) {
	width: 4.3rem;
	float: left;
}

.video-every div:nth-child(3) {
	width: 1.5rem;
	float: right;
}
	.content .tabbox{
	height: 0.8rem;
	}
	.content .tabbox li{
	line-height:0.8rem;
	}
	.pay{
	height: 0.8rem;
	}
	.pay .price{
	line-height:0.8rem;
	}
	.go_pay{
	margin-top:0.1rem;
	margin-bottom:0.1rem;
	}
	.infobox{
	padding:0.27rem 0.27rem 1.8rem;
	}
</style>
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
    <div class="videobox">
    	<video src="${generalVideo.gvideoUrl}" id="myvideo" controls="controls" class="video">
    </div>
	<c:if test="${not empty weekVal }">
		<div style="width:100%;color:gray;font-size:16px;">【${weekVal}更新】</div>
	</c:if>
	<ul class="tabbox">
       <li class="tab active">目录</li>
        <li class="tab">简介</li>
        <li class="tab">推荐视频</li>
        <li class="tab">评论</li>
    </ul>
   <div class="infobox"> 
   
    <div class="info info_show">
    	<table style="width: 100%; height: auto;">
			<tr>
				<td style="width: 17%; border-left: 1px solid #fff;">
					<div style="height: auto; width: 100%; overflow: auto;">
				        <ul class="ce">
							  <li> 
							  	<div class="info_key"> 
								   <a href="javascript:void(0)"  class="xz">播放目录</a>
								</div>  
								<div class="info_val info_val_active"> 
								   <ul class="er" style="display:block;">
								   <c:forEach items="${generalVideo.vclist}" var="gl" varStatus="st">
										<c:if test="${st.index==0 }">
											<li id="vli_${st.index}" class="choose_li"><a
												href="javascript:void(0)" style="color:black;"
												onclick="playVideo('${gl.vcideoUrl}','${gl.cImgUrl}',${st.index},'${gl.vcid}','${gl.vcname}',true)">${gl.vcname}</a>
											</li>
										</c:if>
										<c:if test="${st.index>0 }">
											<li id="vli_${st.index}"><a
												href="javascript:void(0)"
												onclick="playVideo('${gl.vcideoUrl}','${gl.cImgUrl}',${st.index},'${gl.vcid}','${gl.vcname}',true)">${gl.vcname}</a>
											</li>
										</c:if>
									</c:forEach>
								   </ul>
								</div>
							  </li>
							  
							  <li> 
							  	<div class="info_key"> 	
								   <a href="javascript:void(0);"  class="xz2">章节测试</a>
								</div>
								<div class="info_val"> 
								   <ul class="er2" style="display:block;">
										<li><a id="testName" data-toggle="modal" data-target="#msk_test">${videoChild.vcname}测验题</a></li>
								   </ul>
								</div>
							  </li>
							  
							  <li> 
							  	<div class="info_key"> 
								   <a href="javascript:void(0);"  class="xz2">讲义下载</a>
								</div>
								<div class="info_val"> 
								   <ul class="er2" style="display:block;">
								       <c:if test="${generalVideo.pdflist.size()==0}">
							              <li><a  href="javascript:void(0)">尚未上传讲义</a>  </li>
								       </c:if>
									  <c:forEach items="${generalVideo.pdflist}" var="pdf">
										 <li ><a  href="javascript:void(0)" onclick="dowbLoad('${pdf.pdfUrl}')" >${pdf.pdfUrl.replace("/pdf/","")}</a></li>
							          </c:forEach>	
								   </ul>
								</div>
							  </li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
		
		<!--测验题弹出框 -->
	<div class="modal fade" id="msk_test" style="display:none;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" > 
				<div class="modal-body" >
					<h4 style="color:#5CB85C;" id="h4_tip">测试题加载中...</h4>
					<div id="unitTest_div" style="display:none;"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div> 
		
        </div>
        <div class="info" >
            <p class="prompt">${generalVideo.gintro}</p>
        </div>
        
        <div class="info"><%--推荐视频 --%>
            <div class="model model_flex">
            <c:forEach items="${glist}" var="gl">
               <div class="every_info  thisv">
				<input class="no" type="hidden" value="${gl.gid}">
				<input id="isMore_${gl.gid}" type="hidden" value="${gl.isMore==null?0:gl.isMore}">
				 <a href="javaScript:void(0);" class="detail_info_img"> 
		 			<c:if test="${gl.gvimg==null||gl.gvimg.length()==0 }">
						<img src="${pageContext.request.contextPath}/jsp/img/class5.jpg"/>
				  	</c:if>	
				   <c:if test="${gl.gvimg!=null&&gl.gvimg.length()>0 }">
				     <img src="${gl.gvimg}"/>
				   </c:if>
				 </a>
				 <h6>${not empty gl.gclassify2?gl.gclassify2:(gl.gclass=='新概念'?gl.gname:gl.gclassify)} </h6>
				 <p class="name" style="display:none;">${gl.gname}</p>
				<p class="info_name_char">主讲老师：${gl.teacherName}</p> 
				<p >
					<div class="clearfix rmbbox">
					    <c:if test="${gl.gmoney=='0'}">
							<p class="rmb f_fl">免费</p>
						</c:if> 
						<c:if test="${gl.gmoney!='0'}">
							<p class="rmb f_fl">￥${gl.gmoney}</p>
						</c:if>
					    <span class="f_fr datebox" >时长：<span class="date"></span></span>
						<video src="${gl.gvideoUrl }"  preload="none" class="videoHide" style="display:none">
						</video>
					</div>
				</p>
				<p class="study">
					<span>${gl.gplayNo}</span>人学习
				</p>
			</div>
			</c:forEach>
            </div>
        </div>
        
        <div class="info" id="subEval_div">
            
           	<c:if test="${empty user }">
				<p class="login_prompt"><a href="login">登录</a>后评论</p>
				<textarea name="pl" class="comment" disabled="disabled" placeholder="说说你对该视频的看法"></textarea>
				<div class="user-submit" onclick="subEvaluation(0)">
					<span class="comment_btn">提交评论</span>
			    </div>
			</c:if>
			<c:if test="${! empty user }">
				<p class="login_prompt">${user.userName}:</p>
				<textarea placeholder="说说你对该视频的看法，最多660字" name="evaluation" id="evaluation"></textarea>
				<div class="user-submit" onclick="subEvaluation(1)" id="subbtn">
					<span class="comment_btn">提交评论</span>
				</div>
				<span style="color:green;" id="ok_span"></span>
			</c:if>
			
			<div style="clear: both;"></div>
			
			<c:forEach items="${elist}" var="e">
			<div class="video-every">
				<div class="user-name-one">${e.uname}:</div>
				<div class="user-info">
					${e.evaluation}
				</div>
				<div class="user-submit">
					${e.ecreatTime}
				</div>
				<div style="clear: both;"></div>
			</div>
		 	</c:forEach>
			
		</div>
		
   </div>
</div>    

<%--视频支付 --%>

<c:if test="${!generalVideo.gmoney.equals('0')}"> 
   <div class="pay clearfix" style="height:auto;bottom:1.4rem;">
     <!-- 原价 --> 
     <c:if test="${killInfo==null||killInfo.timeType==2||generalVideo.isKill==0}"> 
      <c:if test="${isBuy==0}">
	      <p class="price"> 视频价格：
	     	 <span>￥${generalVideo.gmoney}</span> 
	      </p>
	      <button class="go_pay" type="botton" onclick="payUseWeiPay()"> 去支付 </button>
      </c:if> 
      <c:if test="${isBuy!=0}">
	      <p class="price">
	     	 <span >已支付</span> 
	      </p>
      </c:if> 
     </c:if> 
     
     <!-- 优惠价或原价 --> 
     <c:if test="${killInfo!=null&&killInfo.timeType!=2&&generalVideo.isKill==1}"> 
     <%--
       <p class="price">
         <c:if test="${not empty generalVideo.killName}">
          	【${generalVideo.killName}】
         </c:if> &nbsp;&nbsp; 
          <c:if test="${killInfo.timeType==0}">
          	<p class="price">
	     	 <span> 离活动开始还有:${killInfo.showTimerText} </span> 
	      	</p>
          </c:if>
          <c:if test="${killInfo.timeType==1}">
          	<p class="price">
	     	 <span> 活动还剩:${killInfo.showTimerText} </span> 
	      	</p>
          </c:if> 
         </span>
        </p>
       --%>
          <%--情况1--%>
           <c:if test="${killInfo.timeType==1 }"> 
            <c:if test="${isBuy==0}"> 
	            <p class="price">￥${generalVideo.killMoney}
		     	 <span>专柜价：￥${generalVideo.gmoney}</span> 
		       	</p>
		        <button class="go_pay" type="botton" onclick="payUseWeiPay()">马上抢</button> 
            </c:if> 
            <c:if test="${isBuy!=0}"> 
             	<button class="go_pay" type="botton">已支付</button>
            </c:if> 
          </c:if> 
           <%--情况2--%>
           <c:if test="${killInfo.timeType==0 }"> 
            <c:if test="${isBuy==0}"> 
             	<p class="price">￥${generalVideo.killMoney}
		     	 <span>专柜价：￥${generalVideo.gmoney}</span> 
		       	</p>
		        <button class="go_pay" type="botton" onclick="payUseWeiPay()">去支付</button>
            </c:if> 
            <c:if test="${isBuy!=0}"> 
             <button class="go_pay" type="botton" >已支付</button> 
            </c:if> 
           </c:if>
    </c:if>
   </div> 
  </c:if>

<%--视频支付  未做--%>
<%--
<div class="pay clearfix">
    <p class="price"> 视频价格：<span>￥29.9</span> </p>
    <button class="go_pay" > 去支付 </button>
</div>
--%>


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
	     <!-- 分页参数 -->
	     <input type="hidden" name="pageNo" id="pageNo">
	</form>
</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsp/js/jwplayer.js"></script>
<script>jwplayer.key="WebEzzv0/FjWreLKIGCDbPbSN4WiZ+rC9+HPjg==";</script>
<script>
	var playIndex=0;
	var vcId=0;
	var vcname="${videoChild.vcname}";
	var isRemove=false;
	
	function playVideo(url,cImgUrl,index,vcid,vcname,isplay){
		changeVideoPlayNum();
		if(!isRemove){
			$("#vli_0").removeClass("choose_li");
			$("#vli_0 a").removeAttr("color");
			isRemove=true;
		}
		playIndex=index;
		//修改章节测试题
		vcId=vcid;
		vcname= vcname;
		$("#testName").text(vcname+"测验题");
		//切换视频播放
		initPlayer(playerInstance,url,cImgUrl,isplay);
		initUnitTests(vcId,2,0,vcname);
	}
	
	function openUnitTest(){
		$("#openBtn").click();
	} 
	
	var isBuy="${isBuy}";//是否购买过
	var vvip=0;
	var islogin=0;
	var userIsVip=0;
	var endTime;
	 var timeII;
	 var count=7200;//2小时
	 var playerInstance;
	 var time;
	 var isPlay=false;
	 var playerlimittime = 60;
	 var orderMoney ;
	$(function(){
	  	 playerInstance = jwplayer('myvideo');  
	  //	var playerlimittime = 60;	
//	  	会员的标识是会员为1
        var bpn = $('.bpns').val();
		 islogin="${user==null?0:1}";//是否登录
		 userIsVip=islogin==0?0:"${user.isVip}";
		 endTime=islogin==0?"":"${user.endTime==null?'':user.endTime}";
	  	 vvip = "${generalVideo.gisVip}";
	  	//initPlayer(playerInstance,"${videoChild.vcideoUrl}",false);
	  	 //2018年4月18日13:39:44 郭迪 ,多添加一个参数-视频图片url . 
	  	initPlayer(playerInstance,"${videoChild.vcideoUrl}","${videoChild.cImgUrl}",false);
	  	//确定视频现在的价格
	  	if("${killInfo.timeType}" == 1){
	  		orderMoney = "${generalVideo.killMoney}";
	  	}else{
	  		orderMoney = "${generalVideo.gmoney}";
	  	}
    	
    	
    });
	//设置播放器参数
	function initPlayer(playerInstance,url,cImgUrl,autostart){
		var playerwidth = $("#myvideo").width();
	    var playerheight = $("#myvideo").height();
	    if(cImgUrl=="" || cImgUrl=="undefined" ){
	    	cImgUrl = "${pageContext.request.contextPath}/jsp/img/back.jpg";
	    }
	  //初始化视频  
	  	playerInstance.setup({
        	//视频文件路径
            file:url,
            //未播放前图片路径
            image: cImgUrl,
            //播放器宽度
            width: playerwidth,
            //播放器高度
            height: playerheight,
            //设置默认播放器的渲染模式。
            primary: "flash",
            //设置视频铺满屏幕变换了形状
            stretching: "exactfit",
            autostart:autostart//是否自动播放
    	});
	  //监控播放时间  
		playerInstance.onTime(function(){  
		  //获取当前的播放时间  
		   time = playerInstance.getPosition();  
		   if(!isPlay){
				 $.post("${pageContext.request.contextPath}/video/changePlayCount",
						 {vid:"${generalVideo.gid}",vclassify:0},function(){});
				 isPlay=true;
			  }
		  //不回答问题不能进行播放下面的视频  
		  //if(vvip==1){
		 if(vvip==0){//数据库中：0：是；1：否 (20170326-update)
		   if(isNeedBuy()){ 
		  	if(time >= playerlimittime){
//		  		让播放条滑动到设定的时间段
		  		playerInstance.seek(playerlimittime); 
//				暂停当前播放视频
		  		playerInstance.pause();
		  		alert("购买视频即可观看.")
	 	 	}
	 	  } 
	    }
	 }); 
	}
	function login(){
		if(confirm("您还没登录,确定登录吗？")){
  	    	window.location.href=encodeURI(contextpath+"/public/login");//跳转登录页
     	}
	}
	function payUseWeiPay(){//二维码支付.-->应该改为直接调用微信接口
		if(islogin=="0"){
			login();
	  	}else{
  		  //发送请求到服务器生成预支付订单号
			if(${generalVideo.gmoney } > 0){
				var url="<%=basePath%>pay/0?vid=${generalVideo.gid}"; //注意此处的basePath是没有端口号的域名地址。如果包含:80,在提交给微信时有可能会提示 “redirect_uri参数错误” 。
				var appid = 'wx63ab356fb8658cf3';
				var orderID = "";// 可以附带想添加的自定义参数. 此处可以带上订单号(暂时未定义)
		       //money为订单需要支付的金额
		        var weixinUrl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appid+"&redirect_uri="
		      		+encodeURI(url)+"&response_type=code&scope=snsapi_base&state="+orderID+"#wechat_redirect";
		 		window.location.href=encodeURI(weixinUrl);
			}else{
				alert("免费视频,不需要支付");
			}
	  	}
	}	
		
    /* function isNeedBuy(){
    	if((userIsVip != 1 &&isBuy=="0")||(userIsVip ==1 && (!compareTo(endTime)||(compareTo(endTime)&&!isRight(islogin)))&&isBuy=="0")||islogin=="0"){
    		return true;
    	}
    	return false;
    } */
    
	//是否需要购买 或 登录
    function isNeedBuy(){
    	if( (orderMoney != 0 && userIsVip != 1 && isBuy=="0")
    			|| (userIsVip == 1 
    				&& ( !compareTo(endTime) || (compareTo(endTime) && !isRight(islogin) && orderMoney != 0 ) )
    				&& isBuy=="0")
    			|| islogin=="0"){
    		/** 价格不为0 && 用户非vip && 没有购买过
    		*	是vip && ( vip过期 || (vip没过期&& 没登录,没权限 ) || 没购买 )
    		*/
    		
    		return true;
    	}
    	return false;
    }
    
    function isRight(islogin){
	    if(islogin=="0"){
	    	 return false;
	    }else{
	    	var rightContent="${user.rightContent}";
	    	if(rightContent.length==0){
	    		return true;
	    	}else{
	    	   var class_g="${generalVideo.gclass}";
	    	   var gclassify="${generalVideo.gclassify}";
	    	   var gclassify2="${generalVideo.gclassify2}";
	    	   var gsbuject="${generalVideo.gsbuject}";
	    	   if(class_g.indexOf("古诗")>-1||class_g.indexOf("阅读")>-1||class_g.indexOf("写作")>-1||class_g.indexOf("语法")>-1||class_g.indexOf("流利英语")>-1){
	    		   class_g="";
	    	   }
	    	   if(gclassify2!=""){
	    		   gclassify="";
	    	   }
	    	   if(class_g==""){
	    		   return rightContent.indexOf(gsbuject+gclassify+gclassify2)>-1?true:false;
	    	   }
	    	   var class_arr=class_g.split(",");
	    	   for(var i in class_arr){
	    		  if(rightContent.indexOf(gsbuject+class_arr[i]+gclassify+gclassify2)>-1){
	    		    return true;
	    		  }
	    	   }
	    	   return false;
	    	}
	    }
	 }
	
	 function readPdf(url,This){
		 var  flag=false;
		 if(vvip==0){
			if(isNeedBuy()){
				    if(islogin=="0"){
			  	      //alert("您还没有登录！");
				    	login();
			  		}else{
			  			 alert("您还没有购买此视频！");
			  		}
			}else{
				flag=true;
			}
		  }else{
			  flag=true;
		  }
		 if(flag){
			 $(This).attr("href",url);
			 $(This).attr("target","_blank");
		 }
	 }		 
    function dowbLoad(url){
    	 var  flag=false;
		 if(vvip==0){
			if(isNeedBuy()){
				    if(islogin=="0"){
			  	      //alert("您还没有登录！");
				    	login();
			  		}else{
			  			 alert("您还没有购买此视频，不能下载！");
			  		}
			}else{
				flag=true;
			}
		  }else{
			  flag=true;
		  }
		 if(flag){
			 window.open("${pageContext.request.contextPath}/download/file?url="+url);
		 }
	}
	 function timeStart(){
		  count=7200;
		  setSpanTime(count);
		  var ii=setInterval(function(){
				 timeII=ii;
				  if(count>0){
					  count--;
					  setSpanTime(count);
				  }else{
					 $("#closeErweima").click();
				  }
				 
			  }, 1000);
	  }
	  function setSpanTime(seconds){
		  $(".msk h4 span").html(getTimeVal(seconds));
	  }
	  function getTimeVal(seconds){
	    var val="";
	    var h=Math.floor(seconds/3600);
		var m=Math.floor(seconds%3600/60);
		var s=Math.floor(seconds%3600%60);
		 h=h<0?0:h;
		 m=m<0?0:m;
		 s=s<0?0:s;
		val=h+"时"+m+"分"+s+"秒";
		return val;
	  }
	  //日期比大小	  
		 function compareTo(endTime){
			var flag=false;
			if(endTime.length>0){
				var currdate=new Date();
				//日期比较大小
				var endDate = new Date(Date.parse(endTime)); 
				if(endDate>=currdate){
					flag=true;
				}
			}
			return flag;
		 }
	</script>
	
	</script>
	<script>
	// 四个标签 ,点击时 轮换显示.
    $(function () {
        $(".tab").on("click",function(){
            tabClick(this);
        })
        onclickVideo();
    })
    	function tabClick(element) {
            $(".tab").removeClass("active");
            $(element).addClass("active");
            var len = $(element).index(".tab");
            $(".info").removeClass("info_show");
            $($(".info")[len]).addClass("info_show");
        }
	    function onclickVideo(){
 	        var videos = $(".videoHide");
			for(var i =0 ;i < videos.length ;i ++){
				getDurations(i,videos);
 	        }
		}
	    function getDurations(i,videos) {
	    	var item = videos[i];
	    	item.onloadedmetadata=function(){
	             let duration = item.duration;
	             let h = Math.floor(duration/3600);
	             let m = Math.floor((duration%3600)/60);
	             let s = Math.ceil(duration%60);
	             setParams({
	                 item,
	                 h,
	                 m,
	                 s
	             })
	         };
	    }
	    function setParams(data) {
	            let {item,h,m,s} = data;
	            let date = "";
	            if (h) date += h + ":";
	            if (m) date += m + ":";
	            if (s) date += s;
	            console.log(date);
	            $(item).parents(".every_info").find(".date").text(date);
	        }
   
</script>

<script src="${pageContext.request.contextPath}/jsp/js/jquery.1.10.1.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/jsp/js/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/jsp/js/video.js?v=1" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
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
	
	
	//初始化章节测验html
	function initUnitTests(vid,type,isRedo,vname){
		isRedo=isRedo?1:0;
		vname=vname?vname:vcname;
		 //加载章节测试题
		  $.post("${pageContext.request.contextPath}/back/getUnitTestsHtmlByVid",
				  {vid:vid,utype:type,isRedo:isRedo,vname:"${generalVideo.gname}"+vname},function(res){
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
					  changeHtml("即将上线，敬请期待！","#5CB85C");
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
	    	//alert("您还没有登录！");
	    	login();
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
	//提交打分
	function submitAnswer(){
		if(islogin==0){
	    	//alert("您还没有登录！");
	    	login();
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
		$.post("${pageContext.request.contextPath}/back/addUserScore",{vid:vcId,utype:2,score:totalScore,rightNum:right_num,errorNum:error_num,
			isHasJDT:isHasJDT,totalNums:$("#nums_hide").val(),totalScores:$("#scores_hide").val(),teacherName:"${generalVideo.teacherName}",JDT_answer:JSON.stringify(JDT_answer)},function(res){});
	}
	function redo(){
		initUnitTests(vcId,2,1);
		//$("#result_tests").hide();
		//$("#submitAnswer_btn").attr("disabled",false);
	}
	$(function(){
		vcId="${videoChild.vcid}";
		if(vcId!=""){
			initUnitTests(vcId,2);
		}
		 setChangeTimeStatus(true);
		 //异步更新下一集
		  editVideoLastNew();
    });
	function editVideoLastNew(){
		var editTimerNum="${editTimerNum}";
		 if(editTimerNum!=""&&editTimerNum>0){
			 setTimeout(function(){
			   $.post("${pageContext.request.contextPath}/general/getLastNewVideo",{gid:"${generalVideo.gid}",lastVcid:"${lastVcid}"},function(data){
				  if(data){
					  var li_size=$(".er").children("li").length;
					  var li_html="";
					  if(li_size==0){
						  li_html="<li id=\"vli_0\"  class=\"choose_li\"><a href=\"javascript:void(0)\"  style=\"color:black;\" onclick=\"playVideo('"+data.vcideoUrl+"','"+data.cImgUrl+"',0,'"+data.vcid+"','"+data.vcname+"',true)\">"+data.vcname+"</a></li>";
						  playVideo(data.vcideoUrl,data.cImgUrl,0,data.vcid,data.vcname,false);
					  }else{
						  li_html="<li id=\"vli_"+li_size+"\" ><a href=\"javascript:void(0)\"  onclick=\"playVideo('"+data.vcideoUrl+"','"+data.cImgUrl+"',"+li_size+",'"+data.vcid+"','"+data.vcname+"',true)\">"+data.vcname+"</a></li>";
					  }
					  $(".er").append(li_html);
				  }
			   });
			 }, editTimerNum);
		 }
	}
	
	var sub_flag=true;
	function subEvaluation(type){
		if(type==0){
			//alert("请登录后再评论！");
			login();
		}else{
		  if(sub_flag){
			  sub_flag=false;
			  $("#subbtn").unbind();
			  $("#subbtn span").html("评论提交中...");
			  $("#subbtn span").css({background:"gray"});
			  var evaluation=$("#evaluation").val();
				var len=evaluation.length;
				if(len==0){
					alert("评论内容不可为空！");
				}else if(len>660){
					alert("评论内容最多660字！");
				}else{
					 var vid="${generalVideo.gid}";
						var vclassify=0;
						var uname="${user.userName}"; 
						$.ajax({
							url:"${pageContext.request.contextPath}/eval/addEvaluation",
							data:{evaluation:evaluation,vid:vid,vclassify:vclassify,uname:uname},
							type:"post",
						    async:false,
						    success:function(res){
						    	if(res.indexOf("ok")>-1){
						    		$("#ok_span").html("评论新增成功!");
						    		$("#evaluation").val("");
						    		var ecreatTime=res.split("_")[1];
						    		//追加一行评论信息
						    		var addhtml='<div class="video-every">'+
						    						'<div class="user-name-one">'+uname+':</div>'+
						    						'<div class="user-info"><p>'+evaluation+'</p></div>'+
						    						'<div class="user-submit">'+ecreatTime+'</div>'+
						    					'</div>'+
						    					'<div style="clear: both;"></div>';
										       
						    		$("#subEval_div").append(addhtml);
						    		setTimeout(function(){$("#ok_span").html("");},2000);
						    	}else{
						    		alert(res);
						    	}
						    }
						}); 
				}
				 $("#subbtn").click(function(){
					 subEvaluation(type);
				 });
				  $("#subbtn span").html("提交评论");
				  $("#subbtn span").css({background:"rgb(92,184,92)"});
		  }else{
			  alert("不可重复提交！");
		  }
		  sub_flag=true;
	 }
	}
	
	//修改学生学习时间
	function changeVideoPlayNum(){
	  if(time&&islogin=="1"){
	    $.ajax({
	   url:"${pageContext.request.contextPath}/user/changeStuLeanTime",
	   type:"post",
	   async:false,
	   data:{vid:"${generalVideo.gid}",vclassify:0,time:time},
	    success:function(){}
	   });
	  }
	}
	
 	//浏览器关闭
	window.onbeforeunload = function closeWindow(e){
		e = e || window.event;
	    if (e){
	    	changeVideoPlayNum();
	    	//alert("后退");
	    }
	};
	var agent="<%=request.getHeader("user-agent")%>";
	//浏览器后退
	jQuery(document).ready(function($) {
	  if(agent.indexOf("Safari")>-1){
		 return;
	  }
		   if (window.history && window.history.pushState) {
		    $(window).on('popstate', function() {
		      var hashLocation = location.hash;
		      var hashSplit = hashLocation.split("#!/");
		      var hashName = hashSplit[1];

		      if (hashName !== '') {
		        var hash = window.location.hash;
		        if (hash === '') {
		         //alert("后退");
		         changeVideoPlayNum();
		          window.history.back();
		        }
		      }
		    });
		    window.history.pushState('forward', null, "");
		  } 
		}); 
	</script>
<script src="${pageContext.request.contextPath}/jsp/js/publicJS/menuFun.js" type="text/javascript" charset="utf-8"></script>