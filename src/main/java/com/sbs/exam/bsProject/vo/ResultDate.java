package com.sbs.exam.bsProject.vo;

import lombok.Getter;

public class ResultDate {

	@Getter
	private String resultCode;
	@Getter
	private String msg;
	@Getter
	private Object data1;
	
	public static ResultDate from(String resultCode, String msg, Object data1) {
		ResultDate rd = new ResultDate();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1 = data1;
		
		return rd;
	}
	
	public boolean isSuccess() {
		return resultCode.startsWith("S-");
	}
	
	public boolean isFail() {
		return isSuccess() == false;
	}
}
