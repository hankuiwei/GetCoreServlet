package com.hpedu.core.wxPublicPay.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface WxPublicPayService {

	/**
	 * 获取 预付订单id
	 * @param out_trade_no
	 * @return
	 * @throws Exception
	 */
	  String weixin_pay(String out_trade_no) throws Exception; 
	  
	  void encodeQrcode(String content,HttpServletResponse response) throws Exception;
	  void weixin_notify(HttpServletRequest request,HttpServletResponse response) throws Exception;
}
