package com.hpedu.core.wxPublicPay.util;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.hpedu.util.BaseUtil;

//微信扫码支付工具类

public class WechatPayUtil {
	private static Logger log = BaseUtil.getLogger(WechatPayUtil.class);
	public static Map<String, String> errorMap = null;

	// 根据参数生成签名
	public static String getSign(Map<String, String> map, Integer type) {
		String key = PayConfigUtil.getKey();
		if (map == null) {
			map = new HashMap<String, String>();
		} else {
		}
		Map<String, String> orderMap = MapUtil.order(map);
		// 1.按照参数名ASCII码从小到大排序（字典序）
		String stringA = MapUtil.mapJoin(orderMap, true, false);

		// 2.在stringA最后拼接上key
		String stringSignTemp = "";
		if (key != null && key.length() > 0) {
			stringSignTemp = stringA + "&key=" + key;
		} else {
			stringSignTemp = stringA;
		}
		// 3.将得到的字符串所有字符转换为大写得到sign
		String sign = MD5.MD5Encode(stringSignTemp).toUpperCase();
		if (type == null) {
			return sign;
		} else {
			return stringSignTemp.replace("&key=" + key, "") + "&sign=" + sign;
		}

	}

	// 获取时间戳
	public static String gettime_stamp() {
		String str = new Date().getTime() + "";
		if (str.length() > 10) {
			str = str.substring(0, 10);
		}
		return str;
	}

	// 生成不重复随机字符串包括字母数字
	public static String getRandomStr(int len) {
		// 字符源，可以根据需要删减
		String generateSource = "0123456789abcdefghigklmnopqrstuvwxyz";
		String rtnStr = "";
		for (int i = 0; i < len; i++) {
			// 循环随机获得当次字符，并移走选出的字符
			String nowStr = String.valueOf(generateSource.charAt((int) Math
					.floor(Math.random() * generateSource.length())));
			rtnStr += nowStr;
			generateSource = generateSource.replaceAll(nowStr, "");
		}
		return rtnStr;
	}

	// 生成支付二维码参数codeUrl
	public static String getErweiCodeUrl(String product_id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("product_id", product_id);
		String codeUrl = getSign(map, 1);
		return codeUrl;
	}

