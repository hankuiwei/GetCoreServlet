package com.hpedu.core.exam.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hpedu.core.exam.dao.ExamMapper;
import com.hpedu.core.exam.pojo.Exam;
import com.hpedu.core.exam.pojo.ExamImg;
import com.hpedu.core.exam.service.ExamService;
import com.hpedu.util.mybatis.MyBatisBase;
import com.hpedu.util.mybatis.Page;

@Service
public class ExamServiceImpl extends MyBatisBase implements ExamService{

	@Override
	public Page<Exam> findExamListByMap(Map<String, String> map,int pageNo,int pageSize) throws Exception {
		
		Page<Exam> pages = this.queryPage("com.hpedu.core.exam.dao.ExamMapper.findExamListByMap",
			"com.hpedu.core.exam.dao.ExamMapper.findExamListByMapCount", map, pageNo, pageSize);
		return pages;
	}

	@Override
	public Exam findExamByEtid(String etid) throws Exception {
		ExamMapper mapper = this.getSqlSessionTemplate().getMapper(ExamMapper.class);
		Exam exam = mapper.findExamByEtid(etid);
		return exam;
	}

	@Override
	public void deleteExamById(String etId) throws Exception {
		ExamMapper mapper = this.getSqlSessionTemplate().getMapper(ExamMapper.class);
		mapper.deleteExamById(etId);
	}

	@Override
	public void updateExam(Exam exam) throws Exception {
		ExamMapper mapper = this.getSqlSessionTemplate().getMapper(ExamMapper.class);
		mapper.updateExam(exam);
	}

	@Override
	public void addExam(Exam exam) throws Exception {
		ExamMapper mapper = this.getSqlSessionTemplate().getMapper(ExamMapper.class);
		mapper.addExam(exam);
	}

	@Override
	public int insertExamImgs(List<ExamImg> list) {
		ExamMapper mapper = this.getSqlSessionTemplate().getMapper(ExamMapper.class);
		return mapper.insertExamImgs(list);
	}

	@Override
	public int deleteExamImgs(String[] list) {
		ExamMapper mapper = this.getSqlSessionTemplate().getMapper(ExamMapper.class);
		return mapper.deleteExamImgs(list);
	}

	@Override
	public List<ExamImg> selectExamImgByExid(String ExamImg) {
		ExamMapper mapper = this.getSqlSessionTemplate().getMapper(ExamMapper.class);
		return mapper.selectExamImgByExid(ExamImg);
	}

	@Override
	public void updateLearnCount(String etid) {
		ExamMapper mapper = this.getSqlSessionTemplate().getMapper(ExamMapper.class);
		mapper.updateLearnCount(etid);
	}
}
