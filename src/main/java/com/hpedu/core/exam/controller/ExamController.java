package com.hpedu.core.exam.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hpedu.core.exam.pojo.Exam;
import com.hpedu.core.exam.pojo.ExamImg;
import com.hpedu.core.exam.service.ExamService;
import com.hpedu.core.user.pojo.UnitTest;
import com.hpedu.core.user.pojo.UnitTest_Choose;
import com.hpedu.core.user.pojo.User;
import com.hpedu.core.user.service.UserService;
import com.hpedu.core.video.pojo.ContestVideo;
import com.hpedu.core.video.pojo.GeneralVideo;
import com.hpedu.core.video.service.ContestVideoService;
import com.hpedu.core.video.service.GeneralVideoService;
import com.hpedu.util.BaseUtil;
import com.hpedu.util.PrintHelper;
import com.hpedu.util.StringUtil;
import com.hpedu.util.mybatis.Page;

@Controller
@RequestMapping("/")
public class ExamController {
	
	@Resource
	ExamService examService;
	@Resource
	UserService userService;
	@Resource
	GeneralVideoService generalVideoService;
	@Resource
	ContestVideoService contestVideoService;
	private Logger log=BaseUtil.getLogger(ExamController.class);

	@RequestMapping("/exam/examlist.html")
	public void findExamListByMap(HttpServletRequest req, HttpSession session,
			Model model, String etsubject, String etclass, String etclassify)
			throws Exception {
		User user = (User) session.getAttribute("user");
		Page<Exam>pages=null;
		int pageNo = 0;
		int pageSize = 20;
		if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {pageNo = 1;}
		Map<String,String> map  = new HashMap<String,String>(); 
	
		/*map.put("etsubject", new String(etsubject.getBytes("iso8859-1"),"utf-8"));
		map.put("etclass", new String(etclass.getBytes("iso8859-1"),"utf-8"));
		map.put("etclassify", new String(etclassify.getBytes("iso8859-1"),"utf-8"));*/
		
		map.put("etsubject", etsubject);
		map.put("etclass", etclass);
		map.put("etclassify", etclassify);
		try{
		  pages = examService.findExamListByMap(map, pageNo, pageSize);
		}catch(Exception e){
			log.error("查询测验题出错了:",e);
			pages=new Page<Exam>();
			pages.setResult(new ArrayList<Exam>());
		}
		model.addAttribute("user", user);
		model.addAttribute("etsubject", map.get("etsubject"));
		model.addAttribute("etclass", map.get("etclass"));
		model.addAttribute("etclassify", map.get("etclassify"));
	
		model.addAttribute("pages", pages);
	}
	
	@RequestMapping("/public/examList")
	public void getExamListByMap(HttpServletRequest req, HttpSession session,
			Model model, String etsubject, String etclass, String etclassify)
			throws Exception {
		User user = (User) session.getAttribute("user");
		Page<Exam>pages=null;
		int pageNo = 0;
		int pageSize = 20;
		if (req.getParameter("pageNo") != null
				&& StringUtil.isNumeric(req.getParameter("pageNo"))) {
			pageNo = Integer.parseInt(req.getParameter("pageNo"));
		}
		if (pageNo < 1) {pageNo = 1;}
		Map<String,String> map  = new HashMap<String,String>(); 
		map.put("etsubject", etsubject);
		map.put("etclass", etclass);
		map.put("etclassify", etclassify);
		try{
		  pages = examService.findExamListByMap(map, pageNo, pageSize);
		}catch(Exception e){
			log.error("查询测验题出错了:",e);
			pages=new Page<Exam>();
			pages.setResult(new ArrayList<Exam>());
			
		}
		model.addAttribute("user", user);
		model.addAttribute("etsubject", map.get("etsubject"));
		model.addAttribute("etclass", map.get("etclass"));
		model.addAttribute("etclassify", map.get("etclassify"));
		model.addAttribute("pages", pages);
	}
	
