<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ECOMORE</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/sidebar.css" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link href="//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css" rel="stylesheet" type="text/css">	
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 
 <style type="text/css">
body {
	font-family: 'Pretendard-Regular', 'Noto Sans KR', sans-serif;
	background-color: #f7f6f3;
	color: #333;
	margin: 0;
}

@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-style: normal;
}




</style>
</head>
<body>
<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<!-- 메인 영역 -->
<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
	<div class="right-panel">
	    <div class="title">
	        <h3>판매 현황</h3>
	    </div>

		<div class="section p-5" data-aos="fade-up" data-aos-delay="200">
			<div class="section-body p-5">
				<div class="row gy-4 m-0">
					<div class="col-lg-12 p-2 m-2" data-aos="fade-up" data-aos-delay="200">
						
						<div class="row g-1 p-1" style="background: white; border-radius: 10px;">
							<div class="col-3 p-2">
								<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 오늘 판매 현황</div>
								<div class="border rounded p-5 text-center">
									<div class="fs-5 mb-2">총 판매 건수 : 
										<span class="product-totalAmount fw-semibold text-primary">${today.COUNT}</span>
									</div>
									<div class="fs-5">총 판매 금액 : 
										<span class="product-totalAmount fw-semibold text-danger"><fmt:formatNumber value="${today.TOTAL}"/></span>원
									</div>
								</div>
							</div>
							
							<div class="col-3 p-2">
								<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 이번달 판매 현황</div>
								<div class="border rounded p-5 text-center">
									<div class="fs-5 mb-2">총 판매 건수 : 
										<span class="product-totalAmount fw-semibold text-primary">${thisMonth.COUNT}</span>
									</div>
									<div class="fs-5">총 판매 금액 : 
										<span class="product-totalAmount fw-semibold text-danger"><fmt:formatNumber value="${thisMonth.TOTAL}"/></span>원
									</div>
								</div>
							</div>
				    	
							<div class="col-3 p-2">
								<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 전월 판매 현황</div>
								<div class="border rounded p-5 text-center">
									<div class="fs-5 mb-2">총 판매 건수 : 
										<span class="product-totalAmount fw-semibold text-primary">${previousMonth.COUNT}</span>
									</div>
									<div class="fs-5">총 판매 금액 : 
										<span class="product-totalAmount fw-semibold text-danger"><fmt:formatNumber value="${previousMonth.TOTAL}"/></span>원
									</div>
								</div>
							</div>
							
							<div class="col-3 p-2">
								<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i>회원 수</div>
								<div class="border rounded p-5 text-center">
									<div class="fs-5 mb-2">총 판매 건수 : 
										<span class="product-totalAmount fw-semibold text-primary">${member.COUNT}</span>명
									</div>
									<div class="fs-5">총 판매 금액 : 
										<span class="product-totalAmount fw-semibold text-danger">${staff.COUNT}</span>명
									</div>
								</div>
							</div>
						</div>
				    
						<div class="row mt-3 p-1" style="background: white; border-radius: 10px;">
							<div class="col-4 p-2">
								<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 최근 1주일 판매 현황</div>
								<div class="charts-day border rounded" style="height: 430px; width: 100%;"></div>
							</div>
							<div class="col-4 p-2">
								<div class="fs-6 fw-semibold mb-2 "><i class="bi bi-chevron-right"></i> <label class="charts-dayOfWeek-title">전월 요일별 판매건수</label></div>
								<div class="charts-dayOfWeek border rounded" style="height: 430px; width: 100%;"></div>
							</div>
							<div class="col-4 p-2">
								<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 최근 6개월 판매 현황</div>
								<div class="charts-month border rounded" style="height: 430px; width: 100%;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.6.0/echarts.min.js"></script>
