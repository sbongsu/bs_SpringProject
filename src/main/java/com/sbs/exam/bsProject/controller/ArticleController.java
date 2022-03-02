package com.sbs.exam.bsProject.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.exam.bsProject.service.ArticleService;
import com.sbs.exam.bsProject.service.BoardService;
import com.sbs.exam.bsProject.service.ReplyService;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.Article;
import com.sbs.exam.bsProject.vo.Board;
import com.sbs.exam.bsProject.vo.Reply;
import com.sbs.exam.bsProject.vo.ResultData;
import com.sbs.exam.bsProject.vo.Rq;

@Controller
public class ArticleController {

	private ArticleService articleService;
	private Rq rq;
	private BoardService boardService;
	private ReplyService replyService;
	
	public ArticleController(ArticleService articleService, Rq rq, BoardService boardService, ReplyService replyService) {
		this.articleService = articleService;
		this.rq = rq;
		this.boardService = boardService;
		this.replyService =replyService;
	}
	
	@RequestMapping("/usr/article/write")
	public String showWrite(String title, String body) {
		
		return "usr/article/write";
	}
	
	@RequestMapping("/usr/article/dowrite")
	@ResponseBody
	public String doWrite(int boardId, String title, String body) {
		
		if(Ut.empty(title)) {
			return rq.jsHistoryBack("제목을 입력해주세요");
		}
		
		if(Ut.empty(body)) {
			return rq.jsHistoryBack("내용을입력해주세요");
		}
		
		ResultData writeRd = articleService.doWrite(rq.getLoginedId(),boardId,title, body);
		
		return rq.jsReplace(writeRd.getMsg(), Ut.f("../article/list?boardId=%d&page=1", boardId));
	}
	
	@RequestMapping("/usr/article/list")
	public String showList(Model model, @RequestParam(defaultValue = "1") int boardId, @RequestParam(defaultValue = "1") int page) {
		Board board = boardService.getBoardById(boardId);
		
		if(board == null) {
			return rq.jsHistoryBack("존재하지 않는 게시판입니다.");
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
		ResultData increaseHitCountRd = articleService.increaseHitCount(id);
		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMember(), "article", id);
		int repliesCount = replies.size();

		model.addAttribute("repliesCount", repliesCount);
		model.addAttribute("replies", replies);
		model.addAttribute("article", article);
		
		return "usr/article/detail";
	}
	
	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, int id) {
		Article article = articleService.getForPrintArticle(rq.getLoginedId(),id);
		
		if(article == null) {
			return rq.historyBackJsOnView("게시물이 존재하지 않습니다");
		}
		
		if(!article.isExtra__actorCanSee()) {
			return "권한이 없습니다.";
		}
		
		model.addAttribute("article", article);
		
		return "usr/article/modify";
	}
	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {
		
		Article article = articleService.getForPrintArticle(rq.getLoginedId(),id);
		
		if(article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}
		
		
		if(!article.isExtra__actorCanSee()) {
			return rq.jsHistoryBack("권한이 없습니다.");
		}
		
		articleService.articleModify(id, title, body);
		return rq.jsReplace("게시물이 수정되었습니다",  Ut.f("../article/detail?id=%d", id));
	}
	
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		
		Article article = articleService.getForPrintArticle(rq.getLoginedId(),id);
		
		if(article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}
		
		
		if(!article.isExtra__actorCanSee()) {
			return rq.jsHistoryBack("권한이 없습니다.");
		}
		
		articleService.articleDelete(id);
		return rq.jsReplace("게시물이 삭제되었습니다", "/");
	}
}
