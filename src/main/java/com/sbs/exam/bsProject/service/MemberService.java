package com.sbs.exam.bsProject.service;

import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.MemberRepository;
import com.sbs.exam.bsProject.vo.Member;
import com.sbs.exam.bsProject.vo.ResultData;

@Service
public class MemberService {

	private MemberRepository memberRepository;
	
	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	public Member getMemberId(String loginId) {
		
		return memberRepository.getMemberId(loginId);
	}
	
	public Member getMemberById(int id) {
		
		return memberRepository.getMemberById(id);
	}

	public ResultData modify(int id, String loginPw, String nickName, String email, String phoneNum) {

		memberRepository.modify(id, loginPw, nickName, email, phoneNum);

		return ResultData.from("S-1", "회원정보가 수정되었습니다.");
	}

	public ResultData join(String loginId, String userName, String nickName, String loginPw, String email, String phoneNum) {
       // 중복 아이디 확인하기
		Member oldUserId = memberRepository.getMemberId(loginId);
		if(oldUserId != null) {
			return ResultData.from("F-1", "이미 사용중인 아이디입니다.");
		}
		
		// 중복 닉네임 확인하기
		oldUserId = memberRepository.getMemberByNickName(nickName);
		if(oldUserId != null) {
			return ResultData.from("F-1", "이미 사용중인 닉네임입니다.");
		}
		
		memberRepository.join(loginId, userName, nickName, loginPw, email, phoneNum);
		
		return ResultData.from("S-1", "회원가입완료!");
		
	}

}
