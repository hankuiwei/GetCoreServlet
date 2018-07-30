package com.hpedu.core.user.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.hpedu.core.user.pojo.User;
import com.hpedu.core.user.pojo.UserLearn;
import com.hpedu.core.user.pojo.UserLevel;
import com.hpedu.core.user.service.UserService;
import com.hpedu.util.BaseUtil;
import com.hpedu.util.DateUtil;
import com.hpedu.util.MD5;
import com.hpedu.util.PrintHelper;
import com.hpedu.util.StringUtil;
import com.hpedu.util.UUIDUtil;
import com.hpedu.util.mybatis.Page;

@Controller
@RequestMapping("/")
public class UserController {

	@Resource
	UserService userService;
	private Logger log = BaseUtil.getLogger(UserController.class);

	@Value("#{configProperties['page.limit']}")
	private int pageLimit ;
	@Value("#{configProperties['uploadAbsolutePath']}")
	private String uploadAbsolutePath ;
	

	/**
	 * 修改学生学习时间
	 * */
	@RequestMapping("/user/changeStuLeanTime")
	public void changeStuLeanTime(HttpServletRequest req, HttpSession session,
			String vid, String vclassify, String time) throws Exception {
		User u = (User) session.getAttribute("user");
		if (u != null) {
			// System.out.println(vid+"=="+vclassify+"=="+time+"=="+u.getUid());
			time = time == null ? "0" : time;
			Long realTime = Long
					.parseLong(time.substring(0, time.indexOf(".")));
			try {
				userService.updateLearnTotalTime(u.getUid(), realTime);
				u.setLearnTime(u.getLearnTime() + realTime);
				session.setAttribute("user", u);
			} catch (Exception e) {
				log.error("修改学生【uid:" + u.getUid() + "】总学习时间失败：", e);
			}
			// 修改当天的学习记录
			try {
				String ulid = userService.selectIsExitUserLearn(u.getUid(),
						vid, vclassify);
				UserLearn ul = new UserLearn();
				if (ulid == null) {// 新增学习记录
					ul.setLearnTime(realTime);
					ul.setUlid(UUIDUtil.getUUID());
					ul.setUserid(u.getUid());
					ul.setVctype(Integer.parseInt(vclassify));
					ul.setVid(vid);
					userService.insertLearnTimeByDay(ul);
				} else {// 修改学习记录
					ul.setLearnTime(realTime);
					ul.setUlid(ulid);
					userService.updateLearnTimeByDay(ul);
				}
			} catch (Exception e) {
				log.error("修改学生【uid:" + u.getUid() + "】当天学习时间失败：", e);
			}
		}
	}

	/**
	 * 注册?
	 * 
	 * @param req
	 * @param response
	 * @param session
	 * @param ycode
	 *            验证码
	 * @param user
	 *            用户对象
	 * @return 视图对象
	 * @throws Exception
	 */
	@RequestMapping(value = "/reg/user", method = RequestMethod.POST)
	public ModelAndView req(HttpServletRequest req,HttpServletResponse response, HttpSession session,
			String ycode, User user) throws Exception {
		
		String code = String.valueOf(session.getAttribute("ycodes"));
		ModelAndView mode = new ModelAndView();
		String res = "";
		if (ycode != null && code != null && ycode.equals(code)) {
			user.setUid(UUIDUtil.getUUID());
			user.setPassWord(new MD5(user.getPassWord()).compute_upper());
			// 若使用码不为空，更新邀请人的vip时间
			User invateUser = null;// 邀请人
			if (StringUtils.isNotBlank(user.getUsedCode())) {
				invateUser = userService.getUserByYQCode(user.getUsedCode());
			}
			int type = user.getType();
			int status = 0;// 未审核
			if (type == 0 || invateUser != null) {// 普通用户
				status = 1;
			}
			user.setStatus(status);
			user.setRegTime(new Date());
			if (invateUser != null) {// 使用邀请码注册
				user.setIsVip("1");
				user.setFreeType("1月");
				user.setEndTime(DateUtil.addMonth(new Date(), 1));// 被邀请人延长1个月
			} else {
				user.setIsVip("0");
			}
			user.setLearnTime(0l);
			// 生成自己的邀请码
			String[] codes = userService.getNewYQCode(8, req,uploadAbsolutePath);
			user.setYqCode(codes[0]);
			user.setYqCodeUrl(codes[1]);
			try {
				userService.addUser(user);
			} catch (Exception e) {
				res = "注册失败：" + e.getMessage();
			}
			// 被邀请人延长半个月
			upadteInvator(invateUser);
		} else {
			res = "手机验证码不正确";
		}

		if (res.length() == 0) {// 成功?
			session.setAttribute("user", user);
			mode.setViewName("redirect:/public/login" );
		} else {// 失败
			session.setAttribute("regError", res);
			mode.setViewName("redirect:/public/register");
		}

		return mode;
	}

