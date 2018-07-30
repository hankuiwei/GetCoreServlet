package com.hpedu.core.publicTest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hpedu.core.publicTest.pojo.Test;
import com.hpedu.core.publicTest.service.TestService;

/**
 * 测试 控制器
 * @author Administrator
 *
 */
@Controller
public class TestController {
	@Autowired
	private TestService testService ;
	
	/**
	 * 展示 测试.
	 * @return
	 */
	/*@RequestMapping(value="/back/test/controlTest")
	public ModelAndView showTest(HttpServletRequest request){
		Map<String ,String> map = new HashMap<>();
		ModelAndView mv = new ModelAndView("/back/test/controlTest");
		int pageNo = 0;
		int pageSize = 4;
		if (request.getParameter("pageNo") != null
				&& StringUtil.isNumeric(request.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		Page<Test> page = null ;
		try {
			page = testService.getTest_Page(map,pageNo,pageSize);
		} catch (Exception e) {
			System.out.println("查询知识点出错-->"+e.getMessage());
		}
		
		mv.addObject("pages", page);
		return mv;
	}*/
	
	@RequestMapping("/goTest")
	public ModelAndView goTest(String grade){
		ModelAndView mv = new ModelAndView("public/test");
		List<Test> testList = testService.getRandomTestByGrade(grade);
		
		mv.addObject("testList", testList);
		
		return mv;
	}
	
	
}
