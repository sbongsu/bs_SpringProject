<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="로그인" />
<%@ include file="../common/head.jspf"%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<form method="POST" action="../member/doLogin">
  <div class="w-96 h-60 p-2 mx-auto mt-28 rounded-t-2xl rounded-b-2xl">
    <div class="form-control">
      <label class="label">
        <span class="label-text">ID로그인</span>
      </label>
      <input name="loginId" type="text" placeholder="아이디" class="input input-bordered mb-2">
      <input name="loginPw" type="password" placeholder="비밀번호" class="input input-bordered">
      <div class="mx-auto mt-2">
        <button class="btn btn-ghost mx-auto float-left">로그인</button>
        <button type="button" class="btn btn-ghost mx-auto ml-2">회원가입</button>
        <%--카카오 REST API코드, 리다이렉트주소! --%>
        <a href="https://kauth.kakao.com/oauth/authorize?client_id=8e5884bd3c5a6e6fba97ef8aee1a0019&redirect_uri=http://localhost:8084/auth/kakao/callback&response_type=code">
          <img src="../../resources/img/kakao_login_medium_wide.png" />
        </a>
      </div>
    </div>
  </div>
</form>
<%@ include file="../common/foot.jspf"%>