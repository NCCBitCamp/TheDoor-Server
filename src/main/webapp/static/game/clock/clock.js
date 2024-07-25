const circle_1 = document.getElementById('circle1');
const circle_3 = document.getElementById('circle3');

const hour = document.getElementById('hour-hand');
const minute = document.getElementById('minute-hand');

// 눈금 그리기
for (let i = 0; i < 30; i++) {
  const line = document.createElement('div');
  line.classList.add('line');
  line.style.transform = `rotate(${6 * i}deg)`;
  if (i % 5) {
    line.classList.add('thin');
  } else {
    line.classList.add('thick');
  }
  circle_1.appendChild(line);
}

// 숫자 넣기
let right = 3;
let left = 9;

for (let i = 0; i < 6; i++) {
  const num_container = document.createElement('div');
  num_container.classList.add('num-container');
  num_container.style.transform = `rotate(${30 * i}deg)`;
  num_container.innerHTML = `
    <div class="num ${(i === 0 || i === 3) ? 'highlight' : ''}" style="transform: rotate(-${30 * i}deg)">${left > 12 ? left - 12 : left}</div>
    <div class="num ${(i === 0 || i === 3) ? 'highlight' : ''}" style="transform: rotate(-${30 * i}deg)">${right}</div>
  `;
  circle_3.appendChild(num_container);
  right++;
  left++;
}

//----------//
// 시간 설정 //
//----------//
let setHour = new Date();
setHour.setHours(0, 0);

let hourVal = 0;
let minuteVal = 0;

const hourPlusBtn = document.querySelector("#hour-plus-btn");
const clearBtn = document.querySelector("#clearBtn");
const minPlusBtn = document.querySelector("#minute-plus-btn");

let hourDeg;
let minuteDeg = 5;

hourPlusBtn.addEventListener("click", function(e) {
  hourVal++;
  setHour.setHours(hourVal, minuteVal);

  //---------------//
  // 시침 각도 계산 //
  //---------------//
  hourDeg = (360 * (setHour.getHours() / 12))  + (30 * (minuteDeg / 360));
  hour.style.transform = "rotate(" + hourDeg + "deg)";
  if(hourVal == 12) hourVal = 0;

  console.log(hourVal);
});

minPlusBtn.addEventListener("click", function(e) {
  minuteVal += 5;
  setHour.setHours(hourVal, minuteVal);

  //---------------//
  // 분침 각도 계산 //
  //---------------//
  minuteDeg = (360 * (setHour.getMinutes() / 60));
  minute.style.transform = "rotate(" + minuteDeg + "deg)";
  if(minuteVal == 60) minuteVal = 0;
 
  console.log(minuteVal);
});

  //---------------//
  // - 정답일 때 -- //
  //---------------//
// clock.html에서 시간 설정 후 정답을 맞춘 경우
clearBtn.addEventListener('click', (e) => {
  if (hourVal === 7 && minuteVal === 15) {
    alert('닫혔던 서랍이 열렸다.');
    localStorage.setItem('drawerUnlocked', 'true');
    localStorage.setItem('clockSolved', 'true');
    setTimeout(function() {
      window.location.href = '/theHostel/left-wall.do'; // left_wall.html로 이동
    }, 500);
  } else {
    alert('시간이 맞지 않습니다. 다시 시도하세요.');
  }
});

//---------------//
// 버튼 눌림 액션 //
//---------------//
const button1 = document.querySelector(".button1");
const button2 = document.querySelector(".button2");
const button3 = document.querySelector(".button3");

button1.addEventListener("click", (e) => {
  button1.classList.add("active");
  setTimeout(() => { 
    button1.classList.remove("active");
  }, 150);
});
button2.addEventListener("click", (e) => {
  button2.classList.add("active");
  setTimeout(() => { 
    button2.classList.remove("active");
  }, 150);
});
button3.addEventListener("click", (e) => {
  button3.classList.add("active");
  setTimeout(() => { 
    button3.classList.remove("active");
  }, 150);
});


document.getElementById('back-button').addEventListener('click', function() {
  window.location.href = '/theHostel/left-wall.do'; // 돌아갈 페이지로 이동
});
