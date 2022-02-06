<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="게시판 수정" />
<%@ include file="../common/head.jspf"%>

<script>
  let ArticleModify__submitDone = false;
  function ArticleModify__submit(form) {
    if ( ArticleModify__submitDone ) {
      return;
    }
    
   form.title.value = form.title.value.trim();
    
    if ( form.title.value.length == 0 ) {
      alert('제목을 입력해주세요.')
      form.title.focus();
      
      return;
    }
    
    form.body.value = form.body.value.trim();
    
    if ( form.body.value.length == 0 ) {
      alert('내용을 입력해주세요.')
      form.body.focus();
      
      return;
    }
    
    ArticleModify__submitDone = true;
    form.submit();
  }
</script>

<%--게시물 상세보기--%>
<div class="overflow-x-auto mt-12 w-3/4">
  <div class=" border border-gray-200 rounded-lg">

    <form method="POST" action="../article/doModify" onsubmit="ArticleModify__submit(this); return false;">
    <input type="hidden" name="id" value="${article.id}" />
      <div class="mt-12 ml-64 pb-6">

        <%--게시물 제목 --%>
        <div class="form-control">
          <label class="label">
            <span class="text-blue-500">제목</span>
          </label>
          <input name="title" type="text" placeholder="제목" value="${article.title}" class="input input-bordered w-3/4">
        </div>

        <%--게시물 내용 --%>
        <div class="form-control mt-6 w-3/4">
          <label class="label">
            <span class="label-text">내용</span>
          </label>
          <textarea name="body" class="textarea h-24 textarea-bordered h-64" placeholder="내용">${article.body }</textarea>
        </div>
      </div>
      <%--수정, 삭제버튼--%>
      <div class="float-right mt-1">
        <button type="submit" class="btn btn-ghost">수정</button>
        <button class="btn btn-ghost" type="button" onclick="history.back();">뒤로가기</button>

      </div>
    </form>
  </div>
</div>


<%@ include file="../common/foot.jspf"%>