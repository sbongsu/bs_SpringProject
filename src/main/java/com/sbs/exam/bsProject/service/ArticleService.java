package com.sbs.exam.bsProject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.ArticleRepository;
import com.sbs.exam.bsProject.vo.Article;
import com.sbs.exam.bsProject.vo.ResultDate;

@Service
public class ArticleService {

	private ArticleRepository articleRepository;
	
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	public List<Article> getArticles(int boardId, int articlesInAPage, int page) {
		
		int pageStart = (page - 1) * articlesInAPage;
		int pageLast = articlesInAPage;
		
		return articleRepository.getArticles(boardId, pageStart, pageLast);
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

	public ResultDate doWrite(String title, String body) {
		articleRepository.doWrite(title,body);
		return ResultDate.from("S-1", "게시물을 작성 하였습니다.");
		
	}



}
