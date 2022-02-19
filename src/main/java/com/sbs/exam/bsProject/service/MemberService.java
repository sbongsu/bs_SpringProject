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

}
