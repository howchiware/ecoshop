<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<style>
.hover-cursor {
  cursor: pointer;
}

.my-btn {
   background: #fff;
   border: 1px solid black !important;
   border-radius: 4px;
   padding: 3px 10px
}

</style>

<!-- 신청 목록 -->
<span class="dataCount">${dataCount}개(${pageNo}/${total_page} 페이지)</span>
	<div class="col-md-5 text-end">&nbsp;</div>

<table class="table board-list">
	  <thead class="table-light" style="text-align: center;">
	    <tr>
	      <th>번호</th>
	      <th>이름</th>
	      <th>제목</th>
	      <th>가입일자</th>
	      <th>문의유형</th>
	      <th>게시 기간</th>
	      <th>처리</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach var="dto" items="${list}" varStatus="status">
	      <tr  align="center" class="hover-cursor" 
	          data-bs-toggle="collapse" 	
	          data-bs-target="#collapse-${dto.advertisingId}" 
	          aria-expanded="false" 
	          aria-controls="collapse-${dto.advertisingId}">
	        <td align="center">${dataCount - ((page-1) * size + status.index)}</td>
	        <td align="center">${dto.username}</td>
	        <td align="center">${dto.subject}</td>
	        <td align="center">${dto.regDate}</td>
	        <td align="center">
			    <c:choose>
			        <c:when test="${dto.inquiryType == 1}">
			            메인
			        </c:when>
			        <c:when test="${dto.inquiryType == 2}">
			            개인페이지
			        </c:when>
			        <c:otherwise>
			            ${dto.inquiryType}
			        </c:otherwise>
			    </c:choose>
			</td>
			<td>${dto.adverStart}&nbsp;~&nbsp;${dto.adverEnd}</td>
	        <td>
	          <button type="button" class="btn my-btn"
	                  onclick="event.stopPropagation(); updateStatus('${dto.advertisingId}', 5)">승인</button>
	          <button type="button" class="btn my-btn"
	                  onclick="event.stopPropagation(); updateStatus('${dto.advertisingId}', 4)">반려</button>
	        </td>
	      </tr>
	      <!-- 상세 영역 -->
	      <tr class="collapse" id="collapse-${dto.advertisingId}">
	        <td colspan="6">
	          <div class="accordion-body" id="detail-${dto.advertisingId}">
	            <!-- 광고 상세보기 -->
				<table class="advertising-info">
				  <tr>
				    <td>회원번호</td>
				    <td>${dto.advertisingId }</td>
				  </tr>
				  <tr>
				    <td>이름</td>
				    <td>${dto.username}</td>
				  </tr>
				  <tr>
				    <td>생일</td>
				    <td>${dto.subject}</td>
				  </tr>
				  <tr class="date-row">
				    <td>가입일</td>
				    <td>${dto.regDate}</td>
				  </tr>
				  <tr>
				    <td>전화번호</td>
				    <td>${dto.tel}</td>
				  </tr>
				  <tr>
				    <td>우편번호</td>
				    <td>${dto.zip}</td>
				  </tr>
				  <tr>
				    <td>이메일</td>
				    <td>${dto.email}</td>
				  </tr>
				</table>
	          </div>
	        </td>
	      </tr>
	    </c:forEach>
	  </tbody>
	</table>

    <!-- 페이징 -->
    <div class="page-navigation">
      ${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
    </div>

	<div class="row board-list-footer">
	
	</div>