<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssFaq/faq.css">

</head>
<body>

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
  
  <div class="right-panel">

		<div class="title">
			<h3>자주 묻는 질문</h3>
		</div>
		
		<hr>

		<div class="board-container" data-aos="fade-up" data-aos-delay="100">
			<div class="board-controls">
				<form name="searchForm" class="search-form">
				    <div class="input-group">
				        <input type="text" name="kwd" value="" class="form-control" placeholder="검색어를 입력하세요">
				        <input type="hidden" id="searchValue" value="">
				        <button type="button" class="btn my-btn" onclick="searchList();"><i class="bi bi-search"></i></button>
				    </div>
				</form>
				<div class="action-buttons">
					<button type="button" class="btn my-btn btn-sm btnCategoryManage">카테고리 관리</button>
					<button type="button" class="btn my-btn btn-sm" onclick="writeForm()">질문 등록</button>
				</div>
			</div>

			<div class="row mt-4">
				<div class="col-md-2">
					<div class="nav flex-column nav-pills" id="categoryTab" role="tablist" aria-orientation="vertical">
						<button class="nav-link active" id="tab-0" data-bs-toggle="pill" data-bs-target="#nav-content" 
								type="button" role="tab" data-categoryId="0">전체</button>
						<c:forEach var="dto" items="${listCategory}" varStatus="status">
							<button class="nav-link" id="tab-${status.count}" data-bs-toggle="pill" data-bs-target="#nav-content" 
									type="button" role="tab" data-categoryId="${dto.categoryId}">
								${dto.categoryName}
							</button>
						</c:forEach>
					</div>
				</div>
			
				<div class="col-md-10">
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="nav-content" role="tabpanel">
							</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<div class="modal fade" id="myDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">자주하는질문</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-2"></div>
		</div>
	</div>
</div>

<div class="modal fade" id="faqCategoryDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="faqCategoryDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="faqCategoryDialogModalLabel">FAQ 카테고리</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-3">
				<form name="categoryForm" method="post" onsubmit="return false;">
					<table class="table table-bordered">
						<thead class="table-light">
							<tr class="text-center">
								<th>카테고리</th>
								<th style="width: 90px;">작업</th>
							</tr>
						</thead>
						<tbody>
							<tr class="text-center">
								<td><input type="text" name="categoryName" class="form-control form-control-sm"></td>
								<td><button type="button" class="my-btn btn btn-sm btnCategoryAddOk">등록</button></td>
							</tr>
						</tbody>
						<tfoot class="category-list"></tfoot>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	const CONTEXT_PATH = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/dist/jsFaq/faq.js"></script>
<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

</body>
</html>