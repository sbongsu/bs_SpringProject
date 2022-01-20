package com.sbs.exam.bsProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {
	@RequestMapping("/usr/home/controller")
	@ResponseBody
	public String showHomeMain() {
		return "프로젝트 만들기전에 확인!";
	}
}
