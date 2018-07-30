package com.hpedu.core.order.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hpedu.core.order.dao.OrderMapper;
import com.hpedu.core.order.pojo.ArticleImg;
import com.hpedu.core.order.pojo.Banner;
import com.hpedu.core.order.pojo.Order;
import com.hpedu.core.order.service.OrderService;
import com.hpedu.util.mybatis.MyBatisBase;
@Service
public class OrderServiceImpl extends MyBatisBase implements OrderService {
	/*@Override
	public Page<Order> findOrderListByPage(Map<String, String> map, int pageNo,
			int pageSize) throws Exception {
		 Page<Order> page = this.queryPage("com.hpedu.core.order.dao.OrderMapper.findOrderListByPage",
				 "com.hpedu.core.order.dao.OrderMapper.findOrderListListCount", map,  pageNo, pageSize);
		return page;
	}*/
	@Override
	public List<Order> findOrderListByPage(int pageno, int pagesize)
			throws Exception {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		int skip=(pageno-1)*pagesize;
		return mapper.findOrderListByPage(skip, pagesize);
	}
	@Override
	public int findOrderListCount() throws Exception {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.findOrderListCount();
	}
	@Override
	public List<Order> findAllOrderByUserId(String uid) throws Exception {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.findAllOrderByUserId(uid);
	}
	@Override
	public String getMaxOrderNoByOrderNoPre(String prev) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.getMaxOrderNoByOrderNoPre(prev);
	}
	@Override
	public int getIsBuyVideoByVid(String vid, String vclassify, String uid) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.getIsBuyVideoByVid(vid, vclassify, uid);
	}
	@Override
	public int insertOrder(Order o) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.insertOrder(o);
	}
	@Override
	public int updateOrderPayStatus(String orderNo) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.updateOrderPayStatus(orderNo);
	}
	@Override
	public Order findOrderByOid(String oid) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.findOrderByOid(oid);
	}
	@Override
	public List<Order> findOrderByParams(String uid, String vid,
			String vclassify,String oisPay) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.findOrderByParams(uid, vid, vclassify,oisPay);
	}
	@Override
	public Order findOrderByOrderNo(String orderNo) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.findOrderByOrderNo(orderNo);
	}
	@Override
	public List<Banner> selectAllBanner() {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.selectAllBanner();
	}
	@Override
	public int insertBanner(Banner b) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.insertBanner(b);
	}
	@Override
	public int deleteBanner(String bid) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.deleteBanner(bid);
	}
	@Override
	public int updateBannerSort(String bid, String sort) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.updateBannerSort(bid, sort);
	}
	@Override
	public Banner findBannerByBid(String bid) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.findBannerByBid(bid);
	}
	@Override
	public int updateBanner(Banner b) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.updateBanner(b);
	}
	@Override
	public int updateOrderPayMoney(String orderId, String money,String orderNo,String bodyDes) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.updateOrderPayMoney(orderId, money,orderNo,bodyDes);
	}
	@Override
	public int insertArticleImgs(List<ArticleImg> list) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.insertArticleImgs(list);
	}
	@Override
	public int deleteArticleImgs(String[] list) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.deleteArticleImgs(list);
	}
	@Override
	public List<ArticleImg> selectArticleImgByBid(String bid) {
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.selectArticleImgByBid(bid);
	}
	@Override
	public List<Banner> getPublicBanner() {
		// TODO Auto-generated method stub selectAllBanner
		OrderMapper mapper=this.getSqlSessionTemplate().getMapper(OrderMapper.class);
		return mapper.getPublicBanner();
	}

	

}
