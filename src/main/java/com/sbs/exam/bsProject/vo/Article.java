package com.sbs.exam.bsProject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {

	private int id;
	private String title;
	private String regDate;
	private String updateDate;
	private String body;
}