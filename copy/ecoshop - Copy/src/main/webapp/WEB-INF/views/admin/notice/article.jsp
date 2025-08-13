<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />


<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
 
 <div class="right-panel">
		<div class="page-title" data-aos="fade-up" data-aos-delay="200">
			<h2>공지사항</h2>
		</div>

		<div class="section p-5" data-aos="fade-up" data-aos-delay="200">
			<div class="section-body p-5">
				<div class="row gy-4 m-0">
					<div class="col-lg-12 board-section p-5 m-2" data-aos="fade-up" data-aos-delay="200">
						
						<div class="pb-2">
							<span class="small-title">상세정보</span>
						</div>
										
						<table class="table board-article">
							<thead>
								<tr>
									<td colspan="2" class="text-center">
										${dto.subject}
									</td>
								</tr>
							</thead>
	
							<tbody>
								<tr>
									<td width="50%">
										작성자 : ${dto.name}
									</td>
									<td width="50%" class="text-end">
										작성일 : ${dto.regDate}
									</td>
								</tr>
								
								<c:if test="${not empty dto.updateId}">
									<tr>
										<td width="50%">
											수정자 : ${dto.updateName}(${dto.loginUpdate})
										</td>
										<td width="50%" class="text-end">
											수정일 : ${dto.updateDate}
										</td>
									</tr>
								</c:if>

								<tr>
									<td width="50%">
										조회수 : ${dto.hitCount}
									</td>
									<td width="50%" class="text-end">
										출 력 : ${dto.showNotice == 1 ? "표시" : "숨김" }
									</td>
								</tr>
								
								<tr>
									<td colspan="2" valign="top" height="200" class="article-content" style="border-bottom:none;">
										${dto.content}
									</td>
								</tr>
	
								<tr>
									<td colspan="2">
										<c:if test="${listFile.size() != 0}">
											<p class="border text-secondary mb-1 p-2">
												<i class="bi bi-folder2-open"></i>
												<c:forEach var="vo" items="${listFile}" varStatus="status">
													<a href="${pageContext.request.contextPath}/admin/notice/download/${vo.noticefileId}">
														${vo.originalFilename}
														(<fmt:formatNumber value="${vo.fileSize}" type="number"/>byte)
													</a>
													<c:if test="${not status.last}">|</c:if>
												</c:forEach>
											</p>
											<p class="border text-secondary mb-1 p-2">
												<i class="bi bi-folder2-open"></i>
												<a href="${pageContext.request.contextPath}/admin/notice/zipdownload/${dto.noticeId}">파일 전체 압축 다운로드(zip)</a>
											</p>
										</c:if>
									</td>
								</tr>
	
								<tr>
									<td colspan="2">
										이전글 : 
										<c:if test="${not empty prevDto}">
											<a href="${pageContext.request.contextPath}/admin/notice/article/${prevDto.noticeId}?${query}">${prevDto.subject}</a>
										</c:if>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										다음글 : 
										<c:if test="${not empty nextDto}">
											<a href="${pageContext.request.contextPath}/admin/notice/article/${nextDto.noticeId}?${query}">${nextDto.subject}</a>
										</c:if>
									</td>
								</tr>
							</tbody>
						</table>
	
						<div class="row mb-2">
							<div class="col-md-6 align-self-center">
				    			<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?noticeId=${dto.noticeId}&page=${page}';">수정</button>
								<button type="button" class="btn-default" onclick="deleteOk();">삭제</button>
							</div>
							<div class="col-md-6 align-self-center text-end">
								<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list?${query}';">리스트</button>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</main>
	
<script type="text/javascript">
	function deleteOk() {
		let params = 'noticeId=${dto.noticeId}&${query}';
		let url = '${pageContext.request.contextPath}/admin/notice/delete?' + params;
	
		if(confirm('위 자료를 삭제 하시 겠습니까 ? ')) {
			location.href = url;
		}
	}
</script>


</body>
</html>