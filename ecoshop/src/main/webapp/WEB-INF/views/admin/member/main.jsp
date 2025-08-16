<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">

.content-box {
    margin-left: 220px; 
    padding: 20px;
    background: #fff;
    border: 1px solid #e0e0e0;
    border-radius: 6px; 
    box-shadow: 0 2px 6px rgba(0,0,0,0.05); /* 부드러운 그림자 */
}

/* --- 탭 스타일 --- */
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

/* --- 흰색 컨텐츠 박스 --- */
.section {
  border: 1px solid #e0e0e0;   
  border-radius: 0 6px 6px 6px;
  background: #fff;
  padding: 20px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

/* 페이지네이션 스타일 (기존 유지) */
.page-navigation {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 6px;
  margin: 20px 0;
  font-family: 'Noto Sans KR', sans-serif;
}

.page-navigation a,
.page-navigation span {
  padding: 6px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  background: #fff;
  color: #555;
  font-size: 0.95rem;
  text-decoration: none;
  transition: all 0.2s ease;
}


.page-navigation span.current {
  background: #007bff;
  color: #fff;
  border-color: #007bff;
  font-weight: 600;
}

.page-navigation a:hover {
  background: #f2f2f2;
  border-color: #bbb;
  color: #000;
}

.modal-backdrop { z-index: 9998 !important; }
.modal { z-index: 9999 !important; }
body.modal-open { overflow: hidden; padding-right: 0 !important; }
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

  <div class="container">
    <div class="row">
      <div class="col">
        <!-- 탭 -->
        <ul class="nav nav-tabs" id="myTab" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="tab-1" role="tab" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" aria-selected="true" data-tab="1">
              <i class="bi bi-person-fill"></i> 회원
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="tab-2" role="tab" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" aria-selected="false" data-tab="2">
              <i class="bi bi-mortarboard-fill"></i> 직원
            </button>
          </li>
        </ul>

        <!-- 흰색 박스 -->
        <div class="section">
          <div class="tab-content pt-3" id="nav-tabContent"></div>

          <form name="memberSearchForm">
            <input type="hidden" name="schType">
            <input type="hidden" name="kwd">
            <input type="hidden" name="role" value="1">
            <input type="hidden" name="non" value="0">            
            <input type="hidden" name="enabled">
          </form>
        </div>
      </div>
    </div>
  </div>
</main>

<!-- 회원 등록 모달 -->
<div class="modal fade" id="myDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myDialogModalLabel">회원 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-2"></div>
    </div>
  </div> 	
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.6.0/echarts.min.js"></script>


<script type="text/javascript">
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
    listMember(1);
});

$(function(){
    $('#btnMemberWrite').hide();

    $('button[role="tab"]').on('click', function(){
        $('button[role="tab"]').removeClass('active');
        $(this).addClass('active');

        const tab = $(this).attr('data-tab');

        if (tab !== '3') {
            resetList();
        }
    });
});


function listMember(page) {
	let url = '${pageContext.request.contextPath}/admin/member/list';		
	let params = $('form[name=memberSearchForm]').serialize();
	params += '&page=' + page;
	
	const fn = function(data) {
		$('#nav-tabContent').html(data);		
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

function listPage(page) {
    const $tab = $('button[role="tab"].active');
    let role = $tab.attr('data-tab');
    let schType = $('input[name=schType]').val();
    let kwd = $('input[name=kwd]').val();

    let url = '${pageContext.request.contextPath}/admin/member/list';
    let params = 'pageNo=' + page + '&role=' + role;

    if (kwd) params += '&schType=' + schType + '&kwd=' + encodeURIComponent(kwd);

    ajaxRequest(url, 'get', params, 'text', function(data) {
        $('#nav-tabContent').html(data);
    });
}

// 초기화
function resetList() {
	const $tab = $('button[role="tab"].active');
	let role = $tab.attr('data-tab');

	const f = document.memberSearchForm;
	
	f.schType.value = 'userLevel';
	f.kwd.value = '';
	f.role.value = role;
	f.enabled.value = '';
	
	listMember(1);
}

// 검색
function searchList() {
	const f = document.memberSearchForm;
	
	f.schType.value = $('#searchType').val();
	f.kwd.value = $('#keyword').val();
	
	listMember(1);
}

//회원 정보 수정
function updateMemberOk(page) {
	const f = document.memberUpdateForm;
	
	if( ! confirm('회원 정보를 수정하시겠습니까?')){
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/member/updateMember';
	let params = $('#memberUpdateForm').serialize();
	
	const fn = function(data){
		listMember(page);
	};
	ajaxRequest(url, 'post', params, 'json', fn);
	
	$('#memberUpdateDialogModal').modal('hide');
}

// 상세보기
function profile(memberId, page){
	let url = '${pageContext.request.contextPath}/admin/member/profile';
	let params = 'memberId=' + memberId + '&page=' + page;
	
	const fn = function(data){
		$('#nav-tabContent').html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

function updateMember(){
	$('#memberUpdateDialogModal').appendTo('body');
	$('#memberUpdateDialogModal').modal('show');
}

// 회원 등록
function writeForm(){
	$('#myDialogModalLabel').text('회원 등록');
	
	let url = '${pageContext.request.contextPath}/admin/member/write';
	
	const fn = function(data){
		$('#myDialogModal .modal-body').html(data);
		$('#myDialogModal').modal("show");
	}
	
	ajaxRequest(url, 'get', null, 'text', fn);
	
}

function sendOk(mode = 'write', page = 1) {
    const url = '${pageContext.request.contextPath}/admin/member/write';
    const params = $('form[name=memberForm]').serialize();
    
    const fn = function(data) {
        if (data.state == true || data.state === "true") {
        	
            listMember(page);

            $('#myDialogModal .btn-close').click();

            $('#myDialogModal .modal-body').empty();
        } else {
            alert("등록에 실패했습니다.");
        }
    };

    ajaxRequest(url, 'post', params, 'json', fn);
}

function sendCancel() {
    const modalEl = document.getElementById('myDialogModal');
    const modalInstance = bootstrap.Modal.getOrCreateInstance(modalEl);
    modalInstance.hide();
    $('#myDialogModal .modal-body').empty();
}



function deleteMember(memberIdx) {

}

function daumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullAddr = ''; 
            var extraAddr = ''; 

            if (data.userSelectedType === 'R') { 
                fullAddr = data.roadAddress;
            } else {
                fullAddr = data.jibunAddress;
            }

            if(data.userSelectedType === 'R'){
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            document.getElementById('zip').value = data.zonecode;
            document.getElementById('addr1').value = fullAddr;
            document.getElementById('addr2').focus();
        }
    }).open();
}
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</body>
</html>