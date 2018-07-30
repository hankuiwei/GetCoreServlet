package com.hpedu.core.verify.controller;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hpedu.util.baseMenu.MenuManager;

import it.sauronsoftware.jave.Encoder;
import it.sauronsoftware.jave.MultimediaInfo;

@Controller
public class CoreServlet {
	
	@Value("#{configProperties['uploadAbsolutePath']}")
	private String uploadAbsolutePath ;
	private  boolean flag = true ;
	
	@RequestMapping("/CoreServlet")
	public void verify(HttpServletRequest request, HttpServletResponse response){
		//微信加密签名
		String signature = request.getParameter("signature");
		//时间戳
		String timestamp = request.getParameter("timestamp");
		//随机数
		String nonce = request.getParameter("nonce");
		//随机字符串
		String echostr = request.getParameter("echostr");
		
		PrintWriter out = null;
		try {
			out = response.getWriter();
			//通过校验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
			if(SignUtil.checkSignature(signature,timestamp,nonce)){
				out.print(echostr);
			}
			if(flag){
				MenuManager mm = new MenuManager();
				mm.getMain();
				flag = false ;
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			if(out!=null) out.close();
		}
		out = null;
	}
	
	@RequestMapping("/getVideoTimeLength")
	@ResponseBody
	 public String ReadVideoTime(HttpServletRequest request ,@RequestParam String source) {
		String dbPath = source.replaceAll("/", "\\\\");//\video\*.txt
		File file = new File(uploadAbsolutePath + "/" + dbPath) ;
		Encoder encoder = new Encoder();
		StringBuilder length = new StringBuilder();
		try {
			MultimediaInfo m = encoder.getInfo(file);
			long ls = m.getDuration() / 1000;
			int hour = (int) (ls / 3600);
			int minute = (int) (ls % 3600) / 60;
			int second = (int) (ls - hour * 3600 - minute * 60);
			length.append(hour + ":"+ minute + ":" +second);
		} catch (Exception e) {
			System.out.println("文件找不到!!-->"+e.getMessage()); 
			length.append("0");
		}
		return JSON.toJSONString(length);
	}
	
}
