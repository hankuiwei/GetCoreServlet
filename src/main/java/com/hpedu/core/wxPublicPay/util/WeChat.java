package com.hpedu.core.wxPublicPay.util;


public class WeChat {
	static String GZHID = "wxfd7c065eee11112222";// 微信公众号id
	static String GZHSecret = "b5b3a627f5d1f8888888888888";// 微信公众号密钥id
	static String SHHID = "111111111";// 财付通商户号
    static String SHHKEY = "mmmmmmmmmmmmmmm";// 商户号对应的密钥
	
	/**
     * 元转换成分
     * @param money
     * @return
     */
    public static String getMoney(String amount) {
        if(amount==null){
            return "";
        }
        // 金额转化为分为单位
        String currency =  amount.replaceAll("\\$|\\￥|\\,", "");  //处理包含, ￥ 或者$的金额  
        int index = currency.indexOf(".");  
        int length = currency.length();  
        Long amLong = 0l;  
        if(index == -1){  
            amLong = Long.valueOf(currency+"00");  
        }else if(length - index >= 3){  
            amLong = Long.valueOf((currency.substring(0, index+3)).replace(".", ""));  
        }else if(length - index == 2){  
            amLong = Long.valueOf((currency.substring(0, index+2)).replace(".", "")+0);  
        }else{  
            amLong = Long.valueOf((currency.substring(0, index+1)).replace(".", "")+"00");  
        }  
        return amLong.toString(); 
    }
    
    
    /**
     * 通过微信用户的code换取网页授权access_token
     * @return
     * @throws IOException
     * @throws
     */
   /* public List<Object> accessToken(String code) throws IOException {
        List<Object> list = new ArrayList<Object>();
        String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="
                + PayConfigUtil.getAppid() + "&secret=" + PayConfigUtil.getKey()+ "&code=" + code + "&grant_type=authorization_code";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);
        HttpResponse res = client.execute(post);
        if (res.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
            HttpEntity entity = res.getEntity();
            String str = org.apache.http.util.EntityUtils.toString(entity, "utf-8");
            ObjectMapper mapper=new com.fasterxml.jackson.databind.ObjectMapper.ObjectMapper();
            Map<String,Object> jsonOb=mapper.readValue(str, Map.class);
            list.add(jsonOb.get("access_token"));
            list.add(jsonOb.get("openid"));
        }
        return list;
    }*/
    
    
    
}

