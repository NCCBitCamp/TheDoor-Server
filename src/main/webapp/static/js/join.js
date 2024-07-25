const idPattern = /^[a-z0-9]{5,20}$/;
// const pwPattern = /^(?=.[a-z])(?=.[A-Z])(?=.\d)(?=.[@$!%?&])[A-Za-z\d@$!%?&]{8,16}$/;
const pwPattern = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
const namePattern = /^[가-힣a-zA-Z]{2,20}$/;
const birthdayPattern = /^(19[0-9][0-9]|20[0-9][0-9])(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$/;


// input태그
const idInput = document.getElementById('id');
const pw1Input = document.getElementById('pw1');
const pw2Input = document.getElementById('pw2');
const nicknameInput = document.getElementById('nickname');
const emailInput = document.getElementById('email');
const nameInput = document.getElementById('name');
const birthdayInput = document.getElementById('birthday');

// div박스
const idDiv = document.getElementById('divId');
const pw1Div = document.getElementById('divPw1');
const pw2Div = document.getElementById('divPw2');
const nicknameDiv = document.getElementById('divNickname');
const emailDiv = document.getElementById('divEmail');
const nameDiv = document.getElementById('divUsername');
const birthdayDiv = document.getElementById('divBirthday');
const divMsg1 = document.getElementById('divMsg1');
const divMsg2 = document.getElementById('divMsg2');
const liMsg1 = document.getElementById('liMsg1');
const liMsg2 = document.getElementById('liMsg2');

// ------------------- //
// 아이디 메소드 할당(?) //
// ------------------- //
idInput.addEventListener('focus', idClick);
idInput.addEventListener('blur', idBlur);

// 클릭 :: 포커스
function idClick() {
    idDiv.style.border = '2px solid #ddd';
    idInput.style.color = '#fff';
    idInput.classList.remove('errorPlaceholder');
    idInput.placeholder = '아이디';
}

// 아무값도 입력하지 않았을 때
function idBlur() {
    const inputValue = this.value;


    // 아이디중복체크 // 아래 && 뒤에도 수정해야함.
    if (idInput.value === 'bitcamp') {
        divMsg1.style.visibility = 'visible';
        idDiv.style.border = '2px solid red';
        idInput.style.color = 'red';
        idInput.placeholder = '아이디는 필수 정보입니다.';
        idInput.classList.add('errorPlaceholder');
        liMsg1.textContent = '사용할 수 없는 아이디입니다.';

    }
    // 공백과 정규식에 맞지 않는 값 처리
    if (idInput.value == '' || !idPattern.test(inputValue)) {
        idDiv.style.border = '2px solid red';
        idInput.style.color = 'red';
        idInput.placeholder = '아이디는 필수 정보입니다.';
        idInput.classList.add('errorPlaceholder');
        divMsg1.style.visibility = 'visible';
        liMsg1.textContent = '5~20자의 영문 소문자, 숫자만 사용 가능합니다.';
    }

    // 맞을 때
    if (idPattern.test(inputValue) && idInput.value !== 'bitcamp') {
        divMsg1.style.visibility = 'hidden';
        idDiv.style.border = '0px';
        idInput.classList.remove('errorPlaceholder');
        idInput.style.color = '#fff';

    }
}


// --------------- //
// 패스워드 메소드  //
// --------------- //
pw1Input.addEventListener('focus', pw1Click);
pw1Input.addEventListener('blur', pw1Blur);
pw1Input.addEventListener('input', pw1Check);

function pw1Click() {
    pw1Div.style.border = '2px solid #ddd';
    pw1Input.style.color = '#fff';
    pw1Input.classList.remove('errorPlaceholder');
    pw1Input.placeholder = '8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.';
}

function pw1Blur() {
    const inputValue = this.value;

    // 공백과 정규식에 맞지 않는 값 처리
    // if (pwPattern.test(inputValue)) {
        if (pw1Input.value == '' || !pwPattern.test(inputValue)) {
            pw1Div.style.border = '2px solid red';
            pw1Input.style.color = 'red';
            pw1Input.placeholder = '비밀번호는 필수 정보입니다.';
            pw1Input.classList.add('errorPlaceholder');

            if (pw2Input.value != pw1Input.value && !pw2Input.value == '') {
                pw2Div.style.border = '2px solid red';
                pw2Input.style.color = 'red';
                pw2Input.placeholder = '비밀번호를 확인해 주세요.';
                pw2Input.classList.add('errorPlaceholder');

            } else if (pw2Input.value == pw1Input.value && !pw1Input.value == '' && pwPattern.test(inputValue)) {
                pw2Div.style.border = '0px';
                pw2Input.classList.remove('errorPlaceholder');
                pw2Input.style.color = '#fff';
            }
        }

        if (pwPattern.test(inputValue) || (pw2Input.value == pw1Input.value
            && !pw1Input.value == '')) {
            pw1Div.style.border = '0px';
            pw1Input.classList.remove('errorPlaceholder');
            pw1Input.style.color = '#fff';

            if (pw2Input.value != pw1Input.value && !pw2Input.value == '') {
                pw2Div.style.border = '2px solid red';
                pw2Input.style.color = 'red';
                pw2Input.placeholder = '비밀번호를 확인해 주세요.';
                pw2Input.classList.add('errorPlaceholder');
            }
        }
    // }
}

function pw1Check() {
    const inputValue = this.value;

    // 정규식 맞을 때
    if (pwPattern.test(inputValue) && pw2Input.value == pw1Input.value) {
        pw1Div.style.border = '2px solid #ddd';
        pw1Input.classList.remove('errorPlaceholder');
        pw1Input.style.color = '#fff';

        pw2Div.style.border = '0px';
        pw2Input.classList.remove('errorPlaceholder');
        pw2Input.style.color = '#fff';

    }
}

// ------------------- //
// 패스워드 확인 메소드 //
// ------------------- //
pw2Input.addEventListener('focus', pw2Click);
pw2Input.addEventListener('blur', pw2Blur);
pw2Input.addEventListener('input', pw2Check);

function pw2Click() {
    pw2Div.style.border = '2px solid #ddd';
    pw2Input.style.color = '#fff';
    pw2Input.classList.remove('errorPlaceholder');
    pw2Input.placeholder = '8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.';
}

function pw2Blur() {
    const inputValue = this.value;

    // 공백과 정규식에 맞지 않는 값 처리
    if (pw2Input.value == '' || pw2Input.value != pw1Input.value
        || !pwPattern.test(inputValue)) {
        pw2Div.style.border = '2px solid red';
        pw2Input.style.color = 'red';
        pw2Input.placeholder = '비밀번호를 확인해 주세요.';
        pw2Input.classList.add('errorPlaceholder');
    }

    if (pw2Input.value == pw1Input.value && pwPattern.test(inputValue)) {
        pw2Div.style.border = '0px';
        pw2Input.classList.remove('errorPlaceholder');
        pw2Input.style.color = '#fff';
    }
}

function pw2Check() {
    const inputValue = this.value;

    // 비번 일치할 때
    if (pw2Input.value == pw1Input.value) {
        pw2Div.style.border = '0px';
        pw2Input.classList.remove('errorPlaceholder');
        pw2Input.style.color = '#fff';
    }
}

// ------------ //
// 닉네임 메소드 //
// ------------ //
nicknameInput.addEventListener('focus', nicknameClick);
nicknameInput.addEventListener('blur', nicknameBlur);
// nicknameInput.addEventListener('input', nickcnameCheck);

function nicknameClick() {
    nicknameDiv.style.border = '2px solid #ddd';
    nicknameInput.style.color = '#fff';
    nicknameInput.classList.remove('errorPlaceholder');
    nicknameInput.placeholder = '닉네임';
    liMsg2.textContent = '사용할 수 없는 닉네임입니다.';

}

function nicknameBlur() {
    const inputValue = this.value;

    // 닉네임 중복체크
    if (namePattern.test(inputValue) && nicknameInput.value !== '고기천') {
        nicknameDiv.style.border = '0px';
        nicknameInput.classList.remove('errorPlaceholder');
        nicknameInput.style.color = '#fff';
        divMsg2.style.visibility = 'hidden';

    // 닉네임 중복일 때
    } else if(nicknameInput.value === '고기천') {
        divMsg2.style.visibility = 'visible';
        nicknameInput.style.color = 'red';
        nicknameDiv.style.border = '2px solid red';
        nicknameInput.placeholder = '닉네임은 필수 정보입니다.';
        nicknameInput.classList.add('errorPlaceholder');


    } else {
        nicknameDiv.style.border = '2px solid red';
        nicknameInput.style.color = 'red';
        nicknameInput.placeholder = '닉네임은 필수 정보입니다.';
        nicknameInput.classList.add('errorPlaceholder');
    }
}


// ------------ //
// 이메일 메소드 //
// ------------ //
emailInput.addEventListener('focus', emailClick);
emailInput.addEventListener('blur', emailBlur);
// emailInput.addEventListener('input', emailCheck);

function emailClick() {
    emailDiv.style.border = '2px solid #ddd';
    emailInput.style.color = '#fff';
    emailInput.classList.remove('errorPlaceholder');
    emailInput.placeholder = '이메일주소';
}

function emailBlur() {
    const inputValue = this.value;

    if (emailInput.value == '') {
        emailDiv.style.border = '0px';
    } else {
        emailDiv.style.border = '0px';
    }
}


// ------------ //
//  이름 메소드  //
// ------------ //
nameInput.addEventListener('focus', nameClick);
nameInput.addEventListener('blur', nameBlur);
// nameInput.addEventListener('input', nameCheck);

function nameClick() {
    nameDiv.style.border = '2px solid #ddd';
    nameInput.style.color = '#fff';
    nameInput.classList.remove('errorPlaceholder');
    nameInput.placeholder = '이름';
}

function nameBlur() {
    const inputValue = this.value;

    // 공백과 정규식에 맞지 않는 값 처리
    // if (nicknameInput.value == '') {
    //     nicknameDiv.style.border = '2px solid red';
    //     nicknameInput.style.color = 'red';
    //     nicknameInput.placeholder = '닉네임은 필수 정보입니다.';
    //     nicknameInput.classList.add('errorPlaceholder');
    // }

    if (namePattern.test(inputValue)) {
        nameDiv.style.border = '0px';
        nameInput.classList.remove('errorPlaceholder');
        nameInput.style.color = '#fff';
    } else {
        nameDiv.style.border = '2px solid red';
        nameInput.style.color = 'red';
        nameInput.placeholder = '이름은 필수 정보입니다.';
        nameInput.classList.add('errorPlaceholder');
    }
}


// -------------- //
// 생년월일 메소드 //
// -------------- //
birthdayInput.addEventListener('focus', birthdayClick);
birthdayInput.addEventListener('blur', birthdayBlur);
// birthdayInput.addEventListener('input', birthdayCheck);

function birthdayClick() {
    birthdayDiv.style.border = '2px solid #ddd';
    birthdayInput.style.color = '#fff';
    birthdayInput.classList.remove('errorPlaceholder');
    birthdayInput.placeholder = '생년월일 8자리';
}

function birthdayBlur() {
    const inputValue = this.value;

    if (birthdayPattern.test(inputValue)) {
        birthdayDiv.style.border = '0px';
    } else {
        birthdayDiv.style.border = '2px solid red';
        birthdayInput.style.color = 'red';
        birthdayInput.placeholder = '생년월일은 8자리 숫자로 입력해 주세요.';
        birthdayInput.classList.add('errorPlaceholder');
    }
}
