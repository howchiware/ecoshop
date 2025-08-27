function attendanceOk(event) {
  event.preventDefault(); 
  fetch(CONTEXT_PATH + '/event/attendance/check', { method: 'POST' })
    .then(res => res.json())
    .then(data => {
      if (data.message === '로그인이 필요합니다.') {
        window.location.href = CONTEXT_PATH + '/member/login';
        return;
      }
      alert(data.success ? data.message: data.message);
      if (data.success) window.location.reload();
    })
    .catch(() => alert('오류가 발생했습니다.'));
}

function ajaxRequest(url, type, params, dataType, fn) {
    $.ajax({
        type: type,
        url: url,
        data: params,
        dataType: dataType,
        success: fn,
        error: function(jqXHR) {
            console.log(jqXHR.responseText);
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
	const calendarEl = document.getElementById('calendar');

	const calendar = new FullCalendar.Calendar(calendarEl, {
		// --- 기본 설정 ---
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',         
			right: ''       
		},
		initialView: 'dayGridMonth', 
		locale: 'ko',            
		
	    dayCellContent: function (arg) {
	      return {
	        html: String(arg.date.getDate())
	      };
	    },
		
		events: function(info, successCallback, failureCallback) {
			let url = CONTEXT_PATH + '/schedule/month';
			
			let startDate = info.startStr.substring(0, 10);
			let endDate = info.endStr.substring(0, 10);
			let params = 'start=' + startDate + '&end=' + endDate;
            
			const fn = function(data){
				let arr = []
				for(let item of data.list) {
					let obj = {};
					obj.id = item.num;
					obj.title = item.subject;
      				obj.start = item.start;
					obj.end = item.end;
					obj.allDay = true; 
					obj.color = item.color;
					arr.push(obj);
				}
				
				successCallback(arr);
			};
        	
        	ajaxRequest(url, 'get', params, 'json', fn);
		}
	});

	calendar.render();
});