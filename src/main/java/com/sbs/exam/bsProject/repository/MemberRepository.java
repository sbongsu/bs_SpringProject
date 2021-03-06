package com.sbs.exam.bsProject.repository;

import org.apache.ibatis.annotations.Insert;
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
	public Member getMemberLoginId(String loginId);

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

	@Insert("""
			INSERT INTO `member`
			SET loginId = #{loginId},
			userName = #{userName},
			nickName = #{nickName},
			loginPw = #{loginPw},
			email = #{email},
			phoneNum = #{phoneNum},
			regDate = NOW(),
			updateDate = NOW()
			""")
	public void join(String loginId, String userName, String nickName, String loginPw, String email, String phoneNum);

	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();

	@Select("""
			SELECT *
			FROM `member` AS m
			WHERE m.nickName = #{nickName}
			""")
	public Member getMemberByNickName(String nickName);

	@Select("""
			SELECT *
			FROM `member` AS m
			WHERE m.userName = #{userName}
			AND m.email = #{email}
			""")
	public Member getMemberByNameAndEmail(String userName, String email);
}
