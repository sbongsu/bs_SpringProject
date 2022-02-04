package com.sbs.exam.bsProject.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sbs.exam.bsProject.util.Ut;

import lombok.Getter;

public class Rq {

	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;

	public Rq(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();
		boolean isLogined = false;
		int loginedMemberId = 0;

		if (session.getAttribute("loginedId") != null) {
			isLogined = true;
			loginedMemberId =  (int) session.getAttribute("loginedId");
		}

		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
	}

	public void printHistoryBackJs(String msg) {
		
		println("<script>");
		
		if(!Ut.empty(msg)) {
			println("alert('"+ msg +"');");
		}
		println("historyback();");
		println("</script>");
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
	}

	public void logout() {
		session.removeAttribute("loginedId");
	}

}
