package com.sbs.exam.bsProject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.ArticleRepository;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.Article;
import com.sbs.exam.bsProject.vo.ResultData;

@Service
public class ArticleService {

	private ArticleRepository articleRepository;
	
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	public List<Article> getArticles(int boardId, int articlesInAPage, int page) {
		
		int pageStart = (page - 1) * articlesInAPage;
		int pageLast = articlesInAPage;
		
		return articleRepository.getForPrintArticles(boardId, pageStart, pageLast);
	}

	public Article getForPrintArticle(int actor, int id) {
		Article article = articleRepository.getForPrintArticle(id);
		
		actorCanSee(actor, article);
		
		return article;
	}

	public void articleModify(int id, String title, String body) {
		articleRepository.articleModify(id, title, body);
	}

	public void actorCanSee(int actor, Article article) {
	
		if (article == null) {
			return;
		}
		
		if(actor == article.getMemberId()) {
			article.setExtra__actorCanSee(true);
		}
	
	}

	public void articleDelete(int id) {
		articleRepository.articleDelete(id);
	}

	public int getArticlesCount(int boardId) {
		return articleRepository.getArticlesCount(boardId);
	}

	public ResultData doWrite(int memberId, int boardId, String title, String body) {
		articleRepository.doWrite(memberId,boardId,title,body);
		int id = articleRepository.getLastInsertId();
		return ResultData.from("S-1",Ut.f("%d번 게시물이 생성되었습니다.", id));
		
	}

	public ResultData increaseHitCount(int id) {
		int affectedRowsCount  = articleRepository.increaseHitCount(id);
		
		if(affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물이 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}
			
		return ResultData.from("S-1", "조회수가 증가되었습니다.", "affectedRowsCount", affectedRowsCount);
	}

	public int getArticleHitCount(int id) {
		return articleRepository.getArticleHitCount(id);
	}

}
