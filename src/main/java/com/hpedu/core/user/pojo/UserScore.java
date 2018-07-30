package com.hpedu.core.user.pojo;
//用户章节测试分数
public class UserScore {
private String	usid;
private String	  uid;// 关联用户id
private String	  vid ;//关联视频id
private int	  utype ;//视频类型：0：单个常规；1：单个竞赛；2：多集常规；3：多集竞赛
private String	  ucreateTime ;//创建时间
private int	  score ;// 选择题得分
private int rightNum;//正确个数
private int errorNum;//错误个数

private String totalScores;//题目总分
private String totalNums;//题目总数
private Integer	  JDTscore ;// 简答题得分
private Integer	  gotScore ;// 总得分
private Integer isHasJDT;//是否含有简答题（0/null：没有，1：只有简答题；2：简答题和选择题）
private String teacherName;//批改教师
public String getUsid() {
	return usid;
}
public void setUsid(String usid) {
	this.usid = usid;
}
public String getUid() {
	return uid;
}
public void setUid(String uid) {
	this.uid = uid;
}
public String getVid() {
	return vid;
}
public void setVid(String vid) {
	this.vid = vid;
}
public int getUtype() {
	return utype;
}
public void setUtype(int utype) {
	this.utype = utype;
}
public String getUcreateTime() {
	return ucreateTime;
}
public void setUcreateTime(String ucreateTime) {
	this.ucreateTime = ucreateTime;
}
public int getScore() {
	return score;
}
public void setScore(int score) {
	this.score = score;
}
public int getRightNum() {
	return rightNum;
}
public void setRightNum(int rightNum) {
	this.rightNum = rightNum;
}
public int getErrorNum() {
	return errorNum;
}
public void setErrorNum(int errorNum) {
	this.errorNum = errorNum;
}
public String getTotalScores() {
	return totalScores;
}
public void setTotalScores(String totalScores) {
	this.totalScores = totalScores;
}
public String getTotalNums() {
	return totalNums;
}
public void setTotalNums(String totalNums) {
	this.totalNums = totalNums;
}
public Integer getJDTscore() {
	return JDTscore;
}
public void setJDTscore(Integer jDTscore) {
	JDTscore = jDTscore;
}
public Integer getGotScore() {
	return gotScore;
}
public void setGotScore(Integer gotScore) {
	this.gotScore = gotScore;
}
public Integer getIsHasJDT() {
	return isHasJDT;
}
public void setIsHasJDT(Integer isHasJDT) {
	this.isHasJDT = isHasJDT;
}
public String getTeacherName() {
	return teacherName;
}
public void setTeacherName(String teacherName) {
	this.teacherName = teacherName;
}

}
