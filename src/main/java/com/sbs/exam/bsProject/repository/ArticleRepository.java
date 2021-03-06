package com.sbs.exam.bsProject.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sbs.exam.bsProject.vo.Article;

@Mapper
public interface ArticleRepository {

	@Select("""
			<script>
			SELECT A.*,
			IFNULL(SUM(RP.point), 0) AS extra__sumReactionPoint,
			IFNULL(SUM(IF(RP.point &gt; 0, RP.point, 0)), 0) AS extra__goodReactionPoint,
			IFNULL(SUM(IF(RP.point &lt; 0, RP.point, 0)), 0) AS extra__badReactionPoint
			FROM (
				SELECT A.*,
				M.nickname AS extra__writerName
				FROM article AS A
				LEFT JOIN `member` AS M
				ON A.memberId = M.id
				<if test="boardId != 0">
				WHERE boardId = #{boardId}
				</if>
				<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordTypeCode == 'title'">
						AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<when test="searchKeywordTypeCode == 'body'">
						AND A.body LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<otherwise>
						AND (
							A.title LIKE CONCAT('%', #{searchKeyword}, '%')
							OR
							A.body LIKE CONCAT('%', #{searchKeyword}, '%')
						)
					</otherwise>
				</choose>
			</if>
				ORDER BY
				id DESC
				LIMIT #{pageStart}, #{pageLast}
			) AS A
			LEFT JOIN reactionPoint AS RP
			ON RP.relTypeCode = 'article'
			AND A.id = RP.relId
			GROUP BY A.id
			ORDER BY
			id DESC
			</script>
			""")
	List<Article> getForPrintArticles(int boardId, String searchKeywordTypeCode, String searchKeyword, int pageStart, int pageLast);

	@Select("""
			<script>
			SELECT A.*,
			M.nickname AS extra__writerName,
			IFNULL(SUM(RP.point), 0) AS extra__sumReactionPoint,
			IFNULL(SUM(IF(RP.point &gt; 0, RP.point, 0)), 0) AS extra__goodReactionPoint,
			IFNULL(SUM(IF(RP.point &lt; 0, RP.point, 0)), 0) AS extra__badReactionPoint
			FROM article AS A
			LEFT JOIN `member` AS M
			ON A.memberId = M.id
			LEFT JOIN reactionPoint AS RP
			ON RP.relTypeCode = 'article'
			AND A.id = RP.relId
			WHERE A.id = #{id}
			AND A.id = #{id}
			GROUP BY A.id
			</script>
			""")
	Article getForPrintArticle(int id);

	@Update("""
				<script>
				UPDATE article
				<set>
					<if test="title != null and title !=''">
						title = #{title},
					</if>
					<if test="body != null and body != ''">
						`body` = #{body},
					</if>
					updateDate = NOW()
				</set>
				WHERE id = #{id}
			</script>
					""")
	void articleModify(int id, String title, String body);

	@Delete("""
			DELETE FROM article
			WHERE id = #{id}
			""")
	void articleDelete(int id);

	@Select("""
			<script>
			SELECT COUNT(*)
			FROM article
			WHERE 1
			<if test="boardId != 0">
				AND boardId = #{boardId}
			</if>
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordTypeCode == 'title'">
						AND title LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<when test="searchKeywordTypeCode == 'body'">
						AND body LIKE CONCAT('%', #{searchKeyword}, '%')
					</when>
					<otherwise>
						AND (
							title LIKE CONCAT('%', #{searchKeyword}, '%')
							OR
							body LIKE CONCAT('%', #{searchKeyword}, '%')
						)
					</otherwise>
				</choose>
			</if>
			</script>
			""")
	int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword);

	@Insert("""
			INSERT INTO article
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			boardId = #{boardId},
			title = #{title},
			body = #{body}
			""")
	void doWrite(int memberId, int boardId, String title, String body);

	@Select("""
			SELECT LAST_INSERT_ID()
			""")
	int getLastInsertId();

	@Update("""
			UPDATE article
			SET hitCount = hitCount + 1
			WHERE id = #{id}
			""")
	int increaseHitCount(int id);

	@Select("""
			SELECT hitCount
			FROM article
			WHERE id = #{id}
			""")
	int getArticleHitCount(int id);

	@Update("""
			<script>
			UPDATE article
			SET replyConut = #{repliesCount}
			WHERE id = #{id}
			</script>
			""")
	void repliesConut(int id, int repliesCount);

}
