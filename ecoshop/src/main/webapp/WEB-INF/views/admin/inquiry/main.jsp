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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssInquiry/inquiry.css">
</head>
<body>

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
  
  	<div class="right-panel">
		<div class="title">
			<h3>1:1 문의 관리</h3>
		</div>
		
		<hr>

	<div class="board-container" data-aos="fade-up" data-aos-delay="100">
           <div class="board-controls">
               <form name="searchForm" class="search-form" style="max-width: 400px; width: 100%;">
                   <div class="input-group">
                       <input type="text" name="kwd" class="form-control" placeholder="제목, 작성자 검색">
                       <button type="button" class="btn my-btn" onclick="searchList();">검색</button>
                   </div>
               </form>
               <button type="button" class="btn my-btn btn-sm btnCategoryManage">카테고리 관리</button>
           </div>
           
           <div class="row">
               <div class="col-md-2">
                   <div class="nav flex-column nav-pills" id="categoryTab">
					<button class="nav-link active" type="button" data-categoryId="0">전체</button>
					<c:forEach var="dto" items="${listCategory}">
						<button class="nav-link" type="button" data-categoryId="${dto.categoryId}">${dto.categoryName}</button>
					</c:forEach>
				</div>
               </div>

                <div class="col-md-10">
                    <ul class="nav list-filter-tabs" id="statusTab">
                        <li class="nav-item"><a class="nav-link active my-tab" data-status="-1">전체</a></li>
                        <li class="nav-item"><a class="nav-link my-tab" data-status="0">답변 대기</a></li>
                        <li class="nav-item"><a class="nav-link my-tab" data-status="1">답변 완료</a></li>
                    </ul>

                    <div class="table-responsive" id="nav-content">
                    </div>
                </div>
            </div>
		</div>
	</div>
</main>

<%-- 모달 영역 --%>
<div class="modal fade" id="myDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">1:1 문의 확인 및 답변</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4"></div>
		</div>
	</div>
</div>
<div class="modal fade" id="inquiryCategoryDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">1:1 문의 카테고리 관리</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body pt-3">
				<form name="categoryForm" onsubmit="return false;">
					<table class="table table-bordered">
						<thead class="table-light">
							<tr class="text-center">
								<th>카테고리명</th>
								<th style="width: 90px;">작업</th>
							</tr>
						</thead>
						<tbody>
							<tr class="text-center">
								<td><input type="text" name="categoryName" class="form-control form-control-sm"></td>
								<td><button type="button" class="btn btn-sm my-btn btnCategoryAddOk">등록</button></td>
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
<script src="${pageContext.request.contextPath}/dist/jsInquiry/inquiry.js"></script>

</body>
</html>