	@RequestMapping("public/examDetail")
	public void findExamByetid(HttpServletRequest req,HttpSession session,String etid,Model model)throws Exception{
		User user = (User) session.getAttribute("user");
		Exam exam = null;
		List<GeneralVideo> glist = null;
		List<ContestVideo> clist = null;
		String gsubject = "";
		List<ExamImg> imglist = null;
		try {
			exam = examService.findExamByEtid(etid);
			String etsubject = exam.getEtsubject();
			gsubject = etsubject.replace("测验", "");

			String gclass = "";
			String etclass = exam.getEtclass();
			gclass = etclass.replace("年级", "");

			if (gsubject.equals("英语")) {
				exam.setEtclass("");
			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("gsubject", gsubject);
			map.put("gclass", gclass);
			map.put("pagesize", 8);
			try {
				glist = generalVideoService.findVideoListByExam(map);
			} catch (Exception ee) {
				glist = new ArrayList<GeneralVideo>();
				log.error("查询测验常规推荐视频出错:", ee);
			}
			if (!gsubject.equals("英语")) {
				map.put("cclass", gclass);
			}
			try {
				clist = contestVideoService.findVideoListByExam(map);
			} catch (Exception er) {
				clist = new ArrayList<ContestVideo>();
				log.error("查询测验竞赛推荐视频出错:", er);
			}
			if (StringUtils.isNotEmpty(exam.getEtimg())
					&& exam.getEtimg().equals("1")) {
				try {
					imglist = examService.selectExamImgByExid(exam.getEtid());
				} catch (Exception er) {
					imglist = new ArrayList<ExamImg>();
					log.error("查询测验试卷和答案图片list出错:", er);
				}
				exam.setImgList(imglist);
			}
		} catch (Exception e) {
			log.error("查询测验题【id:" + etid + "】出错：", e);
		}

		model.addAttribute("glist", glist);
		model.addAttribute("clist", clist);
		model.addAttribute("exam", exam);
		model.addAttribute("user", user);
		model.addAttribute("gsubject", gsubject);
	}
	
	
	// 根据视频id和类型查询所有测试题 并拼接前端html
		@RequestMapping("/back/getUnitTestsHtmlByVid")
		public void getUnitTestsHtmlByVid(HttpServletRequest req, HttpServletResponse response, HttpSession session,
				String vid, String utype, int isRedo, String vname) throws Exception {
			String status = "ok";
			String data = "";

			try {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("vid", vid);
				map.put("utype", utype);
				map.put("rand", "true");// 是否随机
				List<Map> list = userService.selectVidoeTestAll(map);
				
				Map<String, Object> resMap = getUnitTests(list);
				List<UnitTest> utlist = (List<UnitTest>) resMap.get("utlist");
				
				if (utlist.size() > 0) {
					Map<String, List<UnitTest_Choose>> ucData = (Map<String, List<UnitTest_Choose>>) resMap.get("ucData");
					// 拼接前端测试题html
					StringBuffer sb_html = new StringBuffer();
					if (isRedo == 0) {// 初始化测验题
						List<Map> mapList = userService.getTotalUnitTests(vid, Integer.parseInt(utype));
						if (mapList.size() > 0) {
							Map mmap = mapList.get(0);
							String nums = String.valueOf(mmap.get("nums"));
							String scores = String.valueOf(mmap.get("scores"));
							
							if (mapList.size() > 1) {
								Map mmap2 = mapList.get(1);
								String nums2 = String.valueOf(mmap2.get("nums"));
								String scores2 = String.valueOf(mmap2.get("scores"));
								nums = (Integer.parseInt(nums) + Integer.parseInt(nums2)) + "(选择题" + nums + "道，简答题" + nums2
										+ "道)";
								scores = (Integer.parseInt(scores) + Integer.parseInt(scores2)) + "(选择题" + scores + "分，简答题"
										+ scores2 + "分)";
							}
							int isHasJDT = 0;// 只有选择题
							if (mapList.size() == 1 && String.valueOf(mmap.get("testType")).equals("1")) {// 只有简答题
								isHasJDT = 1;
							} else if (mapList.size() > 1) {// 二者皆有
								isHasJDT = 2;
							}
							
							sb_html.append(
									"<div style=\"width:100%;background:#BDBDBD;font-weight:bold;padding:10px;text-align:left;\">"
										+ "<ul>"
											+ "<li>名称：" + vname + "&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;题目数：" + nums + " &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总分：" + scores + "</li>"
											+ "<li>&nbsp;</li>"
											+ "<li>说明："
												+ "<input type=\"hidden\" id=\"isHasJDT\" value=\"" + isHasJDT + "\">"
												+ "<input type=\"hidden\" id=\"nums_hide\" value=\"" + nums + "\">"
												+ "<input type=\"hidden\" id=\"scores_hide\" value=\"" + scores + "\">"
											+ "</li>"
											+ "<li style=\"color:#CE0221;\">提示：选择题选项顺序为随机排列，若要核对答案，请以选项内容为准</li>"
										+ "</ul>"
									+ "</div>");
						}
						sb_html.append("<div id=\"unit_testAll\">");
					}
					
					int size = utlist.size();//本章试题数
					for (int i = 0; i < size; i++) {
						UnitTest ut = utlist.get(i);
						List<UnitTest_Choose> ulist = ucData.get(ut.getUtid());
						if (i == 2) {// 第3题开始 -- 隐藏试题
							sb_html.append("<div style=\"display:" + (isRedo == 0 ? "none" : "block") + ";text-align:left;\" id=\"more_div\">");
						}
						sb_html = getHtml(sb_html, ut, ulist, i + 1);

						if (i == size - 1) {// 最后一道题的打分按钮
							sb_html.append(" <div style=\"width:100%;padding:10px;text-align:left;\">"
											+ "<input type=\"button\" class=\"btn btn-primary\"  value=\"提交打分\"  id=\"submitAnswer_btn\" onclick=\"submitAnswer()\">"
											+ " <input type=\"button\" class=\"btn btn-primary\" value=\"重新做题\" onclick=\"redo()\">"
											+ " <h4 style=\"display:none;\" id=\"result_tests\">答题结果：</h4>"
										 + "</div>");
							if (size > 2) {
								sb_html.append("</div>");
							}
						}

					}
					if (size > 2) {
						sb_html.append("<input type=\"button\" class=\"btn btn-primary\" value=\""
								+ (isRedo == 0 ? "展开全部" : "隐藏") + "\" onclick=\"slideDown_div2(this)\">");
					}
					if (isRedo == 0) {
						sb_html.append("</div>");
					}
					data = sb_html.toString();
				}

			} catch (Exception e) {
				log.error("根据视频id和类型查询所有测试题并拼接前端html【vid:" + vid + "】异常：", e);
				status = "error";
			}
			Map<String, String> res = new HashMap<String, String>();
			res.put("status", status);
			res.put("data", data);
			PrintHelper.sendJsonObject(response, res);
		}
		private StringBuffer getHtml(StringBuffer sb_html, UnitTest ut, List<UnitTest_Choose> ulist, int i) {
			String answer = ut.getAnswer();
			StringBuffer show_answer = new StringBuffer();
			StringBuffer answer_ids = new StringBuffer();
			StringBuffer html_sb = new StringBuffer();
			if (ut.getTestType() == 0) {//测验题目类型：0/null：选择题；1：简答题
				String[] answer_a = new String[] { "A", "B", "C", "D", "E", "F" };
				for (int j = 0; j < ulist.size(); j++) {
					UnitTest_Choose u = ulist.get(j);
					if (answer.indexOf(u.getTanswer()) > -1) {
						if (answer_ids.length() > 0) {
							answer_ids.append(",");
							show_answer.append(",");
						}
						answer_ids.append(u.getCsid());
						show_answer.append(answer_a[j]);
					}
					html_sb.append("<input type=\"checkbox\" value=\"" + u.getCsid() + "\" onclick=\"checkBox(this,'hide_"+ ut.getUtid() + "')\"> " 
							+ answer_a[j] + ". " + u.getTcontent() + "<br>");
				}
				
				html_sb.append("<input type=\"hidden\" name=\"right_answer\" value=\"" + answer_ids.toString()+ "\"> "
							+ "<input type=\"hidden\" name=\"user_answer\" id=\"hide_" + ut.getUtid() + "\">"
							+ "<input type=\"hidden\" name=\"score\" value=\"" + ut.getScore() + "\">"
						+ "</div>");
			} 
			//简答题 格式
			else {
				html_sb.append("<textarea class=\"input\" name=\"JDT_answer\" id=\"JDT_" + ut.getUtid()
						+ "\" style=\"width:600px;height:120px;\" placeholder=\"答题区\"></textarea></div>");
			}

			String testType = "简答题";
			String answerHtml = "";
			if (ut.getTestType() == 0) {
				testType = ut.getIsMoreChoose() == 0 ? "单选题" : "多选题";
				answerHtml = "<span id=\"sp_" + ut.getUtid() + "\" style=\"font-size:16px;color:#CE0221;font-weight:bold;display:none;\">✘"+ "&nbsp;&nbsp;"
						+ "<span style=\"font-size:16px;font-weight:bold;\">正确答案：(" + (show_answer.length() == 0 ? "无" : show_answer.toString()) + ")</span></span>";
			}
			html_sb.insert(0,
					"<div style=\"width:100%;background:#EEEEEE;word-break:break-all;margin-top:10px;padding:5px;text-align:left;\">"
							+ "<font style=\"font-weight:bold;\"> " + i + ".【" + testType + "】（" + ut.getScore() + "分）：</font>" 
							+ "<h4>&nbsp;&nbsp;&nbsp;" + ut.getUcontent() + "&nbsp;&nbsp;" + answerHtml + "</h4>" 
					+ "</div>"
							+ (ut.getUtimg() != null && ut.getUtimg().length() > 0 ?
						"<div style=\"width:100%;margin-top:5px;\"><img src=\"" + ut.getUtimg() + "\"></div>" : "")
							+ "<div style=\"width:100%;margin-top:5px;display:none;\" id=\"hideDiv_" + ut.getUtid() + "\">"
							+ (ut.getPonit() == null || ut.getPonit().length() == 0 ? ""
									: "<p style=\"width:100%;word-break:break-all;font-weight:bold;font-size:16px;\">【考点】：" + ut.getPonit() + "</p>")
							+ (ut.getDetail() == null || ut.getDetail().length() == 0 ? ""
									: "<p style=\"font-size:16px;width:100%;word-break:break-all;\"><b>【详解】：</b>" + ut.getDetail() + "</p>")
							+ "</div>"
					+ "<div style=\"width:100%;word-break:break-all;margin-top:5px;\">");

			sb_html.append(html_sb);
			return sb_html;
		}
		/**
		 * 根据 试题和试题选项  得到-->
		 * @param list
		 * @return
		 */
		private Map<String, Object> getUnitTests(List<Map> list) {
			Map<String, Object> mapRes = new HashMap<String, Object>();
			Map<String, List<UnitTest_Choose>> ucData = new HashMap<String, List<UnitTest_Choose>>();//题目 对应的 选项集合 映射
			List<UnitTest> utlist = new ArrayList<UnitTest>();//试题集合
			Map<String,String> uniqueMap = new HashMap<String,String>();
			for (Map map : list) {//编历得到每一个试题
				String utid = String.valueOf(map.get("utid"));
				List<UnitTest_Choose> clist =  new ArrayList<UnitTest_Choose>();//选项集合
				if(!uniqueMap.containsKey(utid)){//包含这个utid,就跳过添加步骤.
					UnitTest u = new UnitTest();//试题对象
					//包装对象
					u.setUtid(utid);
					u.setAnswer(String.valueOf(map.get("answer")));
					u.setScore(Integer.parseInt(String.valueOf(map.get("score"))));
					u.setUcontent(String.valueOf(map.get("ucontent")));
					u.setTestType(map.get("testType") == null ? 0 : Integer.parseInt(String.valueOf(map.get("testType"))));
					u.setIsMoreChoose(map.get("isMoreChoose") == null ? null
						: Integer.parseInt(String.valueOf(map.get("isMoreChoose"))));
					if (map.get("utimg") != null) {//题目图片
						u.setUtimg(String.valueOf(map.get("utimg")));
					}
					if (map.get("ponit") != null) {//考点
						u.setPonit(String.valueOf(map.get("ponit")));
					}
					if (map.get("detail") != null) {//详解
						u.setDetail(String.valueOf(map.get("detail")));
					}
					utlist.add(u);
					//添加到集合中.防止重复添加.
					uniqueMap.put(utid, null);
				}
				if (map.get("csid") != null) {
					UnitTest_Choose uc = new UnitTest_Choose();
					uc.setCsid(String.valueOf(map.get("csid")));
					uc.setTcontent(map.get("tcontent") == null ? "" : String.valueOf(map.get("tcontent")));
					uc.setTanswer(map.get("tanswer") == null ? "" : String.valueOf(map.get("tanswer")));
					uc.setUtid(utid);
					if(ucData.get(utid) != null ) {
						List<UnitTest_Choose> list2 = ucData.get(utid);
						clist.addAll(list2);
					}
					clist.add(uc);
					ucData.put(utid, clist);
				}
			}
			mapRes.put("ucData", ucData);
			mapRes.put("utlist", utlist);
			return mapRes;
		}
}
