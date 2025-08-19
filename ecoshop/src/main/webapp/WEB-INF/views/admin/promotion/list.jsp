<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/vendor/glightbox/css/glightbox.min.css" type="text/css">
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
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<!-- Page Title -->
	<div class="page-title">
		<div class="container align-items-center" data-aos="fade-up">
			<h1>포토 갤러리</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container photo-section" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 my-1 p-2">
				
					<div class="row mb-4">
						<div class="col-md-4 text-start">
							<form name="searchForm" class="form-group-search">
								<input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어를 입력하세요">
								<button type="button" onclick="searchList();"><i class="bi bi-search"></i></button>
							</form>
						</div>
						<div class="col-md-8 text-end">
							<button type="button" class="btn-accent btn-md" onclick="location.href='${pageContext.request.contextPath}/photo/write';">사진올리기</button>
						</div>
					</div>
				
					<div class="row gy-4 mb-3">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<div class="col-lg-4 col-md-6">
								<div class="photo-content h-100">
									<img src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}" class="img-fluid border rounded w-100" style="height: 235px;" alt="">
									<div class="photo-info">
										<p><label>${dto.subject}</label></p>
										<a href="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}" title="${dto.subject}" class="glightbox preview-link"><i class="bi bi-zoom-in"></i></a>
										<a href="#inline-content-${dto.num}" title="상세정보" class="glightbox4 details-link" data-glightbox="width: 700; height: auto;"><i class="bi bi-link-45deg"></i></a>
									</div>
								</div>
								
								<div id="inline-content-${dto.num}" class="d-none">
									<div class="inline-inner">
										<h4 class="text-center mb-3">${dto.subject}</h4>
										<div class="row g-3">
											<div class="col-md-12 border-top"></div>
											<div class="col-md-6">
												작성자 : ${dto.name}
											</div>
											<div class="col-md-6 text-end">
												작성일 : ${dto.reg_date}
											</div>
											<div class="col-md-12 border-top"></div>
											<div class="col-md-12">
												${dto.content}
											</div>
											<div class="col-md-12 border-top"></div>
											<div class="col-md-6">
												<c:choose>
													<c:when test="${sessionScope.member.member_id==dto.member_id}">
														<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/photo/update?num=${dto.num}&page=${page}';">수정</button>											</c:when>
													<c:otherwise>
														<button type="button" class="btn-default" disabled>수정</button>
													</c:otherwise>
												</c:choose>
												
												<c:choose>
													<c:when test="${sessionScope.member.member_id==dto.member_id || sessionScope.member.userLevel>50}">
														<button type="button" class="btn-default" onclick="deleteOk('${dto.num}', '${dto.imageFilename}')">삭제</button>
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
	</div>
</main>


</body>
</html>