package com.hpedu.core.publicTest.service;

import java.util.List;

import com.hpedu.core.publicTest.pojo.Test;

/**
 * 测试题 业务层.
 * @author Administrator
 *
 */

public interface TestService {
	
	/**
	 * 查询测试题 - 分页.
	 * @param map
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	/*Page<Test> getTest_Page(Map<String, String> map, int pageNo, int pageSize);*/


	List<Test> getRandomTestByGrade(String grade ) ;
}
