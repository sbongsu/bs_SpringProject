package com.sbs.exam.bsProject.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ReactionPointRepository {

	@Select("""
			<script>
			SELECT IFNULL(SUM(point), 0)
			FROM reactionPoint
			WHERE memberId = #{memberId}
			AND relTypeCode = #{relTypeCode}
			AND relId = #{relId}
			</script>
			""")
	int getSumReactionPointByMemberId(int memberId, int relId, String relTypeCode);

	@Insert("""
			INSERT INTO reactionPoint
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			relTypeCode = #{relTypeCode},
			relId = #{relId},
			`point` = 1
			""")
	void addGoodReactionPoint(int memberId, int relId, String relTypeCode);

	@Insert("""
			INSERT INTO reactionPoint
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{actorId},
			relTypeCode = #{relTypeCode},
			relId = #{relId},
			`point` = -1
			""")
	void addBadReactionPoint(int actorId, int relId, String relTypeCode);

}
