package com.hpedu.core.publicTest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hpedu.core.publicTest.service.TestPointService;

/**
 * 测试知识点 控制器
 * @author Administrator
 *
 */
@Controller
public class TestPointController {
	@Autowired
	private TestPointService tpService ;
	
	
	
	@RequestMapping("/getAllGrade")
	@ResponseBody
	public String getAllGrade(){
		
		List<String> list = tpService.getAllGrade();
		
		return JSON.toJSONString(list);
	}
	
}
