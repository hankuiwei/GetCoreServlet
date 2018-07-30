package com.hpedu.core.teacher.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.hpedu.core.teacher.dao.TeacherMapper;
import com.hpedu.core.teacher.pojo.Teacher;
import com.hpedu.core.teacher.service.TeacherService;
import com.hpedu.util.mybatis.MyBatisBase;
import com.hpedu.util.mybatis.Page;

@Service
public class TeacherServiceImpl extends MyBatisBase implements TeacherService{

	@Override
	public List<Teacher> findAllTeacher(Map<String,Object> param) throws Exception {
		TeacherMapper mapper = this.getSqlSessionTemplate().getMapper(TeacherMapper.class);
		List<Teacher> tlist = mapper.findAllTeacher(param);
		return tlist;
	}
	@Override
	public Page<Teacher> getAllTeacher(Map<String, Object> param,int pageNo, int pageSize)
			throws Exception {
		Page<Teacher> page = this.queryPage("com.hpedu.core.teacher.dao.TeacherMapper.getAllTeacher",
				 "com.hpedu.core.teacher.dao.TeacherMapper.searchTeacherListCount", param,  pageNo, pageSize);
		return page;
	}
	@Override
	public Teacher findTeacherById(String id) throws Exception {
		TeacherMapper mapper = this.getSqlSessionTemplate().getMapper(TeacherMapper.class);
		Teacher teacher = mapper.findTeacherById(id);
		return teacher;
	}

	@Override
	public void updateTeacher(Teacher teacher) throws Exception {
		TeacherMapper mapper = this.getSqlSessionTemplate().getMapper(TeacherMapper.class);
		mapper.updateTeacher(teacher);
	}

	@Override
	public void deleteTeacherById(String id) throws Exception {
		TeacherMapper mapper = this.getSqlSessionTemplate().getMapper(TeacherMapper.class);
		mapper.deleteTeacherById(id);
	}

	@Override
	public void addTeacher(Teacher teacher) throws Exception {
		TeacherMapper mapper = this.getSqlSessionTemplate().getMapper(TeacherMapper.class);
		mapper.addTeacher(teacher);
	}

	@Override
	public int updateTeacherSort(String tid, String sort) {
		TeacherMapper mapper = this.getSqlSessionTemplate().getMapper(TeacherMapper.class);
		return mapper.updateTeacherSort(tid, sort);
	}

	@Override
	public Teacher findTeacherByName(String tname) throws Exception {
		TeacherMapper mapper = this.getSqlSessionTemplate().getMapper(TeacherMapper.class);
		return mapper.findTeacherByName(tname);
	}

	@Override
	public Page<Teacher> searchTeacherList(Map<String, String> map, int pageNo,
			int pageSize) throws Exception {
		Page<Teacher> page =this.queryPage("com.hpedu.core.teacher.dao.TeacherMapper.findTeacherByPage",
				"com.hpedu.core.teacher.dao.TeacherMapper.searchTeacherListCount", map, pageNo, pageSize);
		return page;
	}
	@Override
	public List<Map<String,String>> getCourse(String tname) {
		TeacherMapper mapper = this.getSqlSessionTemplate().getMapper(TeacherMapper.class);
		
		return mapper.getCourse(tname);
	}
	@Override
	public List<Teacher> getIndexTeacher( List<String> list) {
		TeacherMapper mapper = this.getSqlSessionTemplate().getMapper(TeacherMapper.class);
		return mapper.getIndexTeacher(list);
	}

	
}
