package com.hpedu.core.trophy.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

import com.hpedu.core.trophy.pojo.StuImg;
import com.hpedu.core.trophy.pojo.Trophy;
import com.hpedu.core.trophy.service.TrophyService;
import com.hpedu.core.user.pojo.User;
import com.hpedu.util.BaseUtil;
import com.hpedu.util.PrintHelper;
import com.hpedu.util.StringUtil;
import com.hpedu.util.UUIDUtil;
import com.hpedu.util.mybatis.Page;


@Controller
@RequestMapping("/")
public class TrophyController {

	@Resource
	TrophyService trophyService;
	private Logger log=BaseUtil.getLogger(TrophyController.class);
	@RequestMapping("/back/trophy.html")	
	public void searchAllTrophy(HttpServletRequest req,HttpSession session,Model model)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		try{
		List<Trophy> tlist = trophyService.findAllTrophy(map);
		model.addAttribute("tlist", tlist);
		}catch(Exception e){
			log.error("查询学生后台出错：",e);
			model.addAttribute("tlist", new ArrayList<Trophy>());
		}
	}
	/**
	 * 增加奖杯
	 * 
	 * */
	@RequestMapping("/back/toAddTrophy.html")
	public void toAddTrophy(HttpServletRequest req,HttpSession session,Model mode)throws Exception{
		if(session.getAttribute("error")!=null){
			mode.addAttribute("error", session.getAttribute("error"));
			session.removeAttribute("error");
		}
	}
	@RequestMapping(value="/back/addTrophy",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView addTrophy(HttpServletRequest req,HttpSession session,@RequestParam(value="pimgUrl1",required=false)MultipartFile file,Trophy trophy,@RequestParam(value="file1",required=false)MultipartFile[] files)throws Exception{
		User user = (User)session.getAttribute("backuser");
		if(user!=null){
			try{
			 trophy=getTrophy(req,trophy,files,file);
			 trophyService.addTrophy(trophy);
			List<StuImg> stuList=trophy.getStuList();
			if(stuList.size()>0){
				trophyService.insertStuImgs(stuList);
			}
			 return new ModelAndView("redirect:/back/trophy.html");
			}catch(Exception e){
				log.error("新增奖杯信息出错了:",e);
				session.setAttribute("error", "出错了:"+e.getMessage());
			}
	}
		return new ModelAndView("redirect:/back/backlogin.html");
		
	}
	
	
private Trophy getTrophy(HttpServletRequest req,Trophy trophy,MultipartFile[] files,MultipartFile pimgUrl1) throws IOException{
		
		String realPath = req.getSession().getServletContext().getRealPath("/");
		String path = req.getContextPath().substring(1);
		realPath = realPath.replace(path, "trophyImg");
		String id=trophy.getPid()==null||trophy.getPid().length()==0?UUIDUtil.getUUID():trophy.getPid();
		List<StuImg> imgList=new ArrayList<StuImg>();
		 String fileName = UUIDUtil.getUUID();
		 String suffix = pimgUrl1.getOriginalFilename().substring(pimgUrl1.getOriginalFilename().lastIndexOf(".") + 1);
		if(pimgUrl1.getSize()>0){
			 FileUtils.copyInputStreamToFile(pimgUrl1.getInputStream(),new File(realPath, fileName+"."+suffix));	
			 trophy.setPimgUrl("/trophyImg/"+fileName+"."+suffix);
		}
		
		 trophy.setPid(id);
		 trophy.setSort(String.valueOf(new Date().getTime()));
		
		if(files!=null){
			Long sort=new Date().getTime();
			int i=0;
			for(MultipartFile file:files){//学员答案
				 if(file.getSize()>0){ 
				 fileName = UUIDUtil.getUUID();
				 suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
				 FileUtils.copyInputStreamToFile(file.getInputStream(),new File(realPath, fileName+"."+suffix));
				 StuImg img=new StuImg();
				 img.setStid(UUIDUtil.getUUID());
				 img.setSort(String.valueOf(sort+i));
				 img.setStUrl("/trophyImg/"+fileName+"."+suffix);
				 img.setTpid(id);
				 imgList.add(img);
				 }
				 ++i;
			}
		}
		trophy.setStuList(imgList);
		return trophy;
	}
	
	/**
	 * 根据id删除奖杯
	 * */
	@RequestMapping("/back/deleteTrophy")
	public ModelAndView deleteTrophy(HttpServletRequest req,HttpSession session,String id)throws Exception{
		User user = (User)session.getAttribute("backuser");
		if(user!=null){
			try{
			trophyService.deleteTrophy(id);
			}catch(Exception e){
				log.error("删除奖杯信息【id:"+id+"】出错了:",e);
			}
			return new ModelAndView("redirect:/back/trophy.html");
		}
		return new ModelAndView("redirect:/back/backlogin.html");
	}
	/**
	 * 修改奖杯信息
	 * */
	@RequestMapping("/back/toUpdateTrophy.html")
	public void toUpdateTrophy(HttpServletRequest req,HttpSession session,String id,Model mode)throws Exception{
		try{
		Trophy trophy = trophyService.findTrophyById(id);
		trophy.setStuList(trophyService.selectStuImgByTpid(id));
		mode.addAttribute("trophy", trophy);
		}catch(Exception e){
			log.error("修改奖杯信息【id:"+id+"】出错了:",e);
			mode.addAttribute("error","出错了:"+e.getMessage());
		}
		
		if(session.getAttribute("error")!=null){
			mode.addAttribute("error", session.getAttribute("error"));
			session.removeAttribute("error");
		}
	}
	@RequestMapping(value="/back/updatTrophy",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView updatTrophy(HttpServletRequest req,HttpSession session,@RequestParam(value="pimgUrl1",required=false)MultipartFile file,Trophy trophy,@RequestParam(value="file1",required=false)MultipartFile[] files,String[] delImhid)throws Exception{
		User user = (User)session.getAttribute("backuser");
		if(user!=null){
			try{
			trophy=getTrophy(req,trophy,files,file);
		    trophyService.updateTrophy(trophy);
			List<StuImg> stuList=trophy.getStuList();
			if(stuList.size()>0){
				trophyService.insertStuImgs(stuList);
			}
			if(delImhid!=null&&delImhid.length>0){
				trophyService.deleteStuImgs(delImhid);
			}
			
		    return new ModelAndView("redirect:/back/trophy.html");
			}catch(Exception e){
				session.setAttribute("error", "出错了："+e.getMessage());
				log.error("修改学员信息【id:"+trophy.getPid()+"】失败：",e);
				 return new ModelAndView("redirect:/back/toUpdateTrophy.html?id="+trophy.getPid());
			}
		}
		return new ModelAndView("redirect:/back/backlogin.html");
	}
	
	
	
	
	//查看学员信息
		@RequestMapping("/order/checkStu.html")
		public ModelAndView checkStu(HttpServletRequest req,HttpServletResponse response,String id)throws Exception{
			ModelAndView mode=new ModelAndView();
			Trophy stu=null;
			try{
			 stu = trophyService.findTrophyById(id);
			 stu.setStuList(trophyService.selectStuImgByTpid(id));
			String info=stu.getInfo();
			String pintro=stu.getPintro();
			if(info!=null){
				info=info.replace("<pre class=\"js_message_plain ng-binding\">", "<pre class=\"js_message_plain ng-binding\" style=\"border:0px;background:white;\">");
				stu.setInfo(info);
			}
			if(pintro!=null){
				pintro=pintro.replace("<pre class=\"js_message_plain ng-binding\">", "<p>").replace("</pre>", "</p>");
				stu.setPintro(pintro);
			}
			
			}catch(Exception e){
				stu=new Trophy();
				stu.setStuList(new ArrayList<StuImg>());
				log.error("查询学员【id:"+id+"】失败:",e);
			}
			mode.setViewName("order/checkStu");
			mode.addObject("stu", stu);
			return mode;
		}
		
	//分页查看所有学员信息
		/*	@RequestMapping("/order/stuList.html")
			public ModelAndView stuList(HttpServletRequest req,HttpServletResponse response)throws Exception{
				
				ModelAndView mode=new ModelAndView();
				Map<String,String> map=new HashMap<String,String>();
				Page<Trophy> pages=null;
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
				 pages =trophyService.searchTrophyList(map, pageNo, pageSize);
				}catch(Exception e){
					log.error("查询学员失败:",e);
					pages=new Page<Trophy>();
					pages.setResult(new ArrayList<Trophy>());
							
				}
				mode.addObject("pages", pages);
				mode.setViewName("order/stuList");
				return mode;
				
	}*/
	/**
	 * 上移、下移
	 * */
	@RequestMapping("/back/updatStuSort")
	public void updatStuSort(HttpServletRequest req,HttpServletResponse response,String id1,String sort1,String id2,String sort2)throws Exception{
		String res="ok";
		 try{
			 trophyService.updateTrophySort(id1, sort1);
			 trophyService.updateTrophySort(id2, sort2);
		}catch(Exception e){
			res="出错了："+e.getMessage();
		} 
		PrintHelper.sendJsonString(response, res);
	}
	
}
