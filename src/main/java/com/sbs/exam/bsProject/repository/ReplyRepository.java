package com.sbs.exam.bsProject.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sbs.exam.bsProject.vo.Reply;

@Mapper
public interface ReplyRepository {

	@Insert("""
			INSERT INTO reply
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			relTypeCode = #{relTypeCode},
			relId = #{relId},
			body = #{body}
			""")
	void doWrite(int memberId, String relTypeCode, int relId, String body);

	@Select("""
			SELECT LAST_INSERT_ID()
			""")
	int getLastInsertId();

	@Select("""
			SELECT R.*,
			M.nickname AS extra__writerName
			FROM reply AS R
			LEFT JOIN `member` AS M
			ON R.memberId = M.id
			WHERE R.relTypeCode = #{relTypeCode}
			AND R.relId = #{relId}
			""")
	List<Reply> getForPrintReplies(String relTypeCode, int relId);

	@Select("""
			SELECT *
			FROM reply
			WHERE id = #{id};
			""")
	Reply getReplyByID(int id);

	@Update("""
			UPDATE reply
			SET body = #{body}
			WHERE id= #{id}
			""")
	void replyModify(int id, String body);

	@Delete("""
			DELETE FROM reply
			WHERE id = #{id}
			""")
	void replyDelete(int id);

}
