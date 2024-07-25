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

function getItem(imageSrc) {
    let inventory = JSON.parse(localStorage.getItem('inventory')) || [];

    // 이미 아이템이 존재하는지 확인
    const itemExists = inventory.includes(imageSrc);
    if (itemExists) {
        alert("이미 같은 아이템이 인벤토리에 있습니다.");
        return;
    }

    if (inventory.length < 7) { // 인벤토리에 아이템이 7개 이하인 경우만 추가
        inventory.push(imageSrc);
        localStorage.setItem('inventory', JSON.stringify(inventory));
        alert("아이템이 추가되었습니다.");
    } else {
        alert("인벤토리가 가득 찼습니다.");
    }
}

//----------------------------//
//   모달 클릭으로 열기 단계    //
//----------------------------//
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
        // const modal = document.getElementById('purple-modal');
        // const modalImg = document.getElementById('purple-img'); <== 검토 후 삭제 결정
        history.back();
        itemSelected = '보라술';
        localStorage.setItem("itemSelected", itemSelected);
        alert('보라 술이 선택되었습니다.');
    } else if (item === '/static/images/theHostel/useritem/동전.png') {
        handleCoinClick(item);

        //---------------//
        // 모달 관련 코드 //
        //---------------//
    } else if (item === '/static/images/theHostel/useritem/심장.png') {
        let modal = document.getElementById('heart-modal');
        let modalImg = document.getElementById('heart-img');
        modalImg.src = item;
        modal.style.display = 'block';

    } else if (item === '/static/images/theHostel/useritem/깨진액자.png') {
        let modal = document.getElementById('photo-modal');
        let modalImg = document.getElementById('photo-img');
        modalImg.src = item;
        modal.style.display = 'block';

    } else if (item === '/static/images/theHostel/useritem/쟁미.png') {
        let modal = document.getElementById('rose-modal');
        let modalImg = document.getElementById('rose-img');
        modalImg.src = item;
        modal.style.display = 'block';

    } else if (item === '/static/images/theHostel/useritem/손목시계.png') {
        let modal = document.getElementById('watch-modal');
        let modalImg = document.getElementById('watch-img');
        modalImg.src = item;
        modal.style.display = 'block';

    } else if (item === '/static/images/theHostel/useritem/반지.png') {
        let modal = document.getElementById('ring-modal');
        let modalImg = document.getElementById('ring-img');
        modalImg.src = item;
        modal.style.display = 'block';
    }
}

// 동전 아이템 클릭 이벤트 처리 함수
function handleCoinClick(item) {
    if (item === '/static/images/theHostel/useritem/동전.png') {
        alert('동전을 넣었다.');
        localStorage.setItem("coinClick", true);
        location.href = "/theHostel/left-wall.do";

    }
}

function goToInventory() {
    window.location.href = "/theHostel/inventory.do";
}

// 우클릭 시 호출되는 함수
function onContextMenu(event, index) {
    event.preventDefault(); // 우클릭 메뉴가 뜨는 것을 방지
    removeItem(index); // 아이템 제거 함수 호출
}

// 아이템을 제거하는 함수
function removeItem(index) {
    let inventory = JSON.parse(localStorage.getItem('inventory')) || []; // 로컬 스토리지에서 인벤토리 데이터를 가져옴
    inventory.splice(index, 1); // 지정된 인덱스의 아이템을 제거
    localStorage.setItem('inventory', JSON.stringify(inventory)); // 변경된 인벤토리 데이터를 로컬 스토리지에 저장
    location.reload(); // 페이지를 새로고침하여 변경사항을 반영
    localStorage.setItem("coinClick", false); // <== 코인 삭제 해도 엔딩 장면 연결되서 추가함.
}

// 인벤 돌아가기 버튼 선택
function getBack() {
    // 뒤로 가기 기능 구현
    window.history.back();
}

//----------------------------//
//      모달 창 닫는 기능      //
//----------------------------//
document.getElementById('recipe-modal').addEventListener('click', function () {
    this.style.display = 'none';
});

document.getElementById('rose-modal').addEventListener('click', function () {
    this.style.display = 'none';
});

document.getElementById('watch-modal').addEventListener('click', function () {
    this.style.display = 'none';
});

document.getElementById('photo-modal').addEventListener('click', function () {
    this.style.display = 'none';
});

document.getElementById('heart-modal').addEventListener('click', function () {
    this.style.display = 'none';
});

document.getElementById('ring-modal').addEventListener('click', function () {
    this.style.display = 'none';
});