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
.page-navigation {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px 0;
  font-family: 'Noto Sans KR', sans-serif;
  gap: 10px;
}

.page-navigation a,
.page-navigation span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #7ecf98;
  color: #4caf50;
  text-decoration: none;
  font-weight: 600;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(126, 207, 152, 0.4);
  transition: background-color 0.25s ease, color 0.25s ease, box-shadow 0.25s ease;
  font-size: 1rem;
}

.page-navigation a:hover {
  background-color: #a4d7a7;
  color: white;
  box-shadow: 0 4px 12px rgba(126, 207, 152, 0.6);
}

.paginate span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #4caf50;
  background-color: #4caf50;
  color: #fff;
  font-weight: 700;
  cursor: default;
  box-shadow: 0 2px 5px rgba(76, 175, 80, 0.6);
  font-size: 1rem;
}

.paginate a {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  border: 2px solid #4caf50;
  color: #4caf50;
  text-decoration: none;
  font-weight: 600;
  transition: background-color 0.3s, color 0.3s;
  font-size: 1rem;
}

.paginate a:hover {
  background-color: #81c784;
  color: #fff;
  box-shadow: 0 4px 12px rgba(129, 199, 132, 0.6);
}

.page-navigation .disabled {
  color: #cde5d4;
  border-color: #cde5d4;
  cursor: default;
  pointer-events: none;
  box-shadow: none;
}
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<main class="main-container">
  <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp" />

  <div class="container-md">회원 목록</div>
  <div class="container">
    <div class="row">
      <!-- 탭 -->
      <div class="col">
        <div class="section p-5">
         <ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" userLevel="presentation">
					<button class="nav-link active" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" userLevel="tab" aria-selected="true" data-tab="1"> <i class="bi bi-person-fill"></i> 회원</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" userLevel="tab" aria-selected="true" data-tab="2"> <i class="bi bi-mortarboard-fill"></i>직원</button>
				</li>
          </ul>
          
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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.6.0/echarts.min.js"></script>

<script type="text/javascript">
$(function(){
    $('#tab-1').addClass('active');
	
    $('button[role="tab"]').on('click', function(e){
    	const tab = $(this).attr('data-tab');
    	
		if(tab !== '3') {
			resetList();
		}else{
			
		}
		
    });	
});

$(function(){
	listMember(1);
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
	const f = document.memberSearchFrom;
	
	f.schType.value = $('#searchType').val();
	f.kwd.value = $('#keyword').val();
	
	listMember(1);
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

// 회원 정보 수정
function updateMemberOk(page) {
	const f = document.memberUpdateForm;
	
	if(f.userLevel.value === '0' || f.userLevel.value === '50') {
		f.enabled.value = '0';	
	}
	
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

function deleteMember(memberIdx) {
	// 회원 삭제
	
}


</script>
</body>
</html>