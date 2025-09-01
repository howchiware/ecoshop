<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

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
	                        <button type="button" class="product-item-heart" style="border: none; background: none;" data-productCode="${dto.productCode}">
	                        	<i class="bi ${dto.userProductLike==1 ? 'bi-heart-fill text-danger':'bi-heart'} "></i>
	                        </button>
	                    </div>
	                    <p class="card-price">${dto.price}원</p>
	                    <a class="card-link" data-reviewCount="${dto.reviewCount}"><i class="bi bi-chat-right"></i></a>&nbsp;&nbsp;${dto.reviewCount}
	                    <button type="button" class="ms-3 product-item-cart" style="border: none; background: none;" data-productCode="${dto.productCode}">
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
				
			<div id="product-template">
				<input type="hidden" id="web-contextPath" value="${pageContext.request.contextPath}">
				<input type="hidden" id="memberLogin" value="${sessionScope.member}">
			</div>
</div>
<!-- 
<c:if test="${not empty listProduct}">
    <c:forEach var="dto" items="${listProduct}">
		<div class="modal fade" id="productDetailDialogModal${dto.productCode}" tabindex="-1" 
				data-bs-backdrop="static" data-bs-keyboard="false"
				aria-labelledby="productDetailDialogModal${dto.productCode}Label" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="productDetailDialogModal${dto.productCode}Label">상품 문의 하기</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
		
						<div>
							<div class="row gy-4" >
						
								<div class="col-md-12">
									<div class="row">
										<div class="col-md-6 p-2 pe-5">
											<div class="row gx-1 p-1">
												<div class="col border rounded lg-img p-0">
													<img class="w-100 h-100 rounded" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
												</div>
											</div>
											<div class="row gx-1 mt-2 p-1">
												<c:forEach var="vo" items="${listPhoto}">
													<div class="col-md-auto sm-img">
														<img class="border rounded" src="${pageContext.request.contextPath}/uploads/products/${vo.photoName}">
													</div>
												</c:forEach>
											</div>
										</div>
										
										<div class="col-md-6 ps-4">
											<form name="buyForm">
												<c:if test="${dto.totalStock < 1}">
													<div class="border rounded mt-2 mb-2 p-2 text-center" style="background: ">
														<label class="text-black-50 fw-bold">상품 재고가 없습니다.</label>
													</div>
												</c:if>
												<div class="row pt-2 border-bottom namePrice">
													<div class="col productName mb-2">
														${dto.productName}
													</div>
													<div class="price">
														<fmt:formatNumber value="${dto.price}"/>원
													</div>
												</div>
												
												<div class="row infoArea">
													<p class="content">${dto.content}</p>
												</div>
												
												<div class="row mt-2">
													<table class="info-table">
														<tbody>
															<tr>
																<td>브랜드</td>
																<td>ecobrand 샵</td>
															</tr>
															<tr>
																<td>구매혜택</td>
																<td>${dto.point} 포인트 적립예정</td>
															</tr>
															<tr>
																<td>배송 방법</td>
																<td>택배</td>
															</tr>
															<tr>
																<td>배송비</td>
																<td>3,000원 (30,000원 이상 무료배송)<br>도서산간 배송비 추가</td>
															</tr>
														</tbody>
													</table>
												</div>
														
												<div class="option-area">
													<c:if test="${dto.optionCount > 0}">
														<div class="row mt-2" style="font-weight: 500">
															* 필수 옵션
														</div>
													</c:if>
													
													<div class="option-select-area" style="padding: 3px 6px;">
														<c:if test="${dto.optionCount > 0}">
															<div class="row mt-2">
																<select class="form-select requiredOption" data-optionNum="${listOption[0].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
																	<option value="">${listOption[0].optionName}</option>
																	<c:forEach var="vo" items="${listOptionDetail}">
																		<c:if test="${dto.optionCount == 1}">
																			<option value="${vo.optionDetailNum}" data-stockNum="${vo.stockNum}" data-totalStock="${vo.totalStock}" data-optionValue="${vo.optionValue}">${vo.optionValue}${vo.totalStock<5?' 재고 - '+= vo.totalStock:''}</option>
																		</c:if>
																		<c:if test="${dto.optionCount != 1}">
																			<option value="${vo.optionDetailNum}">${vo.optionValue}</option>
																		</c:if>
																	</c:forEach>
																</select>
															</div>
														</c:if>
									
														<c:if test="${dto.optionCount > 1}">
															<div class="row mt-2">
																<select class="form-select requiredOption2" data-optionNum2="${listOption[1].optionNum}" ${dto.totalStock < 1 ? 'disabled':''}>
																	<option value="">${listOption[1].optionName}</option>
																</select>
															</div>
														</c:if>
													</div>
												</div>
																		
												<div class="row pb-2 order-area">
													<div class="order-box">
														
													</div>
											        
													<div class="total-div">
														<div class="col-auto fw-semibold pt-1 total">총상품금액 (<span class="product-totalQty">0</span>개)</div>
														<div class="col text-end">
															<label><span class="product-totalAmount fs-5 fw-semibold text-primary">0</span><span class="fw-semibold fs-6 text-primary">원</span></label>
														</div>
													</div>
												</div>
												
							
												<div class="mt-2">
													<input type="hidden" name="mode" value="buy">
													<button type="button" class="btn-accent btn-lg w-100 btn-buySend" onclick="sendOk('buy');" ${dto.totalStock < 1 ? 'disabled':''} ${empty sessionScope.member ? 'disabled' : ''}>구매하기</button>
												</div>
												
												<div class="row mt-2 mb-2">
													<div class="col pe-1">
														<button type="button" class="btn-default btn-lg w-100 btn-productLike" data-productCode="${dto.productCode}" ${empty sessionScope.member.memberId ? "disabled" : ""}>찜하기&nbsp;&nbsp;<i class="bi ${dto.userProductLike==1 ? 'bi-heart-fill text-danger':'bi-heart'}"></i></button>
													</div>
													<div class="col ps-1">
														<button type="button" class="btn-default btn-lg w-100 btn-productCart" onclick="sendOk('cart');" ${empty sessionScope.member.memberId || dto.totalStock < 1 ? "disabled" : ""}>장바구니&nbsp;&nbsp;<i class="bi bi-cart-plus"></i></button>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</c:if>
-->
		<div class="modal fade" id="productDetailDialogModal" tabindex="-1" 
				data-bs-backdrop="static" data-bs-keyboard="false"
				aria-labelledby="productDetailDialogModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="productDetailDialogModalLabel">장바구니에 상품 담기</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
		
						
					</div>
				</div>
			</div>

		</div>