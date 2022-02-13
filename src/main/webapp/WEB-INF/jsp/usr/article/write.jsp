<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="글쓰기" />
<%@ include file="../common/head.jspf"%>

<%--게시물 작성--%>
<div class="overflow-x-auto mt-12 w-3/4">
  <div class=" border border-gray-200 rounded-lg">

    <form method="POST" action="../article/dowrite">
      <div class="mt-10 ml-64 pb-6">

        <c:if test="${param.boardId == 1}">
          <input type="hidden" name="boardId" value="1" />
         <span class="text-2xl">공지사항</span>
        </c:if>
        <c:if test="${param.boardId == 2}">
          <input type="hidden" name="boardId" value="2" />
        <span class="text-2xl">자유게시판</span>
        </c:if>
        <span class="text-2xl"> 작성</span>
        <%--게시물 제목 --%>
        <div class="form-control">
          <label class="label">
            <span class="text-blue-500">제목</span>
          </label>
          <input required="required" name="title" type="text" placeholder="제목" class="input input-bordered w-3/4">
        </div>

        <%--게시물 내용 --%>
        <div class="form-control mt-3 w-3/4">
          <label class="label">
            <span class="label-text">내용</span>
          </label>
          <textarea required="required" name="body" class="textarea h-24 textarea-bordered h-64" placeholder="내용"></textarea>
        </div>
      </div>
      <%--수정, 삭제버튼--%>
      <div class="float-right mt-1">
        <button type="submit" class="btn btn-ghost">완료</button>
        <button class="btn btn-ghost" type="button" onclick="history.back();">뒤로가기</button>

      </div>
    </form>
  </div>
</div>
<%@ include file="../common/foot.jspf"%>