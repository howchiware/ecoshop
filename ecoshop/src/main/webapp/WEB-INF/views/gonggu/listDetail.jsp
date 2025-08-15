<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:choose>
    <c:when test="${not empty listGongguProduct}">
        <c:forEach var="dto" items="${listGongguProduct}">
            <div class="col">
                <div class="card">
                    <img src="${pageContext.request.contextPath}/dist/images/${dto.gongguThumbnail}" style="position: absolute; width: 100%; height: 100%;" alt="${dto.gongguProductName}">
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-name">${dto.gongguProductName}</h5>
                        <i class="bi bi-heart heart-icon"></i>
                    </div>
                    <p class="card-price">${dto.gongguPrice}원</p>
                    <a href="#" class="card-link"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;32
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