	@RequestMapping("public/setSession")
	@ResponseBody
	public void setSession (String prevLink,HttpSession session){
		if(!StringUtils.isBlank(prevLink)){
			session.setAttribute("prevLink", prevLink) ;
		}
	}
	
	// 邀请人延长半个月
	private void upadteInvator(User invateUser) throws Exception {
		if (invateUser != null) {
			String endTimeStr = invateUser.getEndTime();
			Date endTime = null;
			if (endTimeStr == null) {
				endTime = new Date();
			} else {
				endTime = DateUtil.string2Date(endTimeStr, "yyyy-MM-dd");
			}
			invateUser.setEndTime(DateUtil.addDate(endTime, 15));// 到期时间延长半个月
			invateUser.setStatus(1);
			invateUser.setIsVip("1");
			userService.updateUserNews(invateUser);
		}
	}

	/**
	 * 手机验证码校验
	 * */
	@RequestMapping("/user/yzCode")
	public void yzCode(HttpServletRequest req, HttpServletResponse response,
			HttpSession session, int type, String code, String phone)
			throws Exception {
		String ycode = String.valueOf(session.getAttribute("ycodes"));
		String res = "ok";
		if (ycode != null && code != null && ycode.equals(code)) {
			if (type == 0) {
				// 验证手机号是否唯一
				int count = userService.getIsExitsByPhone(phone);
				if (count > 0) {
					res = "手机号【" + phone + "】已存在，不可重复注册！";
				}
			}
		} else {
			res = "手机验证码不正确！";
		}
		PrintHelper.sendJsonString(response, res);
	}

	/**
	 * 手机验证码校验
	 * */
	@RequestMapping("/user/ckPhoneIsExsits")
	public void ckPhoneIsExsits(HttpServletRequest req,
			HttpServletResponse response, HttpSession session, String phone)
			throws Exception {
		String res = "ok";
		try {
			int count = userService.getIsExitsByPhone(phone);
			if (count > 0) {
				res = "exsits";
			}
		} catch (Exception e) {
			e.printStackTrace();
			res = e.getMessage();
		}
		PrintHelper.sendJsonString(response, res);
	}

	@RequestMapping(value = "/reg/backPass", method = RequestMethod.POST)
	public ModelAndView backPass(HttpServletRequest req,
			HttpServletResponse response, HttpSession session, String ycode,
			User user) throws Exception {
		String code = String.valueOf(session.getAttribute("ycodes"));
		ModelAndView mode = new ModelAndView();
		String res = "";
		if (ycode != null && code != null && ycode.equals(code)) {
			// 验证手机号是否存在
			int count = userService.getIsExitsByPhone(user.getPhoneNo());
			if (count > 0) {
				String newPwd = new MD5(user.getPassWord()).compute_upper();
				try {
					userService.updatePwdByPhone(user.getPhoneNo(), newPwd);
				} catch (Exception e) {
					res = "找回密码失败：" + e.getMessage();
				}
			} else {
				res = "手机号不存在，请先注册";
			}
		} else {
			res = "手机验证码不正确";
		}
		if (res.length() == 0) {
			mode.setViewName("redirect:/public/login");
		} else {
			session.setAttribute("regError", res);
			mode.setViewName("redirect:/public/backPass");
		}
		return mode;
	}

	/**
	 * 短信验证码
	 * */
	@RequestMapping(value = "/reg/ycode", method = RequestMethod.POST)
	public void sendMessage(HttpServletRequest reqt,
			HttpServletResponse response, String tel, HttpSession session,
			String type) throws Exception {
		int typeInt = Integer.valueOf(type);
		String res = CommUtil.sendSMS(tel, session, true, typeInt);// type:0:注册验证码：1：普通验证码如密码找回
		PrintHelper.sendJsonString(response, res);
	}

	/**
	 * 登陆页面
	 * */
	@RequestMapping("/login.html")
	public void toLogin(HttpServletRequest req, HttpSession session, Model model)
			throws Exception {
		String loginError = (String) session.getAttribute("loginError");
		if (loginError != null) {
			model.addAttribute("loginError", loginError);
			session.removeAttribute("loginError");
		}
	}

