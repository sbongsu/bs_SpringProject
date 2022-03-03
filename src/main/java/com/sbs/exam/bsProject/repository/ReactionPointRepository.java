package com.sbs.exam.bsProject.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ReactionPointRepository {

	@Select("""
			<script>
			SELECT SUM(point)
			FROM reactionPoint
			WHERE memberId = #{actorId}
			AND relTypeCode = #{relTypeCode}
			AND relId = #{relId}
			</script>
			""")
	int getSumReactionPointByMemberId(int actorId, int relId, String relTypeCode);

}
