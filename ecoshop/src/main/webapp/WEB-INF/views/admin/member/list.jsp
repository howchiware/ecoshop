<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
    <!-- 회원 목록 -->
    <div class="col-md-6 text-end">
		<div class="form-search">
			<select id="searchType" name="schType">
				<option value="memberId"  ${schType=="memberId" ? "selected":""}>아이디</option>
				<option value="name"      ${schType=="name" ? "selected":""}>이름</option>
				<option value="email"     ${schType=="email" ? "selected":""}>이메일</option>
				<option value="tel"       ${schType=="tel" ? "selected":""}>전화번호</option>
			</select>
			<input type="text" id="keyword" name="kwd" value="${kwd}">
			<button type="button" class="btn-default" onclick="searchList()"> <i class="bi bi-search"></i> </button>
		</div>
	</div>
	<span class="dataCount">${dataCount}개(${page}/${total_page} 페이지)</span>
		<div class="col-md-3 text-end">
			&nbsp;
		</div>
		
    <table class="table table-hover board-list">
      <thead class="table-light">
        <tr>
		  <th>번호</th>
		  <th>아이디</th>
          <th>이름</th>
          <th>전화번호</th>
          <th>가입일자</th>
        </tr>
      </thead>
      
      <tbody>
        <c:forEach var="dto" items="${list}" varStatus="status">
          <tr class="hover-cursor" onclick="profile('${dto.memberId}', '${page}');"> 
            <td>${dataCount - (page-1) * size - status.index}</td>
            <td>${dto.memberId}</td>
            <td>${dto.name}(${dto.nickname})</td>
            <td>${dto.tel}</td>
            <td>${dto.regDate}</td>	
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