package com.hpedu.core.video.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hpedu.core.video.dao.ContestVideoMapper;
import com.hpedu.core.video.pojo.ContestVideo;
import com.hpedu.core.video.pojo.VideoPdf;
import com.hpedu.core.video.service.ContestVideoService;
import com.hpedu.util.mybatis.MyBatisBase;
import com.hpedu.util.mybatis.Page;

@Service
public class ContestVideoServiceImpl extends MyBatisBase implements ContestVideoService {

	@Override
	public List<ContestVideo> findContestVideoIndex() throws Exception {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		List<ContestVideo> conlist = mapper.findContestVideoIndex();
		return conlist;
	}

	@Override
	public ContestVideo findContestVideoById(String cId) throws Exception {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		ContestVideo contestVideo = mapper.findContestVideoById(cId);
		return contestVideo;
	}

	@Override
	public List<ContestVideo> findContestVideoByVideo(String competitionName,
			String cclass, String cclassify,String vid) throws Exception {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		List<ContestVideo> conlist  = mapper.findContestVideoByVideo(competitionName, cclass, cclassify,vid);
		return conlist;
	}

	@Override
	public Page<ContestVideo> searchContestVideoList(Map<String, String> map,
			int pageNo, int pageSize) throws Exception {
		Page<ContestVideo> page =this.queryPage("com.hpedu.core.video.dao.ContestVideoMapper.searchContestVideoList",
				"com.hpedu.core.video.dao.ContestVideoMapper.searchContestVideoListCount", map, pageNo, pageSize);
		return page;
	}

	@Override
	public void addUSAClass(ContestVideo contestVideo) throws Exception {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		mapper.addUSAClass(contestVideo);
	}

	@Override
	public void updateUSAClass(ContestVideo contestVideo) throws Exception {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		mapper.updateUSAClass(contestVideo);
	}

	@Override
	public void deleteUSAClass(String cid) throws Exception {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		mapper.deleteUSACLass(cid);
	}

	@Override
	public List<ContestVideo> searchContestVideoListByCname(String cname)
			throws Exception {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		return mapper.searchContestVideoListByCname(cname);
	}

	@Override
	public List<ContestVideo> findVideoListByExam(Map<String, Object> map)
			throws Exception {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		return mapper.findVideoListByExam(map);
	}

	@Override
	public List<VideoPdf> selectPdfByVid(String vid, String type) {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		return mapper.selectPdfByVid(vid, type);
	}

	@Override
	public int updateIsKill(String vid, String status) {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		return mapper.updateIsKill(vid, status);
	}

	@Override
	public void updatePlayCount(String vid) {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		mapper.updatePlayCount(vid);
	}

	@Override
	public List<ContestVideo> getCourse(String tname) {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		return mapper.getCourse(tname);
	}

	@Override
	public List<ContestVideo> getLatestContestVideoList(Map<String, String> maps) {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		List<ContestVideo> contestCourseList = mapper.getLatestContestVideoList(maps);
		return contestCourseList;
	}

	@Override
	public List<ContestVideo> getFreeCourse() {
		ContestVideoMapper mapper = this.getSqlSessionTemplate().getMapper(ContestVideoMapper.class);
		return mapper.getFreeCourse();
	}

}
