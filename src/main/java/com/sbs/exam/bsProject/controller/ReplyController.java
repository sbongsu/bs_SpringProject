package com.sbs.exam.bsProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.exam.bsProject.service.ReplyService;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.ResultData;
import com.sbs.exam.bsProject.vo.Rq;

@Controller
public class ReplyController {

	private ReplyService replyService;
	private Rq rq;
	
	public ReplyController(ReplyService replyService, Rq rq) {
		this.replyService = replyService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/reply/dowrite")
	@ResponseBody
	public String doWrite(String relTypeCode, int relId, String body, String replaceUri) {
		
		if(Ut.empty(relTypeCode)) {
			return rq.jsHistoryBack("relTypeCode을(를) 입력해주세요");
		}
		
		if(Ut.empty(relId)) {
			return rq.jsHistoryBack("relId을(를) 입력해주세요");
		}
		
		if(Ut.empty(body)) {
			return rq.jsHistoryBack("댓글을(를)입력해주세요");
		}
		
		ResultData writeRd = replyService.doWrite(rq.getLoginedId(),relTypeCode,relId, body);
		
		switch (relTypeCode) {
			case "article" :
				replaceUri = Ut.f("../article/detail?id=%d", relId);
				break;
		}
		
		return rq.jsReplace(writeRd.getMsg(), replaceUri);
	}
	
}
