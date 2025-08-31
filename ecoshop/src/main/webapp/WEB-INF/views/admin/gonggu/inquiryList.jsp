<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<form name="inquiryAnswerForm" method="post">
	<p>총 ${dataCount}개의 문의 (${pageNo} / ${total_page} 페이지)</p>
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
	                    <td>${dto.gongguProductName}</td>
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
                            <button type="button" class="small-btn deleteInquiry" data-gongguInquiryId="${dto.gongguInquiryId}">삭제</button>
	                    </td>
	                </tr>
	                <tr class="inquiryDetailTr d-none">
							<td colspan="4">
								<div class="">
									<div class="inquiry-detailInfo">
										<div class="inquiryDetailHeader">
											<img src="/dist/images/person.png" class="user-icon">
											<div class="inquiryDetailNTD">
											<div class="inquiryDetailTD">
													<p class="inquiryDetailName">${dto.userName}</p>
													<p class="inquiryDetailDate">${dto.regDate}</p>
												</div>
												<p class="inquiryDetailTitle">${dto.title}</p>
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
															<div class="inquireDetailAnswerContent">
																<p class="answerP" readonly>${dto.answer}</p>
															</div>
															<div>
																<button type="button" class="small-btn updateAnswer" data-gongguInquiryId="${dto.gongguInquiryId}"
						                                			data-managerId="${managerId}" data-managerName="${managerName}">수정</button>
																<button type="button" class="small-btn removeAnswer" data-gongguInquiryId="${dto.gongguInquiryId}">삭제</button>
															</div>
														</div>
													</div>
												</c:when>
												<c:otherwise>
													<div class="inquireDetailAnswerAdd" id="inquireDetailAnswerAdd">
						                                <button type="button" class="small-btn addAnswer" data-gongguInquiryId="${dto.gongguInquiryId}"
						                                	data-managerId="${managerId}" data-managerName="${managerName}">등록</button>
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
	    </tbody>
	</table>
	<div class="page-navigation">
		${dataCount==0 ? "등록된 내용이 없습니다." : paging}
	</div>

</form>