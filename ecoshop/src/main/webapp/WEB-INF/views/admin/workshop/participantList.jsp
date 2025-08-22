<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>참여자 관리</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
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
	position: relative;
	margin-left: 250px; /* 사이드바 너비 */
	padding: 20px;
	min-height: calc(100vh - 60px);
	background-color: #f9f9f9;
	font-size: 15px;
}

/* 공통 카드 */
.outside {
	background: #fff;
	border: 1px solid #dee2e6;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 20px;
}

/* 표 */
.table {
	background-color: #fff;
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

select.form-select {
	font-size: 15px;
}

.section-title {
	font-weight: 700;
	margin-bottom: 8px;
}

.form-label {
	font-weight: 700;
}

/* 버튼 */
.btn-manage {
	background: #fff;
	border: 1px solid #000;
	border-radius: 4px;
	padding: 3px 10px;
	color: #000;
	font-size: 0.9rem;
	transition: background 0.2s, color 0.2s;
	cursor: pointer;
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
				<h3 class="m-0">참여자 관리</h3>
			</div>

			<hr>

			<div class="outside">
				<form class="row g-3 filters mb-4" method="get"
					action="${ctx}/admin/workshop/participant/list">
					<div class="col-sm-6 col-lg-4">
						<label class="form-label">워크샵명</label> <select name="workshopId"
							class="form-select" onchange="this.form.submit()">
							<option value="">워크샵 선택</option>
							<c:forEach var="w" items="${workshopList}">
								<option value="${w.workshopId}"
									<c:if test="${w.workshopId == workshopId}">selected</c:if>>
									<c:out value="${w.workshopTitle}" />
								</option>
							</c:forEach>
						</select>
					</div>
				</form>

				<!-- 안내 -->
				<c:if test="${empty workshopId}">
					<div class="alert alert-secondary">워크샵을 선택하면 해당 워크샵의 참여자 목록이
						표시됩니다.</div>
				</c:if>

				<!-- 참여자 목록 -->
				<c:if test="${not empty workshopId}">
					<div class="section-title">참여자 명단</div>

					<div class="table-outline mb-3">
						<table class="table table-sm align-middle">
							<thead>
								<tr>
									<th class="row-no">번호</th>
									<th>이름</th>
									<th>연락처</th>
									<th>이메일</th>
									<th>신청일</th>
									<th class="col-status">상태</th>
									<th class="col-attend">출석</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty participantList}">
										<tr>
											<td colspan="7" class="text-center text-muted py-4">참여자가
												없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="p" items="${participantList}" varStatus="st">
											<tr>
												<td class="text-center">${st.index + 1}</td>
												<td class="text-center"><c:out value="${p.name}" /></td>
												<td class="text-center"><c:out value="${p.tel}" /></td>
												<td class="text-center"><c:out value="${p.email}" /></td>
												<td class="text-center"><fmt:formatDate
														value="${p.appliedDate}" pattern="yyyy.MM.dd HH:mm" /></td>
												<td><select
													class="form-select form-select-sm js-status"
													data-id="${p.participantId}">
														<option value="1"
															<c:if test="${p.participantStatus == 1}">selected</c:if>>확정</option>
														<option value="2"
															<c:if test="${p.participantStatus == 2}">selected</c:if>>대기</option>
														<option value="0"
															<c:if test="${p.participantStatus == 0}">selected</c:if>>취소</option>
												</select></td>
												<td class="text-center"><input type="checkbox"
													class="form-check-input js-attend"
													data-id="${p.participantId}"
													<c:if test="${p.isAttended == 'Y'}">checked</c:if> /></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</c:if>
			</div>

			<nav aria-label="페이지네이션">
				<ul class="pagination justify-content-center">
					<li class="page-item active"><span class="page-link">${page}</span></li>
				</ul>
			</nav>

		</div>

	</main>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
  (function() {
    const post = (url, body) => fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams(body)
    }).then(r => r.json());

    // 출석 체크
    document.querySelectorAll(".js-attend").forEach(cb => {
      cb.addEventListener("change", async (e) => {
        const participantId = e.target.dataset.id;
        const isAttended = e.target.checked ? "Y" : "N";
        try {
          const res = await post("${ctx}/admin/workshop/participant/attendance", { participantId, isAttended });
          if (res.success) {
        	if(isAttended === 'Y') {
        		alert("출석 처리 되었습니다.");
        	} else {
        		alert("출석이 취소되었습니다.");
        	}
          } else {
        	alert("출석 저장 실패: " + (res.message || ""));
            e.target.checked = !e.target.checked; 
          }
        } catch (err) {
          alert("네트워크 오류로 실패했습니다.");
          e.target.checked = !e.target.checked;
        }
      });
    });

    // 상태 변경
    document.querySelectorAll(".js-status").forEach(sel => {
      sel.dataset.prev = sel.value;

      sel.addEventListener("change", async (e) => {
        const participantId = e.target.dataset.id;
        const participantStatus = e.target.value;
        try {
          const res = await post("${ctx}/admin/workshop/participant/status", { participantId, participantStatus });
          if (res.success) {
            alert("상태가 변경되었습니다.");
            e.target.dataset.prev = participantStatus;
          } else {
            alert("상태 변경 실패: " + (res.message || ""));
            e.target.value = e.target.dataset.prev; 
          }
        } catch (err) {
          alert("네트워크 오류로 실패했습니다.");
          e.target.value = e.target.dataset.prev; 
        }
      });
    });
  })();
  </script>

</body>
</html>
