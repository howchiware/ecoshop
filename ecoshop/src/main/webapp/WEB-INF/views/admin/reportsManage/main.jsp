<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssReport/report.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin_paginate.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="right-panel">
			<div class="title">
				<h3>게시글 신고 관리</h3>
			</div>
			<hr>

			<div class="section p-2" data-aos="fade-up" data-aos-delay="200">
				<div class="row gy-4 m-0">
					<div class="col-lg-12" data-aos="fade-up"
						data-aos-delay="200">
						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link active" id="tab-all" data-bs-toggle="tab" data-bs-target="#nav-content"
									type="button" role="tab" aria-controls="all" aria-selected="true" data-tab="all">전체목록</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link" id="tab-group" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab"
									aria-controls="group" aria-selected="true" data-tab="group">게시글별 통계</button>
							</li>
						</ul>

						<div class="tab-content p-3 pt-4" id="nav-content">
							<div class="row mb-2">
								<div class="col-md-2 align-self-center">
									<select id="selectStatus" class="form-select">
										<option value="0" ${reportsStatus==0 ? "selected":""}>전체</option>
										<option value="1" ${reportsStatus==1 ? "selected":""}>신고접수</option>
										<option value="2" ${reportsStatus==2 ? "selected":""}>처리완료</option>
										<option value="3" ${reportsStatus==3 ? "selected":""}>기각</option>
									</select>
								</div>
								<div class="col-md-10 form-search-wrapper">
									<form name="searchForm" class="form-search">
										<select name="schType" class="form-select">
											<option value="all" ${schType=="all"?"selected":""}>신고사유</option>
											<option value="contentTitle" ${schType=="contentTitle"?"selected":""}>콘텐츠</option>
											<option value="reporterName" ${schType=="reporterName"?"selected":""}>신고자</option>
											<option value="reportDate" ${schType=="reportDate"?"selected":""}>작성일</option>
										</select> 
										<input type="text" name="kwd" value="${kwd}" class="form-control"> 
										<input type="hidden" name="status" value="0">
										<button type="button" class="btn-default" onclick="searchList();">
											조회
										</button>
									</form>
								</div>
							</div>
						</div>
						<div class="reports-list"></div>
					</div>
				</div>
			</div>
		</div>



	</main>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		const CONTEXT_PATH = "${pageContext.request.contextPath}";
		const REPORT_ID = "${report.reportId}";
		const TARGET_NUM = "${report.targetNum}";
		const TARGET = "${report.target}";
		const PAGE_NUM = "${page}";
	</script>
	<script
		src="${pageContext.request.contextPath}/dist/jsReport/reportMain.js"></script>

</body>
</html>


