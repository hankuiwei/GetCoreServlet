package com.hpedu.core.publicTest.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hpedu.core.publicTest.dao.TestPointMapper;
import com.hpedu.core.publicTest.service.TestPointService;
import com.hpedu.util.mybatis.MyBatisBase;
@Service
public class TestPointServiceImpl extends MyBatisBase implements TestPointService{

	@Autowired
	private TestPointMapper tpMapper ;


	@Override
	public List<String> getAllGrade() {
		return tpMapper.getAllGrade();
	}

	
}
