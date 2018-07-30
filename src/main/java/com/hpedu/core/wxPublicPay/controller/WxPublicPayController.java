package com.hpedu.core.wxPublicPay.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.jdom.JDOMException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hpedu.core.order.pojo.Order;
import com.hpedu.core.order.service.OrderService;
import com.hpedu.core.user.pojo.User;
import com.hpedu.core.video.pojo.ContestVideo;
import com.hpedu.core.video.pojo.GeneralVideo;
import com.hpedu.core.video.service.ContestVideoService;
import com.hpedu.core.video.service.GeneralVideoService;
import com.hpedu.core.wxPublicPay.service.WxPublicPayService;
import com.hpedu.core.wxPublicPay.util.CommonUtil;
import com.hpedu.core.wxPublicPay.util.MD5;
import com.hpedu.core.wxPublicPay.util.PayCommonUtil;
import com.hpedu.core.wxPublicPay.util.PayConfigUtil;
import com.hpedu.core.wxPublicPay.util.WeChat;
import com.hpedu.core.wxPublicPay.util.WechatPayUtil;
import com.hpedu.core.wxpay.util.HttpClient;
import com.hpedu.core.wxpay.util.XMLUtil;
import com.hpedu.util.BaseUtil;
import com.hpedu.util.UUIDUtil;
@Controller
@RequestMapping("/")
public class WxPublicPayController {

	@Resource
	WxPublicPayService WxPublicPayService;
	@Resource
	OrderService orderService;
	@Resource
	ContestVideoService contestVideoService;
	@Resource
	GeneralVideoService generalVideoService;
	/**统一支付订单?*/
	@RequestMapping(value = "/WxPublicPayUnifiedorder", method = RequestMethod.GET)  
	@ResponseBody  
	public Object WxPayUnifiedorder(String out_trade_no) throws Exception{  
	    HashMap<String,Object> map = new HashMap<String,Object>();  
	    String codeUrl = WxPublicPayService.weixin_pay(out_trade_no);  
	    map.put("codeUrl",codeUrl);       
	    return map;  
	}  
	
	/**
	 * 微信服务端完成支付后 调用此接口 通知 商户系统.
	 * */
	@RequestMapping(value = "/wxPublicNotify", method = RequestMethod.POST)  
	@ResponseBody  
	public void weixinNotify(HttpServletRequest request,HttpServletResponse response) throws Exception{  
		/**
		 * 推荐的做法是，
		 * 1当收到通知进行处理时，首先检查对应业务数据的状态，判断该通知是否已经处理过，
		 * 2如果没有处理过再进行处理，如果处理过直接返回结果成功。
		 *   在对业务数据进行状态检查和处理之前，要采用数据锁进行并发控制，以避免函数重入造成的数据混乱。
		 * 3特别提醒：商户系统对于支付结果通知的内容一定要做签名验证,
		 *	并校验返回的订单金额是否与商户侧的订单金额一致，防止数据泄漏导致出现“假通知”，造成资金损失。
		 */
		 SortedMap<String, String> packageParams = getInfoMapFromReturnXml(request);  
	    // 账号信息  
	       String key = PayConfigUtil.getKey(); // key  
	       String out_trade_no = (String)packageParams.get("out_trade_no");//订单id?  
	       String total_fee = packageParams.get("total_fee");	 
	       String return_code = packageParams.get("return_code");
	       String return_msg = packageParams.get("return_msg");
	       String product_id = packageParams.get("product_id");
	       //判断签名是否正确  
	    if(PayCommonUtil.isTenpaySign("UTF-8", packageParams,key)) {  
	        //处理业务开始  
	        if("SUCCESS".equals((String)packageParams.get("result_code"))){  
	            //1 验证 返回的 订单金额 和 商户设定的 数额是否相同?
	        	Order order = orderService.findOrderByOrderNo(out_trade_no);
	    		String myMoney = order.getOmoney();
	    		myMoney = BaseUtil.getWpayMOney(myMoney);
	    		String oispay = order.getOisPay();//这是订单状态值
	    		if (myMoney.equals(total_fee)) {//两者相同,支付金额正确
	    			if (oispay.equals("0")) {// 修改订单状态
	    				try {
	    					orderService.updateOrderPayStatus(out_trade_no);
	    				} catch (Exception e) {
	    					System.out.println("支付成功,修改订单状态出错,订单号为--->"+out_trade_no);
	    				}
	    			} else {
	    				System.out.println("订单收到重复通知");
	    			}
	    		} else {
	    			return_code = "FAIL";
	    			return_msg = "订单金额不一致";
	    		}
	            //成功回调后需要处理预生成订单的状态和一些支付信息  
	    		
	        } else {  
	        	System.out.println("---------------支付失败-----------");
	        }  
	        //------------------------------  
	        //处理业务完毕  
	        //------------------------------  
	    } else{  
	    	System.out.println("------------通知签名验证失败---");  
	    }  
	  //向微信后台 返回 收到通知的 响应. 
	    Map<String, String> map = new HashMap<String, String>();   
		return_code = packageParams.get("return_code");
		return_msg = packageParams.get("return_msg");
		map.put("return_code", return_code);
		map.put("return_msg", return_msg);
		// 响应xml
		String resXml = CommonUtil.ArrayToXml(map, true);
		response.getWriter().write(resXml);
		response.getWriter().flush();  
		response.getWriter().close();
	}

