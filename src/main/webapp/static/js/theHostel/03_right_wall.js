// 클릭 이벤트 관련 변수 초기화
let buttonDisplayed = false; 

const imageElement = document.getElementById('right-wall-image');
const leftButton = document.getElementById('left-button');
const rightButton = document.getElementById('right-button');

// 클릭 가능한 영역을 추가하는 함수
function addClickableAreas() {
    const clickableAreas = [
        { id: 'rushhourgame', x: 117 , y: 185, width: 260, height: 230, href: '/static/game/rushhour/rushhour.jsp' },
        { id: 'woman-frame', x: 520, y: 110, width: 140, height: 160, image: '/static/images/theHostel/rightwall/여자액자2.png' },
        { id: 'fish-frame', x: 714, y: 150, width: 150, height: 170, image: '/static/images/theHostel/rightwall/물고기액자2.png' },
        { id: 'shadow-right-frame', x: 917, y: 76, width: 180, height: 210, image: '/static/images/theHostel/rightwall/그림자액자2.png' },
        { id: 'tree-frame', x: 1122, y: 88, width: 130, height: 160, image: '/static/images/theHostel/rightwall/나무액자2.png' },
        { id: 'pianoclick', x: 702, y: 566, width: 500, height: 120, href: '/static/game/piano/piano.jsp' },
        { id: 'lockerclick', x: 111, y: 440, width: 280, height: 280, href: '/static/game/locker/locker.jsp' }
    ];

    clickableAreas.forEach(area => {
        const overlay = document.createElement('div');
        overlay.classList.add('clickable-area');
        overlay.style.position = 'absolute'; // 오버레이를 절대 위치로 설정
        overlay.style.left = area.x + 'px';
        overlay.style.top = area.y + 'px';
        overlay.style.width = area.width + 'px';
        overlay.style.height = area.height + 'px';
        overlay.style.backgroundColor = 'transparent'; // 영역이 보이지 않도록 투명하게 설정
        overlay.style.pointerEvents = 'auto'; // 오버레이가 클릭 이벤트를 받도록 설정
        overlay.id = area.id;

        document.getElementById('game-container').appendChild(overlay);

        // 마우스 포인터를 변경하기 위한 이벤트 리스너 추가
        overlay.addEventListener('mouseenter', function() {
            document.body.style.cursor = 'pointer';
        });
        overlay.addEventListener('mouseleave', function() {
            document.body.style.cursor = 'default';
        });

        // 클릭 이벤트 리스너 추가
        overlay.addEventListener('click', function(event) {
            event.stopPropagation(); // 이벤트 전파를 막아 오버레이 뒤의 요소가 클릭되지 않도록 함
            handleFrameClick(event, area);
        });
    });
}

// 액자 클릭 이벤트를 처리하는 함수
function handleFrameClick(event, area) {
    if (area.href) {
        window.location.href = area.href;
    } else {
        imageElement.src = area.image;
        addCloseButton(); // 'Back' 버튼 추가
        removeClickableAreas();
        leftButton.style.display = 'none';
        rightButton.style.display = 'none';
    }
}

// 클릭 가능한 영역을 제거하는 함수
function removeClickableAreas() {
    const overlays = document.querySelectorAll('.clickable-area');
    overlays.forEach(overlay => {
        overlay.remove();
    });
    document.body.style.cursor = 'default'; // 커서를 기본값으로 설정
}

// "닫기" 버튼 추가 함수
function addCloseButton() {
    const closeButton = document.createElement("button");
    closeButton.textContent = "Back";
    closeButton.id = "close-button";
    closeButton.className = "close-button";
    document.getElementById('game-container').appendChild(closeButton);

    buttonDisplayed = true; 

    closeButton.addEventListener('click', function() {
        imageElement.src = '/static/images/theHostel/rightwall/오른쪽벽.png'; // 원래 이미지로 돌아가기
        closeButton.remove();
        buttonDisplayed = false;
        removeClickableAreas(); // 클릭 가능한 모든 영역 제거
        addClickableAreas(); // 닫기 버튼 클릭 시 영역 다시 추가
        leftButton.style.display = 'block';
        rightButton.style.display = 'block';
    });
}

// 초기 영역 추가
addClickableAreas();
