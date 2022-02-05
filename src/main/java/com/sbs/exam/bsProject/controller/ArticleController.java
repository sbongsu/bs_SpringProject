package com.sbs.exam.bsProject.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.exam.bsProject.service.ArticleService;
import com.sbs.exam.bsProject.vo.Article;

@Controller
public class ArticleController {

	private ArticleService articleService;
	
	public ArticleController(ArticleService articleService) {
		this.articleService = articleService;
	}

	@RequestMapping("/usr/article/list")
	public String showList(Model model) {
		
		List<Article> articles = articleService.getArticles();
		
		model.addAttribute("articles", articles);
		
		return "usr/article/list";
	}
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {
		
		Article article = articleService.getForPrintArticle(id);
		
		model.addAttribute("article", article);
		
		return "usr/article/detail";
	}
}
