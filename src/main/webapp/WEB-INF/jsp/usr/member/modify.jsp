<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="회원정보수정" />
<%@ include file="../common/head.jspf"%>

<script>
	let MemberModify__submitDone = false;
	function MemberModify__submit(form) {
		if (MemberModify__submitDone) {
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();

			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호확인을 입력해주세요.')
				form.loginPwConfirm.focus();

				return;
			}

			if (form.loginPw.value != form.loginPwConfirm.value) {
				alert('비밀번호확인이 일치하지 않습니다.');
				form.loginPwConfirm.focus();

				return;
			}
		}

		form.nickName.value = form.nickName.value.trim();

		if (form.nickName.value.length == 0) {
			alert('닉네임을 입력해주세요.')
			form.nickName.focus();

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

		MemberModify__submitDone = true;
		form.submit();
	}
</script>

<form method="POST" action="../member/doModify" onsubmit="MemberModify__submit(this); return false;">
  <div class="w-96 h-60 p-2 mx-auto mt-6 rounded-t-2xl rounded-b-2xl">
    <div class="form-control">
      <label class="label text-blue-400">
        <span class="label-text">회원정보 수정</span>
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
          <input type="text" name="nickName" value="${rq.loginedMember.nickName }" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>New Password</span>
          <input type="password" name="loginPw" placeholder="새 비밀번호를 입력해주세요" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>New Password Check</span>
          <input type="password" name="loginPwConfirm" placeholder="새 비밀번호를 확인해주세요" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>Email</span>
          <input type="email" name="email" value="${rq.loginedMember.email }" class="input input-bordered">
        </label>
        <label class="input-group input-group-vertical mt-2">
          <span>Cell Phone Number</span>
          <input type="tel" name="phoneNum" value="${rq.loginedMember.phoneNum }" class="input input-bordered">
        </label>
        <div class="mx-auto mt-2">
          <button type="submit" class="btn btn-ghost mx-auto float-left">회원정보수정</button>
          <button type="button" class="btn btn-ghost" type="button" onclick="history.back();">뒤로가기</button>
        </div>
      </div>
    </div>
  </div>
</form>
<%@ include file="../common/foot.jspf"%>