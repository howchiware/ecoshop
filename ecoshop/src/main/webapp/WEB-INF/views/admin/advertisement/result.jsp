<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
    <!-- 회원 목록 -->
    
    <div class="form-search">
        <select id="searchType" name="schType">
            <option value="username"  ${schType=="username" ? "selected":""}>이름</option>
            <option value="subject"      ${schType=="subject " ? "selected":""}>제목</option>
            <option value="content "     ${schType=="content " ? "selected":""}>내용</option>
        </select>
        <input type="text" id="keyword" name="kwd" value="${kwd}">
        <button type="button" class="btn-default" onclick="searchList()"> 
            <i class="bi bi-search"></i> 
        </button>
    </div>

		
	<span class="dataCount">${dataCount}개(${pageNo}/${total_page} 페이지)</span>
		<div class="col-md-3 text-end">
			&nbsp;
		</div>
		
		
    <table class="table table-hover board-list">
      <thead class="table-light">
        <tr style="text-align: center;">
		  <th>번호</th>
		  <th>이름</th>
          <th>제목</th>
          <th>가입일자</th>
          <th>문의유형</th>
          <c:if test="${role != 2}">
          	<th>게시여부</th>
          </c:if>
        </tr>
      </thead>
      
      <tbody>
        <c:forEach var="dto" items="${list}" varStatus="status">
          <tr class="hover-cursor" onclick="profile('${dto.advertisingId}', '${page}');" style="text-align: center;"> 
            <td>${dataCount - (page) - status.index}</td>
            <td>${dto.username}</td>
            <td>${dto.subject}</td>
            <td>${dto.regDate}</td>
            <td>
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
            <c:if test="${role != 2}">
            	<td>
				    <c:choose>
				        <c:when test="${dto.postingStatus == 0}">
				            공개
				        </c:when>
				        <c:when test="${dto.postingStatus == 1}">
				            비공개
				        </c:when>
				        <c:otherwise>
				            ${dto.postingStatus}
				        </c:otherwise>
				    </c:choose>
				</td>
            </c:if>
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