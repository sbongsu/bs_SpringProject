<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="로그인" />
<%@ include file="../common/head.jspf"%>
<form method="" action="">
  <div class="w-96 h-60 p-2 mx-auto mt-28 rounded-t-2xl rounded-b-2xl">
    <div class="form-control">
      <label class="label">
        <span class="label-text">ID로그인</span>
      </label>
      <input type="text" placeholder="아이디" class="input input-bordered mb-2">
      <input type="passward" placeholder="비밀번호" class="input input-bordered">
      <div class="mx-auto mt-2">
        <button class="btn btn-ghost mx-auto float-left">로그인</button>
        <button type="button" class="btn btn-ghost mx-auto ml-2">회원가입</button>
      </div>
    </div>
  </div>
</form>
<%@ include file="../common/foot.jspf"%>