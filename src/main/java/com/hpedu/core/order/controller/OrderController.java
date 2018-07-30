package com.hpedu.core.order.controller;

import java.io.InputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hpedu.core.order.pojo.ArticleImg;
import com.hpedu.core.order.pojo.Banner;
import com.hpedu.core.order.pojo.Order;
import com.hpedu.core.order.service.OrderService;
import com.hpedu.core.user.pojo.User;
import com.hpedu.core.video.pojo.ContestVideo;
import com.hpedu.core.video.pojo.GeneralVideo;
import com.hpedu.core.video.service.ContestVideoService;
import com.hpedu.core.video.service.GeneralVideoService;
import com.hpedu.core.wxpay.service.WxPayService;
import com.hpedu.core.wxpay.util.WechatPayUtil;
import com.hpedu.util.BaseUtil;
import com.hpedu.util.PrintHelper;
import com.hpedu.util.StringUtil;
import com.hpedu.util.UUIDUtil;
import com.hpedu.util.mybatis.Page;

@Controller
@RequestMapping("/")
public class OrderController {
	@Resource
	OrderService orderService;
	@Resource
	ContestVideoService contestVideoService;
	@Resource
	GeneralVideoService generalVideoService;
	@Resource
	WxPayService WxPayService;
	private Logger log = BaseUtil.getLogger(OrderController.class);

	@RequestMapping("/order/checkOrdersByUid.html")
	public void searchAllOrder(HttpServletRequest req, HttpSession session,
			Model model) throws Exception {
		User user = (User) session.getAttribute("user");
		if (user != null) {
			List<Order> olist = null;
			try {
				olist = orderService.findAllOrderByUserId(user.getUid());
			} catch (Exception e) {
				log.info("查看用户订单信息出错:", e);
				olist = new ArrayList<Order>();
			}
			model.addAttribute("olist", olist);
		} else {
			model.addAttribute("msg", "您还没有登录！");
		}
	}
	
	@RequestMapping("/public/purchaseRecord")
	public void getAllOrderByUid(HttpServletRequest req, HttpSession session,
			Model model) throws Exception {
		User user = (User) session.getAttribute("user");
		if (user != null) {
			List<Order> olist = null;
			try {
				olist = orderService.findAllOrderByUserId(user.getUid());
			} catch (Exception e) {
				log.info("查看用户订单信息出错:", e);
				olist = new ArrayList<Order>();
			}
			model.addAttribute("olist", olist);
		} else {
			model.addAttribute("msg", "您还没有登录！");
		}
	}
	

	// 订单查看
	@RequestMapping("/back/orderCheck.html")
	public void orderCheck(HttpServletRequest req, HttpSession session,
			Model model) throws Exception {
		int pageNo = 0;
		int pageSize = 20;
		if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		// Map<String,String>maps = new HashMap<String,String>();
		// Page<Order>pages = orderService.findOrderListByPage(maps, pageNo,
		// pageSize);
		List<Order> list = null;
		int totalCount = 0;
		try {
			list = orderService.findOrderListByPage(pageNo, pageSize);
			totalCount = orderService.findOrderListCount();
		} catch (Exception e) {
			log.info("分页查看用户订单信息出错:", e);
			list = new ArrayList<Order>();
		}
		Page pages = new Page();
		pages.setResult(list);
		pages.setPageNo(pageNo);
		pages.setPageSize(pageSize);
		pages.setTotalCount(totalCount);
		model.addAttribute("pages", pages);

	}

	// 视频检索
	@RequestMapping("/order/searchVideo.html")
	public void searchAllOrder(HttpServletRequest req, Model model,
			String keyword) throws Exception {
		StringBuffer error = new StringBuffer();
		List<GeneralVideo> glist = null;
		List<ContestVideo> clist = null;
		try {
			glist = generalVideoService.searchGeneralVideoListByGname(keyword);
		} catch (Exception e) {
			error.append("常规视频查询失败：" + e.getMessage() + ";");
			glist = new ArrayList<GeneralVideo>();
		}
		try {
			clist = contestVideoService.searchContestVideoListByCname(keyword);
		} catch (Exception e) {
			error.append("竞赛视频查询失败：" + e.getMessage() + ";");
			clist = new ArrayList<ContestVideo>();
		}
		if (error.length() > 0) {
			log.error("首页视频关键词检索出错：" + error.toString());
		}
		model.addAttribute("glist", glist);
		model.addAttribute("clist", clist);

	}
	
