// 클릭 이벤트 관련 변수 초기화
let buttonDisplayed = false;
let secondImageDisplayed = false;
let thirdImageDisplayed = false;
let otherAreaClicked = false;
let boyfriendAreaClicked = false; // 남자친구 영역 클릭 여부 추적 변수
let itemSelected = null; // 선택된 아이템 추적 변수

const liquorClickCounts = {
    '봄베이따르기': 0,
    '럼따르기': 0,
    '스미노프따르기': 0,
    '오렌지주스따르기': 0,
    '달모어따르기': 0,
    '레몬주스따르기': 0
};

const liquorAreas = [
    { x: 285, y: 190, width: 56, height: 150, image: '/static/images/theHostel/barpage/봄베이따르기.png', key: '봄베이따르기' },
    { x: 369, y: 190, width: 77, height: 150, image: '/static/images/theHostel/barpage/럼따르기.png', key: '럼따르기' },
    { x: 450, y: 190, width: 50, height: 150, image: '/static/images/theHostel/barpage/스미노프따르기.png', key: '스미노프따르기' },
    { x: 285, y: 400, width: 50, height: 140, image: '/static/images/theHostel/barpage/오렌지주스따르기.png', key: '오렌지주스따르기' },
    { x: 369, y: 390, width: 77, height: 150, image: '/static/images/theHostel/barpage/달모어따르기.png', key: '달모어따르기' },
    { x: 450, y: 390, width: 50, height: 150, image: '/static/images/theHostel/barpage/레몬주스따르기.png', key: '레몬주스따르기' }
];

const imageElement = document.getElementById('bar-image');

// 클릭 가능한 영역을 추가하는 함수 
function addClickableAreas() {
    const clickableAreas = [
        { id: 'boyfriend-area', x: 270, y: 300, width: 180, height: 440 }, // 남자친구 영역
        { id: 'waiter-area', x: 520, y: 250, width: 180, height: 280 }, // 웨이터 영역
        { id: 'liquor-area', x: 700, y: 140, width: 350, height: 400 }  // 술장 영역
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

        // 클릭 이벤트 리스너 추가
        overlay.addEventListener('click', function (event) {
            event.stopPropagation(); // 이벤트 전파를 막아 오버레이 뒤의 요소가 클릭되지 않도록 함
            handleOverlayClick(event, area);
            document.getElementById("left-button").style.display = "none";
            document.getElementById("right-button").style.display = "none";
        });
    });
}

// 술장 클릭 가능한 영역을 추가하는 함수
function addLiquorAreas() {
    liquorAreas.forEach(area => {
        const overlay = document.createElement('div');
        overlay.classList.add('liquor-area');
        overlay.style.position = 'absolute'; // 오버레이를 절대 위치로 설정
        overlay.style.left = area.x + 'px';
        overlay.style.top = area.y + 'px';
        overlay.style.width = area.width + 'px';
        overlay.style.height = area.height + 'px';
        overlay.style.backgroundColor = 'transparent'; // 영역이 보이지 않도록 투명하게 설정
        overlay.style.pointerEvents = 'auto'; // 오버레이가 클릭 이벤트를 받도록 설정

        document.getElementById('game-container').appendChild(overlay);

        // 마우스 포인터를 변경하기 위한 이벤트 리스너 추가
        overlay.addEventListener('mouseenter', function () {
            document.body.style.cursor = 'pointer';
        });
        overlay.addEventListener('mouseleave', function () {
            document.body.style.cursor = 'default';
        });

        // 클릭 이벤트 리스너 추가
        overlay.addEventListener('click', function (event) {
            event.stopPropagation(); // 이벤트 전파를 막아 오버레이 뒤의 요소가 클릭되지 않도록 함
            handleLiquorClick(event, area);
        });
    });
}

// 클릭 가능한 영역을 제거하는 함수
function removeClickableAreas() {
    const overlays = document.querySelectorAll('.clickable-area, .liquor-area, .paper-area, .final-area');
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
        imageElement.src = '/static/images/theHostel/barpage/더호스텔바.png';
        closeButton.remove();
        buttonDisplayed = false;
        otherAreaClicked = false;
        secondImageDisplayed = false;
        thirdImageDisplayed = false;
        resetLiquorClickCounts();
        removeClickableAreas(); // 클릭 가능한 모든 영역 제거
        addClickableAreas(); // 닫기 버튼 클릭 시 영역 다시 추가
        document.getElementById("left-button").style.display = ""; // 왼쪽오른쪽 버튼숨기기
        document.getElementById("right-button").style.display = "";
    });
}

