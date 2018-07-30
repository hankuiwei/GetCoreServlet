package com.hpedu.core.video.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hpedu.core.evaluation.pojo.Evaluation;
import com.hpedu.core.evaluation.service.EvaluationService;
import com.hpedu.core.order.service.OrderService;
import com.hpedu.core.user.pojo.User;
import com.hpedu.core.user.service.UserService;
import com.hpedu.core.video.pojo.ContestVideo;
import com.hpedu.core.video.service.ContestVideoService;
import com.hpedu.core.video.service.GeneralVideoService;
import com.hpedu.util.BaseUtil;
import com.hpedu.util.StringUtil;
import com.hpedu.util.TxtUtil;
import com.hpedu.util.mybatis.Page;


@Controller
@RequestMapping("/")
public class CplayController {
	@Resource
	ContestVideoService contestVideoService;
	@Resource
	EvaluationService evaluationService;
	@Resource
	OrderService orderService;
	@Resource
	GeneralVideoService generalVideoService;
	@Resource
	UserService userService;
	private Logger log=BaseUtil.getLogger(CplayController.class);
	
	@Value("#{configProperties['page.limit']}")
	private int pageLimit ;
	@Value("#{configProperties['uploadAbsolutePath']}")
	private String uploadAbsolutePath ;
	
	
	/**
	 * 首页点击播放竞赛视频视频
	 * @author guodi 
	 * */
	@RequestMapping("/public/competitionCourseDetail")
	public void toCourseDetail(HttpServletRequest req, HttpSession session,
			String classNo, Model model) throws Exception {
		this.editUserInSession(session);
		session.setAttribute("queryString", "classNo="+classNo);
		session.setAttribute("requestUrl", "public/competitionCourseDetail");
		if(classNo!=null){
			session.setAttribute("c_classNo", classNo);
		}else{
			classNo=(String) session.getAttribute("c_classNo");
		}
		//点击播放的视频
		ContestVideo contestVideo=null;
	   try{	
		User user = (User) session.getAttribute("user");
		if (classNo!=null&&!"".equals(classNo)) {
		try{	
		 contestVideo = contestVideoService.findContestVideoById(classNo);
		 contestVideo.setPdflist(contestVideoService.selectPdfByVid(classNo, "1"));
		}catch(Exception e){
			e.printStackTrace();
			log.info("首页查询竞赛视频和相关pdf出错：",e);
		}
		 List<ContestVideo> conList=null;
			if (contestVideo != null) {//相关视频
				try{	
				   conList = contestVideoService.findContestVideoByVideo(
					contestVideo.getCompetitionName(),
					contestVideo.getCclass(),
					contestVideo.getCclassify(),classNo);
				}catch(Exception e){
					e.printStackTrace();
					log.info("首页查询竞赛相关视频出错：",e);
				}
			}else{
				contestVideo=new ContestVideo();
				conList=new ArrayList<ContestVideo>();
			}
			model.addAttribute("conList", conList);
			model.addAttribute("contestVideo", contestVideo);
		   //评论
	 //   List<Evaluation> elist = evaluationService.findAllEvaluationByEid(classNo);
			List<Evaluation> elist=null;
			try{
			 elist= evaluationService.findTop20EvaluationByEid(classNo);
			}catch(Exception e){
				elist=new ArrayList<Evaluation>();
				e.printStackTrace();
				log.info("首页查询竞赛评论出错：",e);
			}
	        model.addAttribute("elist", elist);	
		}
		int isBuy=0;
	    if(user!=null){
	    	model.addAttribute("user", user);
	    	//检查用户是否购买过此视频
	    	try{
			 isBuy=orderService.getIsBuyVideoByVid(classNo, "1", user.getUid());
	    	}catch(Exception e){
	    		e.printStackTrace();
	    		log.info("首页查询竞赛用户是否购买出错：",e);
	    	}
	    }
	    model.addAttribute("isBuy",isBuy);
	    //获取去秒杀价格相关信息
	    if(contestVideo!=null){
	    	 Integer isKill=contestVideo.getIsKill();
			 if(isKill==1&&!contestVideo.getCmoney().equals("0")){//执行秒杀活动
				 Map<String,Object> map=BaseUtil.getKillInfo(contestVideo.getKillStartTime(), contestVideo.getKillEndTime());
				 model.addAttribute("killInfo", map);
			 }
	    }else{
	    	 log.info("contestVideo是空！id:"+classNo);
	    }
		
	   }catch(Exception e){
		   e.printStackTrace();
		   log.info("首页点击播放竞赛视频视频出错：",e);
	   }
	}
	
	//更新session中用户的信息
		private void editUserInSession(HttpSession session) throws Exception{
			 User u=(User) session.getAttribute("user");
			 if(u!=null){
				 session.setAttribute("user", userService.findUserByUid(u.getUid()));
			 }
		}
	
	
	/**
	 * 竞赛课程 list
	 * @author guodi 
	 * 公众号: 请求课程信息
	 * */
	@RequestMapping("/public/competitionCourseList")
	public void getContestList(HttpServletRequest req,HttpSession session,
			String competitionName,String cclass,String cclassify,Model model)throws Exception{
		User user = (User)session.getAttribute("user");		
		Map<String,String>maps = new HashMap<String,String>();
		maps.put("competitionName",competitionName);
		maps.put("cclass",cclass);
		maps.put("cclassify",cclassify);
		int pageNo = 0;
//		int pageSize = 20;
		int pageSize = pageLimit;
		
		if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		Page<ContestVideo> pages =null;
		try{
			pages = contestVideoService.searchContestVideoList(maps, pageNo, pageSize);
		}catch(Exception e){
			pages=new Page<ContestVideo>();
			pages.setResult(new ArrayList<ContestVideo>());
			log.error("首页查询竞赛视频list出错:",e);
		}
		model.addAttribute("pages", pages);
		model.addAttribute("competitionName", maps.get("competitionName"));
		model.addAttribute("cclass", maps.get("cclass"));
		model.addAttribute("cclassify", maps.get("cclassify"));
		if(user!=null){
			model.addAttribute("user", user);
		}
	}
	
	/**
	 * pdf下载
	 * 
	 * */
	@RequestMapping("/download/file")
	public void downLoadCVPDF(HttpServletRequest req,HttpServletResponse response,HttpSession session,String url)throws Exception{
		try{
		//下载调用
		TxtUtil.downFile(req,response,url,uploadAbsolutePath);
		}catch(Exception e){
			log.info("pdf下载出错:",e);
		}
	}
	/**
	 *修改视频播放次数
	 * 
	 * */
	@RequestMapping("/video/changePlayCount")
	public void changePlayCount(HttpServletRequest req,HttpServletResponse response,HttpSession session,String vid,Integer vclassify)throws Exception{
		try{
		   if(vclassify==1){//竞赛
			   contestVideoService.updatePlayCount(vid);
		   }else{//常规
			   generalVideoService.updatePlayCount(vid);
		   }
		}catch(Exception e){
			log.info("修改视频播放次数【vid:"+vid+",vclassify:"+vclassify+"】出错:",e);
		}
	}
}
