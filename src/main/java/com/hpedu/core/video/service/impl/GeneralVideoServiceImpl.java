package com.hpedu.core.video.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hpedu.core.video.dao.GeneralVideoMapper;
import com.hpedu.core.video.pojo.GeneralVideo;
import com.hpedu.core.video.pojo.VideoChild;
import com.hpedu.core.video.service.GeneralVideoService;
import com.hpedu.util.mybatis.MyBatisBase;
import com.hpedu.util.mybatis.Page;

@Service
public class GeneralVideoServiceImpl extends MyBatisBase implements GeneralVideoService {

	@Override
	public List<GeneralVideo> findGeneralVideo() throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		List<GeneralVideo> genlist = mapper.findGeneralVideo();
		return genlist;
	}

	@Override
	public GeneralVideo findGeneralVideoByVid(String vid) throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		GeneralVideo gvideo = mapper.findGeneralVideoByVid(vid);
		return gvideo;
	}

	@Override
	public List<GeneralVideo> findGeneralVideoByVideo(String gsbuject,
			String gclass, String gclassify,String vid) throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		List<GeneralVideo> glist = mapper.findGeneralVideoByVideo(gsbuject, gclass, gclassify,vid);
		return glist;
	}

	@Override
	public Page<GeneralVideo> searchGeneralVideoList(Map<String, String> map,
			int pageNo, int pageSize) throws Exception {
		 Page<GeneralVideo> page = this.queryPage("com.hpedu.core.video.dao.GeneralVideoMapper.searchGeneralVideoList",
				 "com.hpedu.core.video.dao.GeneralVideoMapper.searchGeneralVideoListCount", map,  pageNo, pageSize);
		return page;
	}

	@Override
	public List<GeneralVideo> getLatestGeneralVideoList(Map<String, String> map) throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		List<GeneralVideo> glist = mapper.getLatestGeneralVideoList(map);
		return glist;
	}
	
	@Override
	public void deleteGeneralById(String gid) throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		mapper.deleteGeneralById(gid);
	}

	@Override
	public void addChineseGeneralVideo(GeneralVideo generalVideo)
			throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);	
		mapper.addChineseGeneralVideo(generalVideo);
	}

	@Override
	public void updateChineseGeneralVideo(GeneralVideo generalVideo)
			throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);	
			mapper.updateChineseGeneralVideo(generalVideo);
	}



	@Override
	public List<GeneralVideo> searchGeneralVideoListByGname(String gname)
			throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.searchGeneralVideoListByGname(gname);
	}

	@Override
	public List<GeneralVideo> findVideoListByExam(Map<String, Object> map)
			throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.findVideoListByExam(map);
	}

	@Override
	public List<VideoChild> selectAllChildVideo(Map<String,String> map) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.selectAllChildVideo(map);
	}

	@Override
	public int insertVideoChild(List<VideoChild> list) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.insertVideoChild(list);
	}

	@Override
	public int deleteVideoChild(String[] list) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.deleteVideoChild(list);
	}

	@Override
	public VideoChild selectChildVideoById(String id) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.selectChildVideoById(id);
	}


	@Override
	public void deleteVideoChildById(String pid) throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		mapper.deleteVideoChildById(pid);
	}

	@Override
	public int insertVideoPdf(Map<String,Object>  map) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.insertVideoPdf(map);
	}

	@Override
	public int deleteVideoPdf(String[] list) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.deleteVideoPdf(list);
	}

	@Override
	public int updateIsKill(String vid, String status) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.updateIsKill(vid, status);
	}

	@Override
	public List<GeneralVideo> searchGeneralVideoList(Map<String, String> map)
			throws Exception {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.searchGeneralVideoList(map);
	}

	@Override
	public int updateBatchVideoChild(List<VideoChild> list) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.updateBatchVideoChild(list);
	}

	@Override
	public int insertOneVideoChild(VideoChild vc) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.insertOneVideoChild(vc);
	}

	@Override
	public void updatePlayCount(String vid) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		mapper.updatePlayCount(vid);
	}

	@Override
	public void updateVideoEditDate(String dateStr, String weekVal) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		mapper.updateVideoEditDate(dateStr, weekVal);
	}

	@Override
	public VideoChild getLastNewEditVideoChild(Map<String, String> map) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.getLastNewEditVideoChild(map);
	}

	@Override
	public int updateBatchVideoChildName(List<VideoChild> list) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.updateBatchVideoChildName(list);
	}

	@Override
	public List<GeneralVideo> getCourse(String tname) {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.getCourse(tname);
	}

	@Override
	public List<GeneralVideo> getFreeCourse() {
		GeneralVideoMapper mapper = this.getSqlSessionTemplate().getMapper(GeneralVideoMapper.class);
		return mapper.getFreeCourse();
	}

}
