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
		return ResultData.from("S-1", Ut.f("%d번 댓글이 생성되었습니다.", id));
	}

	public List<Reply> getForPrintReplies(Member actor, String relTypeCode, int relId) {
		return replyRepository.getForPrintReplies(relTypeCode, relId);
	}

	public ResultData replyModifyAvail(int actorId, int id, String body) {
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요.");
		}

		if (Ut.empty(id)) {
			return ResultData.from("F-1", "수정할 댓글 id을(를) 입력해주세요");
		}

		if (Ut.empty(body)) {
			return ResultData.from("F-1", "수정할 댓글을(를) 입력해주세요");
		}

		Reply reply = replyRepository.getReplyByID(id);

		if (reply.getMemberId() != actorId) {
			return ResultData.from("F-1", "권한이 없습니다");
		}

		return ResultData.from("S-1", "댓글 수정 가능");

	}

	public ResultData replyModify(int id, String body) {

		replyRepository.replyModify(id, body);
		
		return ResultData.from("S-1", "댓글을 수정했습니다.");
	}

	public ResultData replyDeleteAvail(int actorId, int id) {
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요.");
		}
		
		if (Ut.empty(id)) {
			return ResultData.from("F-1", "삭제할 댓글 id을(를) 입력해주세요");
		}
		
		Reply reply = replyRepository.getReplyByID(id);

		if (reply.getMemberId() != actorId) {
			return ResultData.from("F-1", "권한이 없습니다");
		}
		
		return ResultData.from("S-1", "댓글 삭제 가능");
	}

	public ResultData replyDelete(int id) {
		replyRepository.replyDelete(id);
		return ResultData.from("S-1", "댓글을 삭제했습니다.");
	}

}
