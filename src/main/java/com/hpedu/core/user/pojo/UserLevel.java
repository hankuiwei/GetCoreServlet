package com.hpedu.core.user.pojo;
//用户等级表
public class UserLevel {
private String	ulid ;
private Integer	  level ;// 等级
private String	  des ;//等级描述
private Long	  minNum;// 下限
private Long	  maxNum;// 上限
public String getUlid() {
	return ulid;
}
public void setUlid(String ulid) {
	this.ulid = ulid;
}
public Integer getLevel() {
	return level;
}
public void setLevel(Integer level) {
	this.level = level;
}
public String getDes() {
	return des;
}
public void setDes(String des) {
	this.des = des;
}
public Long getMinNum() {
	return minNum;
}
public void setMinNum(Long minNum) {
	this.minNum = minNum;
}
public Long getMaxNum() {
	return maxNum;
}
public void setMaxNum(Long maxNum) {
	this.maxNum = maxNum;
}


}
