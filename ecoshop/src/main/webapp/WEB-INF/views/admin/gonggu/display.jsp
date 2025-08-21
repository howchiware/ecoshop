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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css_gonggu/display.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
	</header>
	<main class="main-container">
	<jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
		<div class="right-PANEL">
		<div class="title">
				<h3>공동구매 리스트</h3>
        </div>
		
		<hr>
		<div class="outside">
			 <div class="row gy-4">
			 	<div class="col-md-12">
					<c:forEach var="dto" items="${listProduct}">
						<div class="row p-3 ms-1 me-1 mt-2 bg-light rounded gonggu-item">
							<div class="col-4 border rounded p-1">
								<img class="rounded gonggu-img" src="${pageContext.request.contextPath}/uploads/gonggu/${dto.gongguThumbnail}">
							</div>
							<div class="col align-self-center">
								<h3 class="mb-2">${dto.gongguProductName}</h3>
								<div class="mb-2">
									기간 : ${dto.startDate} ~ ${dto.endDate} 
								</div>
								<div>
									<span class="gonggu-view-btn fw-semibold">상세 설명 보기</span> | 
									<span class="gonggu-product-list fw-semibold" data-gongguProductId="${dto.gongguProductId}">상품 목록</span>
								</div>
							</div>
						</div>
						<div class="gonggu-content p-3">
							${fn:replace(dto.content, "<br>", "")}
						</div>
					</c:forEach>
			 	</div>
			 	
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 상품이 없습니다" : paging}
				</div>			 	
				
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
$(function(){
	$('.gonggu-view-btn').click(function(){
		let $el = $(this).closest('.gonggu-item').next('.gonggu-content');
		let isVisible = $el.is(':visible');
		if(isVisible) {
			$el.fadeOut(100);
			$(this).text('상세 설명 보기');
		} else {
			$el.fadeIn(100);
			$(this).text('상세 설명 닫기');
		}		
	});
});

$(function(){
	$('.gonggu-product-list').click(function(){
		let gongguProductId = $(this).attr('data-gongguProductId');
		
		let url = '${pageContext.request.contextPath}/gonggu/display/' + gongguProductId;
		location.href = url;
	});
});
</script>
</body>
</html>