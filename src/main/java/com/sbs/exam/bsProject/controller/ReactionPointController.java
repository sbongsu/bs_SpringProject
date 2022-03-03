package com.sbs.exam.bsProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.exam.bsProject.service.ReactionPointService;
import com.sbs.exam.bsProject.vo.ResultData;
import com.sbs.exam.bsProject.vo.Rq;

@Controller
public class ReactionPointController {

	private Rq rq;
	private ReactionPointService reactionPointService;

	public ReactionPointController(ReactionPointService reactionPointService, Rq rq) {
		this.reactionPointService = reactionPointService;
		this.rq = rq;
	}

	@RequestMapping("/usr/reactionPoint/doGoodReaction")
	@ResponseBody
	public String doGoodReaction(String relTypeCode, int relId, String replaceUri) {
		boolean actorCanMakeReactionPoint = reactionPointService.actorCanSeeReactionPoint(rq.getLoginedId(),relId, relTypeCode);
		
		if(actorCanMakeReactionPoint == false) {
			rq.jsHistoryBack("이미 처리되었습니다.");
		}
		
		ResultData addGoodReactionPointRd =reactionPointService.addGoodReactionPoint(rq.getLoginedId(), relId, relTypeCode);
		
		return rq.jsReplace(addGoodReactionPointRd.getMsg(), replaceUri);
	}

	@RequestMapping("/usr/reactionPoint/doBadReaction")
	@ResponseBody
	public String doBadReaction(String relTypeCode, int relId, String replaceUri) {
		boolean actorCanMakeReactionPoint = reactionPointService.actorCanSeeReactionPoint(rq.getLoginedId(),relId, relTypeCode);
		
		if(actorCanMakeReactionPoint == false) {
			rq.jsHistoryBack("이미 처리되었습니다.");
		}
		
		ResultData addBadReactionPointRd =reactionPointService.addBadReactionPoint(rq.getLoginedId(), relId, relTypeCode);

		return rq.jsReplace(addBadReactionPointRd.getMsg(), replaceUri);
	}

}
