package com.sbs.exam.bsProject.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.sbs.exam.bsProject.vo.Rq;

@Component
public class NeedLoginIntercepter implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

		
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}