// 클릭 이벤트를 처리하는 함수
function handleOverlayClick(event, area) {
    const clickX = event.clientX - imageElement.getBoundingClientRect().left;
    const clickY = event.clientY - imageElement.getBoundingClientRect().top;

    function checkAreaClick(area) {
        return clickX >= area.x && clickX <= (area.x + area.width) &&
            clickY >= area.y && clickY <= (area.y + area.height);
    }

    //--------------------------//
    // 남자친구 영역 클릭 시 동작 //
    //--------------------------//
    if (area.id === 'boyfriend-area' && checkAreaClick(area) && !buttonDisplayed) {
        imageElement.src = '/static/images/theHostel/barpage/내버려둬(잔x).png';
        otherAreaClicked = true;
        addCloseButton();
        removeClickableAreas(); // 영역 제거
        addPaperArea(); // 남자친구 클릭 시 추가 영역 생성
        boyfriendAreaClicked = true; // 남자친구 영역 클릭으로 설정
        localStorage.setItem('boyfriendAreaClicked', 'true'); // 남자친구 영역 클릭 여부를 localStorage에 저장
    }
    // 웨이터 영역 클릭 시 동작
    else if (area.id === 'waiter-area' && checkAreaClick(area) && !buttonDisplayed) {
        imageElement.src = '/static/images/theHostel/barpage/말하는웨이터.png';
        otherAreaClicked = true;
        addCloseButton();
        removeClickableAreas(); // 영역 제거
    }
    // 술장 영역 클릭 시 동작
    else if (area.id === 'liquor-area' && checkAreaClick(area) && !secondImageDisplayed && !otherAreaClicked) {
        imageElement.src = '/static/images/theHostel/barpage/술있는곳확대.png';
        secondImageDisplayed = true;
        addCloseButton();
        removeClickableAreas(); // 영역 제거
        addLiquorAreas(); // 두 번째 이미지 클릭 시 주류 영역 추가
    } else {
        // 갈색 술 아이템이 선택된 상태에서 잘못된 영역 클릭 시
        if (itemSelected === '갈색술' && !checkAreaClick(area)) {
            alert('사용할 수 없습니다.');
            itemSelected = null; // 선택된 아이템 초기화
        }
    }
}

// 특정 주류 항목 클릭 이벤트를 처리하는 함수
function handleLiquorClick(event, area) {
    const clickX = event.clientX - imageElement.getBoundingClientRect().left;
    const clickY = event.clientY - imageElement.getBoundingClientRect().top;

    function checkAreaClick(area) {
        return clickX >= area.x && clickX <= (area.x + area.width) &&
            clickY >= area.y && clickY <= (area.y + area.height);
    }

    if (secondImageDisplayed && !thirdImageDisplayed && checkAreaClick(area)) {
        imageElement.src = area.image;
        liquorClickCounts[area.key] += 1;
        thirdImageDisplayed = true;
        document.getElementById('close-button').style.display = 'none';

        // 1초 후에 두 번째 이미지로 돌아가기
        setTimeout(function () {
            checkLiquorClickCombination();
            imageElement.src = '/static/images/theHostel/barpage/술있는곳확대.png';
            thirdImageDisplayed = false;
            document.getElementById('close-button').style.display = 'block';
        }, 1000);
    }
}

// 특정 영역을 클릭했을 때 종이(신문) 영역 추가되는 함수
function addPaperArea() {
    const paperArea = { x: 495, y: 717, width: 126, height: 63 };

    const overlay = document.createElement('div');
    overlay.classList.add('paper-area');
    overlay.style.position = 'absolute'; // 오버레이를 절대 위치로 설정
    overlay.style.left = paperArea.x + 'px';
    overlay.style.top = paperArea.y + 'px';
    overlay.style.width = paperArea.width + 'px';
    overlay.style.height = paperArea.height + 'px';
    overlay.style.backgroundColor = 'transparent'; // 영역이 보이지 않도록 투명하게 설정
    overlay.style.pointerEvents = 'auto'; // 오버레이가 클릭 이벤트를 받도록 설정

    document.getElementById('game-container').appendChild(overlay);

    // 마우스 포인터를 변경하기 위한 이벤트 리스너 추가
    overlay.addEventListener('mouseenter', function () {
        document.body.style.cursor = 'pointer';
    });
    overlay.addEventListener('mouseleave', function () {
        document.body.style.cursor = 'default';
    });

    // 클릭 이벤트 리스너 추가
    overlay.addEventListener('click', function (event) {
        event.stopPropagation(); // 이벤트 전파를 막아 오버레이 뒤의 요소가 클릭되지 않도록 함
        addWordleArea();
    });
}

