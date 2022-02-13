package com.sbs.exam.bsProject.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sbs.exam.bsProject.vo.Member;

@Mapper
public interface MemberRepository {

	@Select("""
			SELECT *
			FROM `member` AS m
			WHERE m.loginId = #{loginId}
			""")
	public Member getMemberId(@Param("loginId") String loginId);

	@Select("""
			SELECT *
			FROM `member` AS M
			WHERE M.id = #{id}
			""")
	public Member getMemberById(int id);

}
