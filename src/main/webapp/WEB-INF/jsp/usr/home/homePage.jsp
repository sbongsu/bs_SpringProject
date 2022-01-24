<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 테일윈드 JIT -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" />

<!-- 데이지 UI -->
<link href="https://cdn.jsdelivr.net/npm/daisyui@1.16.2/dist/full.css" rel="stylesheet" type="text/css" />

<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.com/libraries/font-awesome" />
<!-- 사이트 공통 CSS -->
<link rel="stylesheet" href="/resources/common.css">

</head>
<body>
  <header>
    <div class="navbar mb-2 shadow-lg bg-accent-content text-base-content rounded-box">
      <div class="px-2 mx-2 navbar-start">
        <span class="text-lg font-bold main_font"> 댕냥댕냥 </span>
      </div>
      <div class="hidden px-2 mx-2 navbar-center lg:flex">
        <div class="flex items-stretch">
          <a class="btn btn-ghost btn-sm rounded-btn"> 홈 </a>
          <a class="btn btn-ghost btn-sm rounded-btn"> 공지사항 </a>
          <a class="btn btn-ghost btn-sm rounded-btn"> 정보공유게시판 </a>
          <a class="btn btn-ghost btn-sm rounded-btn"> 자유게시판 </a>
        </div>
      </div>
      <div class="navbar-end text-xs text-gray-400">
        <a class="link link-hover">LOGIN</a>
        <a class="link link-hover ml-3 mr-3">JOIN</a>
      </div>
    </div>
  </header>
</body>
</html>