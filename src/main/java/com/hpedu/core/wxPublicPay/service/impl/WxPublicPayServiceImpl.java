package com.hpedu.core.wxPublicPay.service.impl;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.hpedu.core.wxPublicPay.service.WxPublicPayService;
import com.hpedu.core.wxPublicPay.util.PayCommonUtil;
import com.hpedu.core.wxPublicPay.util.PayConfigUtil;
import com.hpedu.core.wxpay.util.HttpUtil;
import com.hpedu.core.wxpay.util.XMLUtil;

@Service
public class WxPublicPayServiceImpl implements WxPublicPayService {

	
	@Override
	public String weixin_pay(String out_trade_no) throws Exception {
		/*1. 账号信息  */
        String appid = PayConfigUtil.getAppid();  // appid  
//        String appsecret = PayConfigUtil.APP_SECRET; // appsecret  
        String mch_id = PayConfigUtil.getMchid();  //商户id -->商业号  
        String key = PayConfigUtil.getKey();   // key  
        String currTime = PayCommonUtil.getCurrTime();  
        String strTime = currTime.substring(8, currTime.length());  
        String strRandom = PayCommonUtil.buildRandom(4) + "";  
        String nonce_str = strTime + strRandom; //随机字符串   
        //String order_price = "1"; // 价格   注意：价格的单位是分    
        //String body = "企嘉科技商品";   // 商品名称    
  
        /*2.查询订单数据表->获取订单信息  */
        /***
         * 下订单开始，需要正式带入
         * */
       // PayOrder payOrder = payOrderDao.get(PayOrder.class,out_trade_no);  
        String spbill_create_ip = PayConfigUtil.getIP();  //请求支付的客户端 ip  
        String notify_url = PayConfigUtil.NOTIFY_URL;   // 回调接口   
        String trade_type = "JSAPI";  //公众号支付应该是 JSAPI?
        String time_start =  new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());  
        Calendar ca = Calendar.getInstance();  
        ca.setTime(new Date());  
        ca.add(Calendar.DATE, 1);           
        String time_expire =  new SimpleDateFormat("yyyyMMddHHmmss").format(ca.getTime());  
        
        SortedMap<Object,Object> packageParams = new TreeMap<Object,Object>();  
        packageParams.put("appid", appid);  
        packageParams.put("mch_id", mch_id);  
        packageParams.put("nonce_str", nonce_str);  
    //  packageParams.put("body",payOrder.getBody());  
        packageParams.put("out_trade_no", out_trade_no);  
        //packageParams.put("total_fee", "1");  
     // packageParams.put("total_fee", payOrder.getTotalFee());  
        packageParams.put("spbill_create_ip", spbill_create_ip);  
        packageParams.put("notify_url", notify_url);  
        packageParams.put("trade_type", trade_type);  
        packageParams.put("time_start", time_start);  
        packageParams.put("time_expire", time_expire);          
        String sign = PayCommonUtil.createSign("UTF-8", packageParams,key);  
        packageParams.put("sign", sign);  
        
        String requestXML = PayCommonUtil.getRequestXml(packageParams);  
   
        String responseXml = HttpUtil.postData(PayConfigUtil.PAY_API, requestXML);
        //https://api.mch.weixin.qq.com/pay/unifiedorder
        @SuppressWarnings("unchecked")
		Map<String,String> map = XMLUtil.doXMLParse(responseXml);  
        //String return_code = (String) map.get("return_code");  
//      String urlCode = (String) map.get("code_url");  
        String prepay_id = (String) map.get("prepay_id");  
        
        return prepay_id;  
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void encodeQrcode(String content, HttpServletResponse response)
			throws Exception {
		 if(content==null || "".equals(content))  
		        return;  
		   MultiFormatWriter multiFormatWriter = new MultiFormatWriter();  
		   Map hints = new HashMap();  
		   hints.put(EncodeHintType.CHARACTER_SET, "UTF-8"); //设置字符集编码类型  
		   BitMatrix bitMatrix = null;  
		   try {  
		       bitMatrix = multiFormatWriter.encode(content, BarcodeFormat.QR_CODE, 300, 300,hints);  
		       BufferedImage image =  MatrixToImageWriter.toBufferedImage(bitMatrix);  
		       //输出二维码图片流  
		       try {  
		           ImageIO.write(image, "png", response.getOutputStream());  
		       } catch (IOException e) {  
		           e.printStackTrace();  
		       }  
		   } catch (WriterException e1) {  
		       e1.printStackTrace();  
		   }           
	}

	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	@Override
	public void weixin_notify(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		  
	}

}
