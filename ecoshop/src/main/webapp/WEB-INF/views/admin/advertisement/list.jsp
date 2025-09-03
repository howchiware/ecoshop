<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssAdmin/member.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin_paginate.css">

<style type="text/css">
<!-- 
.content-box {
    margin-left: 220px; 
    padding: 20px;
    background: #fff;
    border: 1px solid #e0e0e0;
    border-radius: 6px; 
    box-shadow: 0 2px 6px rgba(0,0,0,0.05); /* 부드러운 그림자 */
}

.nav-tabs {
    border-bottom: 1px solid #e0e0e0;
    margin-bottom: 15px;
}

.nav-tabs .nav-link {
    border: 1px solid transparent;
    border-radius: 0;
    color: #666;              
    background-color: #f9f9f9; 
    padding: 8px 16px;
    font-weight: 500;
    transition: background-color 0.2s, color 0.2s;
}

.nav-tabs .nav-link.active {
    border-color: #e0e0e0 #e0e0e0 #fff; 
    background-color: #fff;
    color: #007bff; 
    font-weight: 600;
    		
}

.nav-tabs .nav-link:hover {
    background-color: #f1f1f1;
    color: #333;
}

.nav-tabs .nav-link.active {
    border-color: #e0e0e0 #e0e0e0 #fff;
    background-color: #fff;
    color: #007bff;
    font-weight: 600;
}



/* 페이징 */
.page-navigation {
   display: flex;
   justify-content: center;
   align-items: center;
   gap: 6px;
   flex-wrap: wrap;
}

.page-navigation a, .page-navigation strong, .page-navigation span {
   background: #fff;
   border-radius: 4px;
   padding: 3px 10px;
   color: #363636;
   font-weight: 500;
   text-decoration: none;
   cursor: pointer;
   transition: all 0.2s ease;
}

.page-navigation a:hover {
   background: #e0e0e0;
   border-color: #999;
}

.page-navigation .disabled {
   background: #f8f8f8;
   border-color: #ddd;
   color: #aaa;
   cursor: not-allowed;
}

.page-navigation strong, .page-navigation span {
   background: #ccc;
   border-color: #999;
   color: #333;
}

.right{
	padding: 30px !important;
}

.btn-success {
  color: white
}

.modal-backdrop {
 z-index: 9998 !important; 
 }
.modal {
 z-index: 9999 !important; 
 }
body.modal-open { overflow: hidden; padding-right: 0 !important; }
</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />
  
  <div class="right">
  	<div class="title">
		<h3>광고 목록</h3>
	</div>
	<hr>
  <div class="board-container row">
      <div class="col">
        <!-- 탭 -->
        <ul class="nav nav-tabs" id="myTab" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="tab-1" role="tab" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" aria-selected="true" data-tab="1">
              승인
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="tab-2" role="tab" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" aria-selected="false" data-tab="2">
              반려
            </button>
          </li>
        </ul>
        
        <div class="section">
          <div class="tab-content p-3" id="nav-tabContent"></div>
          
          <form name="advertisementSearchForm">
            <input type="hidden" name="schType">
            <input type="hidden" name="kwd">
            <input type="hidden" name="role" value="4">        
            <input type="hidden" name="inquiryType" value="">  
            <input type="hidden" name="enabled" value=""> 
          </form>
        </div>
      </div>
    </div>
  </div>
 </main>
 
<div class="modal fade" id="myDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myDialogModalLabel">신청 목록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-2 pb-4"></div>
    </div>
  </div> 	
</div>

<div class="modal fade" id="statusModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="statusModalLabel">상태 변경 이력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-2 pb-4"></div>
    </div>
  </div>
</div>
  
  
 <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.6.0/echarts.min.js"></script>
  
 <script type="text/javascript">
 // 탭 
 $(function(){
	    $('#tab-1').addClass('active');
		
	    $('button[role="tab"]').on('click', function(e){
	    	$('button[role="tab"]').removeClass('active');
	        $(this).addClass('active');
	        
	    	const tab = $(this).attr('data-tab');
	    	
	    	if (tab !== '3') {
	            resetList();
			}

	    });	
	    listAdvertisement(1);
	    
	});
 
 // 리스트
 function listAdvertisement(page) {
		let url = '${pageContext.request.contextPath}/admin/advertisement/result';		
		let params = $('form[name=advertisementSearchForm]').serialize();
		params += '&page=' + page;
		
		const fn = function(data) {
			$('#nav-tabContent').html(data);		
		};
		
		ajaxRequest(url, 'get', params, 'text', fn);
	}
 
 // 페이징
 function listPage(page) {
    const $tab = $('button[role="tab"].active');
    let role = $tab.attr('data-tab');
    let schType = $('input[name=schType]').val();
    let kwd = $('input[name=kwd]').val();

    let url = '${pageContext.request.contextPath}/admin/advertisement/result';
    let params = 'pageNo=' + page + '&role=' + role;

    if (kwd) params += '&schType=' + schType + '&kwd=' + encodeURIComponent(kwd);

    ajaxRequest(url, 'get', params, 'text', function(data) {
        $('#nav-tabContent').html(data);
    });
}
 
 // 상태 페이징
 function listStatusPage(page) {
	    const f = document.advertisementSearchForm;

	    //f.role.value = 3;  

	    let url = '${pageContext.request.contextPath}/admin/advertisement/status';
	    let params = $('form[name=advertisementSearchForm]').serialize();
	    params += '&pageNo=' + page;

	    ajaxRequest(url, 'get', params, 'text', function(data){
	        $('#statusModal .modal-body').html(data);
	    });
	}
 
