<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자페이지</title>
  <link rel="icon" href="data:;base64,iVBORw0KGgo=">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/vendor/glightbox/css/glightbox.min.css" type="text/css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
.photo-section .photo-content {
  position: relative;
  overflow: hidden;
}

.photo-section .photo-content img {
  transition: 0.3s;
}

.photo-section .photo-content .photo-info {
  opacity: 0;
  position: absolute;
  inset: 0;
  z-index: 3;
  transition: all ease-in-out 0.3s;
  background: rgba(0, 0, 0, 0.6);
  padding: 15px;
}

.photo-section .photo-content .photo-info h4 {
  font-size: 14px;
  padding: 5px 10px;
  font-weight: 400;
  color: #ffffff;
  display: inline-block;
  background-color: var(--accent-color);
}

.photo-section .photo-content .photo-info p {
  position: absolute;
  bottom: 10px;
  display: flex;
  left: 0;
  right: 0;
  font-size: 16px;
  font-weight: 600;
  justify-content: center;
  color: rgba(255, 255, 255, 0.8);
  > label {   
    flex: 1;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    text-align: center;    
    padding-left: 5px; padding-right: 5px;
  }  
}

.photo-section .photo-content .photo-info .preview-link,
.photo-section .photo-content .photo-info .details-link {
  position: absolute;
  left: calc(50% - 40px);
  font-size: 26px;
  top: calc(50% - 14px);
  color: rgba(255, 255, 255, 0.8);
  transition: 0.3s;
  line-height: 1.2;
  font-weight: 500;
}

.photo-section .photo-content .photo-info .preview-link:hover,
.photo-section .photo-content .photo-info .details-link:hover {
  color: #ffffff;
  font-weight: 700;
  transition: 0.3s;
}

.photo-section .photo-content .photo-info .details-link {
  left: 50%;
  font-size: 34px;
  line-height: 0;
}

.photo-section .photo-content:hover .photo-info {
  opacity: 1;
}

.photo-section .photo-content:hover img {
  transform: scale(1.1);
}

.page-navigation {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px 0;
  font-family: 'Noto Sans KR', sans-serif;
  gap: 10px;
}

.page-navigation a,
.page-navigation span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #7ecf98;
  color: #4caf50;
  text-decoration: none;
  font-weight: 600;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(126, 207, 152, 0.4);
  transition: background-color 0.25s ease, color 0.25s ease, box-shadow 0.25s ease;
  font-size: 1rem;
}

.page-navigation a:hover {
  background-color: #a4d7a7;
  color: white;
  box-shadow: 0 4px 12px rgba(126, 207, 152, 0.6);
}

.paginate span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #4caf50;
  background-color: #4caf50;
  color: #fff;
  font-weight: 700;
  cursor: default;
  box-shadow: 0 2px 5px rgba(76, 175, 80, 0.6);
  font-size: 1rem;
}

.paginate a {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #4caf50;
  color: #4caf50;
  text-decoration: none;
  font-weight: 600;
  transition: background-color 0.3s, color 0.3s;
  font-size: 1rem;
}

.paginate a:hover {
  background-color: #81c784;
  color: #fff;
  box-shadow: 0 4px 12px rgba(129, 199, 132, 0.6);
}

.page-navigation .disabled {
  color: #cde5d4;
  border-color: #cde5d4;
  cursor: default;
  pointer-events: none;
  box-shadow: none;
}

</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

    <div class="page-title">
		<div class="container align-items-center" data-aos="fade-up">
			<h1>광고상태조회</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container photo-section" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 my-1 p-2">
				<div class="data-info">
		        <span class="small-title">글목록</span> <span class="dataCount">${dataCount}개(${page}/${total_page} 페이지)</span>
		      </div>
				
						<div class="col-md-8 text-end">
							<button type="button" class="btn-accent btn-md" onclick="location.href='${pageContext.request.contextPath}/admin/promotion/write';">사진올리기</button>
						</div>
					</div>
				
					<div class="row gy-4 mb-3">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<div class="col-lg-4 col-md-9">
								<div class="photo-content h-100">
									<img src="${pageContext.request.contextPath}/uploads/promotion/${dto.imageFilename}" class="img-fluid border rounded w-100" style="height: 235px;" alt="">
									<div class="photo-info">
										<p><label>${dto.subject}</label></p>
										  <div class="mt-2">
									        <c:choose>
									            <c:when test="${sessionScope.member.memberId==dto.memberId}">
									                <button type="button" class="btn btn-sm btn-outline-primary"
									                        onclick="location.href='${pageContext.request.contextPath}/admin/promotion/update?promotionId=${dto.promotionId}&page=${page}';">
									                    수정
									                </button>
									            </c:when>
									            <c:otherwise>
									                <button type="button" class="btn btn-sm btn-outline-secondary" disabled>수정</button>
									            </c:otherwise>
									        </c:choose>
									
									        <c:choose>
									            <c:when test="${sessionScope.member.memberId==dto.memberId || sessionScope.member.userLevel>50}">
									                <button type="button" class="btn btn-sm btn-outline-danger"
									                        onclick="deleteOk('${dto.promotionId}', '${dto.imageFilename}')">
									                    삭제
									                </button>
									            </c:when>
									            <c:otherwise>
									                <button type="button" class="btn btn-sm btn-outline-secondary" disabled>삭제</button>
									            </c:otherwise>
									        </c:choose>
									    </div>
									</div> 	
								</div>
								
								<div id="inline-content-${dto.promotionId}" class="d-none">
									<div class="inline-inner">
										<h4 class="text-center mb-3">${dto.subject}</h4>
										<div class="row g-3">
											<div class="col-md-12 border-top"></div>
											<div class="col-md-6 text-end">
												작성일 : ${dto.regDate}
											</div>
											<div class="col-md-12 border-top"></div>
											<div class="col-md-12 border-top"></div>
											<div class="col-md-6">
												<c:choose>
													<c:when test="${sessionScope.member.memberId==dto.memberId}">
														<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/admin/promotion/update?num=${dto.promotionId}&page=${page}';">수정</button>											</c:when>
													<c:otherwise>
														<button type="button" class="btn-default" disabled>수정</button>
													</c:otherwise>
												</c:choose>
												
												<c:choose>
													<c:when test="${sessionScope.member.memberId==dto.memberId || sessionScope.member.userLevel>50}">
														<button type="button" class="btn-default" onclick="deleteOk('${dto.promotionId}', '${dto.imageFilename}')">삭제</button>
													</c:when>
													<c:otherwise>
														<button type="button" class="btn-default" disabled>삭제</button>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="col-md-6 text-end">
												<button type="button" class="gtrigger-close btn-accent">닫기</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					
					<div class="page-navigation">
						${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
					</div>
			
				</div>
			</div>
		</div>
</main>

<script type="text/javascript">

function deleteOk(promotionId, filename) {
	let params = 'promotionId=' + promotionId + '&imageFilename=' + filename + '&${query}';
    let url = '${pageContext.request.contextPath}/admin/promotion/delete?' + params;

    if(confirm('위 자료를 삭제 하시 겠습니까 ? ')) {
		location.href = url;
    }
}

</script>



</body>
</html>