package com.sbs.exam.bsProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.MemberRepository;
import com.sbs.exam.bsProject.vo.Member;

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

}
