<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/cssAdmin/member.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

  <div class="container">
  	<div class="title">
		<h3>회원 | 직원 관리</h3>
	</div>
	<hr>
  
    <div class="row">
      <div class="col">
        
        <ul class="nav nav-tabs" id="myTab" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="tab-1" role="tab" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" aria-selected="true" data-tab="1">
				회원
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="tab-2" role="tab" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" aria-selected="false" data-tab="2">
              직원
            </button>
          </li>
        </ul>

        <div class="section">
          <div class="tab-content p-3" id="nav-tabContent"></div>

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

<div class="modal fade" id="myDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myDialogModalLabel">직원 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-2"></div>
    </div>
  </div> 	
</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
	$('#myDialogModalLabel').text('직원 등록');
	
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



function deleteMember(memberId, name) {
	if (confirm(name + " 님을 정말로 삭제하시겠습니까?")) {
		let params = 'memberId=${dto.memberId}&${dto.name}';
		let url = '${pageContext.request.contextPath}/admin/member/deleteMember?' + params;
		location.href= url;
    }
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