	@RequestMapping(value = "/user/login", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public ModelAndView login(HttpServletRequest req, HttpServletResponse resp,
			HttpSession session, User user) throws Exception {
		String jspname = "redirect:/public/login";
		ModelAndView mode = new ModelAndView();
		try {
			String oldPwd = user.getPassWord();
			user.setPassWord(new MD5(oldPwd).compute_upper());
			User users = userService.findUserByPhone(user.getPhoneNo(), user.getPassWord());

			if (users != null) {
				session.setAttribute("user", users);
				jspname = "redirect:/outsideJSP/index.jsp";
			} else {
				session.setAttribute("loginError", "登录账号不存在或密码错误");
			}
		} catch (Exception e) {
			session.setAttribute("loginError", "登录出错，请联系网站管理员！");
			log.info("前端用户登录出错:", e);
		}
		mode.setViewName(jspname);
		return mode;
	}

	/**
	 * 公众号登录 -ajax调用
	 * 
	 * @param req
	 * @param resp
	 * @param session
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/tologin", method = RequestMethod.POST)
	@ResponseBody
	public String userLogin(HttpServletRequest req, HttpServletResponse resp,
			HttpSession session, User user,
			@RequestParam(value = "prevLink", required = false) String prevLink)
			throws Exception {
		Map<String, Object> model = new HashMap<>();
		User users = null;
		try {
			String oldPwd = user.getPassWord();
			user.setPassWord(new MD5(oldPwd).compute_upper());
			users = userService.findUserByPhone(user.getPhoneNo(),
					user.getPassWord());
			if (users != null) {
				session.setAttribute("user", users);
				model.put("user", users);
				session.removeAttribute("prevLink");
			} else {
				req.setAttribute("loginError", "登录账号不存在或密码错误");
				if (!StringUtils.isBlank(prevLink)
						&& !prevLink.contains("login")) {// 请求页 是登录页,则不记录
					session.setAttribute("prevLink", prevLink);
				}
			}
		} catch (Exception e) {
			req.setAttribute("loginError", "登录出错，请联系网站管理员！");
			log.info("前端用户登录出错:", e);
		}
		return JSON.toJSONString(model);
	}

	

	/**
	 * 查看 用户 信息
	 * 
	 * @param req
	 * @param session
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("public/myProfile")
	public void getUserInfo(HttpServletRequest req, HttpSession session,
			Model model) throws Exception {
		User user = (User) session.getAttribute("user");
		// 学生等级
		Integer leval = 0;
		int learnCount = 0;
		if (user != null) {
			model.addAttribute("user", userService.findUserByUid(user.getUid()));
			try {
				List<UserLevel> levelList = userService.selectAllLevel();
				if (user != null) {
					Long learnTime = user.getLearnTime();// 单位是秒
					learnTime = learnTime == null ? 0l : learnTime;
					for (UserLevel u : levelList) {
						Long minNum = u.getMinNum();// 单位是小时
						Long maxNum = u.getMaxNum();// 单位是小时
						if ((learnTime >= minNum * 3600 && maxNum == null)
								|| (learnTime >= minNum * 3600
										&& maxNum != null && learnTime < maxNum * 3600)) {
							leval = u.getLevel();
							break;
						}
					}
					// 学习中的课程总计
					learnCount = userService.getLearnVideoTotalCount(user
							.getUid());
				}

			} catch (Exception e) {
				log.error("查询学生等级异常：", e);
			}

			model.addAttribute("leval", leval);
			model.addAttribute("learnCount", learnCount);
		} else {
			model.addAttribute("msg", "您还未登录!");
		}
	}

	
	
	/**
	 * 修改用户信息
	 * */
	@RequestMapping(value="/user/updateUserProfile",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView updateUserProfile(HttpServletRequest req,HttpSession session,
			@RequestParam(value="timgUrl1",required=false)MultipartFile file,
			User user)throws Exception{
		User users = (User)session.getAttribute("user");
		   if(users==null){
			   String uid=user.getUid();
			   if(uid!=null&&uid.length()>0){
				   users=userService.findUserByUid(uid);
			   }
		   }
		
		if(users!=null){
			   if( file.getSize()>0){
				String realPath = uploadAbsolutePath+ "/" + "userHeadImg";
				String fileName = UUIDUtil.getUUID();
				 String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
				 FileUtils.copyInputStreamToFile(file.getInputStream(),new File(realPath, fileName+"."+suffix));	
				 users.setHeadImgUrl("/userHeadImg/"+fileName+"."+suffix);
				}
			users.setEmail(user.getEmail());
			users.setUserName(user.getUserName());
			try{
			      userService.updateUserNews(users);
			      session.setAttribute("user", users);
				  return new ModelAndView("redirect:/public/myProfile");
			 }catch(Exception e){
				log.error("修改前端用户信息【id:"+users.getUid()+"】失败：",e);
			 }
		}
		return new ModelAndView("redirect:/public/updateMyProfile");
	}
	
	// 学习中的课程分页查询
	@RequestMapping("/learnVideoPage.html")
	public void learnVideoPage(HttpServletRequest req, HttpSession session,
			Model model) throws Exception {
		int pageNo = 0;
		int pageSize = pageLimit;
		if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}

		List<Map> list = null;
		int totalCount = 0;
		String userId = "";
		User user = (User) session.getAttribute("user");
		if (user != null) {
			userId = user.getUid();
		}

		try {
			list = userService.findlearnListByPage(userId, pageNo, pageSize);
			totalCount = userService.getLearnVideoTotalCount(userId);
		} catch (Exception e) {
			log.info("分页查看用户学习中课程出错:", e);
			list = new ArrayList<Map>();
		}
		Page pages = new Page();
		pages.setResult(list);
		pages.setPageNo(pageNo);
		pages.setPageSize(pageSize);
		pages.setTotalCount(totalCount);
		model.addAttribute("pages", pages);
	}

	// 学习中的课程分页查询
		@RequestMapping("/public/myCourse")
		public void getLearnedVideo(HttpServletRequest req, HttpSession session,
				Model model) throws Exception {
			int pageNo = 0;
			int pageSize = pageLimit;
			if (req.getParameter("pageNo") != null
					&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
				pageNo = Integer.parseInt(req.getParameter("pageNo"));
			}
			if (pageNo < 1) {
				pageNo = 1;
			}

			List<Map> list = null;
			int totalCount = 0;
			String userId = "";
			User user = (User) session.getAttribute("user");
			if (user != null) {
				userId = user.getUid();
				
				try {
					list = userService.findlearnListByPage(userId, pageNo, pageSize);
					totalCount = userService.getLearnVideoTotalCount(userId);
				} catch (Exception e) {
					log.info("分页查看用户学习中课程出错:", e);
					list = new ArrayList<Map>();
				}
				Page pages = new Page();
				pages.setResult(list);
				pages.setPageNo(pageNo);
				pages.setPageSize(pageSize);
				pages.setTotalCount(totalCount);
				model.addAttribute("pages", pages);
			}else{
				model.addAttribute("msg", "未登录");
			}

			
		}
	
	// 学生历史分数分页查询
	@RequestMapping("/public/myScore")
	public void getHistoryScores(HttpServletRequest req, HttpSession session,
			Model model) throws Exception {
		
		int pageNo = 0;
		int pageSize = pageLimit;
		if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		
		String userId = "";
		User user = (User) session.getAttribute("user");
		if (user != null) {
			userId = user.getUid();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", userId);
			/**查询 得分记录 */
			try {
				model.addAttribute("pages", userService.searchUnitTestList(map, pageNo, pageSize));
			} catch (Exception e) {
				log.error("学生【userid:" + userId + "】历史分数分页查询失败：", e);
			}
		}else {
			model.addAttribute("msg","未登录");
		}
		
	}

	
	/**
	 * 用户退出
	 * */
	@RequestMapping("/user/exitUser")
	public ModelAndView userExit(HttpServletRequest req, HttpSession session)
			throws Exception {
		session.removeAttribute("user");
		return new ModelAndView("redirect:/classindex.html");
	}

	/**
	 * 批量生成邀请码
	 * */
	@RequestMapping("/user/makingYQCode")
	public void makingYQCode(HttpServletRequest req,
			HttpServletResponse response, HttpSession session) throws Exception {
		List<User> list = userService.searchUserList(null);
		for (int i = 0; i < list.size(); i++) {
			String[] codes = userService.getNewYQCode(8, req,uploadAbsolutePath);
			userService.updateYQCodeByUserId(list.get(i).getUid(), codes[0],
					codes[1]);
		}
		response.getWriter().print("ok");
	}

	/**
	 * 邀请码是否存在
	 * */
	@RequestMapping("/user/ckYQCodeExsits")
	public void ckYQCodeExsits(HttpServletRequest req,
			HttpServletResponse response, HttpSession session, String yqCode)
			throws Exception {
		try {
			User user = userService.getUserByYQCode(yqCode);
			if (user != null) {
				response.getWriter().print("ok");
			} else {
				response.getWriter().print("notExsits");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("error");
		}
	}
}
