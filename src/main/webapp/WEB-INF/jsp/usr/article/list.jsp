<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="${board.name}" />
<%@ include file="../common/head.jspf"%>
<div class="w-11/12">
  <div class="overflow-x-auto mt-12">
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
            <td><a href="../article/detail?id=${article.id }">${article.title }</a></td>
            <td>${article.extra__writerName }</td>
            <td>${article.regDate.substring(2, 16) }</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
<%@ include file="../common/foot.jspf"%>