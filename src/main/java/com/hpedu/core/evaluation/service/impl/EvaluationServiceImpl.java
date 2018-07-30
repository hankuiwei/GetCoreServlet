package com.hpedu.core.evaluation.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hpedu.core.evaluation.dao.EvaluationMapper;
import com.hpedu.core.evaluation.pojo.Evaluation;
import com.hpedu.core.evaluation.service.EvaluationService;
import com.hpedu.util.mybatis.MyBatisBase;

@Service
public class EvaluationServiceImpl extends MyBatisBase implements EvaluationService {

	@Override
	public List<Evaluation> findAllEvaluationByEid(String eid) throws Exception {
		EvaluationMapper mapper = this.getSqlSessionTemplate().getMapper(EvaluationMapper.class);
		List<Evaluation> elist = mapper.findAllEvaluationByEid(eid);
		return elist;
	}

	/*@Override
	public Page<Evaluation> findEvaluationListByPage(Map<String, String> map,
			int pageNo, int pageSize) throws Exception {
		 Page<Evaluation> page = this.queryPage("com.hpedu.core.evaluation.dao.EvaluationMapper.findEvaluationListByPage",
				 "com.hpedu.core.evaluation.dao.EvaluationMapper.findEvaluationListCount", map,  pageNo, pageSize);
		return page;
	}*/

	@Override
	public List<Evaluation> findEvaluationListByPage(int pageno, int pagesize)
			throws Exception {
		EvaluationMapper mapper = this.getSqlSessionTemplate().getMapper(EvaluationMapper.class);
		int skip=(pageno-1)*pagesize;
		return mapper.findEvaluationListByPage(skip, pagesize);
	}
	@Override
	public int findEvaluationListCount() throws Exception {
		EvaluationMapper mapper = this.getSqlSessionTemplate().getMapper(EvaluationMapper.class);
		return mapper.findEvaluationListCount();
	}

	@Override
	public int deleteEvaluationById(String eid) throws Exception {
		EvaluationMapper mapper = this.getSqlSessionTemplate().getMapper(EvaluationMapper.class);
		return mapper.deleteEvaluationById(eid);
	}

	@Override
	public List<Evaluation> findTop20EvaluationByEid(String vid)
			throws Exception {
		EvaluationMapper mapper = this.getSqlSessionTemplate().getMapper(EvaluationMapper.class);
		return mapper.findTop20EvaluationByEid(vid);
	}

	@Override
	public int insertEvaluation(Evaluation e) throws Exception {
		EvaluationMapper mapper = this.getSqlSessionTemplate().getMapper(EvaluationMapper.class);
		return mapper.insertEvaluation(e);
	}

}
