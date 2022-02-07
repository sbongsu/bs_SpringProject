package com.sbs.exam.bsProject.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sbs.exam.bsProject.vo.Board;

@Mapper
public interface BoardRepository {

	@Select("""
			SELECT *
			FROM board
			WHERE id = #{id}
			""")
	Board getBoardById(int id);

}
