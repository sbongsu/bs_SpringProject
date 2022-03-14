package com.sbs.exam.bsProject.controller;

import java.util.UUID;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sbs.exam.bsProject.service.MemberService;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.KakaoProfile;
import com.sbs.exam.bsProject.vo.Member;
import com.sbs.exam.bsProject.vo.OAuthToken;
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
	public String doJoin(String loginId, String userName, String nickName, String loginPw, String email,
			String phoneNum) {

		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("ID를 입력해주세요");
		}

		if (Ut.empty(userName)) {
			return rq.jsHistoryBack("이름을 입력해주세요");
		}

		if (Ut.empty(nickName)) {
			return rq.jsHistoryBack("닉네임을 입력해주세요");
		}

		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요");
		}

		if (Ut.empty(email)) {
			return rq.jsHistoryBack("이메일을 입력해주세요");
		}

		if (Ut.empty(phoneNum)) {
			return rq.jsHistoryBack("휴대폰번호를 입력해주세요");
		}

		ResultData joinRd = memberService.join(loginId, userName, nickName, loginPw, email, phoneNum);

		if (joinRd.isFail()) {

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

		if (rq.isLogined()) {
			return rq.jsHistoryBack("이미 로그인 되었습니다.");
		}

		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("아이디를 입력해주세요");
		}

		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요");
		}

		Member member = memberService.getMemberId(loginId);

		if (member == null) {
			return rq.jsHistoryBack("등록되지 않은 아이디입니다.");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호를 확인해주세요");
		}

		rq.login(member);

		return rq.jsReplace("로그인 성공", "/");
	}

	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {

		if (!rq.isLogined()) {
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
	public String showModify(String memberModifyAuthKey) {

		if (Ut.empty(memberModifyAuthKey)) {
			return rq.historyBackJsOnView("memberModifyAuthKey이(가) 필요합니다.");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedId(),
				memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.historyBackJsOnView(checkMemberModifyAuthKeyRd.getMsg());
		}

		return "usr/member/modify";
	}

	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(String memberModifyAuthKey, String loginPw, String nickName, String email, String phoneNum) {

		if (Ut.empty(memberModifyAuthKey)) {
			return rq.jsHistoryBack("memberModifyAuthKey(이)가 필요합니다.");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedId(),
				memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.jsHistoryBack(checkMemberModifyAuthKeyRd.getMsg());
		}
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

		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요.");
		}

		if (rq.getLoginedMember().getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}

		if (replaceUri.equals("../member/showModify")) {
			String memberModifyAuthKey = memberService.genMemberModifyAuthKey(rq.getLoginedId());

			replaceUri += "?memberModifyAuthKey=" + memberModifyAuthKey;
		}

		return Ut.jsReplace("", replaceUri);
	}

	@RequestMapping("auth/kakao/callback")
	@ResponseBody
	public String kakaoCallBack(String code) {
		
		//받아온 코드로 토큰 받아오기
		RestTemplate rt = new RestTemplate();

		//HttpHeaders 오브젝터 생성
        HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		//HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "8e5884bd3c5a6e6fba97ef8aee1a0019");
		params.add("redirect_uri", "http://localhost:8084/auth/kakao/callback");
		params.add("code", code);
		
		//HttpHeaders와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);
		
		//Http 요청하기 Post방식으로 and response 변수의 응답을 String으로 받음
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST, kakaoTokenRequest, String.class);
		
		//OAuthToken에 받아온 객체 담기.
		//JSON -> Java에서 사용하기위해!!!
		ObjectMapper objectmapper = new ObjectMapper();
		OAuthToken oauthtoken = null;
		try {
			oauthtoken = objectmapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		System.out.println("카카오 엑세스 토큰 :" + oauthtoken.getAccess_token());
		
		
		//토큰으로 사용자 정보 받아와서 클래스에 넣기!
		RestTemplate rt2 = new RestTemplate();

		//HttpHeaders 오브젝터 생성
        HttpHeaders headers2 = new HttpHeaders();
        headers2.add("Authorization", "Bearer " + oauthtoken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		//HttpHeaders를 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = new HttpEntity<>(headers2);
		
		//Http 요청하기 Post방식으로 and response 변수의 응답을 String으로 받음
		ResponseEntity<String> response2 = rt2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST, kakaoProfileRequest2, String.class);
		
		ObjectMapper objectmapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		try {
			kakaoProfile = objectmapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		//Member 오브젝트에 : loginId, loginPw, userName, nickName, email, phoneNum
		System.out.println("카카오 아이디 번호 : " +kakaoProfile.getId());
		System.out.println("카카오 닉네임 : " +kakaoProfile.getProperties().getNickname());
		
		//구현을 위한 임시 값들
		String garbagePw = "abc1234";
		String garbageEmail = "abc1234";
		String garbagePhoneNum = "abc1234";
		
		//카카오에서 받아온 데이터 확인, null값은 임시값으로 넣고 확인 !
		System.out.println("블로그 아이디 : " +kakaoProfile.getProperties().getNickname()+ "_" + kakaoProfile.getId());
		System.out.println("블로그 비밀번호 : " +garbagePw);
		System.out.println("블로그 이름 : " +kakaoProfile.getProperties().getNickname());
		System.out.println("블로그 닉네임 : " +kakaoProfile.getProperties().getNickname());
		System.out.println("블로그 이메일 : " +garbageEmail);
		System.out.println("블로그 휴대폰번호 : " +garbagePhoneNum);
		
		Member member = new Member();
		
		member.setLoginId(kakaoProfile.getProperties().getNickname()+ "_" + kakaoProfile.getId());
		member.setLoginPw(garbagePw);
		member.setUserName(kakaoProfile.getProperties().getNickname());
		member.setNickName(kakaoProfile.getProperties().getNickname());
		member.setEmail(garbageEmail);
		member.setPhoneNum(garbagePhoneNum);
		System.out.println("값 확인 : " + member.getLoginId());
		
		//기존 회원인지 확인하기.
		Member originMemberCheck = memberService.getMemberId(member.getLoginId());
		System.out.println("dddddd : " + originMemberCheck);
		
		Member loginMemberId = null;
		
		//새로운 회원일 경우 회원가입.
		if(originMemberCheck.getLoginId() == null ) {
			memberService.kakaoJoin(kakaoProfile.getProperties().getNickname()+ "_" + kakaoProfile.getId(), kakaoProfile.getProperties().getNickname(), kakaoProfile.getProperties().getNickname(), garbagePw.toString() ,garbageEmail.toString(), garbagePhoneNum.toString());
			loginMemberId = memberService.getMemberId(member.getLoginId());
			rq.login(loginMemberId);
		}

		//새로운 회원이  아닐경우 로그인.
		if(originMemberCheck.getLoginId() != null ) {
			rq.login(originMemberCheck);
		}
		
		//return "카카오 인증 code : " + code ;
		
		//return "카카오 토큰 요청 완료 : 토큰요청에 대한 응답 : " + response2.getBody();
		return rq.jsReplace("로그인 성공", "/");
	}
}
