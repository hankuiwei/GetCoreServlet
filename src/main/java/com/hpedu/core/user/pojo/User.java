package com.hpedu.core.user.pojo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class User {

	private String uid;
	private String userName;
	private String passWord;
	private String phoneNo;
	private String isVip;//是否vip：0：普通用户；1：vip用户（学生家长视频分时段免费）；2：后台管理员；3：后台超级管理员
	private String email;
	private String headImgUrl;
	private Date regTime;
	private Date lastLoginTime;
	private Long learnTime;//学习时长
	
	
	//新增字段
	private Integer type;//登录人身份类型：0：普通用户；1：学生家长
	private Integer status;//状态：1：已审核；0：未审核
	private String freeType;//免费类型:半年、一年
	private Date endTime;//免费到期时间
	private String rightContent;//权限内容
	
	private Integer isused;//使用状态（0：未审核或普通用户；1：使用中；2：已过期）--专用于学生家长审核
	
	private String yqCode;//自己的邀请码内容
	private String yqCodeUrl;//自己的邀请码图片（用于分享）
	private String usedCode;//当前用户注册使用的邀请码
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getIsVip() {
		return isVip;
	}
	public void setIsVip(String isVip) {
		this.isVip = isVip;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHeadImgUrl() {
		return headImgUrl;
	}
	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}
	public String getRegTime() {
		
		return regTime==null?null:format.format(regTime);
	}
	public void setRegTime(Date regTime) {
		this.regTime = regTime;
	}
	public String getLastLoginTime() {
		return lastLoginTime==null?null:format.format(lastLoginTime);
	}
	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String  getEndTime() {
		return endTime==null?null:format.format(endTime);
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getFreeType() {
		return freeType;
	}
	public void setFreeType(String freeType) {
		this.freeType = freeType;
	}
	public Long getLearnTime() {
		return learnTime;
	}
	public void setLearnTime(Long learnTime) {
		this.learnTime = learnTime;
	}
	public Integer getIsused() {
		return isused;
	}
	public void setIsused(Integer isused) {
		this.isused = isused;
	}
	public String getRightContent() {
		return rightContent;
	}
	public void setRightContent(String rightContent) {
		this.rightContent = rightContent;
	}
	public String getYqCode() {
		return yqCode;
	}
	public void setYqCode(String yqCode) {
		this.yqCode = yqCode;
	}
	public String getYqCodeUrl() {
		return yqCodeUrl;
	}
	public void setYqCodeUrl(String yqCodeUrl) {
		this.yqCodeUrl = yqCodeUrl;
	}
	public String getUsedCode() {
		return usedCode;
	}
	public void setUsedCode(String usedCode) {
		this.usedCode = usedCode;
	}
	
	
	
}