	// 统一下单
	public static Map<String, String> mackOrder(String product_id,
			String giveMoney, String bodyDesc, String controllerUrl) {
		Map<String, String> map = new HashMap<String, String>();
		// *********************************************定义参数值
		String appid = PayConfigUtil.getAppid();// 公众号
		String mch_id = PayConfigUtil.getMchid();// 商户id
		String nonce_str = RandomUtil.generateString(10);// 随机码
		String body = "视频-" + bodyDesc;// 商品描述(规则：浏览器打开的网站主页title名 -商品概述)
		String out_trade_no = product_id;// 商户订单号

		log.info("giveMoney===========" + giveMoney);
		String total_fee = BaseUtil.getWpayMOney(giveMoney);// 订单总金额（单位是分）
		log.info("total_fee===========" + total_fee);
		// String total_fee="1";//测试使用
		String spbill_create_ip = PayConfigUtil.getIP();// 商户机器ip
		String notify_url = PayConfigUtil.getWEB_SERVICE_PATH() + controllerUrl;// 通知地址(接收<微信支付结果通知>的回调地址)
		String trade_type = "NATIVE";// 交易类型(扫码支付) -->应改为JSAPI<微信内H5支付>
		// *********************************************设置参数
		map.put("appid", appid);// 公众号
		map.put("mch_id", mch_id);// 商户id
		map.put("nonce_str", nonce_str);// 随机码
		map.put("body", body);// 商品描述
		map.put("out_trade_no", out_trade_no);// 商户订单号
		map.put("total_fee", total_fee);// 订单总金额（分）
		map.put("spbill_create_ip", spbill_create_ip);// 终端IP
		map.put("notify_url", notify_url);// 支付成功回调地址
		map.put("trade_type", trade_type);
		map.put("product_id", product_id);// 参数为二维码中包含的商品ID
		String sign = getSign(map, null);// 生成签名
		map.put("sign", sign);
		try {
			// 统一下单地址串
			String url = "https://api.mch.weixin.qq.com/pay/unifiedorder";
			String returninfo = HttpClient.postOfHttps(url, getRequestXml(map));
			log.info("1.统一下单returninfo====第一次=====" + returninfo);
			if (returninfo == null) {
				return map;
			}
			log.info("统一下单returninfo=====开始解析：");
			JSONObject returnJson = JSONObject.fromObject(xml2JSON(returninfo));
			JSONObject xmlJson = returnJson.getJSONObject("xml");
			String return_code = xmlJson.getJSONArray("return_code").getString(0);// 返回状态码(通信标识)[SUCCESS/FAIL]
			String result_code = "";
			log.info("统一下单result_code====：" + result_code);
			if (return_code.equals("SUCCESS")) {
				result_code = xmlJson.getJSONArray("result_code").getString(0);// 业务结果[SUCCESS/FAIL]
				if (result_code.equals("SUCCESS")) {
					String prepay_id = xmlJson.getJSONArray("prepay_id").getString(
							0);// 预支付交易会话标识（用于后续接口调用中使用，该值有效期为2小时）
					String code_url = xmlJson.getJSONArray("code_url").getString(0);// 支付二维码链接
					log.info("2.二次签名====第二次=====：" + result_code);
					// 二次签名
					map.put("package", "prepay_id=" + prepay_id);
					map.put("timeStamp", gettime_stamp());
					String sidn2 = getSign(map, null);
					map.put("sign", sidn2);
					map.put("code_url", code_url);
				} else {
					String err_code = xmlJson.getJSONArray("err_code").getString(0);// 错误代码
					String err_code_des = xmlJson.getJSONArray("err_code_des")
							.getString(0);// 错误代码描述
					log.info("2.二次签名====出错啦=====：" + err_code + "===="
							+ err_code_des);
					map.put("err_code", err_code);
					map.put("err_code_des", err_code_des);
					map.put("err_code_redome", "订单号【" + product_id + "】"
							+ errorMap.get(err_code));
				}
			} else {
				String return_msg = xmlJson.getJSONArray("return_msg").getString(0);// 返回信息(如非空，为错误原因
																				// )
				log.info("1.统一下单returninfo====第一次==出错啦===" + return_msg);
				map.put("return_msg", return_msg);
			}
			map.put("return_code", return_code);
			map.put("result_code", result_code);
		} catch (Exception e) {

			log.error("微信获取参数异常！", e);
		}

		return map;
	}