	// 视频检索
	@RequestMapping("/searchVideo")
	public ModelAndView searchVideo(HttpServletRequest req, Model model, String keyword) throws Exception {
		ModelAndView view = new ModelAndView("public/searchVideoList");
		StringBuffer error = new StringBuffer();
		List<GeneralVideo> glist = null;
		List<ContestVideo> clist = null;
		String decode_String =  java.net.URLDecoder.decode(keyword,"UTF-8");//需要抛异常
		try {
			glist = generalVideoService.searchGeneralVideoListByGname(decode_String);
		} catch (Exception e) {
			error.append("常规视频查询失败：" + e.getMessage() + ";");
			glist = new ArrayList<GeneralVideo>();
		}
		try {
			clist = contestVideoService.searchContestVideoListByCname(decode_String);
		} catch (Exception e) {
			error.append("竞赛视频查询失败：" + e.getMessage() + ";");
			clist = new ArrayList<ContestVideo>();
		}
		if (error.length() > 0) {
			log.error("首页视频关键词检索出错：" + error.toString());
		}
		view.addObject("glist", glist);
		view.addObject("clist", clist);
		return view;
	}

	// 分页查询更多视频
	@RequestMapping("/order/showAllVideo.html")
	public void showAllVideo(HttpServletRequest req, Model model, Integer type)
			throws Exception {
		Map<String, String> maps = new HashMap<String, String>();
		int pageNo = 0;
		int pageSize = 8;
		if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		if (type == 0) {// 分页查常规
			Page<GeneralVideo> pages = null;
			try {
				pages = generalVideoService.searchGeneralVideoList(maps,
						pageNo, pageSize);
			} catch (Exception e) {
				pages = new Page<GeneralVideo>();
				pages.setResult(new ArrayList<GeneralVideo>());
				log.error("分页查询常规课程失败了", e);
			}
			model.addAttribute("pages", pages);

		} else if (type == 1) {// 分页查竞赛
			Page<ContestVideo> pages = null;
			try {
				pages = contestVideoService.searchContestVideoList(maps,
						pageNo, pageSize);
			} catch (Exception e) {
				pages = new Page<ContestVideo>();
				pages.setResult(new ArrayList<ContestVideo>());
				log.error("分页查询常规课程失败了", e);
			}
			model.addAttribute("pages", pages);
		}
		model.addAttribute("type", type);
	}

	
	// 生成订单号和二维码
	@RequestMapping("/order/getErweimaImg")
	public void getErweimaImg(HttpServletRequest req,
			HttpServletResponse response, String vid, String vclassify,
			String uid) throws Exception {
		String code_url2 = "";
		String omoney = "0";// 支付金额
		Map<String, Object> resMap = new HashMap<String, Object>();
		try {
			// 先查询该用户是否已经生成该订单未支付
			List<Order> olist = null;
			try {
				olist = orderService.findOrderByParams(uid, vid, vclassify, "0");
			} catch (Exception e) {
				olist = new ArrayList<Order>();
				log.error("先查询该用户是否已经生成该订单未支付失败：", e);
			}
			Order order = null;
			String orderNo = null;
			String bodyDes = "";
			String oldMoney = "0";// 原价
			String killMoney = "0";// 秒杀价
			Integer isKill = 0;// 是否杀价
			String killStartTime = "";// 秒杀开始时间
			String killEndTime = "";// 秒杀截止时间

			Map<String, Object> killInfo = null;
			if (vclassify.equals("0")) {// 常规
				try {
					GeneralVideo g = generalVideoService
							.findGeneralVideoByVid(vid);
					oldMoney = g.getGmoney() == null ? "0" : g.getGmoney();

					killMoney = g.getKillMoney() == null ? "0" : g
							.getKillMoney();
					isKill = g.getIsKill();
					killStartTime = g.getKillStartTime();
					killEndTime = g.getKillEndTime();
					String gclass = g.getGclass();
					gclass = gclass == null ? "" : gclass;
					if (gclass.indexOf("古诗") > -1 || gclass.indexOf("阅读") > -1
							|| gclass.indexOf("写作") > -1
							|| gclass.indexOf("流利英语") > -1
							|| gclass.indexOf("语法") > -1
							|| gclass.indexOf("其他") > -1) {
						gclass = "";
					}
					String gname = g.getGname();
					if (gname != null && gname.length() > 0) {
						gname = "【" + gname + "】";
					}
					bodyDes = g.getGsbuject() + gclass + g.getGclassify()
							+ gname;
				} catch (Exception e) {
					log.error("查询订单未支付视频信息【常规】出错：", e);
				}
			} else {// 竞赛
				try {
					ContestVideo c = contestVideoService
							.findContestVideoById(vid);
					oldMoney = c.getCmoney() == null ? "0" : c.getCmoney();

					killMoney = c.getKillMoney() == null ? "0" : c
							.getKillMoney();
					isKill = c.getIsKill();
					killStartTime = c.getKillStartTime();
					killEndTime = c.getKillEndTime();
					String cname = c.getCname();
					if (cname != null && cname.length() > 0) {
						cname = "【" + cname + "】";
					}
					bodyDes = c.getCompetitionName() + c.getCclass()
							+ c.getCclassify() + cname;
				} catch (Exception e) {
					log.error("查询订单未支付视频信息【竞赛】出错：", e);
				}
			}

			if (isKill == 1) {// 秒杀活动正在进行
				killInfo = BaseUtil.getKillInfo(killStartTime, killEndTime);
				int timeType = (Integer) killInfo.get("timeType");
				omoney = timeType == 1 ? killMoney : oldMoney;
			} else {
				omoney = oldMoney;
			}
System.out.println("生成订单方法中 omoney为--->"+omoney);
			// 生成支付订单号部分.
			if (olist.size() > 0) {// 已存在的订单
				order = olist.get(0);
				if (!omoney.equals(order.getOmoney())
						|| !bodyDes.equals(order.getPayStyle())) {
					order.setOmoney(omoney);
					order.setPayStyle(bodyDes);
					try {
						try {
							orderNo = mackeOrderNo(orderService);// 订单编号
						} catch (Exception e) {
							log.info("原单号修改失败");
						}
						orderService.updateOrderPayMoney(order.getOid(),
								omoney, orderNo, bodyDes);
						order.setOrderNo(orderNo);
					} catch (Exception e) {
						log.info("原单号修改未支付订单号【" + orderNo + "】的支付价格失败:", e);
					}
				} else {
					orderNo = order.getOrderNo();
				}
			} else if (Float.parseFloat(omoney) > 0) {// 新生成订单
				order = new Order();
				String oid = UUIDUtil.getUUID();// 主键
				Date ocreatTime = new Date();// 创建时间
				try {
					orderNo = mackeOrderNo(orderService);// 订单编号
				} catch (Exception e) {
					log.error("生成订单号失败：", e);
				}
				order.setOid(oid);
				order.setOcreatTime(ocreatTime);
				order.setOmoney(omoney);
				order.setOrderNo(orderNo);
				order.setUid(uid);
				order.setVclassify(vclassify);
				order.setVid(vid);
				order.setPayStyle(bodyDes);
				try {
					orderService.insertOrder(order);
				} catch (Exception e) {
					log.error("生成视频预支付订单失败：", e);
				}
			}

			log.info("开始生成订单号【" + orderNo
					+ "】的支付二维码：=============================");
			if (Float.parseFloat(omoney) > 0) {
				Map<String, String> map = WechatPayUtil.mackOrder(orderNo,
						order.getOmoney(), bodyDes, "/order/callBackAfterPay");
				log.info("开始生成订单号【" + orderNo
						+ "】的支付二维码结束=============================，信息是："
						+ JSONObject.fromObject(map).toString());
				code_url2 = map.get("code_url");// 模式二
				if (code_url2 == null) {
					code_url2 = "";
				}
			}

		} catch (Exception e) {
			log.error("生成订单号和二维码失败：", e);
		}

		resMap.put("url", code_url2);
		resMap.put("omoney", omoney);

		PrintHelper.sendJsonObject(response, resMap);
	}

