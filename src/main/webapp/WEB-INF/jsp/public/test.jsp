<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title> 

<c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>

<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Fortune Estates Widget Responsive, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, SmartPhone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />
<link rel="stylesheet" href="${ path}/jsp/css/bootstrap.min.css">
<link rel="stylesheet" href="${ path}/jsp/css/publicCSS/mystyle.css">
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<script src="${ path}/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" >
		$(function() {
			//
			$(".list-group1 li").click(function(){
				var index = $(this).index() ;
				$(".list-group1 li").eq(index).css({
					backgroundColor: "#61ccf8",
					color: "white",
					borderColor: "#61ccf8"
				}).siblings().css({
					backgroundColor: "#FCFCFC",
					color: "#333",
					borderColor: "#FCFCFC"
				})

				var len = $(".list-group-item").eq(index).offset().top;
				console.log(len)
				$("body,html").animate({
					scrollTop:len //让body的scrollTop等于pos的top，就实现了滚动
				},0);
			})

			$(".answer").hide();
			$(".time").hide();
			$(".percent").hide();
			
			// 即刻开始计时
			setMyTimeout();
			
			//
		});
		//设置定时器
		var flag = true ;
		var count = 1200;//1200秒
		function setMyTimeout(){
			$("#begin").prop("disabled","disabled");
			$("#begin").css("background","#5CB85C");
			$(".time").show();
			  if (count > 0 && flag) {
			        setTimeout(setMyTimeout, 1000);
			        $("#time").html( parseInt(count/60) +"分"+( count%60 ) + "秒");
			        $(".time").show();
			        count--;
			  }else{
				  //触发提交按钮.
				  submit();
			  }
		}
		
		function submit(){
			$("#end").prop("disabled","disabled");
			$("#end").css("background","#5CB85C");
			//var usedTime = 1200 - count ;//获取已经使用的时间
			//$("#time").html("用时:"+usedTime/60+"分"+(usedTime%60) + "秒");
			//clearTimeout();//清除定时. 
			flag = false ;
			$(".time").hide();
			
			//其他操作
			//1. 对比答案
			
			var right_answer=[];
	        var user_answer=[];
	        var score=[];
	        var ids=[];
	        $("input[name='answer']").each(function(){
	            var val=$(this).val().trim();
	            if(val.length>0){
	            	val=val.split(",").sort().join(",");//使用,分割然后排序,并加入,再组装.....
	            }
	        	right_answer.push(val);
	        });
	        $("input[name='user_answer']").each(function(){
	        	var val=$(this).val().trim();
	            if(val.length>0){
	            	val=val.split(",").sort().join(",");
	            }
	        	user_answer.push(val);
	        	ids.push( $(this).attr("id").replace("hide_",""));
	        });
	        $("input[name='score']").each(function(){
	        	score.push($(this).val());
	        });
	        
	        //判断计分
	        var totalScore=0;//总分
	        var Score=0;//总分
	        var right_num=0;
	        var error_num=0;
	        for(var i in ids){
	        	var right_a = right_answer[i];
	        	var user_a = user_answer[i];
	        	var score_a = score[i];
	        	totalScore +=  parseInt(score_a);
	        	
	        	if(right_a==user_a && right_a.length > 0){
	        		++right_num;
	        		Score += parseInt(score_a);
	        	}else{
	        		++error_num;
	        		$(".option_answer_"+ids[i]).show();
	        		$(".input_answer_"+ids[i]).show();
	        	}
	        	
	        	//arr.splice( $.inArray($(This).val(),arr) , 1 ); 骚操作
	        	
	        }
	        //显示答题情况
	        $(".percent").show();
	        $("#percent").html("总分:"+totalScore+",您的得分:"+Score);//正确率 (right_num/8)*100+"%"
	        
	        var error_testPoint = [] ;
	        //获得 错误题目 相关的 知识点 数组
	        $("input[name='testPoint']").each(function(){
	        	error_testPoint.push( $(this).val() );
	        })
	        //后续操作, 推荐视频!
	        
	        
		}
		
		
        
        /* "<input type=\"hidden\" name=\"right_answer\" value=\"" + answer_ids.toString()+ "\"> "
        <input type=\"hidden\" name=\"user_answer\" id=\"hide_" + ut.getUtid() + "\">"         
        <input type=\"hidden\" name=\"score\" value=\"" + ut.getScore() + "\">"   */              
        
        function checkBox(This,hide_id){
    	    var val_h=$("#"+hide_id).val();
    	    var arr=[];
    	    if(val_h.length>0){
    	    	arr=val_h.split(",");
    	    }
    		if( $(This).is(":checked") ){//勾选
    			arr.push($(This).val());
    		}else{//去除勾选
    			arr.splice($.inArray($(This).val(),arr) , 1 );
    		}
    		$("#"+hide_id).val(arr.join(","));//
    	}
        
	</script>
<!--//pop-up-box -->
<!-- web-fonts -->  
<link href='http://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
<!-- //web-fonts -->
</head>