<script type="text/javascript">
$(function(){
	let url = '${pageContext.request.contextPath}/admin/charts';
	
	$.getJSON(url, function(data){
		// console.log(data);
		chartsDay(data);	
		chartsDayOfWeek(data);
		chartsMonth(data);	
	});
	
	function chartsDay(data) {
		let chartData = [];
		
		for(let item of data.days) {
			let s = parseInt(item.ORDERSTATEDATE.substring(5, 7)) + '월 ';
			s += parseInt(item.ORDERSTATEDATE.substring(8)) + '일';

			let obj = {value:item.TOTALAMOUNT, name:s};
			chartData.push(obj);
		}
		
		const chartDom = document.querySelector('.charts-day');
		let myChart = echarts.init(chartDom);
		let option;
		
		option = {
		  tooltip: {
		    trigger: 'item'
		  },
		  legend: {
		    top: '5%',
		    left: 'center'
		  },
		  series: [
		    {
		      name: '일별 판매현황',
		      type: 'pie',
		      radius: ['40%', '70%'],
		      avoidLabelOverlap: false,
		      itemStyle: {
		        borderRadius: 10,
		        borderColor: '#fff',
		        borderWidth: 2
		      },
		      label: {
		        show: false,
		        position: 'center'
		      },
		      emphasis: {
		        label: {
		          show: true,
		          fontSize: '40',
		          fontWeight: 'bold'
		        }
		      },
		      labelLine: {
		        show: false
		      },
		      data: chartData
		    }
		  ]
		};		
		
		option && myChart.setOption(option);
	}
	
	function chartsDayOfWeek(data) {
		let chartData = [];
		
		let m = new Date().getMonth()+1;
		let m2 = parseInt(data.dayOfWeek.month.substring(4));

		// let title = (m !== 1 && m > m2) || (m === 1 && m2 === 12) ? '전월 요일별 판매건수' : '이번달 요일별 판매건수';
		let title = (m !== m2) ? '전월 요일별 판매건수' : '이번달 요일별 판매건수';
		
		document.querySelector('.charts-dayOfWeek-title').innerHTML = title;
		
		chartData.push(data.dayOfWeek.SUN);
		chartData.push(data.dayOfWeek.MON);
		chartData.push(data.dayOfWeek.TUE);
		chartData.push(data.dayOfWeek.WED);
		chartData.push(data.dayOfWeek.THU);
		chartData.push(data.dayOfWeek.FRI);
		chartData.push(data.dayOfWeek.SAT);
		
		const chartDom = document.querySelector('.charts-dayOfWeek');
		let myChart = echarts.init(chartDom);
		let option;
		
		option = {
		  tooltip: {
		    trigger: 'item'
		  },
		  xAxis: {
		    type: 'category',
		    data: ['일', '월', '화', '수', '목', '금', '토']
		  },
		  yAxis: {
		    type: 'value'
		  },
		  series: [
		    {
		      data: chartData,
		      type: 'bar'
		    }
		  ]
		};
		
		option && myChart.setOption(option);
	}
	
	function chartsMonth(data) {
		let chartData = [];
		
		for(let item of data.months) {
			let s = parseInt(item.ORDERSTATEDATE.substring(4)) + '월';
			let obj = {value:item.TOTALAMOUNT, name:s};
			chartData.push(obj);
		}
		
		const chartDom = document.querySelector(".charts-month");
		let myChart = echarts.init(chartDom);
		let option;
		
		option = {
		  tooltip: {
		    trigger: 'item'
		  },
		  legend: {
		    top: '5%',
		    left: 'center'
		  },
		  series: [
		    {
		      name: '월별 판매현황',
		      type: 'pie',
		      radius: ['40%', '70%'],
		      avoidLabelOverlap: false,
		      itemStyle: {
		        borderRadius: 10,
		        borderColor: '#fff',
		        borderWidth: 2
		      },
		      label: {
		        show: false,
		        position: 'center'
		      },
		      emphasis: {
		        label: {
		          show: true,
		          fontSize: '40',
		          fontWeight: 'bold'
		        }
		      },
		      labelLine: {
		        show: false
		      },
		      data: chartData
		    }
		  ]
		};
		
		option && myChart.setOption(option);
	}
});
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

</body>
</html>