<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssReport/report.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
	<div class="right-panel">
		<div class="page-title" data-aos="fade-up" data-aos-delay="200">
			<h2>게시글 신고 관리</h2>
		</div>

		<div class="section p-5" data-aos="fade-up" data-aos-delay="200">
			<div class="section-body p-5">
				<div class="row gy-4 m-0">
					<div class="col-lg-12 board-section p-5 m-2" data-aos="fade-up" data-aos-delay="200">

						<div class="card shadow-sm mb-3">
							<div class="card-header bg-light-secondary py-3">
								<strong>신고 상세 정보</strong>
							</div>
							<div class="card-body">
							
								<table class="table table-bordered reports-content">
									<tbody>
										<tr>
											<th style="width: 15%;">콘텐츠</th>
											<td style="width: 35%;">${report.contentTitle}</td>
											<th style="width: 15%;">게시글번호</th>
											<td style="width: 35%;">${report.targetNum} (${report.target})</td>
										</tr>
										<tr>
											<th>신고자</th>
											<td>${report.reporterName} (${report.reporterId})</td>
											<th>처리상태</th>
											<td>
												<c:choose>
													<c:when test="${report.reportStatus == 1}">신고접수</c:when>
													<c:when test="${report.reportStatus == 2}">처리완료</c:when>
													<c:when test="${report.reportStatus == 3}">기각</c:when>
													<c:otherwise>미확인</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<th>신고일자</th>
											<td>${report.reportDate}</td>
											<th>신고 IP</th>
											<td>${report.reportIp}</td>
										</tr>
										<tr>
											<th>신고유형</th>
											<td>
												${report.reasonCode}
											</td>
											<th>신고건수</th>
											<td>
												${reportsCount}
											</td>
										</tr>
										<tr>
											<th valign="middle">신고상세내용</th>
											<td colspan="3">
												<div class="p-2">${report.reasonDetail}</div>
											</td>
										</tr>
								
										<c:if test="${not empty report.processorId}">
											<tr>
												<th>처리담당자</th>
												<td>${report.processorName} (${report.processorId})</td>
												<th>처리일자</th>
												<td>${report.processedDate}</td>
											</tr>
											<tr>
												<th valign="middle">처리상세내용</th>
												<td colspan="3">
													<div class="p-2">${report.actionTaken}</div>
												</td>
											</tr>
										</c:if>
									</tbody>
								</table>
								
								<div class="d-flex justify-content-between align-items-center">
									<div>
										<button type="button" class="btn-default me-2" onclick="reportProcess('one');">신고처리</button>
										<button type="button" class="btn-default" onclick="reportProcess('all');">신고 일괄처리</button>
									</div>
									
									<div>
										<button type="button" class="btn-default me-2" onclick="postsView()">게시글 보기</button>
										<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/admin/reportsManage/main?${query}';">리스트</button>
									</div>
								</div>
																
        					</div>
        				</div>
						
						<div class="card shadow-sm">
							<div class="card-header bg-light-secondary py-3">
								<strong>동일 게시글 신고 리스트</strong>
							</div>
							
							<div class="card-body reports-list"></div>
						</div>						

					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<!-- 신고 조치 -->
<div class="modal fade" id="reportHandledDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="reportHandledDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reportHandledDialogModalLabel">신고 조치</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form name="reportsForm" method="post" class="p-3 border rounded">
				    <div class="row mb-3">
				        <div class="col-md-6">
				            <label for="report-status" class="form-label">신고 처리 상태</label>
				            <select name="reportStatus" id="report-status" class="form-select">
				                <option value="2">처리완료</option>
				                <option value="3">기각</option>
				            </select>
				        </div>
				        <div class="col-md-6">
				            <label for="report-action" class="form-label">조치 유형</label>
				            <select name="reportAction" id="report-action" class="form-select">
				                <option value="blind">블라인드</option>
				                <option value="delete">삭제</option>
				                <option value="none">무처리</option>
				                <option value="unlock">블라인드 해제</option>
				            </select>
				        </div>
				    </div>
				
				    <div class="mb-3">
				        <label for="actionTaken" class="form-label">조치 사항</label>
				        <textarea name="actionTaken" id="actionTaken" class="form-control" style="height: 120px;" placeholder="조치사항을 입력해주세요"></textarea>
				    </div>
				
				    <!-- hidden inputs -->
				    <input type="hidden" name="reportId" value="${report.reportId}">
				    <input type="hidden" name="target" value="${report.target}">
				    <input type="hidden" name="targetNum" value="${report.targetNum}">
				    <input type="hidden" name="contentType" value="${report.contentType}">
				    <input type="hidden" name="mode" value="all">
				
				    <input type="hidden" name="status" value="${reportsStatus}">
				    <input type="hidden" name="page" value="${page}">
				    <input type="hidden" name="schType" value="${schType}">
				    <input type="hidden" name="kwd" value="${kwd}">

				    <div class="text-end">
						<button type="button" class="btn-accent" onclick="reportProcessSaved();"> 등록 </button>
						<button type="button" class="btn-default" data-bs-dismiss="modal"> 취소 </button>
				    </div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 게시글 내용 -->
<div class="modal fade" id="postsDialogModal" tabindex="-1" aria-labelledby="postsDialogModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
        
            <div class="modal-header">
                <h5 class="modal-title" id="postsDialogModalLabel">게시글 내용</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
            	<c:choose>
            		<c:when test="${empty posts}">
            			<p class="text-center p-3">삭제된 게시글입니다.</p>
            		</c:when>
            		<c:otherwise>
						<table class="table table-bordered reports-content">
							<tbody>
								<tr>
									<th style="width: 15%;">작성자</th>
									<td style="width: 35%;">${posts.writer} (${posts.writerId})</td>
									<th style="width: 15%;">블라인드</th>
									<td style="width: 35%;">${posts.block == 1 ? "블라인드 처리" : ""}</td>
								</tr>
								<c:if test="${not empty posts.subject}">
									<tr>
										<th style="width: 15%;">제목</th>
										<td style="width: 85%;" colspan="3">${posts.subject}</td>
									</tr>
								</c:if>
								<tr>
									<th style="width: 15%;">내용</th>
									<td style="width: 85%;" colspan="3">${posts.content}</td>
								</tr>
								<c:if test="${not empty posts.imageFilename}">
									<tr>
										<th style="width: 15%;">이미지</th>
										<td style="width: 85%;" colspan="3"> <img src="${posts.imageFilename}" class="img-fluid rounded border mt-2" alt="첨부 이미지"></td>
									</tr>
								</c:if>
							</tbody>
						</table>
            		</c:otherwise>
            	</c:choose>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn-default" data-bs-dismiss="modal">닫기</button>
            </div>
            
        </div>
    </div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
	<script type="text/javascript">
		const CONTEXT_PATH = "${pageContext.request.contextPath}";
	    const REPORT_ID = "${report.reportId}";
	    const TARGET_NUM = "${report.targetNum}";
	    const TARGET = "${report.target}";
	    const PAGE_NUM = "${page}";
	</script>
	<script src="${pageContext.request.contextPath}/dist/jsReport/reportArticle.js"></script>


</body>
</html>