	// 获取活动截止时间
	@RequestMapping("/order/getEndKillTime")
	public void getEndKillTime(HttpServletRequest req,
			HttpServletResponse response, String vid, String vclassify)
			throws Exception {

		String killStartTime = "";// 秒杀开始时间
		String killEndTime = "";// 秒杀截止时间
		if (vclassify.equals("0")) {// 常规
			GeneralVideo g = generalVideoService.findGeneralVideoByVid(vid);
			killStartTime = g.getKillStartTime();
			killEndTime = g.getKillEndTime();
		} else {
			ContestVideo c = contestVideoService.findContestVideoById(vid);
			killStartTime = c.getKillStartTime();
			killEndTime = c.getKillEndTime();
		}
		Map<String, Object> killInfo = BaseUtil.getKillInfo(killStartTime,
				killEndTime);
		PrintHelper.sendJsonObject(response, killInfo);
	}

	// 根据年月日生成订单号
	private String mackeOrderNo(OrderService orderService)
			throws ParseException {
		String dateString = BaseUtil.getCurrentDateStr("yyyyMMdd");
		String orderNo = orderService.getMaxOrderNoByOrderNoPre(dateString);
		orderNo = orderNo == null || orderNo.length() == 0 ? dateString
				+ "00000000" : String.valueOf(Long.parseLong(orderNo) + 1);
		return orderNo;
	}

