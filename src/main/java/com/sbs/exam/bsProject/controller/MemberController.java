package com.sbs.exam.bsProject.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.exam.bsProject.service.MemberService;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.Member;

@Controller
public class MemberController {

	private MemberService memberService;
	
	public MemberController(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@RequestMapping("/usr/member/showLogin")
	public String showLogin() {
		
		return "usr/member/login";
	}
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpSession httpSession, String loginId, String loginPw) {
		boolean loginCheck = false;
		
		if(httpSession.getAttribute("loginedId") != null) {
			loginCheck = true;
		}
		
		if(loginCheck) {
			return Ut.jsHistoryBack("이미 로그인 되었습니다.");
		}
		
		if(Ut.empty(loginId)) {
			return Ut.jsHistoryBack("아이디를 입력해주세요");
			}
		
		if(Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("비밀번호를 입력해주세요");
			}
		
		Member member = memberService.getMemberId(loginId);
		
		if(member == null) {
			return Ut.jsHistoryBack("등록되지 않은 아이디입니다.");
		}
		
		if(member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("비밀번호를 확인해주세요");
		}
		
		httpSession.setAttribute("loginedId", member.getLoginId());
		
		return Ut.jsReplace("로그인 성공", "/");
	}
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpSession httpSession) {
		boolean logoutCheck = false;
		
		if(httpSession.getAttribute("loginedId") == null) {
			logoutCheck = true;
		}
		
		if(logoutCheck) {
			return "이미 로그아웃 상태입니다.";
		}
		
		httpSession.removeAttribute("loginedId");
		
		return "로그아웃 되었습니다.";
	}
}
