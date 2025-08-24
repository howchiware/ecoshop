document.addEventListener('DOMContentLoaded', function() {
    const nicknameInput = document.getElementById('nickname');
    const originalNickname = document.getElementById('originalNickname').value;
    const nicknameHelp = document.getElementById('nicknameHelp');
    const nicknameValid = document.getElementById('nicknameValid');

    nicknameInput.addEventListener('input', function() {
        if (nicknameInput.value !== originalNickname) {
            nicknameHelp.innerHTML = '<span style="color: red;">닉네임이 변경되었습니다. 중복 검사를 다시 해주세요.</span>';
            nicknameValid.value = 'false';
        } else {
            nicknameHelp.textContent = '2~10자의 한글만 가능합니다.';
            nicknameValid.value = 'true';
        }
    });
});


function updateInfo() {
    const f = document.memberUpdateForm;
    let str;
    let p;

    if (f.password.value) {
        p = /^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i;
        if (!p.test(f.password.value)) {
            alert('패스워드는 5~10자이며 하나 이상의 영문자와 숫자/특수문자를 포함해야 합니다.');
            f.password.focus();
            return;
        }

        if (f.password.value !== f.password2.value) {
            alert('새 패스워드가 일치하지 않습니다.');
            f.password2.focus();
            return;
        }
    }

    p = /^[가-힣]{2,10}$/;
    if (!p.test(f.nickname.value)) {
        alert('닉네임은 2~10자의 한글만 사용 가능합니다.');
        f.nickname.focus();
        return;
    }
    if (f.nicknameValid.value === 'false') {
        alert('닉네임 중복 검사를 실행해주세요.');
        f.nickname.focus();
        return;
    }

    p = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!p.test(f.email.value)) {
        alert('올바른 이메일 형식을 입력하세요.');
        f.email.focus();
        return;
    }

    p = /^(010)-?\d{4}-?\d{4}$/;
    if (!p.test(f.tel.value)) {
        alert('올바른 전화번호 형식(010-1234-5678)을 입력하세요.');
        f.tel.focus();
        return;
    }

    if (!f.zip.value || !f.addr1.value) {
        alert('주소를 입력하세요.');
        return;
    }

    f.action = '/member/update';
    f.submit();
}

function nicknameCheck() {
    const nicknameInput = document.getElementById('nickname');
    const nickname = nicknameInput.value;
    const $helpBlock = document.getElementById('nicknameHelp');

    if (!/^[가-힣]{2,10}$/i.test(nickname)) {
        $helpBlock.innerHTML = '닉네임은 2~10자 이내이며, 한글만 가능합니다.';
        nicknameInput.focus();
        return;
    }

    const url = '/member/nicknameCheck';
    const params = 'nickname=' + nickname;

    fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    })
    .then(response => response.json())
    .then(data => {
        if (data.passed === 'true') {
            $helpBlock.innerHTML = `<span style="color:blue; font-weight: bold;">'${nickname}'은(는) 사용 가능한 닉네임입니다.</span>`;
            document.getElementById('nicknameValid').value = 'true';
        } else {
            $helpBlock.innerHTML = `<span style="color:red; font-weight: bold;">'${nickname}'은(는) 이미 사용 중인 닉네임입니다.</span>`;
            document.getElementById('nicknameValid').value = 'false';
            nicknameInput.focus();
        }
    })
    .catch(error => console.error('Error:', error));
}

function daumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            let fullAddr = '';
            let extraAddr = '';

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