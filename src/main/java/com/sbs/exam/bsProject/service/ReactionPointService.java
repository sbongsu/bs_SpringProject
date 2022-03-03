package com.sbs.exam.bsProject.service;

import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.ReactionPointRepository;

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

}
