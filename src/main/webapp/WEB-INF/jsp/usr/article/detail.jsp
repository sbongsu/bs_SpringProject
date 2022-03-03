<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="게시물상세보기" />
<%@ include file="../common/head.jspf"%>
<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__viewDone';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);
		$.get('../article/doIncreaseHitCountAjax', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}

	$(function() {

		ArticleDetail__increaseHitCount();

	})
</script>

<script>
	let ReplyWrite__submitFormDone = false;
	function ReplyWrite__submitForm(form) {

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
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
    <div class=" border-2 border-gray-200 rounded-lg p-9 pb-0 pt-0">

      <div class="mt-12 h-96">

        <%--게시물 제목 --%>
        <p class="text-2xl text-blue-500">${article.title}</p>

        <%--게시물 작성자 내용, 조회수, 추천수 --%>
        <span class="text-xs">${article.extra__writerName }</span>
        <span class="text-xs ml-1">${article.regDate.substring(2, 16) }</span>
        <span class="text-xs ml-1">
          조회수 :
          <span class="badge badge-xs p-1 article-detail__hit-count">${article.hitCount }</span>
        </span>
        <span class="text-xs ml-1">
          추천수 :
          <span class="badge badge-xs p-1 article-detail__hit-count">${article.extra__goodReactionPoint }</span>
        </span>

        <%--게시물 내용 --%>
        <div class="mt-6">${article.body }</div>

      </div>
      <%--좋아요, 싫어요 --%>
      <div class="flex items-center justify-center p-2">
      
      <c:if test="${actorCanSeeReactionPoint }">
        <a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" class="btn btn-info btn-md btn-circle">
          👍
          <br>
          추천
        </a>
        </c:if>
        
        <%--추천수 --%>
        <div class="w-10 h-10 text-center text-2xl leading-loose">${article.extra__goodReactionPoint}</div>
        
        <c:if test="${actorCanSeeReactionPoint }">
        <a href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" class="btn btn-error btn-md btn-circle">
          👎
          <br>
          비추천
        </a>
        </c:if>
      </div>
    </div>
    <%--수정, 삭제버튼--%>
    <c:if test="${article.extra__actorCanSee }">
      <div class="float-right mt-1">
        <a href="../article/modify?id=${article.id }" onclick="if ( confirm('정말 수정하시겠습니까?') == false ) return false;"
          class="btn btn-ghost"
        >수정</a>
        <a href="../article/doDelete?id=${article.id }" onclick="if ( confirm('정말 삭제하시겠습니까?') == false ) return false;"
          class="btn btn-ghost"
        >삭제</a>
      </div>
    </c:if>
  </div>
</section>

<script>
	$(document).ready(function() {
		$('.reply-modify-but').click(function() {

			$('reply-modify-View').toggleClass('active');
			$('.reply-body').toggleClass('active');
		})

	})
</script>

<section>
  <div class="overflow-x-auto w-3/4 mt-2 ml-2 p-3 bg-gray-50 rounded-lg">
    <p class="mt-2">댓글리스트(${repliesCount})</p>
    <c:forEach var="reply" items="${replies }">
      <div class="border border-r-0 border-l-0 border-t-0 border-gray-100 mt-1 p-3">
        <p>${reply.extra__writerName }
          <span class="text-xs text-gray-400">${reply.regDate }</span>
        <div class="w-10 h-5 bg-red-300 float-right reply-modify-but">
          <button>수정</button>
        </div>
        </p>
        <p class="reply-body">${reply.body }</p>
        <form class="reply-modify-View" method="POST" action="../reply/domodify">
          <textarea class="textarea textarea-bordered w-11/12 mt-2 ml-10" rows="3" name="body">${reply.body }</textarea>
        </form>
      </div>
    </c:forEach>

    <%--댓글작성 --%>
    <p class="mt-2">댓글작성</p>
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