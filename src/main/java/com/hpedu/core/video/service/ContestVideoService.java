package com.hpedu.core.video.service;

import java.util.List;
import java.util.Map;

import com.hpedu.core.video.pojo.ContestVideo;
import com.hpedu.core.video.pojo.VideoPdf;
import com.hpedu.util.mybatis.Page;

/**
 * 竞赛servic
 * */
public interface ContestVideoService {
	/**
	 * 首页查询推荐竞赛视频
	 * */
	List<ContestVideo> findContestVideoIndex()throws Exception;
	/**
	 * 根据竞赛视频ID播放
	 * @param cId （竞赛视频ID）
	 * */
	ContestVideo findContestVideoById(String cId)throws Exception;
	/**
	 * 查询该竞赛相关视频
	 * @param competitionName 竞赛名称（例：美国大联盟杯）
	 * @param cclass 年级（例：三四年级）
	 * @param cclassify 年级下分类（例：真题讲解）
	 * */
	List<ContestVideo> findContestVideoByVideo(String competitionName,String cclass,String cclassify,String vid)throws Exception;
	/**
	 * 导航栏分页查询符合条件视频列表
	 * @param Map 参数map
	 * */
	Page<ContestVideo> searchContestVideoList(Map<String,String>map,int pageNo,int pageSize)throws Exception;
	
	/**
	 * 新增竞赛课程
	 * */
	void addUSAClass(ContestVideo contestVideo)throws Exception;
	/**
	 * 修改竞赛视频信息
	 * */
	void updateUSAClass(ContestVideo contestVideo)throws Exception;
	/**
	 * 删除竞赛视频
	 * */
	void deleteUSAClass(String cid)throws Exception;
	/**
	 * 竞赛视频模糊查询
	 * */
	List<ContestVideo> searchContestVideoListByCname(String cname)throws Exception;
	 /**
	 * 根据年级查前8条竞赛视频-测验推荐
	 * */
List<ContestVideo> findVideoListByExam(Map<String,Object> map)throws Exception;

List<VideoPdf> selectPdfByVid(String vid,String type);
int updateIsKill(String vid,String status);//修改秒杀执行状态
/**
	 * 修改竞赛播放次数
	 * */
	void updatePlayCount(String vid);
	
	/**
	 * 根据名字 获取教授课程.
	 * @param tname
	 * @return
	 */
List<ContestVideo> getCourse(String tname);
/**
 * 获取最近一个月的 竞赛课 列表
 * @param maps
 * @return
 */
	List<ContestVideo> getLatestContestVideoList(Map<String, String> maps);
	/**
	 * 获取免费竞赛课
	 * @return
	 */
List<ContestVideo> getFreeCourse();
}
