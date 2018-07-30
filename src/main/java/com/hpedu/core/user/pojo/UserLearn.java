package com.hpedu.core.user.pojo;
//用户学习时间表
public class UserLearn {
private String	ulid ;
private String userid;//用户id
private String	vid;// 视频id
private Integer	vctype;// 视频类型:0:常规；1：竞赛
private Long	learnTime ;// 学习时长
private String	learnDate ;// 学习日期
public String getUlid() {
	return ulid;
}
public void setUlid(String ulid) {
	this.ulid = ulid;
}
public String getUserid() {
	return userid;
}
public void setUserid(String userid) {
	this.userid = userid;
}
public String getVid() {
	return vid;
}
public void setVid(String vid) {
	this.vid = vid;
}
public Integer getVctype() {
	return vctype;
}
public void setVctype(Integer vctype) {
	this.vctype = vctype;
}
public Long getLearnTime() {
	return learnTime;
}
public void setLearnTime(Long learnTime) {
	this.learnTime = learnTime;
}
public String getLearnDate() {
	return learnDate;
}
public void setLearnDate(String learnDate) {
	this.learnDate = learnDate;
}


}
