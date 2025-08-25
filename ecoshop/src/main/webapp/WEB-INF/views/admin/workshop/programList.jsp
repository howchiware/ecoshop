<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 목록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}

.main-container {
	font-size: 15px;
}

.program-content {
	white-space: pre-wrap
}

.btn-manage {
	background: #fff;
	border: 1px solid #000;
	border-radius: 4px;
	padding: 3px 10px;
	color: #000;
	font-size: 0.9rem;
	transition: background 0.2s, color 0.2s;
	cursor: pointer;
	height: 30px;
	width: 51px;
}

.btn-register {
	height: 30px;
	width: 51px;
}

.btn-search {
	background: #fff;
	border: 1px solid #000;
	border-radius: 4px;
	padding: 3px 10px;
	color: #000;
	font-size: 0.9rem;
	transition: background 0.2s, color 0.2s;
	cursor: pointer;
	height: 30px;
	width: 51px;
	margin-bottom: 5px;
}

.outside {
	background: #fff;
	border: 1px solid #dee2e6;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 20px;
}

.table {
	background-color: #fff;
	border-collapse: collapse;
	border: 1px solid #dee2e6;
}

.table thead th {
	background-color: #f8f9fa;
	font-weight: 500;
	text-align: center;
	border: 1px solid #dee2e6;
}

.table td {
	vertical-align: middle;
	border: 1px solid #dee2e6;
	background-color: #fff;
}

.table tbody tr:hover {
	background-color: #fdfdfd;
}

select.form-control {
	font-size: 15px;
}

select.form-select {
	font-size: 15px;
}

.program-title {
	padding-left: 5px;
}


</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<main class="main-container">
		<div class="container py-4">

			<div class="d-flex align-items-center justify-content-between mb-3">
				<h3 class="m-0">프로그램 관리</h3>
			</div>

			<hr>

			<div class="d-flex justify-content-end mb-2">
				<form action="${ctx}/admin/workshop/program/write" method="get"
					style="display: inline;">
					<button type="submit" class="btn-manage btn-register"
						style="width: 51px; height: 30px;">등록</button>
				</form>
			</div>

		</div>

		<div class="outside">
			<form class="row g-2 align-items-end mb-3" method="get"
				action="${ctx}/admin/workshop/program/list">
				<div class="col-md-2">
					<label class="form-label"></label> <select class="form-select"
						name="schType">
						<option value="all" <c:if test="${schType=='all'}">selected</c:if>>전체</option>
						<option value="title"
							<c:if test="${schType=='title'}">selected</c:if>>제목</option>
						<option value="content"
							<c:if test="${schType=='content'}">selected</c:if>>내용</option>
					</select>
				</div>

				<div class="col-md-3">
					<label class="form-label"></label> <select class="form-select"
						name="categoryId">
						<option value="">카테고리 선택</option>
						<c:forEach var="c" items="${category}">
							<option value="${c.categoryId}"
								<c:if test="${categoryId == c.categoryId}">selected</c:if>>${c.categoryName}</option>
						</c:forEach>
					</select>
				</div>

				<div class="col-md-4">
					<label class="form-label"></label> <input type="text"
						class="form-control" name="kwd" value="${kwd}" style="height: 36.5px;">
				</div>

				<div class="col-md-1">
					<input type="hidden" name="page" value="1" />
					<button type="submit" class="btn-search">검색</button>
				</div>
			</form>

			<!-- 목록 테이블 -->
			<div class="table-responsive">
				<table class="table table-sm align-middle">
					<thead class="table-light">
						<tr>
							<th style="width: 50px;" class="text-center">번호</th>
							<th style="width: 130px;">카테고리</th>
							<th>프로그램명</th>
							<th style="width: 120px;" class="text-center">등록일</th>
							<th style="width: 15%" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty list}">
								<tr>
									<td colspan="5" class="text-center text-muted py-4">데이터가
										없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="row" items="${list}" varStatus="st">
									<tr>
										<td class="text-center"><c:out
												value="${(page-1)*size + st.index + 1}" /></td>
										<td class="text-center"><c:out value="${row.categoryName}" /></td>
										<td><a href="javascript:void(0);" class="program-title"
											data-id="${row.programId}"> <c:out
													value="${row.programTitle}" />
										</a></td>
										<td class="text-center"><fmt:formatDate
												value="${row.regDate}" pattern="yyyy-MM-dd" /></td>
										<td class="text-center">
											<form action="${ctx}/admin/workshop/program/update"
												method="get" style="display: inline;">
												<input type="hidden" name="num" value="${row.programId}">
												<input type="hidden" name="page" value="${page}">
												<button type="submit" class="btn-manage"
													style="width: 51px; height: 30px; text-decoration: none;">
													수정</button>
											</form> 
											
											<form action="${ctx}/admin/workshop/program/delete"
												method="post" style="display: inline;">
												<input type="hidden" name="num" value="${row.programId}">
												<input type="hidden" name="page" value="${page}">
												<button type="submit" class="btn-manage"
													onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
											</form>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>


		</div>

		<nav aria-label="페이지네이션">
			<ul class="pagination justify-content-center">
				<li class="page-item active"><span class="page-link">${page}</span></li>
			</ul>
		</nav>


	</main>

	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script type="text/javascript">
	$(function() {
		$(".program-title").click(function(){
			let programId = $(this).data("id");
			let $row = $(this).closest("tr");
			
			// 열려 있으면 닫기
			if($row.next().hasClass("program-detail")) {
				$row.next().remove();
				return;
			}
			
			// 기존 열린 상세 닫기
			$(".program-detail").remove();
			
			$.ajax({
				url: "${ctx}/admin/workshop/program/detail",
				type: "GET",
				dataType: "json",
				data: { programId: programId },
				success: function(data) {
					  console.log('resp:', data);
					  const content = data?.programContent || "<em class='text-muted'>내용 없음</em>";

					  const detailRow =
					      '<tr class="program-detail">' +
					        '<td colspan="4">' +
					          '<div class="detail-box">' +
					            '<div class="detail-head">' +
					              '<div class="detail-title">프로그램 상세</div>' +
					              '<div class="detail-meta"></div>' +
					            '</div>' +
					            '<div class="program-content">' + content + '</div>' +
					          '</div>' +
					        '</td>' +
					      '</tr>';

					  $row.after(detailRow);
					},

				error: function() {
					alert("프로그램 정보를 불러오지 못했습니다.");
				}
			});
		});
	});
	
	</script>

</body>
</html>
