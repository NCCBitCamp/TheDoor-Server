// 클릭 이벤트 관련 변수 초기화
let buttonDisplayed = false;

const imageElement = document.getElementById('left-wall-image');
const leftButton = document.getElementById('left-button');
const rightButton = document.getElementById('right-button');
let interval; // <= 티비 화면 전환을 위한 변수

// 서랍 열림 상태 확인
const drawerUnlocked = localStorage.getItem('drawerUnlocked') === 'true';

window.onload = function() {
    const coinClick = localStorage.getItem("coinClick") === 'true';

    if(coinClick) {
        const leftWallImage = document.getElementById('left-wall-image');
        leftWallImage.src = '/static/images/theHostel/leftwall/동전올려진상자.png';
        setTimeout(() => {
            leftWallImage.src = '/static/images/theHostel/leftwall/최종열린상자.png';
            setTimeout(() => {
                window.location.href = '/theHostel/ending.do';
            }, 2000);
        }, 2000);
    }
}

// 클릭 가능한 영역을 추가하는 함수
function addClickableAreas() {
    const clickableAreas = [
        { id: 'menu', x: 203, y: 142, width: 120, height: 160, image: '/static/images/theHostel/leftwall/메뉴판.png' },
        { id: 'pianokey', x: 399, y: 206, width: 210, height: 160, image: '/static/images/theHostel/leftwall/피아노건반.png' },
        { id: 'mirror', x: 712, y: 78, width: 160, height: 190, image: '/static/images/theHostel/leftwall/거울.png' },
        { id: 'television', x: 75, y: 342, width: 170, height: 160, image: '/static/images/theHostel/leftwall/티비_1.png' },
        { id: 'green_drawer', x: 67, y: 537, width: 370, height: 220, image: '/static/images/theHostel/leftwall/왼쪽벽열린선반.png' },
        { id: 'grandfather_clock', x: 1010, y: 141, width: 126, height: 419, href: '/static/game/clock/clock.jsp' },
        { id: 'grandfather_drawer', x: 971, y: 633, width: 212, height: 95, image: drawerUnlocked ? '/static/images/theHostel/leftwall/서랍속반지.png' : '' }
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
        overlay.addEventListener('mouseenter', function () {
            document.body.style.cursor = 'pointer';
        });
        overlay.addEventListener('mouseleave', function () {
            document.body.style.cursor = 'default';
        });

        // green_drawer 클릭조건문
        overlay.addEventListener('click', function (event) {
            event.stopPropagation(); // 이벤트 전파를 막아 오버레이 뒤의 요소가 클릭되지 않도록 함
            handleFrameClick(event, area);
        });

        // tv화면클릭조건문
        if (area.id === 'television') {
            overlay.addEventListener('click', function (event) {
                event.stopPropagation(); // 이벤트 전파를 막아 오버레이 뒤의 요소가 클릭되지 않도록 함
                addTVArea();
            });
        }

        // green_drawer 클릭조건문
        if (area.id === 'green_drawer') {
            overlay.addEventListener('click', function (event) {
                event.stopPropagation(); // 이벤트 전파를 막아 오버레이 뒤의 요소가 클릭되지 않도록 함
                handleGreenDrawerClick();
            });
        }
    });

    // 서랍이 열렸을 때 반지를 클릭할 수 있는 영역 추가
    if (drawerUnlocked) {
        addRingArea();
    }
}

// 서랍과 액자 클릭 이벤트를 처리하는 함수
function handleFrameClick(event, area) {
    if (area.id === 'grandfather_drawer' && localStorage.getItem('clockSolved') !== 'true') {
        alert('아직 문을 열 수 없습니다.');
        return; // 이미지를 변경하지 않음
    }

    if (area.href) {
        window.location.href = area.href;
    } else {
        imageElement.src = area.image;
        addCloseButton(); // 'Back' 버튼 추가
        removeClickableAreas();
        leftButton.style.display = 'none';
        rightButton.style.display = 'none';

        if (area.id === 'grandfather_drawer' && drawerUnlocked) {
            addRingArea(); // 서랍이 열리면 반지 영역 추가
        }
    }
}

// 클릭 가능한 영역을 제거하는 함수
function removeClickableAreas() {
    const overlays = document.querySelectorAll('.clickable-area, .ring-area, .coin-area, .tv-area');
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

    closeButton.addEventListener('click', function () {
        imageElement.src = '/static/images/theHostel/leftwall/왼쪽벽.png'; // 원래 이미지로 돌아가기
        closeButton.remove();
        buttonDisplayed = false;
        removeClickableAreas(); // 클릭 가능한 모든 영역 제거
        addClickableAreas(); // 닫기 버튼 클릭 시 영역 다시 추가
        leftButton.style.display = 'block';
        rightButton.style.display = 'block';
        clearInterval(interval);
    });
}

