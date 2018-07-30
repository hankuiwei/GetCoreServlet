package com.hpedu.core.publicTest.dao;

import java.util.List;

import com.hpedu.core.publicTest.pojo.Test;

public interface TestMapper {
	
	List<Test> getRandomTestByGrade(String grade) ;
}
