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
  <c:if test="${board.name eq '댕냥장터'}">
    <p class="text-xs text-gray-400">🐶댕댕이🐶 😸냐옹이😸 장터게시판 입니다</p>
  </c:if>
</div>


<div class="w-11/12 mt-2">
  <div class="overflow-x-auto product-wrap bg-red-50">
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
    <div class="product-box bg-blue-100">
      <div class="w-full h-32 bg-blue-50">
        <a href="">
          <img src="" />
        </a>
      </div>
      <a class="text-xs text-center" href="">
        <p class="mt-3">상품명</p>
        <p>상품가격</p>
      </a>
    </div>
  </div>
</div>
<%@ include file="../common/foot.jspf"%>