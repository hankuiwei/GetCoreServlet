package com.hpedu.core.evaluation.dao;

import java.util.List;

import com.hpedu.core.evaluation.pojo.Evaluation;


/**
 * 评论 dao
 * */
public interface EvaluationMapper {

	/**
	 * 查询该视频所有评论 
	 * */
	List<Evaluation> findAllEvaluationByEid(String vid)throws Exception;
	/**
	 * 查看所有评论(分页)
	 * 
	 * */
	/*List<Evaluation>  findEvaluationListByPage(Map<String, String> map) throws Exception;
	int findEvaluationListCount(Map<String, String> map)throws Exception;*/
	List<Evaluation>  findEvaluationListByPage(int skip,int limit) throws Exception;
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
