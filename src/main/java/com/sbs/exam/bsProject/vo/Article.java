package com.sbs.exam.bsProject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {

	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String title;
	private String body;
	private int hitCount;
	private int replyConut;
	
	
	private int extra__sumReactionPoint;
	private int extra__goodReactionPoint;
	private int extra__badReactionPoint;
	private String extra__writerName;
	private boolean extra__actorCanSee;
}
