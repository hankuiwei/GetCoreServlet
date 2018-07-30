package com.hpedu.core.publicTest.pojo;

import java.util.Date;
import java.util.List;

public class Test {
	private String id;
	private String testPointId;// 考点id
	private Date createTime;// 创建时间
	private String testTitle;// 题目内容
	private int score;// 每题分数
	private String testAnswer;// 题目答案
	private String testDetail; // 详解
	private int testType; // 测验题目类型：0/null：选择题；1：简答题
	private int isMoreChoose;// 是否多选题
	
//	private String grade ;
//	private String pointName ;
	
	/*<result column="grade" property="grade"  jdbcType="VARCHAR"/>
	<result column="pointName" property="pointName"  jdbcType="VARCHAR"/>*/
	
	
	private TestPoint testPoint ;
	private List<TestOption> testOptionList ;
	
	
	
	
	public List<TestOption> getTestOptionList() {
		return testOptionList;
	}
	public void setTestOptionList(List<TestOption> testOptionList) {
		this.testOptionList = testOptionList;
	}
	public TestPoint getTestPoint() {
		return testPoint;
	}
	public void setTestPoint(TestPoint testPoint) {
		this.testPoint = testPoint;
	}
	public String getId() {
		return id;
	}
//	public String getGrade() {
//		return grade;
//	}
//	public void setGrade(String grade) {
//		this.grade = grade;
//	}
//	public String getPointName() {
//		return pointName;
//	}
//	public void setPointName(String pointName) {
//		this.pointName = pointName;
//	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTestPointId() {
		return testPointId;
	}
	public void setTestPointId(String testPointId) {
		this.testPointId = testPointId;
	}
	
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getTestTitle() {
		return testTitle;
	}
	public void setTestTitle(String testTitle) {
		this.testTitle = testTitle;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getTestAnswer() {
		return testAnswer;
	}
	public void setTestAnswer(String testAnswer) {
		this.testAnswer = testAnswer;
	}
	public String getTestDetail() {
		return testDetail;
	}
	public void setTestDetail(String testDetail) {
		this.testDetail = testDetail;
	}
	public int getTestType() {
		return testType;
	}
	public void setTestType(int testType) {
		this.testType = testType;
	}
	public int getIsMoreChoose() {
		return isMoreChoose;
	}
	public void setIsMoreChoose(int isMoreChoose) {
		this.isMoreChoose = isMoreChoose;
	}
	
	
	

}
