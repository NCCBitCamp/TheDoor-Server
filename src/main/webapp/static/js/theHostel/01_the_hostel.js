let textDisplayed = false; // 텍스트가 이미 표시되었는지 여부를 확인하는 변수
let buttonDisplayed = false; // 버튼이 이미 표시되었는지 여부를 확인하는 변수

document.getElementById('game-container').addEventListener('click', function() {
    if (!textDisplayed) { // 텍스트가 이미 표시되지 않은 경우에만 실행
        // 다음 화면에 표시할 이미지 경로
        var nextImagePath = '/static/images/theHostel/main/호스텔복도.jpg';
        
        // 이미지 요소 가져오기
        var imageElement = document.getElementById('hostel-image');
        
        // 이미지 경로 변경
        imageElement.src = nextImagePath;

         // 제목 박스 요소 숨기기
         var titleBox = document.getElementById('title-box');
         titleBox.remove(); // Remove the title box element

        // 텍스트 박스 요소 가져오기
        var textBox = document.getElementById('text-box');
                
        // 텍스트 박스 표시
        textBox.style.display = 'block';

        typeWriter(textBox, `한적한 밤, 시골의 구석진 거리에 위치한 호스텔에서 형사 모티브는 스산한 분위기를 느끼며 문을 열었다.
                            며칠 전, 그는 평소와 다를 것 없는 일상 속에서 한 건의 실종 사건을 맡게 되었다.
                            실종된 여자는 록시라는 이름의 젊은 여자로, 바의 단골이었다.
                            록시의 마지막 흔적은 이 호스텔에서 사라졌고...
                            그녀의 흔적을 찾기 위해 모티브는 조사를 시작했다.`, 40);
        
        textDisplayed = true; // 텍스트가 표시되었음을 기록
    }
});

function typeWriter(element, text, speed) {
    let i = 0;
    function type() {
        if(i < text.length) {
            if (text.charAt(i) === '\n') {
                element.innerHTML += '<br>';
            } else {
                element.innerHTML += text.charAt(i);
            }
            i++;
            setTimeout(type, speed)
        } else {
            // 텍스트가 다 출력된 후 버튼을 추가
            if (!buttonDisplayed) {
                addButton();
                buttonDisplayed = true; // 버튼이 표시되었음을 기록
            }
        }
    }
    type();
}

function addButton() {
    var button = document.createElement("button");
    button.textContent = "조사하기";
    button.id = "investigate-button";
    button.className = "investigate-button";
    document.getElementById('game-container').appendChild(button);
    
    // 버튼 클릭 이벤트 추가
    button.addEventListener('click', function() {
        // alert('성실히 조사에 임해보자');
        // 필요한 작업 추가 (예: 페이지 이동)
        // window.location.href = 'investigation_page.html';
        button.remove(); // 버튼 제거
        addEnterButton(); // 들어가기 버튼 추가
    });
}

function addEnterButton() {
    var button = document.createElement("button");
    button.textContent = "들어가기";
    button.id = "enter-button";
    button.className = "enter-button";
    document.getElementById('game-container').appendChild(button);
    
    // 버튼 클릭 이벤트 추가
    button.addEventListener('click', function() {
        window.location.href = '/theHostel/the-bar.do'; // 다음 페이지로 이동
    });
}