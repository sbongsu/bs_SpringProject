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
  <div class="overflow-x-auto product-wrap">
    <div class="product-position">
      <div class="product-box w-60 text-center">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식1.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              롬트릿 에어드라이 
              <br>
              6,000원
            </span>
          </a>
        </div>
      </div>
      <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식2.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              캐니소스 그랑크뤼
              <br>
              69,000원
            </span>
          </a>
        </div>
      </div>
      <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식3.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              시니어 연어 소시지
              <br>
              6,900원
            </span>
          </a>
        </div>
      </div>
      <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식4.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              비타크래프트 쿠키
              <br>
              3,400원
            </span>
          </a>
        </div>
      </div>
      <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식5.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              치즈크래커
              <br>
              800원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식6.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              덴탈껌 사슴
              <br>
              500원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식7.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              덴탈 츄 허니버터
              <br>
              8,600원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식8.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              치즈 크런치볼
              <br>
              4,800원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식9.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              한우 킹스틱
              <br>
              39,800원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식10.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              기력보충 습식간식
              <br>
              1,200원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식11.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              닭 안심
              <br>
              10,000원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식12.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              치킨 오리 사료샘플
              <br>
              800원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식13.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              천연 연어껍질
              <br>
              4,000원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식14.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              밀웜 콜라겐껌
              <br>
              2,500원
            </span>
          </a>
        </div>
      </div>
            <div class="product-box w-60 text-center bg-blue-50">
        <a href="">
          <img class="h-60" src="/resources/img/dogFood/간식15.jpg" />
        </a>
        <div class="mt-3">
          <a class="" href="">
            <span>
              인섹트 습식캔
              <br>
              15,000원
            </span>
          </a>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="../common/foot.jspf"%>