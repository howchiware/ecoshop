<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>내 스페셜 인증글</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/home.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>


<style>
.thumb {
	width: 80px;
	height: 60px;
	object-fit: cover;
	border-radius: 6px;
}


</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>
<main class="main-container container my-4">
	<div class="row justify-content-center">

		<div class="col-md-2">
			<jsp:include page="/WEB-INF/views/layout/myPageMenubar.jsp" />
		</div>

		<div class="col-md-10">
				<div class="contentsArea">
			<h3 class="pb-2 mb-3 border-bottom sub-title">챌린지</h3>

			<jsp:include page="/WEB-INF/views/myPage/challengeTabs.jsp" />

			<form class="row g-2 mb-3" method="get">
				<input type="hidden" name="size" value="${size}">
				<div class="col-md-3">
					<input class="form-control" name="kwd" value="${kwd}"
						placeholder="내용 검색">
				</div>
				<div class="col-auto">
					<button class="btn btn-primary">조회</button>
				</div>
			</form>

			<table class="table align-middle table-hover">
				<thead>
					<tr class="text-center">
						<th style="width: 100px">이미지</th>
						<th class="text-start">제목 · 일차</th>
						<th style="width: 120px">승인상태</th>
						<th style="width: 120px">공개</th>
						<th style="width: 160px">작성일</th>
						<th style="width: 100px">보기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="p" items="${list}">
						<tr class="text-center">
							<td><c:choose>
									<c:when test="${not empty p.photoUrl}">
										<img class="thumb"
											src="${pageContext.request.contextPath}/uploads/challenge/${p.photoUrl}">
									</c:when>
									<c:otherwise>
										<img class="thumb"
											src="${pageContext.request.contextPath}/dist/img/noimage.png">
									</c:otherwise>
								</c:choose>
							</td>
							<td class="text-start"><div class="fw-semibold">${p.title}</div>
								<div class="text-muted small">${p.dayNumber}일차</div></td>
							<td><c:choose>
									<c:when test="${p.approvalStatus==1}">
										<span class="badge bg-success">승인</span>
									</c:when>
									<c:when test="${p.approvalStatus==0}">
										<span class="badge bg-secondary">대기</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-danger">반려</span>
									</c:otherwise>
								</c:choose>
								</td>
							<td>
								<div
									class="form-check form-switch d-flex justify-content-center">
									<input class="form-check-input" type="checkbox"
										${p.approvalStatus==1 ? '' : 'disabled'}
										${p.isPublic=='Y' ? 'checked' : ''}
										onchange="togglePublic(${p.postId}, this.checked)">
								</div>
							</td>
							<td>${p.postRegDate}</td>
							<td><a class="btn btn-sm btn-outline-secondary"
								href="${pageContext.request.contextPath}/challenge/detail/${p.challengeId}">보기</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty list}">
						<tr>
							<td colspan="6" class="text-center text-muted py-5">등록된 스페셜
								인증글이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			
			<!-- 페이징 -->
			<div class="page-navigation">
				${paging}
			</div>
			</div>
		</div>
	</div>
</main>
	
<footer><jsp:include page="/WEB-INF/views/layout/footer.jsp" /></footer>

<script>
function togglePublic(postId, checked){
  const isPublic = checked ? 'Y' : 'N';
  fetch('${pageContext.request.contextPath}/challenge/post/visibility', {
    method:'POST',
    headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body:new URLSearchParams({postId,isPublic})
  }).then(r=>r.json()).then( j=> {
    if(!j.ok){ alert(j.msg||'실패'); location.reload(); 
    }
  }).catch(()=>{ alert('요청 실패'); location.reload(); 
  });
}
</script>
</body>
</html>