	private SortedMap<String, String> getInfoMapFromReturnXml(
			HttpServletRequest request) throws IOException,
			UnsupportedEncodingException, JDOMException {
		//读取参数  
	    InputStream inputStream = request.getInputStream();    
	    StringBuffer sb = new StringBuffer();  
	    String s ;  
	    BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));  
	    while ((s = in.readLine()) != null){  
	        sb.append(s);  
	    }  
	    in.close();  
	    inputStream.close();  
	  
	    //解析xml成map  
	    Map<String, String> resultXmlMap = new HashMap<String, String>();  
	    resultXmlMap = XMLUtil.doXMLParse(sb.toString());  
	      
	    //过滤空 设置 TreeMap  
	    SortedMap<String, String> packageParams = new TreeMap<String, String>();        
	    Iterator<String> it = resultXmlMap.keySet().iterator();  
	    while (it.hasNext()) {  
	        String parameter = (String) it.next();  
	        String parameterValue = resultXmlMap.get(parameter);  
	        String v = "";  
	        if(null != parameterValue) {  
	            v = parameterValue.trim();  
	        }  
	        packageParams.put(parameter, v);  
	    }
		return packageParams;
	} 
	
	
	/**
	 * 用户提交支付，
	 * 获取用户的授权后,跳转此页面
	 * 获取微信预支付订单接口
	 */
	@RequestMapping(value="/pay/{classify}",method={RequestMethod.GET,RequestMethod.POST})