//초기화
 function resetList() {
 	const $tab = $('button[role="tab"].active');
 	let role = $tab.attr('data-tab');

 	const f = document.advertisementSearchForm;
 	
 	f.schType.value = 'status';
 	f.kwd.value = '';
 	f.role.value = role;
 	f.enabled.value = '';
 	
 	listAdvertisement(1);
 }
 
 // 신청 목록
function applicationForm(){
    $('#myDialogModalLabel').text('신청 목록');

    const f = document.advertisementSearchForm;
    f.role.value = 3;

    let url = '${pageContext.request.contextPath}/admin/advertisement/application';
    let params = $('form[name=advertisementSearchForm]').serialize();

    ajaxRequest(url, 'get', params, 'text', function(data){
        $('#myDialogModal .modal-body').html(data);
        $('#myDialogModal').modal("show");
    });
}
 
// 상태 목록
function openStatusModal(page){
    $('#statusModalLabel').text('신청 목록');

    const f = document.advertisementSearchForm;
    //f.role.value = 3;

    let url = '${pageContext.request.contextPath}/admin/advertisement/status';
    let params = $('form[name=advertisementSearchForm]').serialize();

    ajaxRequest(url, 'get', params, 'text', function(data){
        $('#statusModal .modal-body').html(data);
        $('#statusModal').modal("show");
    });
}

 // 상태 변경
function updateStatus(advertisingId, status, page = 1) {
    if(!confirm("상태를 변경하시겠습니까?")) return;

    let url = '${pageContext.request.contextPath}/admin/advertisement/updateStatus';
    let params = { advertisingId: advertisingId, status: status };

    const fn = function(data) {
        if (data.success) {
            alert("상태가 변경되었습니다.");

            const f = document.advertisementSearchForm;

            if ($('#myDialogModal').hasClass('show')) {
                f.role.value = 3; 
                let urlApp = '${pageContext.request.contextPath}/admin/advertisement/application';
                let paramsApp = $('form[name=advertisementSearchForm]').serialize();
                ajaxRequest(urlApp, 'get', paramsApp, 'text', function(html){
                    $('#myDialogModal .modal-body').html(html);

                    const $tab = $('button[role="tab"].active');
                    f.role.value = $tab.attr('data-tab');
                    listAdvertisement(page);
                });
            } else {
                const $tab = $('button[role="tab"].active');
                f.role.value = $tab.attr('data-tab');
                listAdvertisement(page);
            }

        } else {
            alert("변경 실패: " + (data.message || ""));
        }
    };

    ajaxRequest(url, 'post', params, 'json', fn);
}

 // 상세보기
function profile(advertisingId, page){
	let url = '${pageContext.request.contextPath}/admin/advertisement/profile';
	let params = 'advertisingId=' + advertisingId + '&page=' + page;
	
	const fn = function(data){
		$('#nav-tabContent').html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

// 아코디언 상세보기
$(document).on('show.bs.collapse', 'tr.collapse', function (e) {
    e.stopPropagation(); 

    const advertisingId = $(this).attr("id").replace("collapse-", "");
    const $detailDiv = $("#detail-" + advertisingId);

    let url = '${pageContext.request.contextPath}/admin/advertisement/profile';
    let page = 1; 
    let params = 'advertisingId=' + advertisingId + '&page=' + page;

    ajaxRequest(url, 'get', params, 'text', function(data){
        $detailDiv.html(data);
    });
});

// 수정하기
 function updateAdvertisementOk(page) {
	const f = document.advertisementUpdateForm;
	
	
	if( ! confirm('상태 수정하시겠습니까?')){
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/advertisement/updateAdvertisement';
	let params = $('#advertisementUpdateForm').serialize();
	//alert(params);
	const fn = function(data){
		listAdvertisement(page);
	};
	ajaxRequest(url, 'post', params, 'json', fn);
	
	$('#advertisementUpdateDialogModal').modal('hide');
}

 function updateAdvertisement(){
		$('#advertisementUpdateDialogModal').appendTo('body');
		$('#advertisementUpdateDialogModal').modal('show');
	}
 
 // 검색
 function searchList() {
	const f = document.advertisementSearchForm;
	
	f.schType.value = $('#searchType').val();
	f.kwd.value = $('#keyword').val();
	
	listAdvertisement(1);
}
  // 상태 검색
 function searchStatusModal() {
	    const f = document.advertisementSearchForm;
	    f.schType.value = $('#searchType').val();
	    f.kwd.value = $('#keyword').val();
	    listStatusPage(1);
	}
 
 function searchStatusList() {
	    const f = document.advertisementSearchForm;

	    f.schType.value = $('#searchTypeStatus').val();
	    f.kwd.value = $('#keywordStatus').val();

	    openStatusModal(1); 
	}
 
 function resetStatusSearch() {
	    $('#searchTypeStatus').val('oldStatus');  
	    $('#keywordStatus').val('');

	    const f = document.advertisementSearchForm;
	    f.schType.value = 'oldStatus';
	    f.kwd.value = '';

	    openStatusModal(1); 
	}

  
 </script>

</body>
</html>
