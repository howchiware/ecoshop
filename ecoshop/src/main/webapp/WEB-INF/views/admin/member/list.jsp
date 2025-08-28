<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="row-md-6 text-end">
	<div class="form-search">
		<select id="searchType" name="schType">
			<option value="memberId" ${schType=="memberId" ? "selected":""}>아이디</option>
			<option value="name" ${schType=="name" ? "selected":""}>이름</option>
			<option value="nickname" ${schType=="nickname" ? "selected":""}>닉네임</option>
			<option value="enabled" ${schType=="enabled" ? "selected":""}>유효상태</option>
		</select> <input type="text" id="keyword" name="kwd" value="${kwd}" class="form-control">
		<button type="button" class="my-btn" onclick="searchList()">조회</button>
	</div>

</div>
<span class="dataCount">총 ${dataCount}명(${pageNo}/${total_page} 페이지)</span>
<div class="col-md-3 text-end">&nbsp;</div>

<table class="table table-hover board-list">
	<thead class="table-light">
		<tr>
			<th>번호</th>
			<th>고유 번호</th>
			<th>이름(닉네임)</th>
			<th>전화번호</th>
			<th>가입일자</th>
			<th>상태</th>
		</tr>
	</thead>

	<tbody>
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr class="hover-cursor"
				onclick="profile('${dto.memberId}', '${page}');">
				<td>${dataCount - (page-1) * size - status.index}</td>
				<td>${dto.memberId}</td>
				<td>${dto.name}(${dto.nickname})</td>
				<td>${dto.tel}</td>
				<td>${dto.regDate}</td>
				<td>
					 <c:if test="${dto.enabled == 1}">
		                <span>활성화</span>
		            </c:if>
		             <c:if test="${dto.enabled == 0}">
		                <span class="userEnabled2">비활성화</span>
		            </c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	
	
</table>
<div class="form-search">
		<c:if test="${role == 2}">
			<button id="btnMemberWrite" type="button" class="btn my-btn" onclick="writeForm()">직원등록</button>
		</c:if>
	</div>
<!-- 페이징 -->
<div class="page-navigation">${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
</div>