<body class="bg">
	<div class="agile-main">
		<div class="content-wrap">

			<div class="content">
				<!-- banner -->
				<div class="banner about-banner"> 
					<div class="banner-img">  
						<h3>厚普教育</h3>
					</div> 
				</div>
				<div>
					<ul class="list-group2 time">
						<li>剩余时间</li>
						<li id="time"></li>
					</ul>
					</br>
				</div>
				<!-- //banner -->
				<div class="about">

					<ul class="list-group">
					<c:if test="${not empty testList && testList.size() > 0 }">
						<c:forEach items="${testList }" var="test" varStatus="thisItem">
						
							<c:if test="${test.testType == 0 }"><!-- 选择题 -->
								<li class="list-group-item">
					<!-- 问题 -->	<p class="w3-text">${ thisItem.index +1}.[${test.isMoreChoose == 0?"单选题":"多选题"}.${test.score}分]</br>${test.testTitle}</p>
					<!-- 选项 -->	<c:forEach items="${test.testOptionList }" var="testOption">
										<div class="checkbox">
											<label>
												<input type="checkbox" onclick="checkBox(this,'hide_${test.id}')" value="${testOption.option }"> ${testOption.option }.${testOption.optionContent }
											</label>
										</div>
									</c:forEach>
									<input type="hidden" name="user_answer" id="hide_${test.id }" />
									<input type="hidden" name="score" value="${test.score }" />
								</li>
								<!-- 隐藏的正确答案 -->
								<div class="answer option_answer_${test.id }">
									<font color="red">正确答案：</font>
									<input name="answer"  readonly="readonly" value="${ test.testAnswer}">
									<br/>
									<font color="red">考点：</font>
									<input name="testPoint" readonly="readonly" value="${test.testPoint.pointName }">
									<br/>
									<font color="red">详解：</font>
									<input name="testDetail" readonly="readonly" value="${test.testDetail }">
								</div>
							</c:if>
							
							<c:if test="${test.testType == 1 }"><!-- 填空题 -->
								<li class="list-group-item">
									<p class="w3-text">${thisItem.index+1 }.[填空题.${test.score }分]</br>${test.testTitle}</p>
									<input type="text" name="user_answer" id="hide_${test.id }" class="form-control" placeholder="请输入答案">
								</li>
									<input type="hidden" name="score" value="${test.score }" />
								<div class="answer input_answer_${test.id }">
									<font color="red">正确答案：</font>
									<input name="answer" readonly="readonly"  value="${ test.testAnswer}">
									<br/>
									<font color="red">考点：</font>
									<input name="testPoint" id="tp_${test.id }" readonly="readonly" value="${test.testPoint.pointName }">
									<br/>
									<font color="red">详解：</font>
									<input name="testDetail" readonly="readonly" value="${test.testDetail }">
								</div>
							</c:if>
						
						
						</c:forEach>
					</c:if>	
				<!-- services -->
				<div class="services">
					<c:if test="${not empty testList && testList.size() > 0 }">
					<ul class="list-group1">
					<c:forEach items="${testList }" varStatus="each">
						<li>${each.index +1}</li>
					</c:forEach>
					</ul>
					</c:if>
					<div class="clearfix"> </div>
				</div>

				<div class="container">
					<div class="row">
						<!-- 
						<button type="button" id="begin" class="btn btn-primary kaishi" onclick="setMyTimeout()"
								data-toggle="button"> 开始
						</button>
						 -->
						<button  type="button" id="end" class="btn btn-primary tijiao" onclick="submit()"
								data-toggle="button"> 提交
						</button>
					</div>
					<br>
				</div>
				<div >
					<ul class="list-group2 percent">
						<li>答题情况：</li>
						<li id="percent"></li>
					</ul>
				</div>
				
				<!-- 推荐视频 -->
				<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
				<div id="main" <!-- style="width:495px; height:250px;margin: 100px auto;" -->></div>
				
			</div>
		</div>
	</div>
	
</body>
<script src="${path }/jsp/js/publicJS/echarts.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
        var option = { //可以去官网上根据每个案例不同的option去写各种图形
            title: {   //标题
                text: '知识点掌握雷达图'
            }, 
            tooltip: {   //提示框，鼠标悬浮交互时的信息提示
                show:true,
                trigger: 'fuck'
            },
            legend: {    //图例，每个图表最多仅有一个图例
                x: 'center',
                data: ['知识点掌握图']
            },
            radar: [{    //极坐标 
                indicator: [{text: '等差数列',max: 100}, 
                            {text: '等比数列',max: 100},
                            {text: '正多边形',max: 100},
                            {text: '微积分',max: 100},
                            {text: '还有啥',max: 100},
                            {text: '其他',max: 100}
                           ],
                radius: 100,   //这是什么?  半径
                startAngle: 120,   // 改变雷达图的旋转度数
                center: ['33%', '55%'],
            }],
             
            series: [
			{         // 驱动图表生成的数据内容数组，数组中每一项为一个系列的选项及数据
                name: '总点击量',
                type: 'radar',
                itemStyle: {//图形样式，可设置图表内图形的默认样式和强调样式（悬浮时样式）：
                    normal: {
                        areaStyle: {
                            type: 'default'
                        }
                    }
                },
                data: [
					{
	                    value: [],      //外部加载，也可以通过ajax去加载外部数据。
	                    name: ''       
	                } 
				]
            } ]
        };
        $(function() {
            option.series[0].data[0].value=[12,32,34,53,53,65];  // 加载数据到data中
            option.series[0].data[0].name ='知识掌握雷达图';
			
            var myChart = echarts.init(document.getElementById('main'));  
            myChart.setOption(option, true);   //为echarts对象加载数据
        });
    </script>      
</html>	