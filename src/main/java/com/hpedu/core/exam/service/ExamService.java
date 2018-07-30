package com.hpedu.core.exam.service;

import java.util.List;
import java.util.Map;

import com.hpedu.core.exam.pojo.Exam;
import com.hpedu.core.exam.pojo.ExamImg;
import com.hpedu.util.mybatis.Page;

public interface ExamService {
	

	/**
	 * 导航栏检索小测验(分页)
	 * 
	 * */

	Page<Exam> findExamListByMap(Map<String,String> map,int pageNo,int pageSize)throws Exception;
	/**
	 * 点击某个测验查看
	 * */
	Exam findExamByEtid(String etid)throws Exception;
	/**
	 * 根据ID删除测试
	 * */
	void deleteExamById(String etId)throws Exception;
	/**
	 * 修改测试
	 * */
	void updateExam(Exam exam)throws Exception;
	/**
	 * 新增测试
	 * */
	void addExam(Exam exam)throws Exception;
	
	/**
	 * 批量新增测验题和答案
	 * 
	 * */
	int  insertExamImgs(List<ExamImg> list);
	/**
	 * 批量删除测验题和答案
	 * 
	 * */
	int  deleteExamImgs(String[] list);
	
	List<ExamImg> selectExamImgByExid(String ExamImg);
	 /**
		 * 修改小测验学习人数
		 * */
		void updateLearnCount(String etid);
}
