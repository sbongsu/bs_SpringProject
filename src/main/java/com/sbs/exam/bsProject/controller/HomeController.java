package com.sbs.exam.bsProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {
	@RequestMapping("/usr/home/homePage")
	public String showHomeMain() {
		return "usr/home/homePage";
	}
	
	@RequestMapping("/")
	public String showHomeRoot() {
		return "redirect:/usr/home/homePage";
	}
}