// 월들 영역 클릭 이벤트를 처리하는 함수
function addWordleArea() {
    const wordleArea = { x: 608, y: 334, width: 231, height: 248, href: '/static/game/wordle/wordle.jsp' };

    const overlay = document.createElement('div');
    overlay.classList.add('wordle-area');
    overlay.style.position = 'absolute'; // 오버레이를 절대 위치로 설정
    overlay.style.left = wordleArea.x + 'px';
    overlay.style.top = wordleArea.y + 'px';
    overlay.style.width = wordleArea.width + 'px';
    overlay.style.height = wordleArea.height + 'px';
    overlay.style.backgroundColor = 'transparent'; // 영역이 보이지 않도록 투명하게 설정
    overlay.style.pointerEvents = 'auto'; // 오버레이가 클릭 이벤트를 받도록 설정

    document.getElementById('game-container').appendChild(overlay);

    overlay.addEventListener('mouseenter', function () {
        document.body.style.cursor = 'pointer';
    });
    overlay.addEventListener('mouseleave', function () {
        document.body.style.cursor = 'default';
    });

    otherAreaClicked = true;
    imageElement.src = '/static/images/theHostel/barpage/신문.png';
    removeClickableAreas(); // 영역 제거

    // 클릭 이벤트 리스너 추가
    overlay.addEventListener('click', function (event) {
        event.stopPropagation(); // 이벤트 전파를 막아 오버레이 뒤의 요소가 클릭되지 않도록 함
        window.location.href = '/static/game/wordle/wordle.jsp';
    });
}

// 잔완성 이미지에 클릭 영역 추가 함수
function addFinalClickArea(drinkType) {
    const finalArea = { x: 748, y: 546, width: 75, height: 100 };

    const overlay = document.createElement('div');
    overlay.classList.add('final-area');
    overlay.style.position = 'absolute'; // 오버레이를 절대 위치로 설정
    overlay.style.left = finalArea.x + 'px';
    overlay.style.top = finalArea.y + 'px';
    overlay.style.width = finalArea.width + 'px';
    overlay.style.height = finalArea.height + 'px';
    overlay.style.backgroundColor = 'transparent'; // 영역이 보이지 않도록 투명하게 설정
    overlay.style.pointerEvents = 'auto'; // 오버레이가 클릭 이벤트를 받도록 설정
    overlay.dataset.drinkType = drinkType; // drinkType 데이터를 저장

    document.getElementById('game-container').appendChild(overlay);

    // 마우스 포인터를 변경하기 위한 이벤트 리스너 추가
    overlay.addEventListener('mouseenter', function () {
        document.body.style.cursor = 'pointer';
    });
    overlay.addEventListener('mouseleave', function () {
        document.body.style.cursor = 'default';
    });

    // 클릭 이벤트 리스너 추가
    overlay.addEventListener('click', function (event) {
        event.stopPropagation(); // 이벤트 전파를 막아 오버레이 뒤의 요소가 클릭되지 않도록 함
        handleFinalClick(event.target.dataset.drinkType);
    });
}


// 잔완성 이미지 클릭 시 동작
function handleFinalClick(drinkType) {
    imageElement.src = '/static/images/theHostel/barpage/칵테일잔x.png'; // 변경할 이미지로 대체

    let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
    let itemExists;
    let itemName;

    if (drinkType === "갈색술") {
        itemExists = inventory.includes('/static/images/theHostel/useritem/갈색술.png');
        itemName = '/static/images/theHostel/useritem/갈색술.png';
    } else if (drinkType === "보라술") {
        itemExists = inventory.includes('/static/images/theHostel/useritem/보라술.png');
        itemName = '/static/images/theHostel/useritem/보라술.png';
    }

    if (itemExists) {
        alert("이미 같은 아이템이 인벤토리에 있습니다.");
        return;
    }

    inventory.push(itemName);
    localStorage.setItem('inventory', JSON.stringify(inventory));

    // 획득 메시지 표시
    alert(`${drinkType}을(를) 획득하였습니다.`);
}

// 인벤토리 아이템 클릭 이벤트 처리 조건 추가
document.addEventListener('DOMContentLoaded', (event) => {
    // 로컬 스토리지에서 인벤토리 데이터를 가져옴
    let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
    
    // 인벤토리 데이터를 순회하며 박스에 아이템 이미지를 추가
    inventory.forEach((item, index) => {
        if (index < 7) {
            const box = document.getElementById(`box${index + 1}`);
            const img = document.createElement('img');
            img.src = item;
            img.className = 'item';
            img.oncontextmenu = (e) => onContextMenu(e, index);
            img.onclick = () => handleItemClick(item);
            box.appendChild(img);
        }
    });
});

