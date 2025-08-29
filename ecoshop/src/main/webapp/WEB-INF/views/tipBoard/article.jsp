<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
<style>
    .card-header h3 { font-weight: 700; }
    .card-body img { max-width: 100%; border-radius: 8px; margin-bottom: 1rem; }
    .card-body p { white-space: pre-wrap; line-height: 1.8; }
    .btn-like-wrapper {
    text-align: center;
    padding: 1rem 0 2.5rem 0;
}

.btnSendTipBoardLike {
    background: #f1f3f5;
    border: 1px solid #dee2e6;
    border-radius: 50%;
    width: 60px;
    height: 60px;
    font-size: 1.5rem;
    color: #868e96;
    transition: all 0.2s ease;
    display: inline-flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    cursor: pointer;
}

.btnSendTipBoardLike:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.btnSendTipBoardLike .bi-heart-fill {
    color: #e64980;
}

#tipLikeCount {
    font-size: 0.8rem;
    display: block;
    margin-top: -5px;
    font-weight: normal;
}

.button-group {
	margin-top: 2.5rem;
}
.actions-left .btn-action {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    font-size: 0.9rem;
    font-weight: 500;
    border: 1px solid #ced4da;
    border-radius: 6px;
    background-color: #fff;
    color: #495057;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}

.actions-left .btn-action:hover {
    background-color: #f8f9fa;
    transform: translateY(-2px);
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.actions-left .btn-action.delete {
    color: #dc3545;
    border-color: #dc3545;
}

.actions-left .btn-action.asnwer {
    color: #28a745;
    border-color: #28a745;
}


.actions-left .btn-action.delete:hover {
    background-color: #dc3545;
    color: #fff;
}
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	<div class="card mt-4 article-card">
        <div class="card-header">
            <h3>${dto.subject}</h3>
            <div class="d-flex justify-content-between text-muted small">
                <span><strong>작성자:</strong> ${dto.name}</span>
                <span><strong>작성일:</strong> ${dto.regDate} | <strong>조회수:</strong> ${dto.hitCount}</span>
            </div>
        </div>
        <div class="card-body">
		    <c:out value="${dto.content}" escapeXml="false"/>
		</div>
		<div class="btn-like-wrapper">
			<button type="button" class="btn-default btnSendTipBoardLike" title="좋아요">
				<i class="bi ${isUserLiked ? 'bi-heart-fill text-danger' : 'bi-heart' }"></i>
				<span id="tipLikeCount">${dto.tipLikeCount}</span>
			</button>
		</div>
    </div>

    <div class="post-navigation">
        <div class="nav-item">
            <span class="fw-bold">이전글 :</span>
            <c:if test="${not empty prevDto}">
                <a href="${pageContext.request.contextPath}/tipBoard/article?${query}&tipId=${prevDto.tipId}">${prevDto.subject}</a>
            </c:if>
            <c:if test="${empty prevDto}">
                <span>이전글이 없습니다.</span>
            </c:if>
        </div>
        <div class="nav-item">
            <span class="fw-bold">다음글 :</span>
            <c:if test="${not empty nextDto}">
                <a href="${pageContext.request.contextPath}/tipBoard/article?${query}&tipId=${nextDto.tipId}">${nextDto.subject}</a>
            </c:if>
            <c:if test="${empty nextDto}">
                <span>다음글이 없습니다.</span>
            </c:if>
        </div>
    </div>
    
    <div class="article-actions">
    <div class="actions-left">
        <button type="button" class="btn-action asnwer" onclick="location.href='${pageContext.request.contextPath}/tipBoard/reply?tipId=${dto.tipId}&page=${page}&size=${size}';">답변</button>
        <c:if test="${sessionScope.member.memberId == dto.memberId}">
            <button type="button" class="btn-action " onclick="location.href='${pageContext.request.contextPath}/tipBoard/update?tipId=${dto.tipId}&${query}';">수정</button>
            <button type="button" class="btn-action delete" onclick="deleteOk();">삭제</button>
        </c:if>
    </div>
    <div class="actions-right">
        <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/tipBoard/list?${query}';">목록</button>
    </div>
</div>
    
   
    
</main>
<c:if test="${sessionScope.member.memberId==dto.memberId||sessionScope.member.userLevel>50}">
	<script type="text/javascript">
		function deleteOk() {
		    if(confirm('이 게시글을 삭제하면 하위 답변들도 모두 삭제됩니다.\n정말 삭제하시겠습니까?')) {
			    let params = 'tipId=${dto.tipId}&${query}';
			    let url = '${pageContext.request.contextPath}/tipBoard/delete?' + params;
		    	location.href = url;
		    }
		}
	</script>
</c:if>

    <footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
$(function(){
	$('button.btnSendTipBoardLike').click(function(){
		const $i = $(this).find('i');
		let userLiked = $i.hasClass('bi-heart-fill');
		
		let msg = userLiked ? '게시글 공감을 취소하시겠습니까?' : '게시글에 공감하십니까?';
		if(! confirm( msg )) {
			return false;
		}
		
		let url = '${pageContext.request.contextPath}/tipBoard/tipBoardLike/${dto.tipId}';
		let method = userLiked ? 'delete' : 'post';
		let params = null;
		
		const fn = function(data) {
			let state = data.state;
			
			if(state === 'true') {
				if(userLiked) {
					$i.removeClass('bi-heart-fill text-danger').addClass('bi-heart');
				} else {
					$i.removeClass('bi-heart').addClass('bi-heart-fill text-danger');
				}
				
				let count = data.tipLikeCount;
				$('span#tipLikeCount').text(count);
			} else if(state === 'liked') {
				alert('게시글 공감은 한번만 가능합니다.');
			} else {
				alert('게시글 공감 여부 처리가 실패했습니다.');
			}
		};
		
		ajaxRequest(url, method, params, 'json', fn);
	});
});
</script>
<!--<script src="${pageContext.request.contextPath}/dist/jsFree/dairyArticle.js"></script>  -->
</body>
</html>