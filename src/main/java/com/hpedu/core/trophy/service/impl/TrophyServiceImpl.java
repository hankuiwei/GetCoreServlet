package com.hpedu.core.trophy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hpedu.core.trophy.dao.TrophyMapper;
import com.hpedu.core.trophy.pojo.StuImg;
import com.hpedu.core.trophy.pojo.Trophy;
import com.hpedu.core.trophy.service.TrophyService;
import com.hpedu.util.mybatis.MyBatisBase;
import com.hpedu.util.mybatis.Page;

@Service
public class TrophyServiceImpl extends MyBatisBase implements TrophyService {

	@Override
	public List<Trophy> findAllTrophy(Map<String,Object> map) throws Exception {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		List<Trophy> trolist = mapper.findAllTrophy(map);
		return trolist;
	}
	
	
	@Override
	public Page<Trophy> searchTrophyList_page(Map<String, String> map,
			int pageNo, int pageSize) throws Exception {
		Page<Trophy> page =this.queryPage("com.hpedu.core.trophy.dao.TrophyMapper.findAllTrophy",
				"com.hpedu.core.trophy.dao.TrophyMapper.searchTrophyListCount", map, pageNo, pageSize);
		return page;
	}
	@Override
	public List<Trophy> searchTrophyList(Map<String, Object> map) throws Exception {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		return mapper.findAllTrophy(map);
	}
	@Override
	public void deleteTrophy(String id) throws Exception {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		mapper.deleteTrophy(id);
	}

	@Override
	public void addTrophy(Trophy trophy) throws Exception {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		mapper.addTrophy(trophy);
	}

	@Override
	public Trophy findTrophyById(String id) throws Exception {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		Trophy trophy = mapper.findTrophyById(id);
		return trophy;
	}

	@Override
	public void updateTrophy(Trophy trophy) throws Exception {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		mapper.updateTrophy(trophy);
	}

	@Override
	public int updateTrophySort(String tid, String sort) {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		return mapper.updateTrophySort(tid, sort);
	}
	@Override
	public int insertStuImgs(List<StuImg> list) {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		return mapper.insertStuImgs(list);
	}
	@Override
	public int deleteStuImgs(String[] list) {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		return mapper.deleteStuImgs(list);
	}
	@Override
	public List<StuImg> selectStuImgByTpid(String tpid) {
		TrophyMapper mapper = this.getSqlSessionTemplate().getMapper(TrophyMapper.class);
		return mapper.selectStuImgByTpid(tpid);
	}

}
