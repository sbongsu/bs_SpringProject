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

	public boolean actorCanSeeReactionPoint(int actorId, int relId, String relTypeCode) {
		if ( actorId == 0 ) {
			return false;
		}
		
		return reactionPointRepository.getSumReactionPointByMemberId(actorId, relId, relTypeCode) == 0;
	}

	public ResultData addGoodReactionPoint(int actorId, int relId, String relTypeCode) {
		reactionPointRepository.addGoodReactionPoint(actorId, relId, relTypeCode);
		
		return ResultData.from("S-1", "추천 완료!");
		
	}

	public ResultData addBadReactionPoint(int actorId, int relId, String relTypeCode) {
		reactionPointRepository.addBadReactionPoint(actorId, relId, relTypeCode);
		
		return ResultData.from("S-1", "비추천 완료!");
	}

}
