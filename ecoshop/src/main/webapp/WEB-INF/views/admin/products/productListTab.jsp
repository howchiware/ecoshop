<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<div class="outside">
	<div class="section ps-5 pe-5" data-aos="fade-up" data-aos-delay="200" style="padding-top:0px">
		<div>
			<div class="row gy-4 m-0">
				<div class="col-lg-12 p-2 m-2" data-aos="fade-up" data-aos-delay="200">
					
					<div class="row mb-2">
						<div class="col-md-6 align-self-center">
							<span class="small-title">전체</span> <span class="dataCount">${dataCount}건 조회</span>
						</div>	
						<div class="col-md-6 align-self-center text-end">
							<button type="button" class="addBtn">상품 등록</button>
						</div>
					</div>
					
					<form name="productManageForm" method="post">
					<div style="padding: 5px 0 5px; border-top:1px solid #dee2e6; margin: 0px; background: #fcfcfc">
						<button type="button" class="btn-default product-deleteCheck" onclick="deleteProductSelect();">선택삭제</button>
					</div>
					<table class="table product-list">
						<thead>
							<tr class="table-light border-top text-center">
								<th width="35" rowspan="2">
									<input type="checkbox" class="form-check-input product-chkAll" name="chkAll">
								</th>
								<th rowspan="2" width="30">상품코드</th>
								<th rowspan="2" width="70">상품사진</th>
								<th width="80">카테고리</th>
								<th width="80">최초 등록일</th>
								<th rowspan="2" width="70">판매가</th>
								<th rowspan="2" width="50">재고 수량</th>
								<th rowspan="2" width="50">진열</th>
								<th rowspan="2" width="70">관리</th>
							</tr>
							<tr class="table-light border-top text-center">
								<th width="80">상품명</th>
								<th width="80">최근 수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${listProduct}">
								<tr class="text-center" valign="middle">
									<td rowspan="2">
										<input type="checkbox" class="form-check-input" name="nums" value="${dto.totalStock}" 
												data-totalStock="${dto.totalStock}" ${dto.totalStock == 0 ? "disabled":""}>
									</td>
									<td rowspan="2">${dto.productCode}</td>
									<td rowspan="2" width="55">
										<img class="border rounded" width="50" height="50" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
									</td>
									<td>${dto.categoryName}</td>
									<td>${dto.reg_date}</td>
									<td rowspan="2">${dto.price} 원</td>
									<td rowspan="2">2</td>
									<td rowspan="2">
										<c:if test="${dto.productShow == 1}">
											표시
										</c:if>
										<c:if test="${dto.productShow == 0}">
											숨김
										</c:if>
									</td>
									<td rowspan="2">
										<button type="button">재고</button>
										<button type="button">수정</button>
									</td>
								</tr>
								<tr>
									<td>
										${dto.productName}
									</td>
									<td>
										${dto.update_date}
									</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="10" style="text-align: right; border-bottom: none;">
									<button type="button">선택상품삭제</button>
									<button type="button">전체상품삭제</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
					
					<div class="page-navigation">
						${dataCount==0 ? "등록된 상품이 없습니다." : paging}
					</div>

				</div>
			</div>
		</div>
	</div>
</div>