	/*
	 * public static void main(String[] args) { Map<String, String> map=new
	 * HashMap<String, String>(); map.put("nonce_str","2g91mk5zr3");
	 * map.put("time_stamp",""); map.put("out_trade_no","1704010000000000");
	 * map.put("total_fee","1"); map.put("trade_type", "NATIVE");
	 * map.put("is_subscribe", "Y"); map.put("fee_type", "CNY");
	 * map.put("transaction_id", "4004992001201704015392470360");
	 * map.put("time_end", "20170401103410"); map.put("openid",
	 * "o_IUws_MwDpk1JTEZlzOA6KNuHOw"); map.put("result_code", "SUCCESS");
	 * map.put("bank_type", "CFT"); map.put("return_code", "SUCCESS");
	 * map.put("cash_fee", "1");
	 * 
	 * 
	 * }
	 */
	// 微信返回值签名校验
	public static boolean checkBackSign(Map<String, String> map) {
		boolean flag = false;
		String sign_back = map.get("sign");
		map.put("time_stamp", "");
		map.remove("sign");
		String sign = getSign(map, null);
		if (sign.equals(sign_back)) {
			flag = true;
		}
		return flag;
	}

	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * @author 李欣桦
	 * @date 2014-12-5下午2:32:05
	 * @Description：将请求参数转换为xml格式的string
	 * @param parameters
	 *            请求参数
	 * @return
	 */
	public static String getRequestXml(Map<String, String> parameters) {
		StringBuffer sb = new StringBuffer();
		sb.append("<xml>");
		Set es = parameters.entrySet();
		Iterator it = es.iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			String k = (String) entry.getKey();
			String v = (String) entry.getValue();
			if ("attach".equalsIgnoreCase(k) || "body".equalsIgnoreCase(k)
					|| "sign".equalsIgnoreCase(k)) {
				sb.append("<" + k + ">" + "<![CDATA[" + v + "]]></" + k + ">");
			} else {
				sb.append("<" + k + ">" + v + "</" + k + ">");
			}
		}
		sb.append("</xml>");
		return sb.toString();
	}

	public static String xml2JSON(String xml) {
		JSONObject obj = new JSONObject();
		try {
			InputStream is = new ByteArrayInputStream(xml.getBytes("utf-8"));
			SAXBuilder sb = new SAXBuilder();
			Document doc = sb.build(is);
			Element root = doc.getRootElement();
			obj.put(root.getName(), iterateElement(root));
			return obj.toString();
		} catch (Exception e) {
			log.error("xml数据解析异常！", e);
			return null;
		}
	}

	private static Map iterateElement(Element element) {
		List jiedian = element.getChildren();
		Element et = null;
		Map obj = new HashMap();
		List list = null;
		for (int i = 0; i < jiedian.size(); i++) {
			list = new LinkedList();
			et = (Element) jiedian.get(i);
			if (et.getTextTrim().equals("")) {
				if (et.getChildren().size() == 0)
					continue;
				if (obj.containsKey(et.getName())) {
					list = (List) obj.get(et.getName());
				}
				list.add(iterateElement(et));
				obj.put(et.getName(), list);
			} else {
				if (obj.containsKey(et.getName())) {
					list = (List) obj.get(et.getName());
				}
				list.add(et.getTextTrim());
				obj.put(et.getName(), list);
			}
		}
		return obj;
	}

	static {
		// 统一下单错误代码
		errorMap = new HashMap<String, String>();
		errorMap.put("NOAUTH", "商户无此接口权限");
		errorMap.put("NOTENOUGH", "用户帐号余额不足");
		errorMap.put("ORDERPAID", "商户订单已支付");
		errorMap.put("ORDERCLOSED", "当前订单已关闭，请重新下单");
		errorMap.put("SYSTEMERROR", "系统异常，请用相同参数重新调用");
		errorMap.put("APPID_NOT_EXIST", "APPID不存在");
		errorMap.put("MCHID_NOT_EXIST", "MCHID不存在");
		errorMap.put("APPID_MCHID_NOT_MATCH", "appid和mch_id不匹配");
		errorMap.put("LACK_PARAMS", "缺少必要的请求参数");
		errorMap.put("OUT_TRADE_NO_USED", "商户订单号重复");
		errorMap.put("SIGNERROR", "签名错误");
		errorMap.put("XML_FORMAT_ERROR", "XML格式错误");
		errorMap.put("REQUIRE_POST_METHOD", "请使用post方法传递参数");
		errorMap.put("POST_DATA_EMPTY", "post数据为空");
		errorMap.put("NOT_UTF8", "编码格式错误,请使用UTF-8编码格式");

		// 查询订单错误代码
		errorMap.put("REFUND", "转入退款");
		errorMap.put("NOTPAY", "未支付");
		errorMap.put("CLOSED", "已关闭");
		errorMap.put("REVOKED", "已撤销（刷卡支付）");
		errorMap.put("USERPAYING", "用户支付中");
		errorMap.put("PAYERROR", "支付失败（其他原因，如银行返回失败）");
	}
}
