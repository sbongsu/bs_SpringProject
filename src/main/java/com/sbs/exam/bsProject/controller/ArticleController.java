package com.sbs.exam.bsProject.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.exam.bsProject.service.ArticleService;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.Article;
import com.sbs.exam.bsProject.vo.Rq;

@Controller
public class ArticleController {

	private ArticleService articleService;
	private Rq rq;
	
	public ArticleController(ArticleService articleService, Rq rq) {
		this.articleService = articleService;
		this.rq = rq;
	}

	@RequestMapping("/usr/article/list")
	public String showList(Model model) {
		
		List<Article> articles = articleService.getArticles();
		
		model.addAttribute("articles", articles);
		
		return "usr/article/list";
	}
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {
		
		Article article = articleService.getForPrintArticle(rq.getLoginedId(),id);
		
		model.addAttribute("article", article);
		
		return "usr/article/detail";
	}
	
	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, int id) {
		Article article = articleService.getForPrintArticle(rq.getLoginedId(),id);
		
		if(article == null) {
			return Ut.jsHistoryBack("게시물이 존재하지 않습니다.");
		}
		
		model.addAttribute("article", article);
		
		return "usr/article/modify";
	}
	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {
		
		Article article = articleService.getForPrintArticle(rq.getLoginedId(),id);
		
		if(article == null) {
			return Ut.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}
		
		
		if(!article.isExtra__actorCanSee()) {
			return "권한이 없습니다.";
		}
		
		articleService.articleModify(id, title, body);
		return Ut.jsReplace("게시물이 수정되었습니다",  Ut.f("../article/detail?id=%d", id));
	}
	
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		
		Article article = articleService.getForPrintArticle(rq.getLoginedId(),id);
		
		if(article == null) {
			return Ut.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}
		
		
		if(!article.isExtra__actorCanSee()) {
			return "권한이 없습니다.";
		}
		
		articleService.articleDelete(id);
		return Ut.jsReplace("게시물이 삭제되었습니다", "/");
	}
}
