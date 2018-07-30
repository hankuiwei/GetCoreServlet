package com.hpedu.core.index.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hpedu.core.order.pojo.Banner;
import com.hpedu.core.order.service.OrderService;
import com.hpedu.core.teacher.pojo.Teacher;
import com.hpedu.core.teacher.service.TeacherService;
import com.hpedu.core.trophy.pojo.Trophy;
import com.hpedu.core.trophy.service.TrophyService;
import com.hpedu.core.user.pojo.User;
import com.hpedu.core.video.pojo.ContestVideo;
import com.hpedu.core.video.pojo.GeneralVideo;
import com.hpedu.core.video.service.ContestVideoService;
import com.hpedu.core.video.service.GeneralVideoService;
import com.hpedu.util.BaseUtil;
import com.hpedu.util.StringUtil;
import com.hpedu.util.mybatis.Page;

@Controller
@RequestMapping("/")
public class IndexController {
	@Resource
	TeacherService teacherService;
	@Resource
	TrophyService trophyService;
	@Resource
	ContestVideoService contestVideoService;
	@Resource 
	GeneralVideoService generalVideoService;
	@Resource 
	OrderService  orderService;
	
	@Value("#{configProperties['page.limit']}")
	private int pageLimit ;
	
	private Logger log=BaseUtil.getLogger(IndexController.class);
	@RequestMapping("public/index")
	public void toIndex(HttpServletRequest req,Model model,HttpSession session)throws Exception{
		User user = (User) session.getAttribute("user");
		if (user != null) {
			model.addAttribute("user", user);
		}
		List<Banner> blist = null;
		List<Teacher> tlist = null;
		List<GeneralVideo> glist = null ;
		List<ContestVideo> clist = null ; 
		try {
			List<String> list = new ArrayList<String>();
			list.add("李陆欧");
			list.add("何万新");
			list.add("乔宇");
			tlist = teacherService.getIndexTeacher(list);// 教师
		} catch (Exception e) {
			tlist = new ArrayList<Teacher>();
		}
		
		try {
			blist = orderService.getPublicBanner();// 轮播图片
		} catch (Exception e) {
			blist = new ArrayList<Banner>();
		}
		
		try {
			glist = generalVideoService.getFreeCourse();// 免费常规课
		} catch (Exception e) {
			glist = new ArrayList<GeneralVideo>();
		}
		
		try {
			clist = contestVideoService.getFreeCourse();// 免费竞赛课
		} catch (Exception e) {
			clist = new ArrayList<ContestVideo>();
		}
		
		model.addAttribute("clist", clist);//免费竞赛课
		model.addAttribute("glist", glist);//免费常规课
		model.addAttribute("tlist", tlist);//推荐教室列表
		model.addAttribute("blist", blist);//轮播图列表
	}
	
	
	
	@RequestMapping("public/teachers")
	public void getTeachers(HttpServletRequest req,HttpSession session,Model model)throws Exception{
		User user = (User)session.getAttribute("user");		
		int pageNo = 0;
//		int pageSize = 10;
		int pageSize = pageLimit;
		if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		Page<Teacher> pages =null;
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("isShow", 1);
			pages = teacherService.getAllTeacher(param,pageNo,pageSize);
		} catch (Exception e) {
			pages=new Page<Teacher>();
		}
		model.addAttribute("pages", pages);
		if(user!=null){
			model.addAttribute("user", user);
		}
	}
	
	@RequestMapping("public/students")
	public void getStudents(HttpServletRequest req,HttpSession session,Model model)throws Exception{
		User user = (User)session.getAttribute("user");		
/*		int pageNo = 0;
		int pageSize = 10;
*/		/*if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		Page<Trophy> pages =null;*/
		List<Trophy> students = null ;
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("isShow", 1);
//			pages = trophyService.searchTrophyList(param, pageNo, pageSize);
			
			students = trophyService.searchTrophyList(param);
			
		} catch (Exception e) {
//			pages=new Page<Trophy>();
		}
		model.addAttribute("students", students);
		if(user!=null){
			model.addAttribute("user", user);
		}
	}
	
	@RequestMapping("public/teacher-info")
	public void getOneTeacher(HttpServletRequest req,Model model,String url ,String tid){
		StringBuffer error = new StringBuffer();
		Teacher teacher = null ;
		List<GeneralVideo> generalCourseList = null;
		List<ContestVideo> competitionCourseList = null;
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("isShow", 1);
			teacher = teacherService.findTeacherById(tid);
			
			generalCourseList = generalVideoService.getCourse(teacher.getTname());
			competitionCourseList = contestVideoService.getCourse(teacher.getTname());
			
		} catch (Exception e) {
			error.append("获取单个教师失败：" + e.getMessage() + ";");
			teacher = new Teacher();
			generalCourseList = new ArrayList<>();
			competitionCourseList = new ArrayList<>();
		}
		model.addAttribute("teacher", teacher);
		model.addAttribute("generalCourseList", generalCourseList);
		model.addAttribute("competitionCourseList", competitionCourseList);
	}
	
	
	@RequestMapping("public/student-info")
	public void getOneStudent(HttpServletRequest req,Model model,String url ,String pid){
		StringBuffer error = new StringBuffer();
		Trophy student = null ;
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("isShow", 1);
			student = trophyService.findTrophyById(pid);
		} catch (Exception e) {
			error.append("获取单个学生失败：" + e.getMessage() + ";");
			student = new Trophy();
		}
		model.addAttribute("student", student);
	}

	
	
	@RequestMapping("public/latestCompetitionCourse")
	public void LatestCompetitionCourse(HttpServletRequest req,Model model,HttpSession session)throws Exception{
		User user = (User) session.getAttribute("user");
		if (user != null) {
			model.addAttribute("user", user);
		}
		Map<String,String> maps = new HashMap<String,String>();
		int pageNo = 0;
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
		
	}
	@RequestMapping("public/latestGeneralCourse")
	public void getLatestGeneralCourse(HttpServletRequest req,Model model,HttpSession session)throws Exception{
		User user = (User) session.getAttribute("user");
		if (user != null) {
			model.addAttribute("user", user);
		}
		Map<String,String> maps = new HashMap<String,String>();
		int pageNo = 0;
		int pageSize = pageLimit;
		if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		Page<GeneralVideo> pages =null;
		try{
			 pages = generalVideoService.searchGeneralVideoList(maps, pageNo, pageSize);
		}catch(Exception e){
			pages=new Page<GeneralVideo>();
			pages.setResult(new ArrayList<GeneralVideo>());
			log.error("首页查询竞赛视频list出错:",e);
		}
		model.addAttribute("pages", pages);
	}
	
	@RequestMapping("public/latestCourse")
	public void getLatestCourse(HttpServletRequest req,Model model,HttpSession session)throws Exception{
		User user = (User) session.getAttribute("user");
		if (user != null) {
			model.addAttribute("user", user);
		}
		Map<String,String> maps = new HashMap<String,String>();
		List<GeneralVideo> generalList =null;
		List<ContestVideo> contestList =null;
		try{
			generalList = generalVideoService.getLatestGeneralVideoList(maps);
			contestList = contestVideoService.getLatestContestVideoList(maps);
		}catch(Exception e){
			generalList=new ArrayList<GeneralVideo>();
			contestList = new ArrayList<ContestVideo>();
			log.error("首页查询竞赛视频list出错:",e);
		}
		model.addAttribute("generalList", generalList);
		model.addAttribute("contestList", contestList);
	}
	
}
