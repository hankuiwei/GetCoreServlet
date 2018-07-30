package com.hpedu.core.teacher.dao;

import java.util.List;
import java.util.Map;

import com.hpedu.core.teacher.pojo.Teacher;

public interface TeacherMapper {
	/**
	 * 查询所有老师
	 * */
	List<Teacher> findAllTeacher(Map<String,Object> map)throws Exception;
	
	/**
	 * 查询所有老师
	 * */
	List<Teacher> getAllTeacher(Map<String,Object> map)throws Exception;
	/**
	 * 根据ID 查询教师
	 * */
	 Teacher findTeacherById(String id)throws Exception;
	 /**
		 * 根据name查询教师
		 * */
	  Teacher findTeacherByName(String tname)throws Exception;
	 /**
	  * 
	  *更新教师信息 
	  * */
	 void updateTeacher(Teacher teacher)throws Exception;
	 /**
	  * 根据ID删除教师信息
	  * */
	 void deleteTeacherById(String id)throws Exception;
	 /**
	  * 新增教师信息
	  * */
	 void addTeacher(Teacher teacher)throws Exception;
	 /**
	   	 *  修改教师顺序
	   	 * 
	   	 * */
	 int updateTeacherSort(String tid,String sort);
	 int searchTeacherListCount(Map<String,String> map)throws Exception;
	 List<Teacher> findTeacherByPage(Map<String,Object> map)throws Exception;//分页查询教师
	 
	 /**
	  * 获取老师教授的所有课程
	  * @param tname
	  * @return
	  */
	 List<Map<String,String>> getCourse(String tname);

	 /**
	  * 获取首页展示教师/
	  * @param param
	  * @return
	  */
	List<Teacher> getIndexTeacher(List<String> param);
}
