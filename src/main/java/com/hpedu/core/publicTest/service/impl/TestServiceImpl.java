package com.hpedu.core.publicTest.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hpedu.core.publicTest.dao.TestMapper;
import com.hpedu.core.publicTest.pojo.Test;
import com.hpedu.core.publicTest.service.TestService;
import com.hpedu.util.mybatis.MyBatisBase;
@Service
public class TestServiceImpl extends MyBatisBase implements TestService{

	@Autowired
	private TestMapper testMapper ;
//	@Autowired
//	private TestOptionMapper testOptionMapper ;
	
	
	@Override
	public List<Test> getRandomTestByGrade(String grade) {
		return testMapper.getRandomTestByGrade(grade);
	}

	
/*
	@Override
	public Page<Test> getTest_Page(Map<String, String> map, int pageNo, int pageSize) {
		return this.queryPage("com.hpedu.core.publicTest.dao.TestMapper.getTest_Page",
				 "com.hpedu.core.publicTest.dao.TestMapper.getTest_Page_count", map,  pageNo, pageSize);
	}
*/
	
}
