package com.sbs.exam.bsProject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.ReplyRepository;
import com.sbs.exam.bsProject.util.Ut;
import com.sbs.exam.bsProject.vo.Member;
import com.sbs.exam.bsProject.vo.Reply;
import com.sbs.exam.bsProject.vo.ResultData;
import com.sbs.exam.bsProject.vo.Rq;

@Service
public class ReplyService {

	private ReplyRepository replyRepository;
	private Rq rq;
	
	public ReplyService(ReplyRepository replyRepository, Rq rq) {
		this.replyRepository = replyRepository;
		this.rq = rq;
	}
	public ResultData doWrite(int actor, String relTypeCode, int relId, String body) {
		
		replyRepository.doWrite(actor, relTypeCode, relId, body);
		int id = replyRepository.getLastInsertId();
		return ResultData.from("S-1",Ut.f("%d번 댓글이 생성되었습니다.", id));
	}
	public List<Reply> getForPrintReplies(Member loginedMember, String relTypeCode, int relId) {
		return replyRepository.getForPrintReplies(relTypeCode, relId);
		
	}

}
