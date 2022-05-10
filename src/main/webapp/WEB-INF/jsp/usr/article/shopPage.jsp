<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="${board.name}" />
<%@ include file="../common/head.jspf"%>
<div class="mt-8">
  <c:if test="${board.name eq '공지사항'}">
    <p class="text-xs text-gray-400">댕냥댕냥 공지사항 게시판입니다.</p>
  </c:if>
  <c:if test="${board.name eq '자유게시판'}">
    <p class="text-xs text-gray-400">자유롭게 소통하는 게시판입니다.^_^</p>
  </c:if>
  <c:if test="${board.name eq '🐶댕냥댕냥샵😸'}">
    <p class="text-xs text-gray-400">자유롭게 소통하는 게시판입니다.^_^</p>
  </c:if>
</div>

<%@ include file="../common/foot.jspf"%>