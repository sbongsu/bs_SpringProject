<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="${board.name}" />
<%@ include file="../common/head.jspf"%>
<div class="mt-8">
  <p>* ${board.name}</p>
  <c:if test="${board.name eq '공지사항'}">
    <p class="text-xs text-gray-400">댕냥댕냥 공지사항 게시판입니다.</p>
  </c:if>
  <c:if test="${board.name eq '자유게시판'}">
    <p class="text-xs text-gray-400">자유롭게 소통하는 게시판입니다.^_^</p>
  </c:if>
</div>
<div class="w-11/12 mt-2">
  <div class="overflow-x-auto">
    <table class="table w-full text-xs">
      <colgroup>
        <col width="50" />
        <col />
        <col width="50" />
        <col width="50" />
      </colgroup>
      <thead>
        <tr class="text-center">
          <th></th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성날짜</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="article" items="${articles }">
          <tr>
            <th>${article.id }</th>
            <td>
              <a href="../article/detail?id=${article.id }">${article.title }</a>
            </td>
            <td>${article.extra__writerName }</td>
            <td>${article.regDate.substring(2, 16) }</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
<%@ include file="../common/foot.jspf"%>