// 아이템 클릭 이벤트 처리 함수
function handleItemClick(item) {
    if (item === '/static/images/theHostel/useritem/갈색술.png') {
        history.back();
        itemSelected = '갈색술';
        localStorage.setItem("itemSelected", itemSelected);
        alert('갈색 술이 선택되었습니다.');
    } else if (item === '/static/images/theHostel/useritem/레시피2.png') {
        const modal = document.getElementById('recipe-modal');
        const modalImg = document.getElementById('modal-img');
        modalImg.src = item;
        modal.style.display = 'block';
    } else if (item === '/static/images/theHostel/useritem/보라술.png') {
        history.back();
        itemSelected = '보라술';
        localStorage.setItem("itemSelected", itemSelected);
        alert('보라술이 선택되었습니다.');
    }
}

// 메시지를 화면 가운데에 표시하는 함수
function displayMessage1(message) {
    const messageBox = document.createElement('div');
    messageBox.textContent = message;
    messageBox.style.position = 'fixed';
    messageBox.style.top = '50%';
    messageBox.style.left = '50%';
    messageBox.style.transform = 'translate(-50%, -50%)';
    messageBox.style.backgroundColor = 'rgba(0, 0, 0, 0.7)';
    messageBox.style.color = 'white';
    messageBox.style.padding = '20px';
    messageBox.style.borderRadius = '10px';
    messageBox.style.zIndex = '1000';
    document.body.appendChild(messageBox);

    // 2초 후 메시지를 제거하고 alert 표시
    setTimeout(() => {
        document.body.removeChild(messageBox);
        alert('레시피를 찾아보자');
    }, 2000);
}

function displayMessage2(message, callback) {
    const messageBox = document.createElement('div');
    messageBox.textContent = message;
    messageBox.style.position = 'fixed';
    messageBox.style.top = '20%';
    messageBox.style.left = '50%';
    messageBox.style.transform = 'translate(-50%, -50%)';
    messageBox.style.backgroundColor = 'rgba(0, 0, 0, 0.7)';
    messageBox.style.color = 'white';
    messageBox.style.padding = '20px';
    messageBox.style.borderRadius = '10px';
    messageBox.style.zIndex = '1000';
    document.body.appendChild(messageBox);

    // 화면을 잠깐 다른 이미지로 바꾸기
    const originalSrc = imageElement.src;
    imageElement.src = '/static/images/theHostel/barpage/심장건네는남자.png';
    console.log('Image changed to 심장건네는남자.png');

    // 이미지가 바뀐 후 2초 동안 유지
    setTimeout(() => {
        document.body.removeChild(messageBox);
        imageElement.src = originalSrc;
        console.log('Image reverted to original');
        if (callback) callback();
    }, 2000);
}


// 클릭 횟수를 확인하는 함수

function checkLiquorClickCombination() {
    //---------------------------------//
    //            레시피 1번            //
    //---------------------------------//
    if (liquorClickCounts['레몬주스따르기'] === 1 &&
        liquorClickCounts['스미노프따르기'] === 1 &&
        liquorClickCounts['오렌지주스따르기'] === 1 &&
        liquorClickCounts['봄베이따르기'] === 0 &&
        liquorClickCounts['럼따르기'] === 0 &&
        liquorClickCounts['달모어따르기'] === 0) {
        setTimeout(function () {
            imageElement.src = '/static/images/theHostel/barpage/갈색잔채우다.png';
            setTimeout(function () {
                imageElement.src = '/static/images/theHostel/barpage/갈색잔완성.png';
                thirdImageDisplayed = false;
                document.getElementById('close-button').style.display = 'block';
                addFinalClickArea("갈색술"); // 기존 레시피 - 갈색술
            }, 1000); // 1초 동안 특정 이미지를 표시한 후 원래 이미지로 돌아가기
        }, 500);
        return true;
    }

    //---------------------------------//
    //            레시피 2번            //
    //---------------------------------//
    if (liquorClickCounts['레몬주스따르기'] === 0 &&
        liquorClickCounts['스미노프따르기'] === 0 &&
        liquorClickCounts['오렌지주스따르기'] === 0 &&
        liquorClickCounts['봄베이따르기'] === 2 &&
        liquorClickCounts['럼따르기'] === 1 &&
        liquorClickCounts['달모어따르기'] === 2) {
        setTimeout(function () {
            imageElement.src = '/static/images/theHostel/barpage/보라잔채우다.png';
            setTimeout(function () {
                imageElement.src = '/static/images/theHostel/barpage/보라잔완성.png';
                thirdImageDisplayed = false;
                document.getElementById('close-button').style.display = 'block';
                addFinalClickArea("보라술"); // 새로운 레시피 - 보라술
            }, 1000); // 1초 동안 특정 이미지를 표시한 후 원래 이미지로 돌아가기
        }, 500);
        return true;
    }

    return false;
}


