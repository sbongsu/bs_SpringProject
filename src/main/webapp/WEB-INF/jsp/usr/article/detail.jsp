<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="게시물상세보기" />
<%@ include file="../common/head.jspf"%>
<script>
let ReplyWrite__submitFormDone = false;
function ReplyWrite__submitForm(form){
	
	form.body.value = form.body.value.trim();
	
	if(form.body.value.length == 0){
		alert('댓글을 입력해주세요');
		form.body.focus();
		return;
	}
	
	ReplyWrite__submitFormDone = true;
	form.submit();
}
</script>
<%--게시물 상세보기--%>
<section>
  <div class="overflow-x-auto mt-12 w-3/4">
    <div class=" border-2 border-gray-200 rounded-lg">

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
          <a href="../article/modify?id=${article.id }" onclick="if ( confirm('정말 수정하시겠습니까?') == false ) return false;"
            class="btn btn-ghost"
          >수정</a>
          <a href="../article/doDelete?id=${article.id }"
            onclick="if ( confirm('정말 삭제하시겠습니까?') == false ) return false;" class="btn btn-ghost"
          >삭제</a>
        </div>
      </c:if>
    </div>
  </div>
</section>

<section>
<p>댓글리스트(${repliesCount})</p>
</section>

<section>
  <div class="overflow-x-auto w-3/4 mt-2 ml-2 p-3">
    <p>댓글작성</p>

    <%--댓글 로그인 후 작성 --%>
    <c:if test="${!rq.isLogined() }">
      <p>
        <a class="text-blue-500" href="/usr/member/showLogin">로그인</a>
        후 작성해주세요.
      </p>
    </c:if>
    <c:if test="${rq.isLogined() }">
      <form method="POST" action="../reply/dowrite" onsubmit="ReplyWrite__submitForm(this); return false;">
        <input type="hidden" name="relTypeCode" value="article" />
        <input type="hidden" name="relId" value="${article.id}" />
        <div>
          <textarea class="textarea textarea-bordered w-11/12 mt-2 ml-10" rows="3" name="body" placeholder="댓글을 입력해주세요"></textarea>
          <div>
            <button class="btn btn-active float-right mr-14">댓글등록</button>
          </div>
        </div>


      </form>
    </c:if>
  </div>
</section>
<%@ include file="../common/foot.jspf"%>