// 반지 클릭 가능한 영역 추가 함수
function addRingArea() {
    const ringArea = { x: 543, y: 389, width: 150, height: 100 }; // 실제 반지 위치로 조정

    const overlay = document.createElement('div');
    overlay.classList.add('ring-area');
    overlay.style.position = 'absolute';
    overlay.style.left = ringArea.x + 'px';
    overlay.style.top = ringArea.y + 'px';
    overlay.style.width = ringArea.width + 'px';
    overlay.style.height = ringArea.height + 'px';
    overlay.style.backgroundColor = 'transparent';
    overlay.style.pointerEvents = 'auto';

    document.getElementById('game-container').appendChild(overlay);

    overlay.addEventListener('mouseenter', function () {
        document.body.style.cursor = 'pointer';
    });
    overlay.addEventListener('mouseleave', function () {
        document.body.style.cursor = 'default';
    });

    // 클릭 이벤트 리스너 추가
    overlay.addEventListener('click', function (event) {
        event.stopPropagation();
        addRingToInventory();
    });
}

// 반지를 인벤토리에 추가하는 함수
function addRingToInventory() {
    let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
    const itemExists = inventory.includes('/static/images/theHostel/useritem/반지.png');
    if (!itemExists) {
        inventory.push('/static/images/theHostel/useritem/반지.png');
        localStorage.setItem('inventory', JSON.stringify(inventory));
        alert('반지를 획득하였습니다.');
        window.location.href = '/theHostel/left-wall.do'; // 페이지 이동
    }
}

function addTVArea() {
    let i = 0;

    const tvArea = { x: 437, y: 171, width: 434, height: 340 };

    const overlay = document.createElement('div');
    overlay.classList.add('tv-area');
    overlay.style.position = 'absolute';
    overlay.style.left = tvArea.x + 'px';
    overlay.style.top = tvArea.y + 'px';
    overlay.style.width = tvArea.width + 'px';
    overlay.style.height = tvArea.height + 'px';
    overlay.style.backgroundColor = 'transparent';
    overlay.style.pointerEvents = 'auto';

    document.getElementById('game-container').appendChild(overlay);

    overlay.addEventListener('mouseenter', function () {
        document.body.style.cursor = 'pointer';
    });
    overlay.addEventListener('mouseleave', function () {
        document.body.style.cursor = 'default';
    });

    otherAreaClicked = true;
    imageElement.src = '/static/images/theHostel/leftwall/티비0.gif';
    addCloseButton();
    removeClickableAreas(); // 영역 제거

    // 티비 화면 자동 전환
    interval = setInterval(function () {
        i++;
        imageElement.src = `/static/images/theHostel/leftwall/티비${i}.png`;

        if (i === 4) {
            i = 0;
        }
    }, 1000);

    // 자동전환 on / off
    let turnbtn = false;
    overlay.addEventListener('click', () => {
        turnbtn = !turnbtn;
        if (turnbtn) {
            clearInterval(interval);
        } else {
            interval = setInterval(function () {
                i++;
                imageElement.src = `/static/images/theHostel/leftwall/티비${i}.png`;

                if (i === 4) {
                    i = 0;
                }
            }, 900);
        }
    });
}


// green_drawer 클릭 이벤트 처리 함수
function handleGreenDrawerClick() {
    // 기존 클릭 가능한 영역 제거
    removeClickableAreas();

    // 현재 이미지 유지
    addCloseButton(); // 'Back' 버튼 추가

    // 새로운 클릭 가능한 영역 추가
    const coinBoxArea = { x: 300, y: 696, width: 300, height: 300 }; // 실제 동전 상자 위치로 조정
    const overlay = document.createElement('div');
    overlay.classList.add('coin-area');
    overlay.style.position = 'absolute';
    overlay.style.left = coinBoxArea.x + 'px';
    overlay.style.top = coinBoxArea.y + 'px';
    overlay.style.width = coinBoxArea.width + 'px';
    overlay.style.height = coinBoxArea.height + 'px';
    overlay.style.backgroundColor = 'transparent';
    overlay.style.pointerEvents = 'auto';

    document.getElementById('game-container').appendChild(overlay);

    overlay.addEventListener('mouseenter', function () {
        document.body.style.cursor = 'pointer';
    });
    overlay.addEventListener('mouseleave', function () {
        document.body.style.cursor = 'default';
    });

    overlay.addEventListener('click', function (event) {
        event.stopPropagation();
        showCoinBox()
    });
}

// 동전 상자 이미지 표시 함수
function showCoinBox() {
    imageElement.src = '/static/images/theHostel/leftwall/동전상자.png';
}

// 초기 영역 추가
addClickableAreas();
