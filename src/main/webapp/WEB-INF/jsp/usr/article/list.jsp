<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="${board.name}" />
<%@ include file="../common/head.jspf"%>
<div class="mt-8">
  <p>* ${board.name} (${articlesCount})</p>
  <c:if test="${board.name eq '공지사항'}">
    <p class="text-xs text-gray-400">댕냥댕냥 공지사항 게시판입니다.</p>
  </c:if>
  <c:if test="${board.name eq '자유게시판'}">
    <p class="text-xs text-gray-400">자유롭게 소통하는 게시판입니다.^_^</p>
  </c:if>
</div>
<input type="hidden" name="boardId" value="${param.boardId}" />
<!-- 게시물 리스트 -->
<div class="w-11/12 mt-2">
  <div class="overflow-x-auto bg-red-50">
    <table class="table w-full text-xs">
      <colgroup>
        <col width="50" />
        <col />
        <col width="50" />
        <col width="50" />
        <col width="50" />
        <col width="50" />
      </colgroup>
      <thead>
        <tr class="text-center">
          <th></th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성날짜</th>
          <th>조회수</th>
          <th>추천수</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="article" items="${articles }">
          <tr>
            <th>${article.id }</th>
            <td>
              <a href="../article/detail?id=${article.id }">${article.title } (${article.replyConut })</a>
            </td>
            <td>${article.extra__writerName }</td>
            <td>${article.regDate.substring(2, 16) }</td>
            <td class="text-center">${article.hitCount }</td>
            <td class="text-center">${article.extra__goodReactionPoint }</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
  
  <!-- 검색창 -->
  <div class="overflow-x-auto">
    <form class="float-right">
    <input type="hidden" name="boardId" value="${param.boardId }"/>
      <select class="select select-bordered select-xs w-24"  name="searchKeywordTypeCode">
        <option disabled selected>검색타입</option>
        <option value="title">제목</option>
        <option value="body">내용</option>
        <option value="title,body">제목+내용</option>
      </select>
      <input name="searchKeyword" type="text" placeholder="검색어를 입력해주세요" class="input input-bordered input-xs">
      <button type="submit" class="btn btn-xs">검색</button>
    </form>
  </div>

  <!-- 로그인할때만 글쓰기 버튼 -->
  <c:if test="${rq.isLogined() }">
    <a href="../article/write?boardId=${param.boardId}" class="btn btn-xs mt-2 float-right">글쓰기</a>
  </c:if>

  <!-- 페이징처리 -->
  <div class="btn-group justify-center mt-10">

    <c:set var="pageMenuLen" value="4" />
    <c:set var="startPage" value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1}" />
    <c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />

    <c:set var="pageBaseUri" value="&boardId=${boardId}" />
    <c:set var="pageBaseUri" value="${pageBaseUri}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
    <c:set var="pageBaseUri" value="${pageBaseUri}&searchKeyword=${param.searchKeyword}" />

    <c:if test="${startPage > 1}">
      <a class="btn btn-xs" href="?page=1${pageBaseUri}">1</a>
      <c:if test="${startPage > 2}">
        <a class="btn btn-xs btn-disabled">...</a>
      </c:if>
    </c:if>

    <c:forEach begin="${startPage}" end="${endPage}" var="i">
      <a class="btn btn-xs text-2xl ${param.page == i ? 'btn-active' : ''}" href="?page=${i }${pageBaseUri}">${i }</a>
    </c:forEach>

    <c:if test="${endPage < pagesCount}">
      <c:if test="${endPage < pagesCount - 1}">
        <a class="btn btn-xs btn-disabled">...</a>
      </c:if>
      <a class="btn btn-xs" href="?page=${pagesCount }${pageBaseUri}">${pagesCount}</a>
    </c:if>
  </div>
</div>
<%@ include file="../common/foot.jspf"%>