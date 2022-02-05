package com.sbs.exam.bsProject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.ArticleRepository;
import com.sbs.exam.bsProject.vo.Article;

@Service
public class ArticleService {

	private ArticleRepository articleRepository;
	
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	public List<Article> getArticles() {
		
		return articleRepository.getArticles();
	}

	public Article getForPrintArticle(int id) {
		// TODO Auto-generated method stub
		return articleRepository.getForPrintArticle(id);
	}

}
