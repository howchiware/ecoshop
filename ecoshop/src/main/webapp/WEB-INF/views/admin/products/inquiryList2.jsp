<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<form name="inquiryAnswerForm" method="post">
	<table class="table table-borderless board-list">
	    <thead>
	        <tr class="border-bottom">
	            <th width="140">상품</th>
	            <th>내용</th>
	            <th width="100">작성자</th>
	            <th width="140">일시</th>
	            <th width="140">상태</th>
	            <th width="100">관리</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:if test="${not empty inquiryList}">
	            <c:forEach var="dto" items="${inquiryList}">
	                <tr class="border-bottom inquiryTr">
	                    <td>${dto.productName}</td>
	                    <td>${dto.title}</td>
	                    <td>${dto.userName}</td>
	                    <td><fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd" /></td>
	                    <td>
	                        <c:choose>
	                            <c:when test="${dto.status eq 1}">답변완료</c:when>
	                            <c:otherwise>미답변</c:otherwise>
	                        </c:choose>
	                    </td>
	                    <td>
	                        <c:choose>
	                            <c:when test="${dto.status eq 1}">
	                                <button type="button" class="small-btn">수정</button>
	                                <button type="button" class="small-btn">삭제</button>
	                            </c:when>
	                            <c:otherwise>
	                                <button type="button" class="small-btn deleteInquiry" data-inquiryId="${dto.inquiryId}">삭제</button>
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	                </tr>
	                <tr class="inquiryDetailTr d-none">
							<td colspan="4">
								<div class="">
									<div id="inquiryDetail1" class="inquiry-detailInfo">
										<div class="inquiryDetailHeader">
											<img src="/dist/images/person.png" class="user-icon">
											<div class="inquiryDetailNTD">
												<p class="inquiryDetailTitle">${dto.title}</p>
												<div class="inquiryDetailTD">
													<p class="inquiryDetailName">${dto.userName}</p>
													<p class="inquiryDetailDate">${dto.regDate}</p>
												</div>
											</div>
										</div>
										<hr class="inquireDivider">
										<div class="inquiryDetailBody">
											<div class="inquireDetailContent">
												<p class="content">${dto.content}</p>
											</div>
											<c:choose>
	                           					 <c:when test="${dto.status eq 1}">
													<hr class="inquireDivider">
													<div class="inquireDetailAnswer">
														<img src="/dist/images/person.png" class="answer-icon">
														<div class="inquiryDetailNDC">
															<div class="inquiryDetailAnswerND">
																<p class="inquiryDetailAnswerName">${dto.answerName}</p>
																<p class="inquiryDetailAnswerDate">${dto.answerDate}</p>
															</div>
															<div class="inquireDetailAnswerContent" id="inquireDetailAnswerContent">
																<textarea class="answerContentTA" readonly>${dto.answer}</textarea>
																<button type="button" class="small-btn updateAnswer" data-inquiryId="${dto.inquiryId}">수정</button>
																<button type="button" class="small-btn removeAnswer" data-inquiryId="${dto.inquiryId}">삭제</button>
															</div>
														</div>
													</div>
												</c:when>
												<c:otherwise>
													<div class="inquireDetailAnswerAdd">
														<textarea name="answer"></textarea>	
						                                <button type="button" class="small-btn addAnswer" data-inquiryId="${dto.inquiryId}">등록</button>
														<input type="hidden" class="inquiryIdInput" name="inquiryId" value="${dto.inquiryId}">
														<input type="hidden" class="answerIdInput" name="answerId" value="${managerId}">
														<input type="hidden" class="answerNameInput" name="answerName" value="${managerName}">
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
	        <c:if test="${empty inquiryList}">
	            <tr>
	                <td colspan="6" style="text-align: center;">등록된 내용이 없습니다.</td>
	            </tr>
	        </c:if>
	    </tbody>
	</table>
</form>