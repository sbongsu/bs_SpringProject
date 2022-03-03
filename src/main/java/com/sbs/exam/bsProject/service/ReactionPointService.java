package com.sbs.exam.bsProject.service;

import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.ReactionPointRepository;
import com.sbs.exam.bsProject.vo.ResultData;

@Service
public class ReactionPointService {

	private ReactionPointRepository reactionPointRepository;

	public ReactionPointService(ReactionPointRepository reactionPointRepository) {
		this.reactionPointRepository = reactionPointRepository;
	}

	public ResultData actorCanSeeReactionPoint(int actorId, int relId, String relTypeCode) {
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요");
		}

		int sumReactionPointByMemberId = reactionPointRepository.getSumReactionPointByMemberId(actorId, relId,
				relTypeCode);

		if (sumReactionPointByMemberId != 0) {
			return ResultData.from("F-2", "리액션이 불가능합니다.", "sumReactionPointByMemberId", sumReactionPointByMemberId);
		}

		return ResultData.from("S-1", "리액션이 가능합니다.", "sumReactionPointByMemberId", sumReactionPointByMemberId);
	}

	public ResultData addGoodReactionPoint(int actorId, int relId, String relTypeCode) {
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요");
		}

		int sumReactionPointByMemberId = reactionPointRepository.getSumReactionPointByMemberId(actorId, relId,
				relTypeCode);

		if (sumReactionPointByMemberId > 0) {
			return ResultData.from("F-1", "이미 추천을(를) 했습니다.");
		}

		if (sumReactionPointByMemberId < 0) {
			return ResultData.from("F-1", "비추천을(를) 취소해주세요!");
		}

		reactionPointRepository.addGoodReactionPoint(actorId, relId, relTypeCode);

		return ResultData.from("S-1", "추천 완료!");

	}

	public ResultData addBadReactionPoint(int actorId, int relId, String relTypeCode) {
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요");
		}

		int sumReactionPointByMemberId = reactionPointRepository.getSumReactionPointByMemberId(actorId, relId,
				relTypeCode);

		if (sumReactionPointByMemberId < 0) {
			return ResultData.from("F-1", "이미 비추천을(를) 했습니다.");
		}

		if (sumReactionPointByMemberId > 0) {
			return ResultData.from("F-1", "추천을(를) 취소해주세요!");
		}

		reactionPointRepository.addBadReactionPoint(actorId, relId, relTypeCode);

		return ResultData.from("S-1", "비추천 완료!");
	}

	public ResultData deleteGoodReactionPoint(int actorId, int relId, String relTypeCode) {
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요");
		}
		reactionPointRepository.deleteReactionPoint(actorId, relId, relTypeCode);
		
		return ResultData.from("S-1", "추천을(를) 취소하셨습니다.");
	}

	public ResultData deleteBadReactionPoint(int actorId, int relId, String relTypeCode) {
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요");
		}
		reactionPointRepository.deleteReactionPoint(actorId, relId, relTypeCode);
		return ResultData.from("S-1", "비추천을(를) 취소하셨습니다.");
	}

}