	// 支付回调(接收微信支付结果通知的回调地址)
	@RequestMapping("/order/callBackAfterPay")
	public void callBackAfterPay(HttpServletRequest req,
			HttpServletResponse response) throws Exception {
		Map<String, String> backDataMap = parseXml(req);// 解析微信返回的数据
		if (backDataMap != null) {
			log.info("回调信息：" + JSONObject.fromObject(backDataMap).toString());
			Map<String, String> map = new HashMap<String, String>();
			String return_code = backDataMap.get("return_code");// 返回状态码
																// [SUCCESS/FAIL]
			String return_msg = "";
			String sendMsg = "";
			if (return_code.equals("SUCCESS")) {
				String result_code = backDataMap.get("result_code");// 业务结果
				if (result_code.equals("SUCCESS")) {
					if (WechatPayUtil.checkBackSign(backDataMap)) {// 对于支付结果通知的内容做签名验证
						String out_trade_no = backDataMap.get("out_trade_no");// 订单号
						String total_fee = backDataMap.get("total_fee");// 实付金额（单位：分）
						// 校验返回的订单金额是否与商户的订单金额一致
						try {
							Order order = orderService.findOrderByOrderNo(out_trade_no);
							String omoney = order.getOmoney();
							omoney = BaseUtil.getWpayMOney(omoney);
							String oispay = order.getOisPay();
							if (omoney.equals(total_fee)) {
								if (oispay.equals("0")) {
									// 修改订单状态
									try {
										orderService
												.updateOrderPayStatus(out_trade_no);
									} catch (Exception e) {
										log.info("修改定订单状态【订单号:" + out_trade_no
												+ "】出错：", e);
										sendMsg = "修改定订单状态出错";
									}
								} else {
									log.info("订单收到重复通知");
								}
							} else {
								return_code = "FAIL";
								return_msg = "订单金额不一致";
							}
						} catch (Exception e) {
							log.info("校验返回的订单金额是否与商户的订单金额一致查询【订单号:"
									+ out_trade_no + "】出错：", e);
							sendMsg = "订单查询错误";
						}
					} else {
						return_code = "FAIL";
						return_msg = "签名错误";
					}
				}
			} else {
				return_msg = backDataMap.get("return_msg");
			}
			map.put("return_msg", return_msg);
			map.put("return_code", return_code);
			try {
				sendMsg = WechatPayUtil.getRequestXml(map);
			} catch (Exception e) {
				log.info("订单回调向微信发送xml请求出错【 WechatPayUtil.getRequestXml】:", e);
			}
			PrintHelper.sendJsonString(response, sendMsg);
		}
	}

	// 解析微信回调返回的值
	public Map<String, String> parseXml(HttpServletRequest request) {
		Map<String, String> map = null;
		try {
			// 解析结果存储在HashMap
			map = new HashMap<String, String>();
			InputStream inputStream = request.getInputStream();
			// 读取输入流
			SAXReader reader = new SAXReader();
			Document document = reader.read(inputStream);
			// 得到xml根元素
			org.dom4j.Element root = document.getRootElement();
			// 得到根元素的所有子节点
			List<Element> elementList = root.elements();
			// 遍历所有子节点
			for (Element e : elementList)
				map.put(e.getName(), e.getText());
			// 释放资源
			inputStream.close();
			inputStream = null;
		} catch (Exception e) {
			log.info("解析微信回调返回的值出错：", e);
		}
		return map;
	}

	// 检查订单是否支付
	@RequestMapping("/order/checkOrderIsBuy")
	public void checkOrderIsBuy(HttpServletRequest req,
			HttpServletResponse response, String vid, String vclassify,
			String uid) throws Exception {
		List<Order> olist = null;
		try {
			olist = orderService.findOrderByParams(uid, vid, vclassify, "1");
		} catch (Exception e) {
			log.info("检查订单是否支付出错：", e);
		}
		String str = "error";
		if (olist != null && olist.size() > 0) {
			if (olist.get(0).getOisPay().equals("1")) {
				str = "ok";
			}
		}
		PrintHelper.sendJsonString(response, str);
	}

	// 查看文章内容
	@RequestMapping("/banner/checkArticle")
	public ModelAndView checkArticle(HttpServletRequest req,
			HttpServletResponse response, String bid) throws Exception {
		Banner b = null;
		ModelAndView mode = new ModelAndView();
		try {
			b = orderService.findBannerByBid(bid);
			try {
				List<ArticleImg> alist = orderService
						.selectArticleImgByBid(bid);
				mode.addObject("alist", alist);
			} catch (Exception e) {

			}
		} catch (Exception e) {
			log.info("查看文章内容出错【id:" + bid + "】:", e);
			b = new Banner();
		}

		mode.addObject("banner", b);
		mode.setViewName("order/checkArticle");
		return mode;

	}
}
