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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyArticle.css" type="text/css">
<style>

.tip-header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    padding-bottom: 1rem;
    margin-bottom: 2rem;
    border-bottom: 2px solid #315e4e;
}

.tip-header h2 {
    margin: 0;
}

.tip-subtitle {
    color: #555;
    font-size: 1rem;
}
.new-text {
    display: inline-block;
    margin-left: 6px;
    padding: 2px 6px;
    font-size: 0.75rem;
    font-weight: 600;
    color: #fff;
    background: linear-gradient(135deg, #315e4e, #4b8071);
    border-radius: 12px;
    animation: blink 1.5s infinite;
}
.page-navigation .pagination .page-link {
    color: #555;
    border-radius: 6px;
    margin: 0 3px;
    border: 1px solid #dee2e6;
    transition: all 0.2s ease;
}

.page-navigation .pagination .page-link:hover {
    background-color: #e9ecef;
    color: #315e4e;
}

.page-navigation .pagination .page-item.active .page-link {
    background-color: #315e4e;
    border-color: #315e4e;
    color: #fff;
    box-shadow: 0 2px 5px rgba(49, 94, 78, 0.3);
}

.paginate {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    margin-top: 2.5rem;
    margin-bottom: 2.5rem;
    gap: 4px;
    font-size: 0.9rem;
}

.paginate a,
.paginate span {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    width: 36px;
    height: 36px;
    border: 1px solid #d2e4d9;
    border-radius: 40%;
    background-color: #ffffff;
    color: #333;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s ease;
}

.paginate a:hover {
    background-color: #f1f8f3;
    border-color: #28a745;
    color: #28a745;
}

.paginate span {
    background-color: #28a745;
    border-color: #28a745;
    color: #ffffff;
    font-weight: bold;
    cursor: default;
}

@keyframes blink {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.6; }
}

.search-form {
    background-color: #f8f9fa;
    padding: 1.5rem;
    border-radius: 8px;
    margin-bottom: 2.5rem;
    border: 1px solid #e9ecef;
}
.bottom-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 2.5rem;
}
.reply-title .bi-arrow-return-right {
    margin-right: 2px;
    color: #888;
}
</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	<div class="tip-header">
	    <h2 class="fw-bold">제로웨이스트 팁</h2>
	    <span class="tip-subtitle">환경을 사랑하는 우리들의 이야기, 소소한 팁을 나눠주세요.</span>
    </div>
	
	<form name="searchForm" class="search-form row g-3 align-items-end" method="get">
         <div class="col-md-3">
             <label for="schType" class="form-label">검색 조건</label> 
             <select id="schType" name="schType" class="form-select">
                 <option value="name" ${schType=="name"?"selected":""}>작성자</option>
                 <option value="subject" ${schType=="subject"?"selected":""}>제목</option>
             </select>
         </div>
         <div class="col-md-4">
             <label for="kwd" class="form-label">검색어</label> 
             <input type="text" id="kwd" name="kwd" value="${kwd}" class="form-control">
         </div>
         <div class="col-auto">
             <button type="submit" class="btn btn-primary">조회</button>
         </div>
     </form>
	
	<table class="table table-hover align-middle">
		<thead class="table-light text-center">
			<tr>
				<th style="width: 80px;">번호</th>
                <th>제목</th>
                <th style="width: 120px;">작성자</th>
                <th style="width: 120px;">작성일</th>
                <th style="width: 80px;">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list}" varStatus="status">
				<tr>
					<td class="text-center">${dataCount - (page-1) * size - status.index}</td>
					<td class="left reply-title" style="padding-left: 30px;">
					    <c:forEach var="n" begin="1" end="${dto.depth}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach> <%-- 간격 조절 --%>
					    <c:if test="${dto.depth != 0}">
					        <i class="bi bi-arrow-return-right"></i>
					    </c:if>
					    <a href="${articleUrl}&tipId=${dto.tipId}" class="text-reset text-decoration-none">${dto.subject}</a>
					</td>
					<td class="text-center">${dto.name}</td>
					<td class="text-center">${dto.regDate}</td>
					<td class="text-center">${dto.hitCount}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:if test="${empty list}">
		<div class="text-center py-5">등록된 게시글이 없습니다.</div>
	</c:if>

	<div class="bottom-controls">
		<div class="control-section">
			<button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/tipBoard/list';">새로고침</button>
		</div>

		<div class="control-section">
			<div class="page-navigation">${dataCount == 0 ? "" : paging}</div>
		</div>

		<div class="align-self-center">
			<button type="button" class="btn btn-primary"
				onclick="location.href='${pageContext.request.contextPath}/tipBoard/write';">팁
				작성</button>
		</div>
	</div>


	</main>

    <footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') { 
			evt.preventDefault();
			searchList();
		}
	});
});

function changeList() {
	const f = document.boardListForm;
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/tipBoard/list';
	location.href = url + '?' + params;
}

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	// form 요소는 FormData를 이용하여 URLSearchParams 으로 변환
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/tipBoard/list';
	location.href = url + '?' + params;
}
</script>
</body>
</html>