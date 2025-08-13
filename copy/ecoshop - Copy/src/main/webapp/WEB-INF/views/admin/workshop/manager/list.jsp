<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>담당자 관리</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.main-container .container {
    margin-left: 250px;
    max-width: calc(100% - 250px);
}
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<main class="main-container">
    <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

    <div class="container py-3">

        <h4 class="mb-4">담당자 관리</h4>

        <!-- 등록/수정 폼 -->
        <div class="card mb-4">
            <div class="card-header">
                <strong>${mode eq 'update' ? '담당자 수정' : '담당자 등록'}</strong>
            </div>
            <div class="card-body">
                <form method="post" action="${ctx}/admin/workshop/manager/${mode eq 'update' ? 'update' : 'write'}">
                    <c:if test="${mode eq 'update'}">
                        <input type="hidden" name="managerId" value="${dto.managerId}">
                        <input type="hidden" name="page" value="${page}">
                    </c:if>
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label">이름</label>
                            <input type="text" name="name" value="${dto.name}" class="form-control" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">전화번호</label>
                            <input type="text" name="tel" value="${dto.tel}" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">이메일</label>
                            <input type="email" name="email" value="${dto.email}" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">소속</label>
                            <input type="text" name="department" value="${dto.department}" class="form-control">
                        </div>
                    </div>
                    <div class="mt-3">
                        <button type="submit" class="btn btn-${mode eq 'update' ? 'primary' : 'success'}">
                            ${mode eq 'update' ? '수정하기' : '등록하기'}
                        </button>
                        <c:if test="${mode eq 'update'}">
                            <a href="${ctx}/admin/workshop/manager/list?page=${page}" class="btn btn-secondary">취소</a>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>

        <!-- 검색 폼 -->
        <form class="row g-2 align-items-end mb-3" method="get" action="${ctx}/admin/workshop/manager/list">
            <div class="col-md-3">
                <label class="form-label">검색 구분</label>
                <select class="form-select" name="schType">
                    <option value="all" <c:if test="${schType=='all'}">selected</c:if>>전체</option>
                    <option value="name" <c:if test="${schType=='name'}">selected</c:if>>이름</option>
                    <option value="department" <c:if test="${schType=='department'}">selected</c:if>>소속</option>
                </select>
            </div>
            <div class="col-md-5">
                <label class="form-label">키워드</label>
                <input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어 입력">
            </div>
            <div class="col-md-2">
                <input type="hidden" name="page" value="1">
                <button type="submit" class="btn btn-primary w-100">검색</button>
            </div>
        </form>

        <!-- 목록 -->
        <div class="table-responsive">
            <table class="table table-sm align-middle">
                <thead class="table-light">
                    <tr>
                        <th style="width: 80px;" class="text-center">번호</th>
                        <th style="width: 150px;">이름</th>
                        <th style="width: 150px;">전화번호</th>
                        <th style="width: 200px;">이메일</th>
                        <th style="width: 150px;">소속</th>
                        <th style="width: 120px;" class="text-center">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">등록된 담당자가 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="row" items="${list}" varStatus="st">
                                <tr>
                                    <td class="text-center"><c:out value="${(page-1)*size + st.index + 1}" /></td>
                                    <td>${row.name}</td>
                                    <td>${row.tel}</td>
                                    <td>${row.email}</td>
                                    <td>${row.department}</td>
                                    <td class="text-center">
                                        <a href="${ctx}/admin/workshop/manager/update?num=${row.managerId}&page=${page}" 
                                           class="btn btn-sm btn-primary">수정</a>
                                        <form action="${ctx}/admin/workshop/manager/delete" method="post" style="display:inline;">
                                            <input type="hidden" name="num" value="${row.managerId}">
                                            <input type="hidden" name="page" value="${page}">
                                            <button type="submit" class="btn btn-sm btn-danger"
                                                onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- 페이징 -->
        <c:set var="hasPrev" value="${page > 1}" />
        <c:set var="hasNext" value="${not empty list && list.size() >= size}" />
        <nav aria-label="페이징">
            <ul class="pagination justify-content-center">
                <li class="page-item <c:if test='${!hasPrev}'>disabled</c:if>'">
                    <a class="page-link" href="${ctx}/admin/workshop/manager/list?page=${page-1}&schType=${schType}&kwd=${kwd}">이전</a>
                </li>
                <li class="page-item active"><span class="page-link">${page}</span></li>
                <li class="page-item <c:if test='${!hasNext}'>disabled</c:if>'">
                    <a class="page-link" href="${ctx}/admin/workshop/manager/list?page=${page+1}&schType=${schType}&kwd=${kwd}">다음</a>
                </li>
            </ul>
        </nav>

    </div>
</main>

</body>
</html>
