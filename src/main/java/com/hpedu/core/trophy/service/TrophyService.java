package com.hpedu.core.trophy.service;

import java.util.List;
import java.util.Map;

import com.hpedu.core.trophy.pojo.StuImg;
import com.hpedu.core.trophy.pojo.Trophy;
import com.hpedu.util.mybatis.Page;

public interface TrophyService {
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
	Trophy findTrophyById(String id)throws Exception;
	/**
	 * 修改奖杯信息
	 * */
	void updateTrophy(Trophy trophy)throws Exception;
	 /**
   	 *  修改学员信息显示顺序
   	 * 
   	 * */
     int updateTrophySort(String tid,String sort);
     
     Page<Trophy> searchTrophyList_page(Map<String, String> map,
 			int pageNo, int pageSize) throws Exception;
     
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
	List<Trophy> searchTrophyList(Map<String, Object> map) throws Exception;

}
