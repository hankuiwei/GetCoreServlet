package com.hpedu.core.video.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.hpedu.core.video.service.GeneralVideoService;
import com.hpedu.util.BaseUtil;

@Component//将这个对象加入Spring容器中
public class TimerTaskEditVideo{
	@Resource
	GeneralVideoService generalVideoService;
	
	private java.util.Timer timer = new java.util.Timer(true);
	boolean flag = false ;
	Logger log=BaseUtil.getLogger(TimerTaskEditVideo.class);
    @Scheduled(cron = "0 0 0/1 * * ?")//每小时执行一次视频更新
    public void startTimer() {
    	 Date date=new Date();
    	 final String[] dateArr=new SimpleDateFormat("yyyy-MM-dd#EEEE-HH").format(date).split("#");
    	 flag = false ;
    	 do{
    		 timer.schedule(
		    	 new java.util.TimerTask() { 
		    		 public void run(){
		    			 try{
	    		    	   generalVideoService.updateVideoEditDate(dateArr[0]+"-"+ dateArr[1].split("-")[1], dateArr[1]);
	    		    	 }catch(Exception e){
	    		    		 log.error("定时更新视频editDate异常："+ e.getMessage());
	    		    		 flag = true ;
	    		    	 }
		    		 }
		    	 }, 0 );// 
    	}while(flag);
    	 
    }  
}  