//	@ResponseBody
	public ModelAndView pay(HttpServletRequest request,HttpServletResponse response,
			@RequestParam("vid") String vid,@PathVariable("classify") String vclassify){
	    ModelAndView mv = new ModelAndView();
	    mv.setViewName("public/realPay");// 跳转请求支付的页面. --> 
	    
	    User user = (User) request.getSession().getAttribute("user");
	    /**下面这些有什么用呢? 没什么调用吧!*/
	    String GZHID = PayConfigUtil.getAppid();// 微信公众号id(appid)
	    String SHHID = PayConfigUtil.getMchid();// 财付通商户号
	
	    /*------1.获取参数信息------- */
	    Map<String, String> orderNoAndMoney = new HashMap<String, String>();
	    String out_trade_no = "";
		try {
			orderNoAndMoney = getOrderNoAndMoney(vid, vclassify, user.getUid());
		} catch (Exception e1) {
			System.out.println("-------------获取订单号,金额 失败--------------.");
		}
	    String omoney = orderNoAndMoney.get("omoney");
	    if(omoney!=null ){ //&& Integer.valueOf(omoney) != 0 ,0元也可以支付...? 
	    	out_trade_no = orderNoAndMoney.get("orderNo");
		    if("0".equals(omoney)){
		    	/**2018年7月2日17:52:37
		    	 * 0元不能支付成功.
		    	 * 订单为0 , 不需要支付了..... 直接确认购买成功. --返回页面也不能是支付页面了.
		    	 */
		    	//1.确认订单
		    	Order order = orderService.findOrderByOrderNo(out_trade_no);
	    		String myMoney = order.getOmoney();
	    		myMoney = BaseUtil.getWpayMOney(myMoney);
	    		String oispay = order.getOisPay();//这是订单状态值
    			if (oispay.equals("0")) {// 修改订单状态
    				try {
    					orderService.updateOrderPayStatus(out_trade_no);
    				} catch (Exception e) {
    					System.out.println("支付成功,修改订单状态出错,订单号为--->"+out_trade_no);
    				}
    			} else {
    				System.out.println("订单收到重复通知");
    			}
		    	//2.返回详情页
		    	mv.addObject("ErrorMsg", "免费视频支付成功");
		    	return mv ;
		    }
	    }
	    String finalmoney = WeChat.getMoney(omoney);//金额转化为分为单位
	    String code = request.getParameter("code");//获取用户的code
	    /*------2.根据code获取微信用户的openId和access_token------- */
	    String openid= CommonUtil.getOpenIdByCode(code);
	    /*------3.生成 -->预支付订单<需要的的package数据>*/
	    String nonce_str= PayConfigUtil.getNonce_str(); //随机数 
	    String spbill_create_ip = request.getRemoteAddr();//订单生成的机器 IP
	    String trade_type = "JSAPI"; //交易类型 ：jsapi代表微信公众号支付
	    String notify_url ="http://www.houpuclass.com/GetCoreServlet/wxPublicNotify"; //这里notify_url是 微信处理完支付后的回调的应用系统接口url。

	    SortedMap<String, String> packageParams = new TreeMap<String, String>();
	    packageParams.put("appid",  GZHID);  
	    packageParams.put("mch_id",  SHHID);  
	    packageParams.put("nonce_str", nonce_str);  
	    packageParams.put("body", "费用");  
	    packageParams.put("out_trade_no", out_trade_no);  
	    packageParams.put("total_fee", finalmoney );  
	    packageParams.put("spbill_create_ip", spbill_create_ip);  
	    packageParams.put("notify_url", notify_url);  
	    packageParams.put("trade_type", trade_type); 
	    packageParams.put("openid", openid); 
	    packageParams.put("product_id", vid); 
	    
	    /*------4.根据package数据生成 --预支付订单号的签名sign-- ------- */
	    String sign = WechatPayUtil.getSign(packageParams,null);// 生成签名;
	    /*------5.生成xml数据  -->提交给统一支付接口https://api.mch.weixin.qq.com/pay/unifiedorder -*/
		packageParams.put("sign", sign);
		String xml = CommonUtil.ArrayToXml(packageParams, false);
	    /*------6.调用统一支付接口https://api.mch.weixin.qq.com/pay/unifiedorder 生成预支付订单----------*/
	    String unifiedorderUrl = "https://api.mch.weixin.qq.com/pay/unifiedorder";
	    String prepay_id="";
	    try {
			String returninfo = HttpClient.postOfHttps(unifiedorderUrl, xml);
			if (returninfo == null) {
				mv.addObject("ErrorMsg", "支付错误,returnInfo为空");
	            return mv ;
			}
			JSONObject returnJson = JSONObject.fromObject(WechatPayUtil.xml2JSON(returninfo));
			JSONObject xmlJson = returnJson.getJSONObject("xml");
			String return_code = xmlJson.getJSONArray("return_code").getString(0);// 返回状态码(通信标识)[SUCCESS/FAIL]
			String result_code = "";
			if (return_code.equals("SUCCESS")) {
				result_code = xmlJson.getJSONArray("result_code").getString(0);// 业务结果[SUCCESS/FAIL]
				if (result_code.equals("SUCCESS")) {
					prepay_id = xmlJson.getJSONArray("prepay_id").getString(0);// 预支付交易会话标识（用于后续接口调用中使用，该值有效期为2小时）
				}
			}
	        if(prepay_id.equals("")){
	            mv.addObject("ErrorMsg", "支付错误,prepay_id为空");
	            return mv;
	        }
	        
	    } catch (Exception e) {
	        return mv;
	    }
	    
	    /*------7.将预支付订单的id和其他信息生成签名并一起返回到jsp页面 ------- */
	    nonce_str= MD5.byteArrayToHexString(String.valueOf(new Random().nextInt(10000)).getBytes());
	    SortedMap<String, String> finalpackage = new TreeMap<String, String>();
	    String timestamp = String.valueOf(System.currentTimeMillis() / 1000);
	    String packages = "prepay_id="+prepay_id;
	    finalpackage.put("appId",  GZHID);  
	    finalpackage.put("timeStamp", timestamp);  
	    finalpackage.put("nonceStr", nonce_str);  
	    finalpackage.put("package", packages);  
	    finalpackage.put("signType", "MD5");
	    String finalsign = WechatPayUtil.getSign(finalpackage,null);// 生成签名; 
	
	    mv.addObject("appid",  GZHID);
	    mv.addObject("timeStamp", timestamp);
	    mv.addObject("nonceStr", nonce_str);
	    mv.addObject("packageValue", packages);
	    mv.addObject("paySign", finalsign);
	    mv.addObject("success","ok");
	    
	    return mv;
	}
	
	// 生成订单号和 金额
	public Map<String,String> getOrderNoAndMoney(String vid, String vclassify,String uid) throws Exception {
		String ordermoney = "0";// 支付金额
		Map<String, String> resMap = new HashMap<String, String>();
		try {
			// 先查询该用户是否已经生成该订单未支付
			List<Order> olist = null;
			try {
				olist = orderService.findOrderByParams(uid, vid, vclassify, "0");//查找该用户 所有未支付的该视频订单
			} catch (Exception e) {
				olist = new ArrayList<Order>();
//				log.error("先查询该用户是否已经生成该订单未支付失败：", e);
			}
			Order order = null;
			String orderNo = null;
			String bodyDes = "";
			String oldMoney = "0";// 原价
			String killMoney = "0";// 秒杀价
			Integer isKill = 0;// 是否杀价
			String killStartTime = "";// 秒杀开始时间
			String killEndTime = "";// 秒杀截止时间

			Map<String, Object> killInfo = null;
			if ("0".equals(vclassify)) {// 常规
				try {
					GeneralVideo g = generalVideoService.findGeneralVideoByVid(vid);
					oldMoney = g.getGmoney() == null ? "0" : g.getGmoney();
					killMoney = g.getKillMoney() == null ? "0" : g.getKillMoney();
					isKill = g.getIsKill();
					killStartTime = g.getKillStartTime();
					killEndTime = g.getKillEndTime();
					String gclass = g.getGclass();
					gclass = gclass == null ? "" : gclass;
					if (gclass.indexOf("古诗") > -1 || gclass.indexOf("阅读") > -1
							|| gclass.indexOf("写作") > -1
							|| gclass.indexOf("流利英语") > -1
							|| gclass.indexOf("语法") > -1
							|| gclass.indexOf("其他") > -1) {
						gclass = "";
					}
					String gname = g.getGname();
					if (gname != null && gname.length() > 0) {
						gname = "【" + gname + "】";
					}
					bodyDes = g.getGsbuject() + gclass + g.getGclassify()
							+ gname;
				} catch (Exception e) {
//					log.error("查询订单未支付视频信息【常规】出错：", e);
				}
			} else {// 竞赛
				try {
					ContestVideo c = contestVideoService.findContestVideoById(vid);
					oldMoney = c.getCmoney() == null ? "0" : c.getCmoney();

					killMoney = c.getKillMoney() == null ? "0" : c
							.getKillMoney();
					isKill = c.getIsKill();
					killStartTime = c.getKillStartTime();
					killEndTime = c.getKillEndTime();
					String cname = c.getCname();
					if (cname != null && cname.length() > 0) {
						cname = "【" + cname + "】";
					}
					bodyDes = c.getCompetitionName() + c.getCclass()
							+ c.getCclassify() + cname;
				} catch (Exception e) {
//							log.error("查询订单未支付视频信息【竞赛】出错：", e);
				}
			}

			if (isKill == 1) {// 秒杀活动正在进行
				killInfo = BaseUtil.getKillInfo(killStartTime, killEndTime);
				int timeType = (Integer) killInfo.get("timeType");
				ordermoney = timeType == 1 ? killMoney : oldMoney;
			} else {
				ordermoney = oldMoney;
			}
			// 生成支付订单号部分.
			if (olist.size() > 0) {//1. 已存在的订单
				order = olist.get(0);
				if (!ordermoney.equals(order.getOmoney())
						|| !bodyDes.equals(order.getPayStyle())) {
					order.setOmoney(ordermoney);
					order.setPayStyle(bodyDes);
					try {
						try {
							orderNo = mackeOrderNo(orderService);//生成 订单编号
						} catch (Exception e) {
//							log.info("原单号修改失败");
						}
						orderService.updateOrderPayMoney(order.getOid(),ordermoney, orderNo, bodyDes);
						order.setOrderNo(orderNo);
					} catch (Exception e) {
//						log.info("原单号修改未支付订单号【" + orderNo + "】的支付价格失败:", e);
					}
				} else {
					orderNo = order.getOrderNo();
				}
			} 
			else if (Float.parseFloat(ordermoney) >= 0) {//2. 新生成订单
				order = new Order();
				String oid = UUIDUtil.getUUID();// 主键
				Date ocreatTime = new Date();// 创建时间
				try {
					orderNo = mackeOrderNo(orderService);// 订单编号
				} catch (Exception e) {
//					log.error("生成订单号失败：", e);
					System.out.println("生成订单号失败："+ e.getMessage());
				}
				order.setOid(oid);
				order.setOcreatTime(ocreatTime);
				order.setOmoney(ordermoney);
				order.setOrderNo(orderNo);
				order.setUid(uid);
				order.setVclassify(vclassify);
				order.setVid(vid);
				order.setPayStyle(bodyDes);
				try {
					orderService.insertOrder(order);
				} catch (Exception e) {
//					log.error("生成视频预支付订单失败：", e);
					System.out.println("往数据库添加视频 预支付订单失败："+ e.getMessage());
				}
			}
			resMap.put("omoney", ordermoney);
			resMap.put("orderNo", orderNo);
		} catch (Exception e) {
//			log.error("生成订单号和二维码失败：", e);
			resMap.put("omoney", ordermoney);
		}
		return  resMap ;
	}
	
	
	// 根据年月日生成订单号
	private String mackeOrderNo(OrderService orderService)
			throws ParseException {
		String dateString = BaseUtil.getCurrentDateStr("yyyyMMdd");
		String orderNo = orderService.getMaxOrderNoByOrderNoPre(dateString);// 订单号 是包含日期的 数字, 通过日期 模糊查询,得到 最大的 订单号
		orderNo = (orderNo == null || orderNo.length() == 0) ? dateString + "00000000" : String.valueOf(Long.parseLong(orderNo) + 1);
		return orderNo;
	}
	

}
