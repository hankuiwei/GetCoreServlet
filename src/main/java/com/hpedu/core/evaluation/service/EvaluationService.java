package com.hpedu.core.evaluation.service;

import java.util.List;

import com.hpedu.core.evaluation.pojo.Evaluation;


/**
 * 评论Service
 * */
public interface EvaluationService {

	/**
	 * 查询该视频所有评论 
	 * */
	List<Evaluation> findAllEvaluationByEid(String eid)throws Exception;
	/**
	 * 查看所有评论(分页)
	 * 
	 * */
	//Page<Evaluation>  findEvaluationListByPage(Map<String, String> map,int pageNo,int pageSize) throws Exception;
	List<Evaluation>  findEvaluationListByPage(int pageno,int pagesize) throws Exception;
	int findEvaluationListCount()throws Exception;
	/**
	 * 根据ID删除该评论
	 * */
	int deleteEvaluationById(String eid)throws Exception;
	/**
	 * 查询该视频前20条评论 
	 * */
	List<Evaluation> findTop20EvaluationByEid(String vid)throws Exception;
	/**
	 * 新增评论 
	 * */
	int insertEvaluation(Evaluation e)throws Exception;
}
