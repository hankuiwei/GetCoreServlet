package com.hpedu.core.order.pojo;
//首页轮播图
public class Banner {
private String	bid;
private String	  title;// 标题
private String	  content;// 图片说明
private String	  imgUrl;// 图片路径
private String	  sort;//顺序-时间戳
private String   article;//文章

//公众号首页图 添加属性
private String category ;//跟页面跳转相关的属性 - 课名
private String subject ;//跟页面跳转相关的属性 - 科目
private String grade ;//跟页面跳转相关的属性 - 科目
private String classify ;//跟页面跳转相关的属性 - 科目

private Integer belong ;//轮播图所属的项目




public String getCategory() {
	return category;
}
public void setCategory(String category) {
	this.category = category;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public String getGrade() {
	return grade;
}
public void setGrade(String grade) {
	this.grade = grade;
}
public String getClassify() {
	return classify;
}
public void setClassify(String classify) {
	this.classify = classify;
}
public Integer getBelong() {
	return belong;
}
public void setBelong(Integer belong) {
	this.belong = belong;
}
public String getBid() {
	return bid;
}
public void setBid(String bid) {
	this.bid = bid;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getImgUrl() {
	return imgUrl;
}
public void setImgUrl(String imgUrl) {
	this.imgUrl = imgUrl;
}
public String getSort() {
	return sort;
}
public void setSort(String sort) {
	this.sort = sort;
}
public String getArticle() {
	return article;
}
public void setArticle(String article) {
	this.article = article;
}

}
