// timer.js
let elapsedTime = parseInt(localStorage.getItem('elapsedTime'), 10);
let interval;

// localStorage에 저장된 값이 없거나 NaN일 경우 초기화
if (isNaN(elapsedTime)) {
    elapsedTime = 0;
    localStorage.setItem('elapsedTime', elapsedTime);
}

function updateElapsedTime() {
    elapsedTime += 1;
    localStorage.setItem('elapsedTime', elapsedTime);
}

function resetElapsedTime() {
    elapsedTime = 0;
    clearInterval(interval);
    localStorage.removeItem('elapsedTime');
}

// 페이지가 로드될 때 타이머 시작
window.onload = function() {
    interval = setInterval(updateElapsedTime, 1000); // 매초마다 경과 시간 증가
    console.log(localStorage.getItem('elapsedTime'));
};
