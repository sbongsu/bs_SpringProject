<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="게시판" />
<%@ include file="../common/head.jspf"%>
<%--게시물 상세보기--%>
<div class="overflow-x-auto mt-12 w-3/4">
  <div class=" border border-gray-200 rounded-lg">

    <div class="mt-12 ml-9 h-96">

      <%--게시물 제목 --%>
      <p class="text-2xl text-blue-500">${article.title}</p>

      <%--게시물 작성자 내용 --%>
      <span class="text-xs">${article.extra__writerName }</span>
      <span class="text-xs ml-1">${article.regDate.substring(2, 16) }</span>

      <%--게시물 내용 --%>
      <div class="mt-6">${article.body }</div>
    </div>
    <%--수정, 삭제버튼--%>
    <c:if test="${article.extra__actorCanSee }">
      <div class="float-right mt-1">
        <a href="../article/modify?id=${article.id }" class="btn btn-ghost">수정</a>
        <a href="../article/doDelete?id=${article.id }" class="btn btn-ghost">삭제</a>
      </div>
    </c:if>
  </div>
</div>

<%@ include file="../common/foot.jspf"%>