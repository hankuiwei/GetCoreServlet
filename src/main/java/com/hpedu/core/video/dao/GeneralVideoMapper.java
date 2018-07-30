package com.hpedu.core.video.dao;

import java.util.List;
import java.util.Map;

import com.hpedu.core.video.pojo.GeneralVideo;
import com.hpedu.core.video.pojo.VideoChild;


/**
 * 常规赛dao
 * */
public interface GeneralVideoMapper {
	/**
	 * 首页常规赛dao
	 * */
	List<GeneralVideo> findGeneralVideo()throws Exception;
	/**
	 * 根据视频ID查询视频播放
	 * */
	GeneralVideo findGeneralVideoByVid(String vid)throws Exception;
	/**
	 *  该视频相关视频
	 *  @param gsbuject 学科
	 *  @param gclass 年级
	 *  @param gclassify 年级下分类（阅读 写作等）
	 * */
	List<GeneralVideo> findGeneralVideoByVideo(String gsbuject,String gclass,String gclassify,String vid)throws Exception;

	/**
	 * 条件查询常规视频(分页)
	 * 
	 * */
	List<GeneralVideo> searchGeneralVideoList(Map<String, String> map) throws Exception;
	int searchGeneralVideoListCount(Map<String, String> map)throws Exception;
	
	/**
	 * 根据ID删除该视频
	 * */
	 void deleteGeneralById(String gid)throws Exception;

	/**
	 * 新增语文常规视频
	 * */
	void addChineseGeneralVideo(GeneralVideo generalVideo)throws Exception;
	/**
	 * 修改视频
	 * */
	 void updateChineseGeneralVideo(GeneralVideo generalVideo)throws Exception;
	 
     /**
	 * 根据年级查前8条常规视频-测验推荐
	 * */
	List<GeneralVideo> findVideoListByExam(Map<String,Object> map)throws Exception;
	/**
	 * 条件查询常规视频
	 * 
	 * */
	List<GeneralVideo> searchGeneralVideoListByGname(String gname) throws Exception;
	/**
	 * 根据父视频id查询所有的子视频
	 * 
	 * */
	List<VideoChild> selectAllChildVideo(Map<String,String> map);
	/**
	 * 根据id查询子视频
	 * 
	 * */
	VideoChild selectChildVideoById(String id);
	/**
	 * 批量新增子视频
	 * 
	 * */
	int  insertVideoChild(List<VideoChild> list);
	/**
	 * 批量删除子视频
	 * 
	 * */
	int  deleteVideoChild(String[] list);
	/**
	 * 批量修改子视频
	 * 
	 * */
	int  updateBatchVideoChild(List<VideoChild> list);
	/**
	 * 批量修改子视频
	 * 
	 * */
	int  updateBatchVideoChildName(List<VideoChild> list);
	/**
	 * 新增单个子视频
	 * 
	 * */
	int  insertOneVideoChild(VideoChild vc);
	
	/**
	 * 根据pID删除关联子视频
	 * */
	 void deleteVideoChildById(String pid)throws Exception;
	 /**
		 * 批量新增pdf
		 * map:List<VideoPdf> list,vid
		 * */
		int  insertVideoPdf(Map<String,Object>  map);
		/**
		 * 批量删除pdf
		 * 
		 * */
		int  deleteVideoPdf(String[] list);
		int updateIsKill(String vid,String status);//修改秒杀执行状态
		
		 /**
		 * 修改常规播放次数
		 * */
		void updatePlayCount(String vid);
		void updateVideoEditDate(String dateStr,String weekVal);//批量修改子视频更新时间
		VideoChild getLastNewEditVideoChild(Map<String,String> map);//获取最新更新视频
		/**
		 * 根据教师名字 获取 教授课程
		 * @param tname
		 * @return
		 */
		List<GeneralVideo> getCourse(String tname);
		/**
		 * 获取最近一个月的常规课 列表
		 * @param map
		 * @return
		 */
		List<GeneralVideo> getLatestGeneralVideoList(Map<String, String> map);
		/**
		 * 获取免费课程
		 * @return
		 */
		List<GeneralVideo> getFreeCourse();
}
