<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="row">
	<c:choose>
	    <c:when test="${not empty listProduct}">
	        <c:forEach var="dto" items="${listProduct}">
	            <div class="col-3 product-item" data-productCode = "${dto.productCode}">
	                <div class="card card-img" data-productId="${dto.productId}">
	                    <img src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}" style="position: absolute; width: 100%; height: 100%;" alt="${dto.productName}">
	                </div>
	                <div class="card-body">
	                    <div class="d-flex justify-content-between align-items-center">
	                        <h5 class="card-name">${dto.productName}</h5>
	                        <button type="button" class="product-item-heart" style="border: none; background: none;" data-productCode="${dto.productCode}" ${empty sessionScope.member.memberId ? "disabled" : ""}>
	                        	<i class="bi ${dto.userProductLike==1 ? 'bi-heart-fill text-danger':'bi-heart'} "></i>
	                        </button>
	                    </div>
	                    <p class="card-price">${dto.price}원</p>
	                    <a class="card-link" data-reviewCount="${dto.reviewCount}"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;${dto.reviewCount}
	                    <button type="button" class="ms-3 product-item-cart" style="border: none; background: none;" data-productCode="${dto.productCode}" ${empty sessionScope.member.memberId ? "disabled" : ""}>
	                    	<i class="bi bi-cart"></i>
	                    </button>
	                </div>
	            </div>
	        </c:forEach>
	    </c:when>
	    <c:otherwise>
	        <div class="col-12 text-center">
	            <p>해당 카테고리의 상품이 없습니다.</p>
	        </div>
	    </c:otherwise>
	</c:choose>
</div>
<div class="row">
	<div class="page-navigation">
		${dataCount==0 ? "등록된 내용이 없습니다." : paging}
	</div>
</div>