<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="게시물상세보기" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../../common/toastUiEditorLib.jspf"%>

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
        <div class="toast-ui-viewer mt-6">
          <script type="text/x-template">
			${article.body}
       	  </script>
        </div>

      </div>
      <%--좋아요, 싫어요 --%>
      <div class="flex items-center justify-center p-2">
        <c:if test="${actorCanMakeReaction}">
          <a
            href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
            class="btn btn-info btn-md btn-circle"
          >
            👍
            <br>
            추천
          </a>
        </c:if>
        <c:if test="${actorCanCancelBadReaction}">
          <a onclick="alert(this.title); return false;" title="먼저 비추천을(를) 취소해주세요." href="#"
            class="btn btn-md btn-circle"
          >
            👍
            <br>
            추천
          </a>
        </c:if>
        <c:if test="${actorCanCancelGoodReaction}">
          <a
            href="/usr/reactionPoint/doGoodDelReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
            class="btn btn-info btn-md btn-circle"
          >
            👍
            <br>
            추천
          </a>
        </c:if>
        <%--추천수 --%>
        <div class="w-10 h-10 text-center text-2xl leading-loose">${article.extra__goodReactionPoint}</div>
        <c:if test="${actorCanMakeReaction}">
          <a
            href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
            class="btn btn-error btn-md btn-circle"
          >
            👎
            <br>
            비추천
          </a>
        </c:if>
        <c:if test="${actorCanCancelBadReaction}">
          <a
            href="/usr/reactionPoint/doBadDelReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
            class="btn btn-error btn-md btn-circle"
          >
            👎
            <br>
            비추천
          </a>
        </c:if>
        <c:if test="${actorCanCancelGoodReaction}">
          <a onclick="alert(this.title); return false;" title="먼저 추천을(를) 취소해주세요." href="#" class="btn btn-md btn-circle">
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
	function ReplyModifyShow(el) {
		var $div = $(el).closest('[data-id]');

		var replybody = $div.find(' > .replyBody').html().trim();

		$div.find(' > .ReplyModifyCenBut > textarea').val(replybody);

		$div.attr('data-modify-mode', 'Y');
		$div.siblings('[data-modify-mode = "Y"]').attr('data-modify-mode', 'N');
	}

	function ReplyModifyNone(el) {
		var $div = $(el).closest('[data-id]');
		$div.attr('data-modify-mode', 'N');

	}

	function Article__modifyReply(form) {
		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			form.body.focus();
			alert('수정할 댓글을 입력해 주세요.');
			return;
		}

		var $div = $(form).closest('[data-id]');

		var newBody = form.body.value;
		var id = parseInt($div.attr('data-id'));

		$.post('../reply/doModifyReplyAjax', {
			id : id,
			body : newBody
		}, function(data) {
			$div.attr('data-modify-mode', 'N');

			if (data.resultCode == 'S-1') {
				var $replyBodyText = $div.find('.replyBody');
				var $textarea = $div.find('form textarea');

				$replyBodyText.text($textarea.val());
			} else {
				$div.attr('data-modify-mode', 'N');
				if (data.msg) {
					alert(data.msg)
				}
			}
		});

	}

	function ReplyDelete(obj) {
		var $div = $(obj).closest('[data-id]');

		var id = parseInt($div.attr('data-id'));

		$.post('../reply/doDeleteReplyAjax', {
			id : id,
		}, function(data) {
			$div.remove();
			repliesCount();
		});

	}

	function repliesCount() {

		$.post('../reply/doRepliesCountAjax', {
			id : params.id,
		}, function(data) {

			$('.replyList').find(' > p > .repliesConutAjax').empty().text(data);
		});

	}
</script>

<section>
  <div class="replyList overflow-x-auto w-3/4 mt-2 ml-2 p-3 bg-gray-50 rounded-lg">
    <%--댓글리스트 --%>
    <p class="mt-2">
      댓글리스트(
      <span class="repliesConutAjax">${repliesCount}</span>
      )
    </p>
    <c:forEach var="reply" items="${replies }">
      <c:set var="memberId" value="${reply.memberId }" />
      <div data-modify-mode="N" data-id="${reply.id}"
        class="border border-r-0 border-l-0 border-t-0 border-gray-200 mt-1 p-5"
      >
        <c:if test="${rq.loginedMember.id == memberId}">
          <div class="reply-modify-but w-10 h-5 float-right mb-3">
            <button class="ReplyModifyBut hover:text-blue-500" onclick="ReplyModifyShow(this);">수정</button>
            <button class="ReplyModifyBut hover:text-blue-500"
              onclick="if ( confirm('정말 삭제하시겠습니까?') ) { ReplyDelete(this); } return false;"
            >삭제</button>
          </div>
        </c:if>
        <p>${reply.extra__writerName }
          <span class="text-xs text-gray-400">${reply.regDate }</span>
        </p>
        <div class="ReplyModifyBut replyBody">${reply.body }</div>
        <%--댓글수정폼 --%>
        <form class="ReplyModifyCenBut" onsubmit="Article__modifyReply(this); return false;">
          <input type="hidden" name="id" value="${reply.id}" />
          <textarea maxlength="300" class="textarea textarea-bordered w-11/12 mt-2 ml-10" rows="3" name="body"></textarea>
          <button type="button" class="ReplyModifyCenBut float-right ml-2 mr-10 hover:text-blue-500"
            onclick="ReplyModifyNone(this);"
          >수정취소</button>
          <button type="submit" class="float-right mr-1 hover:text-blue-500">댓글수정</button>
        </form>

        <div class="replyModifyView"></div>

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