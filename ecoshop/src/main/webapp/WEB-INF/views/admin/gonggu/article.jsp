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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/paginate.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css_gonggu/article.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	</header>
	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		<div class="right-PANEL">
			<div class="title">
				<h3>패키지 상세(패키지 구성)</h3>
			</div>

			<hr>
			<div class="outside">
				<div class="card-box mb-4"
					style="max-width: 80%; background: #F2F2F2; margin: 0 auto;">
					<div class="row g-0 cardContainer">
						<div class="col-md-4 image-box">
							<img
								src="${pageContext.request.contextPath}/uploads/gonggu/${dto.gongguThumbnail}"
								alt="...">
						</div>
						<div class="col-md-6">
							<div class="cardBody">
								<h5 class="cardTitle">${dto.gongguProductName}</h5>
								<p class="cardText">기간 : ${dto.startDate} - ${dto.endDate}</p>
								<p class="cardText">내용 : ${dto.content}</p>
								<p class="cardText">
									<small class="text-body-secondary">등록일 : ${dto.regDate}</small>
								</p>
							</div>
						</div>
					</div>
				</div>


				<div class="row mb-2">
					<div class="col">
						<button type="button" class="btn-default"
							onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/update?gongguProductId=${dto.gongguProductId}&page=${page}';">수정</button>
						<button type="button" class="btn-default btn-gongguDelete"
							onclick="deleteOk();">삭제</button>
					</div>
					<div class="col text-end">
						<button type="button" class="btn-default"
							onclick="location.href='${pageContext.request.contextPath}/admin/gonggu/listProduct?${query}';">리스트</button>
					</div>
				</div>
			</div>
		</div>
	</main>

	<script type="text/javascript">
		function deleteOk() {
			let params = 'gongguProductId=${dto.gongguProductId}&${query}&gongguThumbnail=${dto.gongguThumbnail}';
			let url = '${pageContext.request.contextPath}/admin/gonggu/delete?'
					+ params;

			if (confirm('위 자료를 삭제 하시 겠습니까 ? ')) {
				location.href = url;
			}
		}
	</script>
</body>
</html>