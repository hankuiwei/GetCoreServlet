package com.hpedu.core.teacher.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hpedu.core.teacher.pojo.Teacher;
import com.hpedu.core.teacher.service.TeacherService;
import com.hpedu.core.user.pojo.User;
import com.hpedu.util.BaseUtil;
import com.hpedu.util.PrintHelper;
import com.hpedu.util.StringUtil;
import com.hpedu.util.UUIDUtil;
import com.hpedu.util.mybatis.Page;

@Controller
@RequestMapping("/")
public class TeacherController {
	
	@Resource
	TeacherService teacherService;
	private Logger log=BaseUtil.getLogger(TeacherController.class);
	@RequestMapping("/back/teacherUp.html")
	public void toUpTeacher(HttpServletRequest req,HttpSession session,String id,Model mode)throws Exception{
		try{
		Teacher teacher = teacherService.findTeacherById(id);
		if(teacher!=null){
			mode.addAttribute("teacher", teacher);
		}
		}catch(Exception e){
			log.error("修改教师查询对象出错：",e);
			mode.addAttribute("error", "错误："+e.getMessage());
		}
		if(session.getAttribute("error")!=null){
			mode.addAttribute("error", session.getAttribute("error"));
			session.removeAttribute("error");
		}
	}
	/**
	 * 上移、下移
	 * */
	@RequestMapping("/back/updateTeacherSort")
	public void updateBannerSort(HttpServletRequest req,HttpServletResponse response,String id1,String sort1,String id2,String sort2)throws Exception{
		String res="ok";
		 try{
			 teacherService.updateTeacherSort(id1, sort1);
			 teacherService.updateTeacherSort(id2, sort2);
		}catch(Exception e){
			res="出错："+e.getMessage();
		} 
		PrintHelper.sendJsonString(response, res);
	}
	/**
	 * 修改教师信息
	 * */
	@RequestMapping(value="/back/teacherUpdate",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView teacherUpdate(HttpServletRequest req,HttpSession session,@RequestParam(value="timgUrl1",required=false)MultipartFile file,@RequestParam(value="file1",required=false)MultipartFile file1,Teacher teacher)throws Exception{
		User user = (User)session.getAttribute("backuser");
		if(user!=null){
			try{
			String realPath = req.getSession().getServletContext().getRealPath("/");
			String path = req.getContextPath().substring(1);
			realPath = realPath.replace(path, "teacherImg");
		   if( file.getSize()>0){
			 String fileName = UUIDUtil.getUUID();
			 String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
			 FileUtils.copyInputStreamToFile(file.getInputStream(),new File(realPath, fileName+"."+suffix));	
			 teacher.setTimgUrl("/teacherImg/"+fileName+"."+suffix);
			}else{
				teacher.setTimgUrl(null);
			}
		   if(file1.getSize()>0){
				 String fileName = UUIDUtil.getUUID();
				 String suffix = file1.getOriginalFilename().substring(file1.getOriginalFilename().lastIndexOf(".") + 1);
				 FileUtils.copyInputStreamToFile(file1.getInputStream(),new File(realPath, fileName+"."+suffix));	
				 teacher.setBackImg("/teacherImg/"+fileName+"."+suffix);
		    }else{
				teacher.setBackImg(null);
			}
		   
		   teacherService.updateTeacher(teacher);	
		   return new ModelAndView("redirect:/back/teacher.html");
			}catch(Exception e){
				session.setAttribute("error", "出错："+e.getMessage());
				log.error("修改教师【id:"+teacher.getTid()+"】出错：",e);
				return new ModelAndView("redirect:/back/teacherUp.html?id="+teacher.getTid());
			}
		}
		return new ModelAndView("redirect:/back/backlogin.html");
	}
	/***
	 * 删除教师信息
	 * */
	@RequestMapping("/back/deleteTeacher")
	public ModelAndView deleteTeacher(HttpServletRequest req,String id,HttpSession session)throws Exception{
		User user = (User)session.getAttribute("backuser");
		if(user!=null){
			try{
			teacherService.deleteTeacherById(id);
			}catch(Exception e){
				log.error("删除教师【id:"+id+"】失败：",e);
			}
			return new ModelAndView("redirect:/back/teacher.html");
		}
		return new ModelAndView("redirect:/back/backlogin.html");
	}
	/**
	 * 新增教师
	 * */
	@RequestMapping("/back/addTeacher.html")
	public void toAddTeacher(HttpServletRequest req,HttpSession session,Model mode)throws Exception{
		if(session.getAttribute("error")!=null){
			mode.addAttribute("error", session.getAttribute("error"));
			session.removeAttribute("error");
		}
	}
	@RequestMapping(value="/back/toAddTeacher",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView addTeacher(HttpServletRequest req,HttpSession session,@RequestParam(value="timgUrl1",required=false)MultipartFile file,@RequestParam(value="file1",required=false)MultipartFile file1,Teacher teacher)throws Exception{
		User user = (User)session.getAttribute("backuser");
		if(user!=null){
			try{
			 String realPath = req.getSession().getServletContext().getRealPath("/");
			 String path = req.getContextPath().substring(1);
			 realPath = realPath.replace(path, "teacherImg");
			 if(file.getSize()>0){
				 String fileName = UUIDUtil.getUUID();
				 String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
				 FileUtils.copyInputStreamToFile(file.getInputStream(),new File(realPath, fileName+"."+suffix));
				 teacher.setTimgUrl("/teacherImg/"+fileName+"."+suffix);
			 }
			 if(file1.getSize()>0){
				 String fileName = UUIDUtil.getUUID();
				 String suffix = file1.getOriginalFilename().substring(file1.getOriginalFilename().lastIndexOf(".") + 1);
				 FileUtils.copyInputStreamToFile(file1.getInputStream(),new File(realPath, fileName+"."+suffix));
				 teacher.setBackImg("/teacherImg/"+fileName+"."+suffix);
			 }
			 teacher.setSort(String.valueOf(new Date().getTime()));
			 teacher.setTid(UUIDUtil.getUUID());
			 teacherService.addTeacher(teacher);
			 
			 return new ModelAndView("redirect:/back/teacher.html");
			}catch(Exception e){
				session.setAttribute("error", "出错了："+e.getMessage());
				log.error("新增教师出错了:",e);
				return new ModelAndView("redirect:/back/addTeacher.html");
			}
	    }
		return new ModelAndView("redirect:/back/backlogin.html");
	}
	
	
	//分页查看所有可显示的教师信息
	@RequestMapping("/teacher/teacherList.html")
	public ModelAndView teacherList(HttpServletRequest req,HttpServletResponse response)throws Exception{
		ModelAndView mode=new ModelAndView();
		Map<String,String> map=new HashMap<String,String>();
		map.put("isShow", "1");
		Page<Teacher> pages=null;
		try{
		int pageNo = 0;
		int pageSize = 4;
		if (req.getParameter("pageNo") != null&&!req.getParameter("pageNo").equals("")
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		 pages =teacherService.searchTeacherList(map, pageNo, pageSize);
		}catch(Exception e){
			log.error("分页查询可显示教师失败:",e);
			pages=new Page<Teacher>();
			pages.setResult(new ArrayList<Teacher>());
					
		}
		mode.addObject("pages", pages);
		mode.setViewName("order/teacherList");
		return mode;
		
    }
	//查看教师信息
	@RequestMapping("/teacher/checkTeacher.html")
	public ModelAndView checkTeacher(HttpServletRequest req,HttpServletResponse response,String id)throws Exception{
		ModelAndView mode=new ModelAndView();
		Teacher teacher=null;
		try{
			teacher=teacherService.findTeacherById(id);
		}catch(Exception e){
			teacher=new Teacher();
			log.error("查询学员【id:"+id+"】异常:",e);
		}
		mode.setViewName("order/checkTeacher");
		mode.addObject("teacher", teacher);
		return mode;
	}
}
