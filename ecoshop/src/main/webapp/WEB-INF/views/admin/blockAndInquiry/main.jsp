<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<style>
:root {
  --color-primary: #4a69bd;
  --color-success: #2ecc71;
  --color-danger-soft: #e74c3c;
  --color-bg: #f8f9fa;
  --color-content-bg: #ffffff;
  --color-text-primary: #2c3e50;
  --color-text-secondary: #8492a6;
  --color-border: #e0e6ed;
}
html { overflow-y: scroll; }
body { background-color: var(--color-bg); }
* { font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif; box-sizing: border-box; }
@font-face {
  font-family: 'Pretendard-Regular';
  src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
  font-style: normal;
}
.right-panel { padding: 1.5rem 2rem; }
.page-title h2 { display: flex; align-items: center; gap: 10px; font-size: 1.8rem; font-weight: 700; color: var(--color-text-primary); margin-bottom: 0.5rem; }
.page-title h2 .bi { color: var(--color-primary); }
.page-subtitle { color: var(--color-text-secondary); padding-left: 42px; margin-bottom: 2.5rem; }

/* 대시보드 카드 공통 스타일 */
.dashboard-card {
    background-color: var(--color-content-bg);
    border: 1px solid var(--color-border);
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(132, 146, 166, 0.05);
    display: flex;
    flex-direction: column;
    height: 100%;
}
.card-header { display: flex; justify-content: space-between; align-items: center; padding: 1.25rem 1.5rem; border-bottom: 1px solid var(--color-border); }
.card-title { font-size: 1.1rem; font-weight: 600; margin: 0; color: var(--color-text-primary); }
.card-header .bi { font-size: 1.5rem; color: var(--color-text-secondary); }
.card-body { padding: 1.5rem; flex-grow: 1; }
.card-footer { padding: 1rem 1.5rem; background-color: #fcfcfd; border-top: 1px solid var(--color-border); text-align: right; }
.card-footer a { text-decoration: none; font-weight: 600; color: var(--color-primary); }
.card-footer a:hover { color: var(--color-primary-darker); }

/* KPI 카드 (문의/신고) */
.kpi-metric { font-size: 2.5rem; font-weight: 700; color: var(--color-primary); }
.kpi-metric small { font-size: 1rem; font-weight: 500; color: var(--color-text-secondary); margin-left: 8px; }
.item-list { list-style: none; padding: 0; margin: 1.5rem 0 0 0; }
.item-list li { display: flex; justify-content: space-between; align-items: center; padding: 0.75rem 0; border-bottom: 1px solid var(--color-border); }
.item-list li:last-child { border-bottom: none; }
.item-list .item-title { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 70%; }
.item-list .item-date { font-size: 0.85rem; color: var(--color-text-secondary); }

/* 통계 카드 */
.stats-card .card-body { display: flex; justify-content: space-around; align-items: center; }
.stat-item { text-align: center; }
.stat-item h4 { font-size: 1rem; color: var(--color-text-secondary); margin-bottom: 0.5rem; font-weight: 500; }
.stat-value { font-size: 1.5rem; font-weight: 700; color: var(--color-text-primary); }
.stat-change { font-size: 0.9rem; font-weight: 600; }
.stat-change.up { color: var(--color-success); }
.stat-change.down { color: var(--color-danger-soft); }
</style>
</head>
<body>

<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
  
  <div class="right-panel">
		<div class="page-title" data-aos="fade-up">
		    <h2><i class="bi bi-graph-up-arrow"></i> 관리자 워크스페이스</h2>
		    <p class="page-subtitle">데이터로 확인하는 고객의 목소리, 신속하고 정확한 대응으로 만족도를 높여보세요.</p>
		</div>

        <div class="row" data-aos="fade-up" data-aos-delay="100">
            <div class="col-12 mb-4">
                <div class="dashboard-card stats-card">
                    <div class="card-header">
                        <h3 class="card-title">주간 업무 현황</h3>
                        <i class="bi bi-calendar-week"></i>
                    </div>
                    <div class="card-body">
                        <div class="stat-item">
                            <h4>1:1 문의 답변 처리율</h4>
                            <p class="stat-value">${weeklyStats.inquiryResponseRate}%</p>
                            <p class="stat-change ${weeklyStats.inquiryRateChange > 0 ? 'up' : 'down'}">
                                <i class="bi ${weeklyStats.inquiryRateChange > 0 ? 'bi-arrow-up-short' : 'bi-arrow-down-short'}"></i> ${weeklyStats.inquiryRateChange}% (지난주 대비)
                            </p>
                        </div>
                        <div class="stat-item">
                            <h4>신규 신고 접수</h4>
                            <p class="stat-value">${weeklyStats.newReportCount} 건</p>
                            <p class="stat-change ${weeklyStats.reportCountChange > 0 ? 'up' : 'down'}">
                                <i class="bi ${weeklyStats.reportCountChange > 0 ? 'bi-arrow-up-short' : 'bi-arrow-down-short'}"></i> ${weeklyStats.reportCountChange}% (지난주 대비)
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" data-aos="fade-up" data-aos-delay="200">
            <div class="col-lg-6 mb-4">
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3 class="card-title">답변 대기 중인 1:1 문의</h3>
                        <i class="bi bi-headset"></i>
                    </div>
                    <div class="card-body">
                        <p class="kpi-metric">${pendingInquiryCount}<small>건</small></p>
                        <ul class="item-list">
                            <c:if test="${empty recentInquiries}">
                                <li>처리할 문의가 없습니다.</li>
                            </c:if>
                            <c:forEach var="dto" items="${recentInquiries}" begin="0" end="4">
                                <li>
                                    <span class="item-title">${dto.subject}</span>
                                    <span class="item-date">${dto.regDate}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/admin/inquiry/main">문의 처리 바로가기 &rarr;</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-6 mb-4">
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3 class="card-title">처리 대기 중인 신고</h3>
                        <i class="bi bi-shield-fill-exclamation"></i>
                    </div>
                    <div class="card-body">
                        <p class="kpi-metric">${pendingReportCount}<small>건</small></p>
                         <ul class="item-list">
                            <c:if test="${empty recentReports}">
                                <li>처리할 신고가 없습니다.</li>
                            </c:if>
                            <c:forEach var="dto" items="${recentReports}" begin="0" end="4">
                                <li>
                                    <span class="item-title">${dto.reportTypeName}</span>
                                    <span class="item-date">${dto.regDate}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/admin/block/list">신고 처리 바로가기 &rarr;</a>
                    </div>
                </div>
            </div>
        </div>
	</div>
</main>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>