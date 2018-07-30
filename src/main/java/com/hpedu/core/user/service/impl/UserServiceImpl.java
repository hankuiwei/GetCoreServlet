package com.hpedu.core.user.service.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.hpedu.core.user.dao.UserMapper;
import com.hpedu.core.user.pojo.ErrorExam;
import com.hpedu.core.user.pojo.RightMenu;
import com.hpedu.core.user.pojo.UnitTest;
import com.hpedu.core.user.pojo.UnitTest_Choose;
import com.hpedu.core.user.pojo.User;
import com.hpedu.core.user.pojo.UserLearn;
import com.hpedu.core.user.pojo.UserLevel;
import com.hpedu.core.user.pojo.UserScore;
import com.hpedu.core.user.service.UserService;
import com.hpedu.util.BaseUtil;
import com.hpedu.util.FontImage;
import com.hpedu.util.mybatis.MyBatisBase;
import com.hpedu.util.mybatis.Page;

@Service
public class UserServiceImpl extends MyBatisBase implements UserService {

	@Override
	public User findUserByPhone(String userPhone, String passWord)
			throws Exception {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(
				UserMapper.class);
		User user = mapper.findUserByPhone(userPhone, passWord);
		return user;
	}

	@Override
	public User backUserLogin(Map<String, String> maps) throws Exception {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(
				UserMapper.class);
		User user = mapper.backUserLogin(maps);
		return user;
	}

	@Override
	public void addUser(User user) throws Exception {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.addUser(user);
	}

	@Override
	public void updateUserNews(User user) throws Exception {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.updateUserNews(user);
	}

