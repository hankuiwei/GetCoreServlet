package com.hpedu.core.trophy.dao;

import java.util.List;
import java.util.Map;

import com.hpedu.core.trophy.pojo.StuImg;
import com.hpedu.core.trophy.pojo.Trophy;

public interface TrophyMapper {

	/**
	 * 查询所有奖杯
	 * */
	List<Trophy> findAllTrophy(Map<String,Object> map)throws Exception;
	/**
	 * 根据ID删除奖杯
	 * */
	void deleteTrophy(String id)throws Exception;
	/**
	 * 新增奖杯
	 * */
	void addTrophy(Trophy trophy)throws Exception;
	/**
	 * 根据ID查询奖杯信息
	 * */
	Trophy findTrophyById(String id) throws Exception;
	/**
	 * 修改奖杯信息
	 * */
	void updateTrophy(Trophy trophy)throws Exception;
	
	 /**
   	 *  修改学员信息显示顺序
   	 * 
   	 * */
     int updateTrophySort(String tid,String sort);
     
    
 	int searchTrophyListCount(Map<String,String> map)throws Exception;
 	
 	/**
	 * 批量新增测验题和答案
	 * 
	 * */
	int  insertStuImgs(List<StuImg> list);
	/**
	 * 批量删除测验题和答案
	 * 
	 * */
	int  deleteStuImgs(String[] list);
	
	List<StuImg> selectStuImgByTpid(String tpid);
}
