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
			M.nickname AS extra__writerName
			FROM article AS A
			LEFT JOIN member AS M
			ON A.memberId = M.id
			<if test="boardId != 0">
			WHERE boardId = #{boardId}
			</if>
			ORDER BY
			id DESC
			LIMIT #{pageStart}, #{pageLast}
			</script>
			""")
	List<Article> getArticles(int boardId, int pageStart, int pageLast);

	@Select("""
			SELECT A.*,
			M.nickname AS extra__writerName
			FROM article AS A
			LEFT JOIN member AS M
			ON A.memberId = M.id
			WHERE A.id = #{id}
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
			SELECT COUNT(*)
			FROM article
			WHERE boardId = #{boardId}
			""")
	int getArticlesCount(int boardId);

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
}
