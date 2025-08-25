<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>ECOMORE</title>
<meta content="width=device-width, initial-scale=1" name="viewport" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/free.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyArticle.css" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="container my-5">
		<h2 class="mb-4 fw-bold">매거진</h2>
		<div class="card mt-4 article-card">
			<div class="card-header">
				<h3>${dto.subject}</h3>
				<div class="d-flex justify-content-between text-muted small">
					<span><strong>작성자:</strong> ${dto.name}</span> 
					<span><strong>작성일:</strong>${dto.regDate} | <strong>조회수:</strong> ${dto.hitCount}</span>
				</div>
			</div>
			<div class="card-body">
				<p>${dto.content}</p>
			</div>

			<div class="btn-like-wrapper">
				<button type="button" class="btnSendMagazineLike" title="좋아요">
					<i class="bi ${isUserLiked ? 'bi-heart-fill text-danger' : 'bi-heart' }"></i>
					<span id="magazineLikeCount">${dto.magazineLikeCount}</span>
				</button>
			</div>

		</div>

		<div class="post-navigation">
			<div class="nav-item">
				<span class="fw-bold">이전글 :</span>
				<c:if test="${not empty prevDto}">
					<a href="${pageContext.request.contextPath}/magazine/article/${prevDto.magazineId}?${query}">${prevDto.subject}</a>
				</c:if>
				<c:if test="${empty prevDto}">
					<span>이전글이 없습니다.</span>
				</c:if>
			</div>
			<div class="nav-item">
				<span class="fw-bold">다음글 :</span>
				<c:if test="${not empty nextDto}">
					<a href="${pageContext.request.contextPath}/magazine/article/${nextDto.magazineId}?${query}">${nextDto.subject}</a>
				</c:if>
				<c:if test="${empty nextDto}">
					<span>다음글이 없습니다.</span>
				</c:if>
			</div>
		</div>

		<div class="article-actions">
		    <div class="actions-left">
		        <c:choose>
		            <c:when test="${sessionScope.member.memberId==dto.memberId}">
		                <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/magazine/update?magazineId=${dto.magazineId}&${query}';">수정</button>
		            </c:when>
		        </c:choose>
		        <c:choose>
		            <c:when test="${sessionScope.member.memberId==dto.memberId || sessionScope.member.userLevel>50}">
		                <button type="button" class="btn-default" onclick="deleteOk();">삭제</button>
		            </c:when>
		        </c:choose>
		    </div>
		
		    <div class="actions-right">
		        <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/magazine/list?${query}';">목록</button>
		    </div>
		</div>


		<div class="reply-session mt-5">
			<div class="reply-form-card">
				<div class="reply-form-header">
					<h5 class="form-title">댓글</h5>
					<p class="form-guide">건전한 소통 문화를 함께 만들어주세요.</p>
				</div>
				<div class="reply-form-body">
					<textarea class="form-control" name="content" rows="4"
						placeholder="댓글을 입력하세요"></textarea>
					<div class="text-end mt-2">
						<button type="button" class="btn btn-primary btn-sm btnSendReply">댓글 등록</button>
					</div>
				</div>
			</div>

			<div id="listReply" class="mt-4" data-target="magazineReply" data-magazineId="${dto.magazineId}"></div>
		</div>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/posts/report.jsp"/>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		const CONTEXT_PATH = "${pageContext.request.contextPath}";
		const MAGAZINE_ID = "${dto.magazineId}";
		const QUERY_STRING = "${query}";
		
		function deleteOk() {
			let params = 'magazineId=' + MAGAZINE_ID + '&' + QUERY_STRING;
			let url = CONTEXT_PATH + '/magazine/delete?' + params;

			if(confirm('게시글을 삭제하시겠습니까?')) {
				location.href = url;
			}
		}

		// 페이징
		$(function() {
			listPage(1);
		});

		function listPage(page) {
			let url = CONTEXT_PATH + '/magazine/listReply';
			let params = {magazineId: MAGAZINE_ID, pageNo: page};
			let selector = 'div#listReply';
			
			const fn = function(data) {
				$(selector).html(data);
			};
			
			ajaxRequest(url, 'get', params, 'text', fn);
		}

		// 댓글 등록
		$(function(){
			$('button.btnSendReply').click(function(){
				const $div = $(this).closest('div.reply-form-body');

				let content = $div.find('textarea').val().trim();
				if(! content) {
					$div.find('textarea').focus();
					return false;
				}
				
				let url = CONTEXT_PATH + '/magazine/insertReply';
				let params = {magazineId: MAGAZINE_ID, content:content, parentNum:0}; 

				const fn = function(data){
					$div.find('textarea').val('');
					
					let state = data.state;
					if(state === 'true') {
						listPage(1);
					} else if(state === 'false') {
						alert('댓글 추가에 실패했습니다.');
					}
				};
				
				ajaxRequest(url, 'post', params, 'json', fn);
			});
		});

		// 삭제, 신고
		$(function(){
			$('div#listReply').on('click', '.dropdown-button', function(){
				const $menu = $(this).next('.reply-menu');
				
				$('.reply-menu').not($menu).addClass('d-none');
				
				$menu.toggleClass('d-none');
			});
			
			$('body').on('click', function(evt) {
				const parent = evt.target.parentNode;
				const isMatch = parent.tagName === 'SPAN' && $(parent).hasClass('dropdown-button');		
				
				if(isMatch) {
					return false;
				}
				
				$('div.reply-menu:not(.d-none)').addClass('d-none');
			});
		});

		// 댓글 삭제
		$(function(){
			$('div#listReply').on('click', '.deleteReply', function(){
				if(! confirm('댓글을 삭제하시겠습니까?')) {
				    return false;
				}
				
				let magazineReplyNum = $(this).attr('data-magazineReplyNum');
				let page = $(this).attr('data-pageNo');
				
				let url = CONTEXT_PATH + '/magazine/deleteReply';
				let params = {magazineReplyNum:magazineReplyNum, mode:'reply'};
				
				const fn = function(data){
					listPage(page);
				};
				
				ajaxRequest(url, 'post', params, 'json', fn);
			});
		});

		// 답글 리스트
		function listReplyAnswer(parentNum) {
			let url = CONTEXT_PATH + '/magazine/listReplyAnswer';
			let params = { parentNum: parentNum };
			let selector = 'div#listReplyAnswer' + parentNum;
			
			const fn = function(data){
				$(selector).html(data);
			};
			
			ajaxRequest(url, 'get', params, 'text', fn);
		}

		// 댓글별 답글 개수
		function countReplyAnswer(parentNum) {
			let url = CONTEXT_PATH + '/magazine/countReplyAnswer';
			let params = 'parentNum=' + parentNum;
			
			const fn = function(data){
				let count = data.count;
				let selector = 'span#answerCount' + parentNum;
				$(selector).html(count);
			};
			
			ajaxRequest(url, 'post', params, 'json', fn);
		}

		// 답글 버튼
		$(function(){
		    $('div#listReply').on('click', 'button.btnReplyAnswerLayout', function(){
		        const magazineReplyNum = $(this).data('reply-id');
				if (!magazineReplyNum) {
				        console.error("magazineReplyNum가 존재하지 않습니다.");
				        return false;
				    }
		        const $replyItem = $(this).closest('.reply-item');
		        const $replyAnswer = $replyItem.find('.reply-answer');

		        let isHidden = $replyAnswer.hasClass('d-none');
		        
		        if (isHidden) {
		            listReplyAnswer(magazineReplyNum);
		            countReplyAnswer(magazineReplyNum);
		        }

		        $replyAnswer.toggleClass('d-none');
		    });
		});


		// 답글 등록
		$(function(){
			$('div#listReply').on('click', 'button.btnSendReplyAnswer', function(){
				const magazineReplyNum = $(this).data('reply-id');
				const $form = $(this).closest('.answer-form');  
				
				let content = $form.find('textarea').val().trim();
				if(!content) {
					$form.find('textarea').focus();
					return false;
				}
				
				let url = CONTEXT_PATH + '/magazine/insertReply';
				let params = {magazineId: MAGAZINE_ID, content: content, parentNum: magazineReplyNum};
				
				const fn = function(data){
					$form.find('textarea').val('');
					
					let state = data.state;
					if(state === 'true') {
						listReplyAnswer(magazineReplyNum);
						countReplyAnswer(magazineReplyNum);
					}
				};
				
				ajaxRequest(url, 'post', params, 'json', fn);
			});
		});


		// 답글 삭제
		$(function(){
			$('div#listReply').on('click', '.deleteReplyAnswer', function(){
				if(! confirm('답글을 삭제하시겠습니까 ? ')) {
				    return false;
				}
				
				let magazineReplyNum = $(this).attr('data-magazineReplyNum');
				let parentNum = $(this).attr('data-parentNum');
				
				let url = CONTEXT_PATH + '/magazine/deleteReply';
				let params = {magazineReplyNum:magazineReplyNum, mode:'answer'};
				
				const fn = function(data){
					listReplyAnswer(parentNum);
					countReplyAnswer(parentNum);
				};
				
				ajaxRequest(url, 'post', params, 'json', fn);
			});
		});


		// 좋아요
		$(function(){
		    $('button.btnSendMagazineLike').click(function(){
		        const magazineId = $(this).data("magazineId");
		        const $i = $(this).find('i');
		        let userLiked = $i.hasClass('bi-heart-fill');

		        let msg = userLiked ? '게시글 공감을 취소하시겠습니까 ? ' : '게시글에 공감하십니까 ?';
		        if(!confirm(msg)) return false;

				let url = CONTEXT_PATH + "/magazine/magazineLike/" + MAGAZINE_ID;
		        let method = userLiked ? 'delete' : 'post';
		        let params = null;

		        const fn = function(data) {
		            if(data.state === 'true') {
		                if(userLiked) {
		                    $i.removeClass('bi-heart-fill text-danger').addClass('bi-heart');
		                } else {
		                    $i.removeClass('bi-heart').addClass('bi-heart-fill text-danger');
		                }
				
		                $('span#magazineLikeCount').text(data.magazineLikeCount);
		            } else if(data.state === 'liked') {
		                alert('게시글 공감은 한번만 가능합니다.');
		            } else {
		                alert('게시글 공감 여부 처리가 실패했습니다.');
		            }
		        };

		        ajaxRequest(url, method, params, 'json', fn);
		    });
		});

		// 게시글 신고
		$('.container').on('click', '.btnPostsReport', function(){
				let magazineId = $(this).attr('data-magazineId');
				reports('magazineBoard', magazineId, 'posts', '자유 게시판');
			});
			
		// 댓글 신고
		$('.reply-session').on('click', '.notifyReply', function(){
			let magazineReplyNum = $(this).attr('data-magazineReplyNum');
			reports('magazineReply', magazineReplyNum, 'reply', '자유 게시판 댓글');
		});

		// 답글 신고
		$('.reply-session').on('click', '.notifyReplyAnswer', function(){
			let magazineReplyNum = $(this).attr('data-magazineReplyNum');
			reports('magazineReply', magazineReplyNum, 'replyAnswer', '자유 게시판 댓글에 대한 답글');
		});

		function reports(target, targetNum, contentType, contentTitle) {
			if(! target || ! targetNum || ! contentType || ! contentTitle) {
				alert('신고 게시글이 선택되지 않은 상태입니다.');
				return;
			}
			
			const f = document.reportsForm;
			f.reasonCode.value = '';
			f.reasonDetail.value = '';
			
			f.target.value = target;
			f.targetNum.value = targetNum;
			f.contentType.value = contentType;
			f.contentTitle.value = contentTitle;
			
			$('#reportDialogModal').modal('show');
		}

		function sendReports() {
			const f = document.reportsForm;
			
			if(! f.reasonCode.value.trim()) {
				alert('신고 사유를 선택하세요.');
				f.reasonCode.focus();
				return;
			}

			const contextPath = f.contextPath.value.trim();
			const url = contextPath + '/roports/saved';
			const formData = new FormData(f);
			const params = new URLSearchParams(formData).toString();

			const fn = function(data) {
				const state = data.state;
				if(state === 'true') {
					alert('신고사항이 접수되었습니다.');
				} else if(state === 'liked') {
					alert('신고는 한번만 가능합니다.');
				} else {
					alert('신고사항 처리가 실패했습니다.');
				}
				
				$('#reportDialogModal').modal('hide');
			};
			
			ajaxRequest(url, 'post', params, 'json', fn);
		}
	</script>
</body>
</html>