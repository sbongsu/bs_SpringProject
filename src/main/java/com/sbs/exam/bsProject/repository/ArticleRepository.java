package com.sbs.exam.bsProject.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sbs.exam.bsProject.vo.Article;

@Mapper
public interface ArticleRepository {

	@Select("""
			SELECT A.*,
			M.nickname AS extra__writerName
			FROM article AS A
			LEFT JOIN member AS M
			ON A.memberId = M.id
			ORDER BY
			id DESC
			""")
	List<Article> getArticles();

	@Select("""
			SELECT *
			FROM article
			WHERE id = #{id}
			""")
	Article getArticle(int id);

}
