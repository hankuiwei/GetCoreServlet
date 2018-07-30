<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/jsp/js/jquery.1.10.1.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<!-- 页面加载之后立马执行pay 方法.
	需要重新设计. 
	
 -->
<body ><!-- onload="javascript:pay();" -->
<% 
String lastUrl = (String)session.getAttribute("lastUrl");
%>
    <script type="text/javascript">
    	$(function(){
    		if("${success}"=="ok"){
    			pay();
    		}else{
    			//需要这一步吗? 有待细思
    			finalGo();
    		}
    	})
    
        function pay(){
            if (typeof WeixinJSBridge == "undefined"){
               if( document.addEventListener ){
                   document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
               }else if (document.attachEvent){
                   document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
                   document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
               }
            }else{
               onBridgeReady();
            }       
        }
        function onBridgeReady(){
           WeixinJSBridge.invoke('getBrandWCPayRequest'
               , {
                   "appId" : "${appid}",     //公众号名称，由商户传入     
                   "timeStamp": "${timeStamp}",         //时间戳，自1970年以来的秒数     
                   "nonceStr" : "${nonceStr}", //随机串     
                   "package" : "${packageValue}",     
                   "signType" : "MD5",         //微信签名方式:     
                   "paySign" : "${paySign}"    //微信签名 
               },function(res){
                if(res.err_msg == "get_brand_wcpay_request:ok"){  
                    alert("微信支付成功!");
                }else if(res.err_msg == "get_brand_wcpay_request:cancel"){  
                    alert("用户取消支付!");
                }else{  
                   alert("支付失败!");
                }  
                finalGo();
            }); 
        }
        function finalGo(){
        	//无论如何 ,跳转请求支付的页面.
			 var prevLink = "<%=lastUrl%>";
			 if($.trim(prevLink)==''){
			     location.href = 'public/index';  
			 }else{  
			     if(prevLink.indexOf('www.houpuclass.com')==-1){    //来自其它站点  
			         location.href = 'public/index';  
			     }
			     location.href = prevLink;  
			 }
        }
    </script>
</body>
</html>