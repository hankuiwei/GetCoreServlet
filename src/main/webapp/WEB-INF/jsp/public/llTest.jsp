<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
	<title>考试</title>
	
</head>
<script src="${path }/jsp/js/publicJS/jquery-3.2.1.min.js"></script>
<body>

	<div class="question">
		<h3>1.中国的书院制度自唐代始，有官方和私人设置的两类，下列各书院属于官方创办的是</h3>
	</div>
	<div class="answer">
		
		<!--填空-->
		<div class="blanks">
			
		</div>
		<!--选择-->
		<div class="choose">
			<ul>
				<li><span>A</span>岳麓书院</li>
				<li><span>B</span>嵩阳书院</li>
				<li><span>C</span>集贤书院</li>
				<li><span>D</span>白鹿洞书院</li>
				<div style="clear:both"></div>
			</ul>
		</div>
		
		<!--判断-->
		<!-- 
		<div class="judge">
			<ul>
				<li><img src="images/yes.png" height="142" width="142" alt=""></li>
				<li class="noJudge"><img src="images/no.png" height="142" width="142" alt=""></li>
			</ul>
		</div>
		 -->
		
	</div>
	<!-- <div class="right">
		<p class="nomrmal">正确答案：<span>错</span></p>
		<p class="choose">已选答案：<span class="mine">B</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;正确答案：<span>C</span></p>
	</div> -->
	<div class="num">
		<ul>
			<li>1</li>
			<li>2</li>
			<li>3</li>
			<li>4</li>
			<li>5</li>
			<li>6</li>
			<li>7</li>
			<li>8</li>
			<li>9</li>
			<li>10</li>
			<div style="clear:both"></div>
		</ul>
	</div>
	<div class="footer">
		<p>剩余时间：20：59</p>
	<div class="start">
		<div>
			<button type="submit">提交</button>
		</div>
		<div>
			<button type="button" class="begin">开始</button>
		</div>
	</div>
	</div>
</body>
<style>
		*{
			padding: 0;
			margin: 0;
		}
		ol, ul, li{
			list-style: none;
		}
		a{
			text-decoration: none;
		}
		html{
			font-size: 12px;
		}
		body{
			width: 90rem;
			font-size: 3rem;
		}
		.question{
			width: 83rem;
			padding: 3.5rem;
			border-bottom: 2px solid #eee;
		}
		.question h3{
			font-size: 3.5rem;
			color: #61ccf6;
		}
		.answer{
			width: 100%;
		}
		.answer .judge{
			width: 100%;
		}
		.answer .blanks{
			width: 100%;
			height: 31rem;
			display: none;
		}
		.answer .choose{
			width: 100%;
			display: none;
		}
		.answer .choose ul{
			width: 100%;
		}
		.answer .choose ul li{
			margin-top: 5rem;
			margin-left: 6rem;
			font-size: 3.5rem;
			color: #61ccf8;
		}
		.answer .choose ul li span{
			background-color: #dfdfdf;
			margin-right: 1rem;
			display: inline-block;
			width: 4.5rem;
			height: 4.5rem;
			text-align: center;
			line-height: 4.5rem;
		}
		.answer .judge ul{
			padding: 19rem;
		}
		.answer .judge ul li{
			float: left;
			width: 142px;
			height: 142px;
		}
		.answer .judge ul li.noJudge{
			float: right;
		}
		.right{
			width: 76.5rem;
			background-color: #f5f5f5;
			margin: 17rem auto 0;
			border-radius: 1rem;
		}
		.right p{
			font-size: 3.5rem;
			line-height: 11rem;
			padding-left: 3rem;
			padding-right: 3rem;
			color: #666;
		}
		.right p span{
			color: #d22b26;
		}
		.right p span.mine{
			color: #666;
		}
		.right p.choose{
			display: none;
		}
		.num{
			width: 100%;
			margin-top: 10rem;
			border-top: 2px solid #eee;
		}
		.num ul{
			width: 84rem;
			margin-left: 4.5rem;
			margin-top: 3rem; 
		}
		.num ul li{
			float: left;
			width: 9rem;
			height: 9rem;
			line-height: 9rem;
			text-align: center;
			background-color: #f5f5f5;
			color: #61ccf8;
			font-size: 4rem;
			border-radius: 2rem;
			margin-right: 3rem;
			margin-bottom: 3rem;
		}
		.footer {
			position: relative;
			width: 86.5rem;
			padding-left: 3.5rem;
			margin-top: 10rem;
		}
		.footer p{
			float: left;
			margin-right: 3.5rem;
			font-size: 3.5rem;
			color: #61ccf8;
		}
		.footer .start{
			position: absolute;
			bottom: 3rem;
			right: 7rem;
			top: -10rem;
		}
		.footer .start div{
			margin-bottom: 1rem;
		}
		.footer .start button{
			display: block;
			width: 18rem;
			height: 8rem;
			font-size: 3.5rem;
			background-color: #61ccf8;
			color: #fff;
			border-radius: 2rem;
		}
		.footer .start button.begin{
			background-color: #f5f5f5;
			color: #61ccf8;
		}
	</style>
</html>