// 클릭 횟수를 초기화하는 함수
function resetLiquorClickCounts() {
    for (let key in liquorClickCounts) {
        liquorClickCounts[key] = 0;
    }
}

// 초기 영역 추가
addClickableAreas();

// wordle에서 돌아왔을 때 레시피를 추가
// window.onload 이벤트 수정
window.onload = function() {
    const selectedItem = localStorage.getItem("itemSelected");
    const boyfriendAreaClicked = localStorage.getItem("boyfriendAreaClicked") === 'true';

    if (selectedItem && selectedItem === '갈색술' && boyfriendAreaClicked) {
        imageElement.src = '/static/images/theHostel/barpage/내버려둬(잔x).png';
        otherAreaClicked = true;
        addCloseButton();
        removeClickableAreas(); // 영역 제거
        addPaperArea(); // 남자친구 클릭 시 추가 영역 생성
        displayMessage1('아, 술이 부족하군요. 신문을 한번 보시고 다른 레시피를 찾아 술을 더 마련해주시면 감사하겠습니다.');
        
        // 인벤토리에서 갈색 술 아이템 삭제-
        let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
        const itemIndex = inventory.indexOf('/static/images/theHostel/useritem/갈색술.png');
        if (itemIndex > -1) {
            inventory.splice(itemIndex, 1);
            localStorage.setItem('inventory', JSON.stringify(inventory));
        }

        localStorage.removeItem("itemSelected");
        localStorage.removeItem("boyfriendAreaClicked");
    }

    if (selectedItem && selectedItem === '보라술' && boyfriendAreaClicked) {
        imageElement.src = '/static/images/theHostel/barpage/내버려둬(잔x).png';
        otherAreaClicked = true;
        addCloseButton();
        removeClickableAreas(); // 영역 제거
        addPaperArea(); // 남자친구 클릭 시 추가 영역 생성
        displayMessage2('감사합니다. 여기 제 심장을 드릴께요. 소중히 다뤄주세요.', function() {
            // 인벤토리에서 보라 술 아이템 삭제
            let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
            const itemIndex = inventory.indexOf('/static/images/theHostel/useritem/보라술.png');
            if (itemIndex > -1) {
                inventory.splice(itemIndex, 1);
                localStorage.setItem('inventory', JSON.stringify(inventory));
            }
            

            // 인벤토리에 심장 추가
            if (!inventory.includes('/static/images/theHostel/useritem/심장.png')) {
                inventory.push('/static/images/theHostel/useritem/심장.png');
                localStorage.setItem('inventory', JSON.stringify(inventory));
            }

            alert('심장을 획득하였습니다.');
            localStorage.removeItem("itemSelected");
            localStorage.removeItem("boyfriendAreaClicked");
        });
    }

    const recipeWon = localStorage.getItem("recipeWon");

    if (recipeWon === "true") {
        // 레시피2를 인벤토리에 추가
        let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
        const itemExists = inventory.includes('/static/images/theHostel/useritem/레시피2.png');
        if (!itemExists) {
            inventory.push('/static/images/theHostel/useritem/레시피2.png');
            localStorage.setItem('inventory', JSON.stringify(inventory));
            alert('레시피를 획득하였습니다.');
        }

        localStorage.removeItem("recipeWon");
    }

    const purpleDrinkWon = localStorage.getItem("purpleDrinkWon");

    if (purpleDrinkWon === "true") {
        // 보라술을 인벤토리에 추가
        let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
        const itemExists = inventory.includes('/static/images/theHostel/useritem/보라술.png');
        if (!itemExists) {
            inventory.push('/static/images/theHostel/useritem/보라술.png');
            localStorage.setItem('inventory', JSON.stringify(inventory));
            alert('보라술을 획득하였습니다.');
        }

        localStorage.removeItem("purpleDrinkWon");
    }
}

// 모달 닫기 기능 추가
document.getElementById('recipe-modal').addEventListener('click', function() {
    this.style.display = 'none';
});
