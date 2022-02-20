<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="회원가입" />
<%@ include file="../common/head.jspf"%>

<script>
	let MemberJoin__submitDone = false;
	function MemberJoin__submit(form) {
		if (MemberJoin__submitDone) {
			return;
		}

		form.loginId.value = form.loginId.value.trim();

		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요.')
			form.loginId.focus();

			return;
		}
		
		form.userName.value = form.userName.value.trim();

		if (form.userName.value.length == 0) {
			alert('이름을 입력해주세요.')
			form.userName.focus();

			return;
		}

		form.nickName.value = form.nickName.value.trim();

		if (form.nickName.value.length == 0) {
			alert('닉네임을 입력해주세요.')
			form.nickName.focus();

			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.')
			form.loginPw.focus();

			return;
		}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.')
			form.email.focus();

			return;
		}

		form.phoneNum.value = form.phoneNum.value.trim();

		if (form.phoneNum.value.length == 0) {
			alert('휴대전화번호를 입력해주세요.')
			form.phoneNum.focus();

			return;
		}

		MemberJoin__submitDone = true;
		form.submit();
	}
</script>

<form method="POST" action="../member/doJoin" onsubmit="MemberJoin__submit(this); return false;">
  <div class="w-96 h-60 p-2 mx-auto mt-8 rounded-t-2xl rounded-b-2xl">
    <div class="form-control">
      <label class="label text-blue-400">
        <span class="label-text">회원가입</span>
      </label>
      <div class="form-control mt-2">
        <label class="input-group input-group-vertical">
          <span>ID</span>
          <input type="text" name="loginId" placeholder="아이디를 입력해주세요" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>Name</span>
          <input type="text" name="userName" placeholder="이름을 입력해주세요" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>NickName</span>
          <input type="text" name="nickName" placeholder="닉네임을 입력해주세요" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>Password</span>
          <input type="password" name="loginPw" placeholder="비밀번호를 입력해주세요" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>Email</span>
          <input type="email" name="email" placeholder="이메일을 입력해주세요" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>Cell Phone Number</span>
          <input type="tel" name="phoneNum" placeholder="휴대폰번호를 입력해주세요" class="input input-bordered">
        </label>
        <div class="mx-auto mt-2">
          <button type="submit" class="btn btn-ghost mx-auto float-left">회원가입완료</button>
          <button type="button" class="btn btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
        </div>
      </div>
    </div>
  </div>
</form>
<%@ include file="../common/foot.jspf"%>