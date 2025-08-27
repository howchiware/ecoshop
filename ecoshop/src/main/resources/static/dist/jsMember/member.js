function isValidDateString(dateString) {
	try {
		const date = new Date(dateString);
		const [year, month, day] = dateString.split("-").map(Number);
		return date instanceof Date && !isNaN(date) && date.getDate() === day;
	} catch (e) {
		return false;
	}
}

function memberOk() {
	const f = document.memberForm;
	let str, p;

	p = /^[a-z][a-z0-9_]{4,9}$/i;
	str = f.userId.value;
	if (!p.test(str)) {
		alert('아이디를 다시 입력 하세요. ');
		f.userId.focus();
		return;
	}

	if (MODE === 'account' && f.loginIdValid.value === 'false') {
		str = '아이디 중복 검사가 실행되지 않았습니다.';
		$('#userIdHelp').html(str);
		f.userId.focus();
		return;
	}

	p = /^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i;
	str = f.password.value;
	if (!p.test(str)) {
		alert('패스워드를 다시 입력 하세요. ');
		f.password.focus();
		return;
	}

	if (str !== f.password2.value) {
		alert('패스워드가 일치하지 않습니다. ');
		f.password.focus();
		return;
	}

	p = /^[가-힣]{2,5}$/;
	str = f.name.value;
	if (!p.test(str)) {
		alert('이름을 다시 입력하세요. ');
		f.name.focus();
		return;
	}

	p = /^[가-힣]{2,10}$/;
	str = f.nickname.value;
	if (!p.test(str)) {
		alert('닉네임을 다시 입력하세요. ');
		f.nickname.focus();
		return;
	}

	if (MODE === 'account' && f.nicknameValid.value === 'false') {
		str = '닉네임 중복 검사가 실행되지 않았습니다.';
		$('#nicknameHelp').html(str);
		f.nickname.focus();
		return;
	}

	str = f.birth.value;
	if (!isValidDateString(str)) {
		alert('생년월일를 입력하세요. ');
		f.birth.focus();
		return;
	}

	p = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	str = f.email.value;
	if (!p.test(str)) {
		alert('이메일을 입력하세요. ');
		f.email.focus();
		return;
	}

	p = /^(010)-?\d{4}-?\d{4}$/;
	str = f.tel.value;
	if (!p.test(str)) {
		alert('전화번호를 입력하세요. ');
		f.tel.focus();
		return;
	}

	f.action = CONTEXT_PATH + '/member/' + MODE;
	f.submit();
}

function userIdCheck() {
	let userId = $('#userId').val();
	let $helpBlock = $('#userIdHelp');

	if (!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) {
		let str = '아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.';
		$helpBlock.html(str);
		$('#userId').focus();
		return;
	}

	let url = CONTEXT_PATH + '/member/userIdCheck';
	let params = 'userId=' + userId;
	$.ajax({
		type: 'POST',
		url: url,
		data: params,
		dataType: 'json',
		success: function(data) {
			let passed = data.passed;

			if (passed === 'true') {
				let str = '<span style="color:blue; font-weight: bold;">' + userId + '</span> 아이디는 사용가능 합니다.';
				$helpBlock.html(str);
				$('#loginIdValid').val('true');
			} else {
				let str = '<span style="color:red; font-weight: bold;">' + userId + '</span> 아이디는 사용할수 없습니다.';
				$helpBlock.html(str);
				$('#userId').val('');
				$('#loginIdValid').val('false');
				$('#userId').focus();
			}
		}
	});
}

function nicknameCheck() {
	let nickname = $('#nickname').val();
	let $helpBlock = $('#nicknameHelp');

	if (!/^[가-힣]{2,10}$/i.test(nickname)) {
		let str = '닉네임은 2~10자 이내이며, 한글만 가능합니다.';
		$helpBlock.html(str);
		$('#nickname').focus();
		return;
	}

	let url = CONTEXT_PATH + '/member/nicknameCheck';
	let params = 'nickname=' + nickname;
	$.ajax({
		type: 'POST',
		url: url,
		data: params,
		dataType: 'json',
		success: function(data) {
			let passed = data.passed;

			if (passed === 'true') {
				let str = '<span style="color:blue; font-weight: bold;">' + nickname + '</span> 닉네임은 사용가능 합니다.';
				$helpBlock.html(str);
				$('#nicknameValid').val('true');
			} else {
				let str = '<span style="color:red; font-weight: bold;">' + nickname + '</span> 닉네임은 사용할수 없습니다.';
				$helpBlock.html(str);
				$('#nickname').val('');
				$('#nicknameValid').val('false');
				$('#nickname').focus();
			}
		}
	});
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

			if (data.userSelectedType === 'R') {
				if (data.bname !== '') {
					extraAddr += data.bname;
				}
				if (data.buildingName !== '') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
			}

			document.getElementById('zip').value = data.zonecode;
			document.getElementById('addr1').value = fullAddr;
			document.getElementById('addr2').focus();
		}
	}).open();
}