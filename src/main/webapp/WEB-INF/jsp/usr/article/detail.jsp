<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="게시판" />
<%@ include file="../common/head.jspf"%>

<div class="overflow-x-auto mt-12 w-3/4 h-96 border border-gray-200 rounded-lg">
  <div class="mt-12 ml-9">
    <%--게시물 제목 --%>
    <p class="text-2xl text-blue-500">${article.title}</p>
    
    <%--게시물 작성자 내용 --%>
    <span class="text-xs">${article.extra__writerName }</span>
    <span class="text-xs ml-1">${article.regDate.substring(2, 16) }</span>
    <%--게시물 내용 --%>
    <div class="mt-6">${article.body }</div>
  </div>
</div>

<%@ include file="../common/foot.jspf"%>