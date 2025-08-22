<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품 등록/수정</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css_gonggu/display.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	</header>
	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		<div class="right-PANEL">
			<div class="title">
				<h3>공동구매 상품등록</h3>
			</div>

			<hr>
			<div class="outside">
				<div class="row gy-4">
					<div class="section-body p-5">
						<h5 class="title">패키지 리스트</h5>
						<hr>
						<div class="row gy-4 m-0">
							<div class="col-lg-12 board-section p-5 m-2">
								<div class="row mb-2">
									<div class="col-md-6 align-self-center">
										<select id="stateSelect" class="form-select"
											style="width: 200px;">
											<option value="1" ${state=="1" ? "selected":""}>진행중</option>
											<option value="2" ${state=="2" ? "selected":""}>진행예정</option>
											<option value="3" ${state=="3" ? "selected":""}>기간종료</option>
										</select>
									</div>
									<div class="col-md-6 align-self-center text-end">
										<span class="small-title">목록</span> <span class="dataCount">${dataCount}개(${page}/${total_page}
											페이지)</span>
									</div>
								</div>

								<table class="table table-hover board-list">
									<thead>
										<tr>
											<th width="60">번호</th>
											<th>제목</th>
											<th width="155">시작일자</th>
											<th width="155">종료일자</th>
											<th width="70">상품수</th>
											<th width="60">출력</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="dto" items="${listProduct}" varStatus="status">
											<tr>
												<td>${dataCount - (page-1) * size - status.index}</td>
												<td class="left">
													<div class="text-wrap"><a href="${articleUrl}&gongguProductId=${dto.gongguProductId}">${dto.gongguProductName}</a></div>
												</td>
												<td>${dto.startDate}</td>
												<td>${dto.endDate}</td>
												<td>${dto.gongguProductCount}</td>
												<td>${dto.productShow==1 ? "표시":"숨김"}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

								<div class="page-navigation">${dataCount == 0 ? "등록된 정보가 없습니다." : paging}
								</div>

								<div class="row mt-3">
									<div class="col-md-2">
										<button type="button" class="btn-default"
											onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/listProduct';"
											title="새로고침">
											<i class="bi bi-arrow-clockwise"></i>
										</button>
									</div>
									<div class="col-md-8 text-center">
										<form name="searchForm" class="form-search">
											<select name="schType">
												<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
												<option value="gongguProductName"
													${schType=="gongguProductName"?"selected":""}>제목</option>
												<option value="content" ${schType=="content"?"selected":""}>내용</option>
											</select> <input type="text" name="kwd" value="${kwd}">
											<button type="button" class="btn-default"
												onclick="searchList();">
												<i class="bi bi-search"></i>
											</button>
										</form>
									</div>
									<div class="col-md-2 text-end">
										<button type="button" class="btn-accent btn-md"
											onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/write';">등록하기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<script type="text/javascript">

// 검색 키워드 입력란에서 엔터를 누른 경우 서버 전송 막기 
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
	
	let url = '${pageContext.request.contextPath}/admin/gonggu/listProduct';
	location.href = url + '?' + params;
}

$(function(){
	$('#stateSelect').on('change', function(){
		let state = $(this).val();
		let params = 'state=' + state;
		
		let url = '${pageContext.request.contextPath}/admin/gonggu/listProduct';
		location.href = url + '?' + params;
	});
});
</script>
</body>
</html>