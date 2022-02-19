<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="마이페이지" />
<%@ include file="../common/head.jspf"%>

  <div class="w-96 h-60 p-2 mx-auto mt-12 rounded-t-2xl rounded-b-2xl">
    <div class="form-control">
      <label class="label text-blue-400">
        <span class="label-text">마이페이지</span>
      </label>
      <div class="form-control">
        <label class="input-group input-group-vertical">
          <span>ID</span>
          <input type="text" disabled value="${rq.loginedMember.loginId }" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>Name</span>
          <input type="text" disabled value="${rq.loginedMember.userName }" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>NickName</span>
          <input type="text" disabled name="nickName" value="${rq.loginedMember.nickName }" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>Email</span>
          <input type="text" disabled name="email" type="email" value="${rq.loginedMember.email }" " class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>Cell Phone Number</span>
          <input type="text" disabled name="phoneNum" type="tel" value="${rq.loginedMember.phoneNum }" " class="input input-bordered">
        </label>
        <div class="mx-auto mt-2">
          <a href="/usr/member/loginCheck?replaceUri=/usr/member/showModify" class="btn btn-ghost mx-auto float-left">회원정보수정</a>
          <button class="btn btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
        </div>
      </div>
    </div>
<%@ include file="../common/foot.jspf"%>