package com.sbs.exam.bsProject.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.sbs.exam.bsProject.service.MemberService;
import com.sbs.exam.bsProject.util.Ut;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {

	@Getter
	private boolean isLogined;
	@Getter
	private int loginedId;
	@Getter
	private Member loginedMember;
	
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;

	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService) {
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();
		boolean isLogined = false;
		int loginedId = 0;
		Member loginedMember = null;


		if (session.getAttribute("loginedId") != null) {
			isLogined = true;
			loginedId =  (int) session.getAttribute("loginedId");
			loginedMember = memberService.getMemberById(loginedId);
		}

		this.isLogined = isLogined;
		this.loginedId = loginedId;
		this.loginedMember = loginedMember;
		this.req.setAttribute("rq", this);
	}

	public void printHistoryBackJs(String msg) {
		
		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsHistoryBack(msg));
	}
	
	public void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void println(String str) {
		print(str + "\n");
	}

	public void login(Member member) {
		session.setAttribute("loginedId", member.getId());
		System.out.println(loginedId);
	}

	public void logout() {
		session.removeAttribute("loginedId");
	}
	
	public String historyBackJsOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "common/js";
	}
	
	public String jsReplace(String msg, String uri) {
		return Ut.jsReplace(msg, uri);
	}
	
	public String jsHistoryBack(String msg) {
		return Ut.jsHistoryBack(msg);
	}

	//Rq 객체가 자연스럽게 생성되도록 유도하는 메서드 (로그인시 첫 화면에서 로그아웃으로 안뜨고 로그인으로 뜨는 오류해결.)
	//지우면 안됨
	//편의성을 높이기 위해 BeforeActionInterceptor 에서 호출 필요
	public void initOnBeforeActionInterceptor() {
	
		
	}

	
}
