package com.sbs.exam.bsProject.service;

import org.springframework.stereotype.Service;

import com.sbs.exam.bsProject.repository.BoardRepository;
import com.sbs.exam.bsProject.vo.Board;

@Service
public class BoardService {

	private BoardRepository boardRepository;
	
	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}

	public Board getBoardById(int id) {
		
		return boardRepository.getBoardById(id);
	}

}
