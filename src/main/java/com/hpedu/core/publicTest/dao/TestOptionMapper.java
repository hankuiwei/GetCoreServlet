package com.hpedu.core.publicTest.dao;

import java.util.List;

import com.hpedu.core.publicTest.pojo.TestOption;

public interface TestOptionMapper {
	
	List<TestOption> selectTestOptionByTestId(String TestId );
	
}
