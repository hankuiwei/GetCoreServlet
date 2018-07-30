package com.hpedu.core.order.dao;

import java.util.List;

import com.hpedu.core.order.pojo.ArticleImg;
import com.hpedu.core.order.pojo.Banner;
import com.hpedu.core.order.pojo.Order;

public interface OrderMapper {
	
	/**
	 * 查询该用户所有购买记录
	 * */
	List<Order> findAllOrderByUserId(String uid)throws Exception;
	/**
	 * 订单查看(分页)
	 * 
	 * */
	/*List<Order>  findOrderListByPage(Map<String, String> map) throws Exception;
	int findOrderListCount(Map<String, String> map)throws Exception;*/
	List<Order>  findOrderListByPage(int skip,int limit) throws Exception;
	int findOrderListCount()throws Exception;
	/**
	 * 获取最大订单号
	 * 
	 * */
	String getMaxOrderNoByOrderNoPre(String prev);
	/**
	 *检查用户是否购买过某视频
	 * 
	 * */
	int getIsBuyVideoByVid(String vid,String vclassify,String uid );
	/**
	 *新增订单
	 * 
	 * */
	int insertOrder(Order o);
	/**
	 *修改订单支付状态
	 * 
	 * */
	int updateOrderPayStatus(String orderNo);
	/**
	 *修改订单支付价格
	 * 
	 * */
	int updateOrderPayMoney(String orderId,String money,String orderNo,String bodyDes);
	/**
	 *根据订单id查询订单
	 * 
	 * */
	Order findOrderByOid(String oid);
	/**
	 *根据用户id、vid、vclassify、oisPay查询订单
	 * 
	 * */
	List<Order> findOrderByParams(String uid,String vid,String vclassify,String oisPay);
	/**
	 *根据订单号查询订单
	 * 
	 * */
	Order findOrderByOrderNo(String orderNo);
	/**
	 *  查询所有首页轮播图
	 * 
	 * */
    List<Banner> selectAllBanner();	
    /**
	 *  新增首页轮播图
	 * 
	 * */
    int insertBanner(Banner b);
    /**
   	 *  删除首页轮播图
   	 * 
   	 * */
    int deleteBanner(String  bid);
    /**
   	 *  修改首页轮播图顺序
   	 * 
   	 * */
    int updateBannerSort(String  bid,String sort);
    /**
	 *  根据id查询首页轮播图
	 * 
	 * */
    Banner findBannerByBid(String  bid);	
    /**
   	 *  修改首页轮播图
   	 * 
   	 * */
    int updateBanner(Banner b);
    
    /**
	 * 批量新增轮播图文章图片
	 * 
	 * */
	int  insertArticleImgs(List<ArticleImg> list);
	/**
	 * 批量删除轮播图文章图片
	 * 
	 * */
	int  deleteArticleImgs(String[] list);
	
	List<ArticleImg> selectArticleImgByBid(String bid);
	/**
	 * 获取公众号轮播图
	 * @return
	 */
	List<Banner> getPublicBanner();
}
