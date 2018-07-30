package com.hpedu.core.wxpay.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hpedu.core.wxpay.service.WxPayService;
@Controller
@RequestMapping("/")
public class WxPayController {

	@Resource
	WxPayService WxPayService;
		
	@RequestMapping(value = "/WxPayUnifiedorder", method = RequestMethod.GET)  
	@ResponseBody  
	public Object WxPayUnifiedorder(String out_trade_no) throws Exception{  
	    HashMap<String,Object> map = new HashMap<String,Object>();  
	    String codeUrl = WxPayService.weixin_pay(out_trade_no);  
	    map.put("codeUrl",codeUrl);       
	    return map;  
	}  
	
	/** 
	 * 生成二维码图片并直接以流的形式输出到页面 
	 * @param code_url 
	 * @param response 
	 */  
	@RequestMapping("qr_codeImg")  
	@ResponseBody  
	public void getQRCode(String code_url,HttpServletResponse response)throws Exception{  
		WxPayService.encodeQrcode(code_url, response);  
	}  
	
	@RequestMapping(value = "/weixinNotify", method = RequestMethod.POST)  
	@ResponseBody  
	public void weixinNotify(HttpServletRequest request,HttpServletResponse response) throws Exception{  
System.out.println("支付回调方法开始！");  
	    WxPayService.weixin_notify(request, response);  
System.out.println("支付回调方法结束！");  
	}  
}
