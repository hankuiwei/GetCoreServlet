package com.hpedu.util.baseMenu;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
@Component
public class MenuManager {
	private static Logger log = LoggerFactory.getLogger(MenuManager.class);

	public void getMain() {
		// 调用接口获取access_token
		AccessToken at = WeixinUtil.getAccessToken(TockenUtil.getAppId(),
				TockenUtil.getSecret());

		if (null != at) {
			// 调用接口创建菜单
			int result = WeixinUtil.createMenu(getMenu(), at.getToken());

			// 判断菜单创建结果
			if (0 == result)
				log.info("菜单创建成功！");
			else
				log.info("菜单创建失败，错误码：" + result);
		}
	}

	/**
	 * 组装菜单数据
	 * 
	 * @return
	 */
	private static Menu getMenu() {
		
		/**
		 * 首页
		 */
		/*CommonButton btn41 = new CommonButton();
		btn41.setName("首页");
		btn41.setType("view");
		btn41.setKey("41");
		btn41.setUrl("http://www.houpuclass.com/GetCoreServlet/public/index");*/
		
		
		/**
		 * 厚朴课堂
		 */
        CommonButton btn11 = new CommonButton();
        btn11.setName("常规课程");
        btn11.setType("view");
        btn11.setKey("11");
        btn11.setUrl("http://www.houpuclass.com/GetCoreServlet/public/generalCourse");

        CommonButton btn12 = new CommonButton();
        btn12.setName("竞赛课程");
        btn12.setType("view");
        btn12.setKey("12");
        btn12.setUrl("http://www.houpuclass.com/GetCoreServlet/public/competitionCourse");
        
        CommonButton btn13 = new CommonButton();
        btn13.setName("最新课程");
        btn13.setType("view");
        btn13.setKey("13");
        btn13.setUrl("http://www.houpuclass.com/GetCoreServlet/public/latestCourse");
        
        CommonButton btn14 = new CommonButton();
		btn14.setName("首页");
		btn14.setType("view");
		btn14.setKey("14");
		btn14.setUrl("http://www.houpuclass.com/GetCoreServlet/public/index");
        
        CommonButton btn15 = new CommonButton();
        btn15.setName("小测试");
        btn15.setType("view");
        btn15.setKey("15");
        btn15.setUrl("http://www.houpuclass.com/GetCoreServlet/public/exam");
 
        /**
         * 厚朴师生.
         */
        CommonButton btn21 = new CommonButton();
        btn21.setName("名师推荐");
        btn21.setType("view");
        btn21.setKey("21");
        btn21.setUrl("http://www.houpuclass.com/GetCoreServlet/public/teachers");

        CommonButton btn22 = new CommonButton();
        btn22.setName("学生展示");
        btn22.setType("view");
        btn22.setKey("22");
        btn22.setUrl("http://www.houpuclass.com/GetCoreServlet/public/students");
        
  /**
   * 个人中心      
   */
        CommonButton btn31 = new CommonButton();
        btn31.setName("我的资料");
        btn31.setType("view");
        btn31.setKey("31");
        btn31.setUrl("http://www.houpuclass.com/GetCoreServlet/public/myProfile");
        
        CommonButton btn32 = new CommonButton();
        btn32.setName("学习课程");
        btn32.setType("view");
        btn32.setKey("32");
        btn32.setUrl("http://www.houpuclass.com/GetCoreServlet/public/myCourse");
        
        CommonButton btn33 = new CommonButton();
        btn33.setName("历史分数");
        btn33.setType("view");
        btn33.setKey("33");
        btn33.setUrl("http://www.houpuclass.com/GetCoreServlet/public/myScore");
       
        CommonButton btn34 = new CommonButton();
        btn34.setName("购买记录");
        btn34.setType("view");
        btn34.setKey("34");
        btn34.setUrl("http://www.houpuclass.com/GetCoreServlet/public/purchaseRecord");
 
        
        
        
        /**
         * 微信：  mainBtn1,mainBtn2,mainBtn3底部的三个一级菜单。
         */
        
      /*  ComplexButton mainBtn4 = new ComplexButton();
        mainBtn4.setName("首页");
        mainBtn4.setSub_button(new CommonButton[] { btn41});*/
        
        ComplexButton mainBtn1 = new ComplexButton();
        mainBtn1.setName("厚朴网课");
        mainBtn1.setSub_button(new CommonButton[] {btn14, btn11, btn12, btn13, btn15 });

        
        ComplexButton mainBtn2 = new ComplexButton();
        mainBtn2.setName("厚朴师生");
        mainBtn2.setSub_button(new CommonButton[] { btn21, btn22});

        
        ComplexButton mainBtn3 = new ComplexButton();
        mainBtn3.setName("个人中心");
        mainBtn3.setSub_button(new CommonButton[] { btn31,btn32,btn33,btn34 });

        
        /**
         * 封装整个菜单
         */
        Menu menu = new Menu();
        menu.setButton(new Button[] {mainBtn1, mainBtn2, mainBtn3 });

        return menu;
    }
}