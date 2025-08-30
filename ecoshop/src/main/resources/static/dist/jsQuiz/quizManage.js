function isValidDateString(dateString) {
	    return dateString && dateString.length === 10;
	}

	function quizOk() {
	    const f = document.quizForm;
	    let str;

	    str = f.subject.value.trim();
	    if (!str) { 
	        alert('퀴즈 제목을 입력하세요.');
	        f.subject.focus();
	        return;
	    }

	    str = f.content.value.trim();
	    if (!str) { 
	        alert('퀴즈 내용을 입력하세요.');
	        f.content.focus();
	        return;
	    }
	    
	    str = f.answer.value;
	    if (!str) { 
	        alert('정답을 선택하세요.');
	        f.answer.focus();
	        return;
	    }

	    str = f.openDate.value;
	    if (!isValidDateString(str)) {
	        alert('개시일을 선택하세요.');
	        f.openDate.focus();
	        return;
	    }
	    
	    f.action = CONTEXT_PATH + '/admin/quiz/' + MODE;
	    f.submit();
	} 