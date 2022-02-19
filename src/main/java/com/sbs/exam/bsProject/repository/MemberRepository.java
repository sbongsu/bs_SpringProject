package com.sbs.exam.bsProject.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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

	@Update("""
			<script>
			UPDATE `member`
			<set>
				updateDate = NOW(),
				<if test="loginPw != null">
				loginPw = #{loginPw},
				</if>
				<if test="nickName != null">
				nickName = #{nickName},
				</if>
				<if test="email != null">
				email = #{email},
				</if>
				<if test="phoneNum != null">
				phoneNum = #{phoneNum},
				</if>
			</set>
			WHERE id = #{id}
			</script>
			""")
	public void modify(int id, String loginPw, String nickName, String email, String phoneNum);

}
