package com.sbs.exam.bsProject.service;

import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.MemberRepository;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.Member;
import com.sbs.exam.bsProject.vo.ResultData;

@Service
public class MemberService {

	private MemberRepository memberRepository;
	private AttrService attrService;
	
	public MemberService(AttrService attrService, MemberRepository memberRepository) {
		this.attrService = attrService;
		this.memberRepository = memberRepository;
	}

	public Member getMemberLoginId(String loginId) {
		Member member = memberRepository.getMemberLoginId(loginId);
		
		if(member == null) {
			return new Member();
		}
		
		return member;
	}
	
	public Member getMemberById(int id) {
		
		return memberRepository.getMemberById(id);
	}

	public ResultData modify(int id, String loginPw, String nickName, String email, String phoneNum) {

		memberRepository.modify(id, loginPw, nickName, email, phoneNum);

		return ResultData.from("S-1", "회원정보가 수정되었습니다.");
	}

	public ResultData join(String loginId, String userName, String nickName, String loginPw, String email, String phoneNum) {
       // loginId로 중복 아이디 확인하기
		Member oldUserId = memberRepository.getMemberLoginId(loginId);
		if(oldUserId != null) {
			return ResultData.from("F-1", "이미 사용중인 아이디입니다.");
		}
		
		// nickName로 중복 닉네임 확인하기
		oldUserId = memberRepository.getMemberByNickName(nickName);
		if(oldUserId != null) {
			return ResultData.from("F-1", "이미 사용중인 닉네임입니다.");
		}
		
		// userName, email 중복 회원 확인하기(이름+이메일)
		oldUserId = memberRepository.getMemberByNameAndEmail(userName,email);
		if(oldUserId != null) {
			return ResultData.from("F-1", "이미 사용중인 이름과 이메일입니다.");
		}
		
		memberRepository.join(loginId, userName, nickName, loginPw, email, phoneNum);
		
		return ResultData.from("S-1", "회원가입완료!");
		
	}

	public String genMemberModifyAuthKey(int actorId) {
		String memberModifyAuthKey = Ut.getTempPassword(10);

		attrService.setValue("member", actorId, "extra", "memberModifyAuthKey", memberModifyAuthKey, Ut.getDateStrLater(60 * 5));

		return memberModifyAuthKey;
	}

	public ResultData checkMemberModifyAuthKey(int actorId, String memberModifyAuthKey) {
		String saved = attrService.getValue("member", actorId, "extra", "memberModifyAuthKey");
		
		if ( !saved.equals(memberModifyAuthKey) ) {
			return ResultData.from("F-1", "일치하지 않거나 만료되었습니다.");
		}

		return ResultData.from("S-1", "정상적인 코드입니다.");
	}

	public ResultData kakaoJoin(String loginId, String userName, String nickName, String loginPw, String email, String phoneNum) {
		memberRepository.join(loginId, userName, nickName, loginPw, email, phoneNum);
		return ResultData.from("S-1", "회원가입완료!");
	}

}
