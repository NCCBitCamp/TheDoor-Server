document.addEventListener('DOMContentLoaded', (event) => {
    const draggables = document.querySelectorAll('.draggable');
    const dropzones = document.querySelectorAll('.dropzone');
    const itemZone = document.getElementById('item-zone');
    const stageImage = document.getElementById('stage-image');
    const envelopeImage = document.getElementById('envelope-image');
    let droppedItems = 0;

    draggables.forEach(draggable => {
        draggable.addEventListener('dragstart', (event) => {
            event.dataTransfer.setData('text/plain', event.target.dataset.id);
            event.dataTransfer.effectAllowed = 'move';  // 드래그 효과 설정
        });
    });

    dropzones.forEach(dropzone => {
        dropzone.addEventListener('dragover', (event) => {
            event.preventDefault();  // 기본 동작 방지
            event.dataTransfer.dropEffect = 'move';  // 드롭 효과 설정
        });

        dropzone.addEventListener('drop', (event) => {
            event.preventDefault();  // 기본 동작 방지
            const draggedId = event.dataTransfer.getData('text/plain');
            const dropzoneId = event.target.dataset.id;

            if (draggedId === dropzoneId) {
                const draggedElement = document.querySelector(`[data-id='${draggedId}']`);
                dropzone.appendChild(draggedElement);
                draggedElement.style.position = 'absolute';
                draggedElement.style.top = '50%';
                draggedElement.style.left = '50%';
                draggedElement.style.transform = 'translate(-50%, -50%)';
                droppedItems++;
                checkAllItemsDropped();
            } else {
                alert('여기가 아닌 것 같다...');
            }
        });
    });

    itemZone.addEventListener('dragover', (event) => {
        event.preventDefault();
        event.dataTransfer.dropEffect = 'move';
    });

    itemZone.addEventListener('drop', (event) => {
        event.preventDefault();
        const draggedId = event.dataTransfer.getData('text/plain');
        const draggedElement = document.querySelector(`[data-id='${draggedId}']`);
        itemZone.appendChild(draggedElement);
        draggedElement.style.position = 'relative';
        draggedElement.style.top = 'auto';
        draggedElement.style.left = 'auto';
        draggedElement.style.transform = 'none';
    });

    const inventory = JSON.parse(localStorage.getItem("inventory"));
    let idx = 1;

    inventory.forEach((ele) => {
        if(ele.includes("심장") || ele.includes("반지") || ele.includes("깨진액자") || ele.includes("쟁미")) {
            document.querySelector(`#draggable${idx}`).textContent = '';
            document.querySelector(`#draggable${idx}`).style.background = `url(${ele})`;
            document.querySelector(`#draggable${idx}`).style.backgroundColor = `white`;
            document.querySelector(`#draggable${idx}`).style.backgroundSize = 'contain';
            document.querySelector(`#draggable${idx}`).style.backgroundRepeat = 'no-repeat';
            document.querySelector(`#draggable${idx}`).style.backgroundPosition = 'center center';
            idx++;
        }
    });

    function checkAllItemsDropped() {
        if (droppedItems === 4) {
            // 모든 아이템이 드롭존에 올바르게 배치된 경우
            stageImage.classList.add('hidden'); // 무대 이미지 숨기기
            itemZone.classList.add('hidden'); // 아이템 존 숨기기
            dropzones.forEach(dropzone => dropzone.classList.add('hidden')); // 드롭존 숨기기
            envelopeImage.style.display = 'block'; // 편지봉투 이미지 보이기

            // 중복 방지를 위해 희귀 동전 추가 전에 인벤토리 확인
            let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
            if (!inventory.includes('/static/images/theHostel/useritem/동전.png')) {
                setTimeout(() => {
                    alert('희귀 동전을 얻었다.');
                    inventory.push('/static/images/theHostel/useritem/동전.png');
                    localStorage.setItem('inventory', JSON.stringify(inventory));
                    location.href = '/theHostel/left-wall.do';
                }, 2000);
            } else {
                setTimeout(() => {
                    alert('희귀 동전이 이미 인벤토리에 있습니다.');
                    location.href = '/theHostel/left-wall.do';
                }, 2000);
            }
        }
    }
});

function goToInventory() {
    window.location.href = "/theHostel/inventory.do";
}