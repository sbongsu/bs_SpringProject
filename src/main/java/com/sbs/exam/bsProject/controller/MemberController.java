package com.sbs.exam.bsProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.exam.bsProject.service.MemberService;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.Member;
import com.sbs.exam.bsProject.vo.ResultData;
import com.sbs.exam.bsProject.vo.Rq;

@Controller
public class MemberController {

	private MemberService memberService;
	private Rq rq;
	
	public MemberController(MemberService memberService, Rq rq) {
		this.memberService = memberService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/member/showJoin")
	public String showJoin() {
		
		return "usr/member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String userName, String nickName, String loginPw, String email, String phoneNum) {
		
		if(Ut.empty(loginId)) {
			return rq.jsHistoryBack("ID를 입력해주세요");
		}
		
		if(Ut.empty(userName)) {
			return rq.jsHistoryBack("이름을 입력해주세요");
		}
		
		if(Ut.empty(nickName)) {
			return rq.jsHistoryBack("닉네임을 입력해주세요");
		}
		
		if(Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요");
		}
		
		if(Ut.empty(email)) {
			return rq.jsHistoryBack("이메일을 입력해주세요");
		}
		
		if(Ut.empty(phoneNum)) {
			return rq.jsHistoryBack("휴대폰번호를 입력해주세요");
		}
		
		ResultData joinRd = memberService.join(loginId, userName, nickName, loginPw, email, phoneNum);
		
		if(joinRd.isFail()) {
		
			return rq.jsHistoryBack(joinRd.getMsg());
		}
		
		return rq.jsReplace(joinRd.getMsg(), "/");
	}
	
	@RequestMapping("/usr/member/showLogin")
	public String showLogin() {
		
		return "usr/member/login";
	}
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
		
		if(rq.isLogined()) {
			return rq.jsHistoryBack("이미 로그인 되었습니다.");
		}
		
		if(Ut.empty(loginId)) {
			return rq.jsHistoryBack("아이디를 입력해주세요");
			}
		
		if(Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요");
			}
		
		Member member = memberService.getMemberId(loginId);
		
		if(member == null) {
			return rq.jsHistoryBack("등록되지 않은 아이디입니다.");
		}
		
		if(member.getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호를 확인해주세요");
		}
		
		rq.login(member);
		
		
		return rq.jsReplace("로그인 성공", "/");
	}
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {
		
		if(!rq.isLogined()) {
			return rq.jsHistoryBack("이미 로그아웃 되었습니다.");
		}
		
		rq.logout();
		
		return rq.jsReplace("로그아웃 되었습니다", "/");
	}
	
	@RequestMapping("/usr/member/showMyPage")
	public String showMypage() {
		
		return "usr/member/myPage";
	}
	
	@RequestMapping("/usr/member/showModify")
	public String showModify() {
		
		return "usr/member/modify";
	}
	
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(String loginPw, String nickName, String email, String phoneNum) {
		if (Ut.empty(loginPw)) {
			loginPw = null;
		}

		if (Ut.empty(nickName)) {
			return rq.jsHistoryBack("nickname(을)를 입력해주세요.");
		}

		if (Ut.empty(email)) {
			return rq.jsHistoryBack("email(을)를 입력해주세요.");
		}

		if (Ut.empty(phoneNum)) {
			return rq.jsHistoryBack("phoneNum(을)를 입력해주세요.");
		}
		
		ResultData modifyRd = memberService.modify(rq.getLoginedId(), loginPw, nickName, email, phoneNum);

		return rq.jsReplace(modifyRd.getMsg(), "/");
	}
	
	@RequestMapping("/usr/member/loginCheck")
	public String loginCheck() {
		
		return "usr/member/loginCheck";
	}
	
	@RequestMapping("/usr/member/doLoginCheck")
	@ResponseBody
	public String doLoginCheck(String loginPw, String replaceUri) {
		
		if(Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요.");
			}
		
		if(rq.getLoginedMember().getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}
		
		
		
		return Ut.jsReplace("", replaceUri);
	}
}
