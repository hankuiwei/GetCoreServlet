package com.hpedu.core.wxPublicPay.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.util.Map;
import java.util.Map.Entry;

import javax.net.ssl.HttpsURLConnection;

import net.sf.json.JSONObject;

import org.jsoup.helper.StringUtil;

/**
 * 通用工具类
 * 
 * @author rory.wu
 * @version .
 * @since 年月日
 */
public class CommonUtil {

	public static JSONObject httpsRequestToJsonObject(String requestUrl,
			String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		try {
			StringBuffer buffer = httpsRequest(requestUrl, requestMethod,
					outputStr);
			jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			ce.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObject;
	}

	private static StringBuffer httpsRequest(String requestUrl,
			String requestMethod, String output)
			throws NoSuchAlgorithmException, NoSuchProviderException,
			KeyManagementException, MalformedURLException, IOException,
			ProtocolException, UnsupportedEncodingException {
		URL url = new URL(requestUrl);
		HttpsURLConnection connection = (HttpsURLConnection) url
				.openConnection();
		connection.setDoOutput(true);
		connection.setDoInput(true);
		connection.setUseCaches(false);
		connection.setRequestMethod(requestMethod);
		if (null != output) {
			OutputStream outputStream = connection.getOutputStream();
			outputStream.write(output.getBytes("utf-8"));
			outputStream.close();
		}
		// 从输入流读取返回内容
		InputStream inputStream = connection.getInputStream();
		InputStreamReader inputStreamReader = new InputStreamReader(
				inputStream, "utf-8");
		BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
		String str = null;
		StringBuffer buffer = new StringBuffer();
		while ((str = bufferedReader.readLine()) != null) {
			buffer.append(str);
		}
		bufferedReader.close();
		inputStreamReader.close();
		inputStream.close();
		inputStream = null;
		connection.disconnect();
		return buffer;
	}

	/**
	 * 获取用户的openId，并放入session
	 * 
	 * @param code
	 *            微信返回的code
	 */
	public static String getOpenIdByCode(String code) {
		// session.put("code", code);
		// String oauth_url = Constants.oauth_url.replace("APPID",
		// Constants.appid).replace("SECRET",
		// Constants.appsecret).replace("CODE",
		// String.valueOf(session.get("code")));

		String oauth_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="
				+ PayConfigUtil.getAppid()
				+ "&secret="
				+ PayConfigUtil.getSecret()
				+ "&code="
				+ code
				+ "&grant_type=authorization_code";

		JSONObject jsonObject = CommonUtil.httpsRequestToJsonObject(oauth_url,
				"POST", null);
		Object errorCode = jsonObject.get("errcode");
		String openId = "" ;
		if (errorCode != null) {
			// log.info("code不合法");
			System.out.println("code不合法");
		} else {
			openId = jsonObject.getString("openid");
			// session.put("openId", openId);
		}
		return openId ;
	}
	
	/**
	 * 从流中取出字符串
	 * */
	public static final String inputStream2String(InputStream in) throws UnsupportedEncodingException, IOException{  
        if(in == null)  
            return "";  
        StringBuffer out = new StringBuffer();  
        byte[] b = new byte[4096];  
        for (int n; (n = in.read(b)) != -1;) {  
            out.append(new String(b, 0, n, "UTF-8"));  
        }  
        return out.toString();  
    }  
      
	
	/**
	 * map转成xml
	 * 
	 * @param arr
	 * @return
	 */
	public static String ArrayToXml(Map<String, String> parm, boolean isAddCDATA) {
		StringBuffer strbuff = new StringBuffer("<xml>");
		if (parm != null && !parm.isEmpty()) {
			for (Entry<String, String> entry : parm.entrySet()) {
				strbuff.append("<").append(entry.getKey()).append(">");
				if (isAddCDATA) {
					strbuff.append("<![CDATA[");
					if (!StringUtil.isBlank(entry.getValue()) ) {
						strbuff.append(entry.getValue());
					}
					strbuff.append("]]>");
				} else {
					if("body".equals(entry.getKey())){
						strbuff.append("<![CDATA[");
						if (!StringUtil.isBlank(entry.getValue()) ) {
							strbuff.append(entry.getValue());
						}
						strbuff.append("]]>");
					}
					else if (!StringUtil.isBlank(entry.getValue())) {
						strbuff.append(entry.getValue());
					}
				}
				strbuff.append("</").append(entry.getKey()).append(">");
			}
		}
		return strbuff.append("</xml>").toString();
	}
	
	
	
}