	@Override
	public int getIsExitsByPhone(String phoneNo) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.getIsExitsByPhone(phoneNo);
	}

	@Override
	public User findUserByUid(String uid) throws Exception {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.findUserByUid(uid);
	}

	@Override
	public Page<User> searchUserList(Map<String, String> map, int pageNo,
			int pageSize) throws Exception {
		Page<User> page =this.queryPage("com.hpedu.core.user.dao.UserMapper.searchUserList",
				"com.hpedu.core.user.dao.UserMapper.searchUserListCount", map, pageNo, pageSize);
		return page;
	}

	@Override
	public List<User> searchUserList(Map<String, String> map) throws Exception {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.searchUserList(map);
	}

	@Override
	public int deleteUserById(String uid) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.deleteUserById(uid);
	}

	@Override
	public int getIsExitsByName(String userName) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.getIsExitsByName(userName);
	}

	@Override
	public List<UserLevel> selectAllLevel() {
			UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.selectAllLevel();
	}

	@Override
	public UserLevel selectLevelById(String ulid) {
			UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.selectLevelById(ulid);
	}

	@Override
	public void insertLevel(UserLevel ul) {
			UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
			mapper.insertLevel(ul);
	}

	@Override
	public void updateLevel(UserLevel ul) {
			UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
			mapper.updateLevel(ul);
	}

	@Override
	public int deleteLevel(String ulid) {
			UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.deleteLevel(ulid);
	}

	@Override
	public void updateLearnTotalTime(String uid, Long addtime) {
	UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
	mapper.updateLearnTotalTime(uid, addtime);
	}

	@Override
	public void insertLearnTimeByDay(UserLearn learn) {
	UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
	   mapper.insertLearnTimeByDay(learn);
	}

	@Override
	public String selectIsExitUserLearn(String uid, String vid, String vclassify) {
	UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.selectIsExitUserLearn(uid, vid, vclassify);
	}

	@Override
	public void updateLearnTimeByDay(UserLearn learn) {
	  UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
	  mapper.updateLearnTimeByDay(learn);
	}

	@Override
	public int getLearnVideoTotalCount(String userId) {
		 UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.getLearnVideoTotalCount(userId);
	}

	@Override
	public List<Map> findlearnListByPage(String userId, int pageno, int pagesize)
			throws Exception {
		 UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		int skip=(pageno-1)*pagesize;
		return mapper.findlearnListByPage(userId, skip, pagesize);
	}

	@Override
	public List<Map> getLearnTimeByUserId(String userId, String dateStr) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.getLearnTimeByUserId(userId, dateStr);
	}

	@Override
	public List<String> getYearByUserId(String userId) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.getYearByUserId(userId);
	}

	@Override
	public List<Map> selectVidoeTestAll(Map<String,Object> map) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.selectVidoeTestAll(map);
	}

	@Override
	public void insertUnitTest_Choose(List<UnitTest_Choose> list) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.insertUnitTest_Choose(list);
	}

	
	@Override
	public void updateUnitTest_Choose(List<UnitTest_Choose> list) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.updateUnitTest_Choose(list);
	}

	

	@Override
	public void delUnitTest_Choose(String[] list) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.delUnitTest_Choose(list);
	}

	@Override
	public void insertUserScore(UserScore us) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.insertUserScore(us);
	}

	@Override
	public void insertErrorExam(List<ErrorExam> list) {
	UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
	mapper.insertErrorExam(list);
	}

	@Override
	public void insertUnitTest(UnitTest u) {
	UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
	mapper.insertUnitTest(u);
	}

	@Override
	public void updateUnitTest(UnitTest u) {
	UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
	mapper.updateUnitTest(u);
	}

	@Override
	public void delUnitTest(String id) {
	UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
	mapper.delUnitTest(id);
	}

	@Override
	public List<Map> selectVidoeTestByUtid(String utid) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.selectVidoeTestByUtid(utid);
	}

	@Override
	public  List<Map>  getTotalUnitTests(String vid, int utype) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.getTotalUnitTests(vid, utype);
	}

	@Override
	public void updateUserScore(UserScore us) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.updateUserScore(us);
	}

	@Override
	public void updateErrorExam(List<ErrorExam> list) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.updateErrorExam(list);
	}

	@Override
	public Page searchUnitTestList(Map<String, Object> map, int pageno,
			int pagesize) throws Exception {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		int skip=(pageno-1)*pagesize;
		map.put("skip",skip);
		map.put("limit", pagesize);
		List<Map> list=mapper.searchUnitTestList(map);
		Page pages=new Page();
		pages.setResult(list);
		pages.setPageNo(pageno);
		pages.setPageSize(pagesize);
		pages.setTotalCount(mapper.searchUnitTestCount(map));
		return pages;
	}

	@Override
	public List<Map> getJDTScoresDetail(String usid) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.getJDTScoresDetail(usid);
	}

	@Override
	public List<RightMenu> selectRightMenu(String checkVal) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.selectRightMenu(checkVal);
	}

	@Override
	public void updatePwdByPhone(String phnone, String pwd) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.updatePwdByPhone( phnone,pwd);
	}

	@Override
	public void updateYQCodeByUserId(String uid, String yqcode, String yqCodeUrl) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		mapper.updateYQCodeByUserId(uid, yqcode, yqCodeUrl);
	}

	@Override
	public String[] getNewYQCode(int codeLen,HttpServletRequest request,String uploadAbsolutePath) {
		String yqcode=BaseUtil.random(codeLen);//随机生成邀请码
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		User user=mapper.getUserByYQCode(yqcode);
		if(user!=null){
			return getNewYQCode(codeLen,request,uploadAbsolutePath);
		}
		//生成邀请码图片 
		String path=BaseUtil.getServerPath(request,"yqCode","",uploadAbsolutePath);
		String yqCodeUrl="/yqCode/";
		try {
			yqCodeUrl+=FontImage.getImage(yqcode, path);
		} catch (IOException e) {
			System.out.println("生成邀请码异常："+e.getMessage());
		}
		return new String[]{yqcode,yqCodeUrl};
	}

	@Override
	public User getUserByYQCode(String yqcode) {
		UserMapper mapper = this.getSqlSessionTemplate().getMapper(UserMapper.class);
		return mapper.getUserByYQCode(yqcode);
	}
}
