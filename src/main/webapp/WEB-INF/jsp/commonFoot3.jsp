<%@ page language="java"  pageEncoding="UTF-8"%>

<div class="course-footer">
	<div class="nav">
	<!--导航条-->
	<ul class="nav-main">
		
		<li id="li-1">
		 	<img src="${ path}/image/1.png" alt="">
			<p>厚朴网课</p>
		<span></span>
		</li>
		<li id="li-2">
			<img src="${ path}/image/2.png" alt="">
			<p>厚朴师生</p>
		<span></span></li>
		<li id="li-3">
			<img src="${ path}/image/3.png" alt="">
			<p>在线测评</p>
		<span></span></li>
		<li id="li-4">
			<img src="${ path}/image/4.png" alt="">
			<p>我的</p>
		<span></span></li>
	</ul> 
	<!--隐藏盒子-->
	<div id="box-1" class="hidden-box hidden-loc-index">
		<ul>
			<li><a href="${path }/public/index">首页</a></li>
			<li><a href="${path }/public/generalCourse">常规课程</a></li>
			<li><a href="${path }/public/competitionCourse">竞赛课程</a></li>
			<%-- 
			<li><a href="${path }/public/latestGeneralCourse">最新常规课</a></li>
            <li><a href="${path }/public/latestCompetitionCourse">最新竞赛课</a></li> 
            --%>
            <li><a href="${path }/public/latestCourse">最新课程</a></li>
            <li><a href="${path }/public/exam">小测试</a></li>
		</ul>
	</div>
	<div id="box-2" class="hidden-box hidden-loc-us">
		<ul>
			<li><a href="${path }/public/teachers">名师推荐</a></li>
			<li><a href="${path }/public/students">学生展示</a></li>
		</ul>
	</div>
	<div id="box-3" class="hidden-box hidden-loc-info">
		<ul>
			<li><a href="${path }/public/goTest">在线测评</a></li>
		</ul>
	</div>
    <div id="box-4" class="hidden-box hidden-loc-info box04">
		<ul >
			<li><a href="${path }/public/myProfile">我的资料</a></li>
			<li><a href="${path }/public/myCourse">学习课程</a></li>
			<li><a href="${path }/public/myScore">历史分数</a></li>
			<li><a href="${path }/public/purchaseRecord">购买记录</a></li>
		</ul>
	</div>
</div>
</div>

<script type="text/javascript">

/* var num;
$('.nav-main>li[id]').hover(function(){ */
 /*图标向上旋转*/

  /*下拉框出现*/
  /* var Obj = $(this).attr('id');
  num = Obj.substring(3, Obj.length);
  $('#box-'+num).slideDown(300);
},function(){ */
  /*图标向下旋转*/

  /*下拉框消失*/
 /*  $('#box-'+num).hide();
}); */
//hidden-box hover e
/* $('.hidden-box').hover(function(){ */
  /*保持图标向上*/
 
/*   $(this).show();
},function(){
  $(this).slideUp(200);
 
}); */

$(function(){
	var num;
	$('.nav-main>li[id]').on("click",function(){
		var Obj = $(this).attr('id');
		  num = Obj.substring(3, Obj.length);
		if($('#box-'+num).css("display")=="block"){
			 $('#box-'+num).hide();
			 $(this).css({'background-color':'white'});
		}else{
			 $('#box-'+num).show().siblings().hide();
			 $('.nav-main').show();
			 $(this).css({'background-color':'#c9c9c9'});
			 $(this).siblings().css({'background-color':'white'});
		}
	})
	
})
</script>

<style> 
/* 底部样式 */
.course-footer{
	width:100%;
	border-top:1px solid #dfdfdf;

	position:fixed;
	bottom:0;
}
.course-list li{
	float:left;
	list-style:none;
	width:25%;
	text-align:center;
	border:1px solid #dfdfdf;
	box-sizing:border-box;
}
.course-list li a{
	color:#333;
	text-decoratioon:none;
}
.cou-list{
	text-align:center;

}
.cou-list li{
    list-style: none;
    line-height: 8rem;
    text-align: center;
    border: 1px solid #dfdfdf;
    box-sizing: border-box;   
}
.cou-list li a{
   	color:#333;
	text-decoratioon:none;
}

div.nav{
  	background:white;
    text-align: center;
    font-size: 12px;
    position: relative;
  
}
/*nav-main*/
ul.nav-main{
    width: 100%;
    height: 100%;
    list-style-type: none;
}
ul.nav-main p{
	line-height: 0px;
    position: relative;
    bottom: -15px;
    font-size: 14px;
}
ul.nav-main img{
	height:30px;
	padding-top: 5px;
}
ul.nav-main a{
   text-decoration:none;
   color:white;
   font-size:14px;
}
ul.nav-main span{
    display: inline-block;
    margin-left: 18px;
    width: 7px;
    height: 7px;
}
/*图标向上旋转*/
.hover-up{
    transition-duration: .5s;
    transform: rotate(180deg);
    -webkit-transform: rotate(180deg);
}
/*图标向下旋转*/
.hover-down{
    transition-duration: .5s;
    transform: rotate(0deg);
    -webkit-transform: rotate(0deg);
}
/*导航条设置*/
ul.nav-main>li{
	width:25%;
    height: 100%;
    display: block;
    float: left;
    font-size: 20px;
    cursor: pointer;
    box-sizing:border-box
}
ul.nav-main>li:hover{

}
/*隐藏盒子设置*/
div.hidden-box{
	width:25%;
	
	z-index:999;

    border-top: 0;
    position: absolute;
    bottom:58px;
   	display:none;
	background:#fff;
	
}
.hidden-box>ul{
    list-style-type: none;
    
    font-size:20px;
    cursor: pointer;
}
.hidden-box>ul li{
	height: 50px;
    line-height: 50px;
    text-align:center;
    font-size:14px;

}
.hidden-box>ul li a{
   text-decoration:none;
   color:#333;
}
.hidden-box li:hover{
    color: #fff;
}
.hidden-box li:hover a{
    color: #fff;
}
/*隐藏盒子位置设置*/
.hidden-loc-index{
    left: 0;
}
.hidden-loc-us{
    left: 25%;
}
.hidden-loc-info{
    left: 50%;
}
.box04{
	left:75%;
}
.modelbox{
	padding-bottom:150px;
}
</style>

