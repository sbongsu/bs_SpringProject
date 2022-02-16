<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="비밀번호확인" />
<%@ include file="../common/head.jspf"%>
<form method="POST" action="../member/doLoginCheck">
  <div class="w-96 h-60 p-2 mx-auto mt-28 rounded-t-2xl rounded-b-2xl">
    <div class="form-control">
      <label class="label">
        <span class="label-text">비밀번호 확인</span>
      </label>
      <p class="mb-3 ml-2">ID : ${rq.loginedMember.loginId }</p>
      <input name="loginPw" type="password" placeholder="비밀번호" class="input input-bordered">
      <div class="mx-auto mt-2">
        <button class="btn btn-ghost mx-auto float-left">확인</button>
        <button class="btn btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
      </div>
    </div>
  </div>
</form>
<%@ include file="../common/foot.jspf"%>