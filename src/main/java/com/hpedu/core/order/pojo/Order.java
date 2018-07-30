package com.hpedu.core.order.pojo;


import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 订单 
 * */
public class Order {
	private String oid;//主键
	private String omoney;//支付金额
	private Date ocreatTime;//创建时间
	private Date opayTime;// 支付时间
	private String oisPay;//是否支付
	private String orderNo;//订单编号
	private String uid;//购买者ID
	private String vid;//视频id
	private String vclassify;//视频所属分类 0常规 1竞赛 
	private String payStyle;//支付方式
	private Integer isKill;//是否秒杀支付
	
	//关联显示的字段
	private String userName;//购买者
	private String gname;//常规视频名称
	private String cname;//竞赛视频名称
	private Integer isUsed;//是否有效：1：有效；0：过期
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
	public String getOmoney() {
		return omoney;
	}
	public void setOmoney(String omoney) {
		this.omoney = omoney;
	}
	public Date getOcreatTime() {
		return ocreatTime;
	}
	public void setOcreatTime(Date ocreatTime) {
		this.ocreatTime = ocreatTime;
	}
	public String getOpayTime() {
		String returnStr="";
		if(opayTime!=null){
			SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd");
		   returnStr=sim.format(opayTime).toString();
		}
		return returnStr;
	}
	public void setOpayTime(Date opayTime) {
		this.opayTime = opayTime;
	}
	public String getOisPay() {
		return oisPay;
	}
	public void setOisPay(String oisPay) {
		this.oisPay = oisPay;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
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
	public String getVclassify() {
		return vclassify;
	}
	public void setVclassify(String vclassify) {
		this.vclassify = vclassify;
	}
	public String getPayStyle() {
		return payStyle;
	}
	public void setPayStyle(String payStyle) {
		this.payStyle = payStyle;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public Integer getIsKill() {
		return isKill;
	}
	public void setIsKill(Integer isKill) {
		this.isKill = isKill;
	}
	public Integer getIsUsed() {
		return isUsed;
	}
	public void setIsUsed(Integer isUsed) {
		this.isUsed = isUsed;
	}

}
