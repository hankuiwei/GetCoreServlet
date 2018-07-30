package com.hpedu.core.teacher.service;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.hpedu.core.teacher.pojo.Teacher;
import com.hpedu.util.mybatis.Page;

public interface TeacherService {

	/**
	 * 查询所有教师
	 * */
	List<Teacher> findAllTeacher(Map<String,Object> param)throws Exception;
	
	/**
	 * 查询所有教师
	 * */
	Page<Teacher> getAllTeacher(Map<String,Object> param,int pageNo, int pageSize)throws Exception;
	
	/**
	 * 根据ID查询教师
	 * */
	Teacher findTeacherById(String id)throws Exception;
	 /**
	 * 根据name查询教师
	 * */
  Teacher findTeacherByName(String tname)throws Exception;
	/**
	 * 修改教师信息
	 * */
	void updateTeacher(Teacher teacher)throws Exception;
	/**
	 * 删除教师信息
	 * */
	void deleteTeacherById(String id)throws Exception;
	/**
	 * 新增教师
	 * */
	void addTeacher(Teacher teacher)throws Exception;
	/**
   	 *  修改教师顺序
   	 * 
   	 * */
 int updateTeacherSort(String tid,String sort);
 Page<Teacher> searchTeacherList(Map<String, String> map,
			int pageNo, int pageSize) throws Exception;

	 /**
	  * 获取盖老师教授的所有课程名字.
	  * @param tname
	  * @return
	  */
 	List<Map<String, String>> getCourse(String tname);

 	/**
 	 * 首页展示的老师. 
 	 * @param list
 	 * @return
 	 */
	List<Teacher> getIndexTeacher(List<String> list);
}
