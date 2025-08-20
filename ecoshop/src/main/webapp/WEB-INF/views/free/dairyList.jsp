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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFree/dairyList.css" type="text/css">
<style>

</style>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

<main class="container my-5">
	
	<jsp:include page="/WEB-INF/views/layout/freeHeader.jsp"/>
	
	<form name="searchForm" class="search-form row g-3 align-items-end" method="get">
         <div class="col-md-3">
             <label for="schType" class="form-label">검색 조건</label> 
             <select id="schType" name="schType" class="form-select">
                 <option value="nickname" ${schType=="nickname"?"selected":""}>작성자</option>
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
	
	<table class="table table-hover">
		<thead>
			<tr class="text-center">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${dairyList}" varStatus="status">
				<tr class="text-center">
                    <td>${dataCount - (page-1) * size - status.index}</td>
					<td class="text-start">
						<c:url var="url" value="/free/article/${item.freeId}">
							<c:param name="page" value="${page}" />
							<c:if test="${not empty kwd}">
								<c:param name="schType" value="${schType}" />
								<c:param name="kwd" value="${kwd}" />
							</c:if>
						</c:url>
						<div class="text-wrap">
							<a href="${url}">${item.subject}</a>
						</div>
					</td>
					<td>${item.nickname}</td>
                    <td>${item.regDate}</td>
                    <td>${item.hitCount}</td>
                </tr>
			</c:forEach>
			
			<c:if test="${empty dairyList}">
                <tr>
                    <td colspan="6" class="text-center py-5">등록된 게시글이 없습니다.</td>
                </tr>
            </c:if>
		</tbody>
	</table>
	
	<div class="table-bottom-controls">
         <div class="align-self-center">
             <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/free/write';">글 작성</button>
         </div>
         <div class="page-navigation">
             ${dataCount == 0 ? "" : paging}
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

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/free/dairyList';
	location.href = url + '?' + params;
}
</script>
</body>
</html>