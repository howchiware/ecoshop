window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') {
			evt.preventDefault();
	    	
			searchList();
		}
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/admin/attendance/list';
	location.href = url + '?' + params;
}

document.getElementById("start").addEventListener("change", function () {
  let start = new Date(this.value);
  let day = start.getDay();

  if (day !== 1) {
    alert("시작일은 월요일로 선택해주세요.");
    this.value = "";
    document.getElementById("end").value = "";
    return;
  }

  let end = new Date(start);
  end.setDate(start.getDate() + 6);
  document.getElementById("end").value = end.toISOString().split("T")[0];
});