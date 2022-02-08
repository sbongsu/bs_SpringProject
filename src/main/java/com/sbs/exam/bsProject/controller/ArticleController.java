package com.sbs.exam.bsProject.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.exam.bsProject.service.ArticleService;
import com.sbs.exam.bsProject.service.BoardService;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.Article;
import com.sbs.exam.bsProject.vo.Board;
import com.sbs.exam.bsProject.vo.Rq;

@Controller
public class ArticleController {

	private ArticleService articleService;
	private Rq rq;
	private BoardService boardService;
	
	public ArticleController(ArticleService articleService, Rq rq, BoardService boardService) {
		this.articleService = articleService;
		this.rq = rq;
		this.boardService = boardService;
	}

	@RequestMapping("/usr/article/list")
	public String showList(Model model, @RequestParam(defaultValue = "1") int boardId, @RequestParam(defaultValue = "1") int page) {
		Board board = boardService.getBoardById(boardId);
		
		if(board == null) {
			return Ut.jsHistoryBack("존재하지 않는 게시판입니다.");
		}
		
		int articlesCount = articleService.getArticlesCount(boardId);
		int ArticlesInAPage = 10;
		int pagesCount = (int)Math.ceil((double)articlesCount / ArticlesInAPage);
		List<Article> articles = articleService.getArticles(boardId, ArticlesInAPage, page);
		
		model.addAttribute("board", board);
		model.addAttribute("page", page);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("pagesCount", pagesCount);
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
