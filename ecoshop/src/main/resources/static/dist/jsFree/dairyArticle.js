function deleteOk() {
	let params = 'freeId=' + FREE_ID + '&' + QUERY_STRING;
	let url = CONTEXT_PATH + '/free/delete?' + params;

	if(confirm('게시글을 삭제하시겠습니까?')) {
		location.href = url;
	}
}

// 페이징
$(function() {
	listPage(1);
});

function listPage(page) {
	let url = CONTEXT_PATH + '/free/listReply';
	let params = {freeId: FREE_ID, pageNo: page};
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
		
		let url = CONTEXT_PATH + '/free/insertReply';
		let params = {freeId: FREE_ID, content:content, parentNum:0}; 

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
		
		let replyId = $(this).attr('data-replyId');
		let page = $(this).attr('data-pageNo');
		
		let url = CONTEXT_PATH + '/free/deleteReply';
		let params = {replyId:replyId, mode:'reply'};
		
		const fn = function(data){
			listPage(page);
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

// 답글 리스트
function listReplyAnswer(parentNum) {
	let url = CONTEXT_PATH + '/free/listReplyAnswer';
	let params = { parentNum: parentNum };
	let selector = 'div#listReplyAnswer' + parentNum;
	
	const fn = function(data){
		$(selector).html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

// 댓글별 답글 개수
function countReplyAnswer(parentNum) {
	let url = CONTEXT_PATH + '/free/countReplyAnswer';
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
        const replyId = $(this).data('reply-id');
		if (!replyId) {
		        console.error("replyId가 존재하지 않습니다.");
		        return false;
		    }
        const $replyItem = $(this).closest('.reply-item');
        const $replyAnswer = $replyItem.find('.reply-answer');

        let isHidden = $replyAnswer.hasClass('d-none');
        
        if (isHidden) {
            listReplyAnswer(replyId);
            countReplyAnswer(replyId);
        }

        $replyAnswer.toggleClass('d-none');
    });
});


// 답글 등록
$(function(){
	$('div#listReply').on('click', 'button.btnSendReplyAnswer', function(){
		const replyId = $(this).data('reply-id');
		const $form = $(this).closest('.answer-form');  
		
		let content = $form.find('textarea').val().trim();
		if(!content) {
			$form.find('textarea').focus();
			return false;
		}
		
		let url = CONTEXT_PATH + '/free/insertReply';
		let params = {freeId: FREE_ID, content: content, parentNum: replyId};
		
		const fn = function(data){
			$form.find('textarea').val('');
			
			let state = data.state;
			if(state === 'true') {
				listReplyAnswer(replyId);
				countReplyAnswer(replyId);
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
		
		let replyId = $(this).attr('data-replyId');
		let parentNum = $(this).attr('data-parentNum');
		
		let url = CONTEXT_PATH + '/free/deleteReply';
		let params = {replyId:replyId, mode:'answer'};
		
		const fn = function(data){
			listReplyAnswer(parentNum);
			countReplyAnswer(parentNum);
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});


// 좋아요
$(function(){
    $('button.btnSendFreeLike').click(function(){
        const freeId = $(this).data("freeid");
        const $i = $(this).find('i');
        let userLiked = $i.hasClass('bi-heart-fill');

        let msg = userLiked ? '게시글 공감을 취소하시겠습니까 ? ' : '게시글에 공감하십니까 ?';
        if(!confirm(msg)) return false;

		let url = CONTEXT_PATH + "/free/freeLike/" + FREE_ID;
        let method = userLiked ? 'delete' : 'post';
        let params = null;

        const fn = function(data) {
            if(data.state === 'true') {
                if(userLiked) {
                    $i.removeClass('bi-heart-fill text-danger').addClass('bi-heart');
                } else {
                    $i.removeClass('bi-heart').addClass('bi-heart-fill text-danger');
                }
		
                $('span#freeLikeCount').text(data.freeLikeCount);
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
		let freeId = $(this).attr('data-freeid');
		reports('freeBoard', freeId, 'posts', '자유 게시판');
	});
	
// 댓글 신고
$('.reply-session').on('click', '.notifyReply', function(){
	let replyId = $(this).attr('data-replyId');
	reports('freeReply', replyId, 'reply', '자유 게시판 댓글');
});

// 답글 신고
$('.reply-session').on('click', '.notifyReplyAnswer', function(){
	let replyId = $(this).attr('data-replyId');
	reports('freeReply', replyId, 'replyAnswer', '자유 게시판 댓글에 대한 답글');
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