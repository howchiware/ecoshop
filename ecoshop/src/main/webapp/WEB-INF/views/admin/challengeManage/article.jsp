<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<c:set var="NOIMG" value="${cp}/uploads/challenge/no-image.png" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 챌린지 상세</title>
<link rel="stylesheet" href="<c:url value='/dist/css/main2.css'/>" type="text/css">
<style>
.admin-main-container { display: flex; }
.admin-sidebar { width: 250px; flex-shrink: 0; }
.admin-content { flex-grow: 1; margin-left: 20px; }
.challenge-detail .info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-top: 1.5rem;
}
.challenge-detail .info-card { border: 1px solid #e9ecef; border-radius: 8px; padding: 1rem; }
.challenge-detail .info-label { font-size: 0.875rem; color: #6c757d; }
.challenge-detail .info-value { font-weight: bold; font-size: 1.125rem; margin-top: 0.25rem; }
.challenge-thumbnail {
    width: 100%; aspect-ratio: 16 / 9; background-color: #f8f9fa;
    background-position: center; background-size: cover; border-radius: 8px;
}
.detail-actions {
    display: flex; justify-content: flex-end; gap: 0.5rem; margin-top: 1rem;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<div class="container my-4 admin-main-container">
    <div class="admin-sidebar">
        <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>
    </div>

    <div class="admin-content">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="mb-0">챌린지 상세</h3>
            <a href="<c:url value='/admin/challengeManage/list'/>" class="btn btn-outline-secondary">목록</a>
        </div>

        <div class="card p-4 challenge-detail">
            <h4 class="card-title"><c:out value="${dto.title}"/></h4>
            <div class="card-subtitle mb-2 text-muted">
                <c:choose>
                    <c:when test="${dto.challengeType=='DAILY'}"><span class="badge bg-info">DAILY</span></c:when>
                    <c:when test="${dto.challengeType=='SPECIAL'}"><span class="badge bg-primary">SPECIAL</span></c:when>
                    <c:otherwise><span class="badge bg-secondary">-</span></c:otherwise>
                </c:choose>
                <span class="ms-2">ID: <c:out value="${dto.challengeId}"/></span>
            </div>
            
            <hr>
            <div class="row g-4">
                <div class="col-lg-7">
                    <p class="mb-4"><c:out value="${dto.description}"/></p>

                    <c:choose>
                        <c:when test="${not empty dto.thumbnail}">
                            <c:url var="thumbUrl" value="/uploads/challenge/${fn:escapeXml(dto.thumbnail)}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="thumbUrl" value="${NOIMG}"/>
                        </c:otherwise>
                    </c:choose>
                    <div class="challenge-thumbnail" style="background-image: url('${thumbUrl}');"></div>
                </div>
                
                <div class="col-lg-5">
                    <div class="info-grid">
                        <div class="info-card">
                            <div class="info-label">타입</div>
                            <div class="info-value"><c:out value="${dto.challengeType}"/></div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">포인트</div>
                            <div class="info-value"><c:out value="${dto.rewardPoints}"/> P</div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">등록일</div>
                            <div class="info-value"><c:out value="${dto.challengeRegDate}"/></div>
                        </div>

                        <c:if test="${dto.challengeType=='DAILY'}">
                            <div class="info-card">
                                <div class="info-label">요일</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${dto.weekday==0}">일요일</c:when>
                                        <c:when test="${dto.weekday==1}">월요일</c:when>
                                        <c:when test="${dto.weekday==2}">화요일</c:when>
                                        <c:when test="${dto.weekday==3}">수요일</c:when>
                                        <c:when test="${dto.weekday==4}">목요일</c:when>
                                        <c:when test="${dto.weekday==5}">금요일</c:when>
                                        <c:otherwise>토요일</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${dto.challengeType=='SPECIAL'}">
                            <div class="info-card">
                                <div class="info-label">시작일</div>
                                <div class="info-value"><c:out value="${dto.startDate}"/></div>
                            </div>
                            <div class="info-card">
                                <div class="info-label">종료일</div>
                                <div class="info-value"><c:out value="${dto.endDate}"/></div>
                            </div>
                            <div class="info-card">
                                <div class="info-label">연속일</div>
                                <div class="info-value"><c:out value="${dto.requireDays}"/>일</div>
                            </div>
                            <div class="info-card">
                                <div class="info-label">상태</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${dto.specialStatus==0}">대기</c:when>
                                        <c:when test="${dto.specialStatus==1}">진행</c:when>
                                        <c:otherwise>종료</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="detail-actions">
                <a href="<c:url value='/admin/challengeManage/update'><c:param name='challengeId' value='${dto.challengeId}'/></c:url>"
                   class="btn btn-outline-primary">수정</a>
                <a href="<c:url value='/admin/challengeManage/delete'><c:param name='challengeId' value='${dto.challengeId}'/></c:url>"
                   class="btn btn-outline-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>
