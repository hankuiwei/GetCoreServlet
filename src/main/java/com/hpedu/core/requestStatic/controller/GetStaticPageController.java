package com.hpedu.core.requestStatic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class GetStaticPageController {
	
	@RequestMapping(value="public/{b}")
	public ModelAndView getPage(@PathVariable(value="b") String b){
System.out.println("i'm coming " + "public/"+ b);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("public"+"/"+b);
		return mv ;
	}
	
}
