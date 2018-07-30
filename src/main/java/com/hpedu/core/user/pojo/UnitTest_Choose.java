package com.hpedu.core.user.pojo;
//视频章节测试题选项
public class UnitTest_Choose {
private String	csid ;
private String	 utid ;// 关联单元测试题id
private String	 tcontent;//选择题内容
private Long	 sort ;// 顺序
private String tanswer;//选项的值
public String getCsid() {
	return csid;
}
public void setCsid(String csid) {
	this.csid = csid;
}
public String getUtid() {
	return utid;
}
public void setUtid(String utid) {
	this.utid = utid;
}
public String getTcontent() {
	return tcontent;
}
public void setTcontent(String tcontent) {
	this.tcontent = tcontent;
}

public String getTanswer() {
	return tanswer;
}
public void setTanswer(String tanswer) {
	this.tanswer = tanswer;
}
public Long getSort() {
	return sort;
}
public void setSort(Long sort) {
	this.sort = sort;
}



}
