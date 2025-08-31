<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<form name="reviewAnswerForm" method="post">
	<p>총 ${dataCount}개의 리뷰 (${pageNo} / ${total_page} 페이지)</p>
	<table class="table table-borderless board-list">
		<thead>
			<tr class="border-bottom">
				<th width="140">상품</th>
				<th>내용</th>
				<th width="140">평점</th>
				<th width="100">작성자</th>
				<th width="140">일시</th>
				<th width="140">상태</th>
				<th width="100">관리</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty reviewList}">
				<c:forEach var="dto" items="${reviewList}">
					<input type="hidden" name="gongguOrderDetailId" value="${dto.gongguOrderDetailId}" />
					<tr class="border-bottom reviewTr">
						<td>${dto.gongguProductName}</td>
						<td>${dto.content}</td>
						<td>
					        <c:forEach var="i" begin="1" end="${dto.rate}">
					            <i class="bi bi-star-fill" style="color: #ffc107;"></i>
					        </c:forEach>
					    </td>
						<td>${dto.userName}</td>
						<td><fmt:formatDate value="${dto.regDate}"
								pattern="yyyy-MM-dd" /></td>
						<td>
	                        <c:choose>
	                            <c:when test="${dto.status eq 1}">답변완료</c:when>
	                            <c:otherwise>미답변</c:otherwise>
	                        </c:choose>
	                    </td>
						<td>
                            <button type="button" class="small-btn deleteReview" data-gongguOrderDetailId="${dto.gongguOrderDetailId}">삭제</button>
	                    </td>
					</tr>
					<tr class="reviewDetailTr d-none">
						<td colspan="4">
							<div>
								<div class="review-detailInfo">
									<div class="reviewDetailHeader">
										<img src="/dist/images/person.png" class="user-icon">
										<div class="reviewDetailNTD">
											<div class="reviewDetailTD">
												<p class="reviewDetailName">${dto.userName}</p>
												<p class="reviewDetailDate">${dto.regDate}</p>
											</div>
										</div>
									</div>
									<div class="reviewDetailBody">
										<div class="reviewDetailContent">
											<p class="content">${dto.content}</p>
										</div>
										<div class="">
											<c:if test="${not empty dto.photoFileName}">
										        <img src="${pageContext.request.contextPath}/uploads/gonggu/review/${dto.photoFileName}" alt="리뷰 사진">
										    </c:if>
									    </div>
										<c:choose>
											<c:when test="${dto.status eq 1}">
												<hr class="reviewDivider">
												<div class="reviewDetailAnswer">
													<img src="/dist/images/person.png" class="answer-icon">
													<div class="reviewDetailNDC">
														<div class="reviewDetailAnswerND">
															<p class="reviewDetailAnswerName">${dto.answerName}</p>
															<p class="reviewDetailAnswerDate">${dto.answerDate}</p>
														</div>
														<div class="reviewDetailAnswerContent">
															<p class="answerP" readonly>${dto.answer}</p>
														</div>
														<div>
															<button type="button" class="small-btn updateAnswer"
																data-gongguOrderDetailId="${dto.gongguOrderDetailId}"
																data-managerId="${managerId}"
																data-managerName="${managerName}">수정</button>
															<button type="button" class="small-btn removeAnswer"
																data-gongguOrderDetailId="${dto.gongguOrderDetailId}">삭제</button>
														</div>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="reviewDetailAnswerAdd"
													id="reviewDetailAnswerAdd">
													<button type="button" class="small-btn addAnswer"
														data-gongguOrderDetailId="${dto.gongguOrderDetailId}"
														data-managerId="${managerId}"
														data-managerName="${managerName}">등록</button>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty reviewList}">
				<tr>
					<td colspan="6" style="text-align: center;">등록된 내용이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</form>