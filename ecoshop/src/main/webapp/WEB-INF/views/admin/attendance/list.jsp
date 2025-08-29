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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssAttendance/attendance.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin_paginate.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

	<main class="main-container">
		<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

		<div class="content">
			<div class="title">
				<h3>출석체크 관리</h3>
			</div>

			<hr>
			<div class="box">
				<form name="searchForm" class="row g-3 mb-4" method="get">
					<div class="col-auto">
						<label for="start" class="form-label">기간 시작일(월요일)</label> <input
							type="date" id="start" name="start"
							value="${empty start ? '' : start}" class="form-control" required>
					</div>
					<div class="col-auto">
						<label for="end" class="form-label">기간 종료일(일요일)</label> <input
							type="date" id="end" name="end" value="${empty end ? '' : end}"
							class="form-control" readonly>
					</div>

					<div class="col-auto">
						<label for="schType" class="form-label">검색 조건</label> <select
							id="schType" name="schType" class="form-select">
							<option value="name" ${schType=="name"?"selected":""}>이름</option>
							<option value="memberId" ${schType=="memberId"?"selected":""}>회원번호</option>
						</select>

					</div>
					<div class="col-auto">
						<label for="keyword" class="form-label">검색어</label> 
						<input type="text" id="kwd" name="kwd" value="${kwd}" class="form-control">
					</div>

					<div class="col-auto align-self-end">
						<button type="submit" class="btn my-btn" onclick="searchList();">조회</button>
						<button type="button" class="btn my-btn" onclick="location.href='${pageContext.request.contextPath}/admin/attendance/list'">초기화</button>
					</div>
				</form>

				<div class="row mb-4">
					<div class="col-md-4">
						<div class="card text-center">
							<div class="card-body">
								<h5 class="card-title">총 조회 인원</h5>
								<p class="card-text fs-4 fw-bold">${dataCount}명</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card text-center">
							<div class="card-body">
								<h5 class="card-title">포인트 지급 대상</h5>
								<p class="card-text fs-4 fw-bold text-success">${pointTargetCount}명</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card text-center">
							<div class="card-body">
								<h5 class="card-title">기간 내 총 출석</h5>
								<p class="card-text fs-4 fw-bold">${totalAttendanceCount}회</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box2">
				<table class="table table-hover">
					<thead class="table-light">
						<tr class="text-center">
							<th>회원번호</th>
							<th>이름</th>
							<th>기간</th>
							<th>출석 횟수</th>
							<th>마지막 출석일</th>
							<th>포인트 지급 여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${list}">
							<tr class="text-center">
								<td>${item.memberId}</td>
								<td>${item.name}</td>
								<td>${start}~${end}</td>
								<td><c:choose>
										<c:when test="${item.attendanceCount > 0}">
			                            ${item.attendanceCount}회
			                        </c:when>
										<c:otherwise>
			                            없음
			                        </c:otherwise>
									</c:choose></td>
								<td><fmt:formatDate value="${item.lastAttendanceDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><c:choose>
										<c:when test="${item.attendanceCount >= 5}">
											<span>지급완료</span>
										</c:when>
										<c:otherwise>
											<span class="text-secondary">미지급</span>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>


						<c:if test="${empty list}">
							<tr>
								<td colspan="6" class="text-center">조회하실 정보를 입력해 주세요.</td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<div style="padding-top: 10px;" class="page-navigation">${paging}</div>
			</div>
		</div>
	</main>

	<script type="text/javascript">
		const CONTEXT_PATH = '${pageContext.request.contextPath}';
	</script>
	<script
		src="${pageContext.request.contextPath}/dist/jsAttendance/attendance.js"></script>

</body>
</html>