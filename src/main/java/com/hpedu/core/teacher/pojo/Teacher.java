package com.hpedu.core.teacher.pojo;

import com.hpedu.util.HanyuPinyinHelper;

public class Teacher {
	private String tid;
	private String tname;
	private String tintro;
	private String timgUrl;
	private String backImg;
	
	private String sort;//顺序-时间戳
	private String subject;//教授科目
	private int nums;//未批改试卷数
	private Integer isShow;//是否显示
	
	private String tnamePinyin;//教师名称全拼
	
	public Integer getIsShow() {
		return isShow;
	}
	public void setIsShow(Integer isShow) {
		this.isShow = isShow;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getTintro() {
		return tintro;
	}
	public void setTintro(String tintro) {
		this.tintro = tintro;
	}
	public String getTimgUrl() {
		return timgUrl;
	}
	public void setTimgUrl(String timgUrl) {
		this.timgUrl = timgUrl;
	}
	
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getBackImg() {
		return backImg;
	}
	public void setBackImg(String backImg) {
		this.backImg = backImg;
	}
	public int getNums() {
		return nums;
	}
	public void setNums(int nums) {
		this.nums = nums;
	}
	public String getTnamePinyin() {
		if(tname!=null){
			return HanyuPinyinHelper.toHanyuPinyin(tname);
		}
		return tnamePinyin;
	}
	public void setTnamePinyin(String tnamePinyin) {
		this.tnamePinyin = tnamePinyin;
	}
	
}
