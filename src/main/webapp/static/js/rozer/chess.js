function movePawn(element) {
    const audio = new Audio('music/2층체스상호작용.mp3');
    audio.play();
    // alert('폰 선택');
    const pawn = element;
    const row = parseInt(pawn.dataset.row);
    const col = parseInt(pawn.dataset.col);
    // alert(pawn.dataset.row + ` = pawn.dataset.row ` + pawn.dataset.col + ` = pawn.dataset.col`);
    const nextRow1Td = document.querySelector(`div[data-row="${row + 1}"][data-col="${col-1}"]`).parentElement;
    const nextRow2Td = document.querySelector(`div[data-row="${row + 2}"][data-col="${col}"]`).parentElement;

    // console.log(`div[data-row="${row + 1}"][data-col="${col-1}"]`);
    // console.log(`div[data-row="${row + 2}"][data-col="${col}"]`);
    // console.log(nextRow1Td);
    // console.log(nextRow2Td);


    if (row == 1) {
        if (nextRow1Td) {
            nextRow1Td.classList.add('possible-move');
        }
        if (nextRow2Td) {
            nextRow2Td.classList.add('possible-move');
        }
    } else {
        if (nextRow1Td) {
            nextRow1Td.classList.add('possible-move');
        }
    }

    const possibleMoves = document.querySelectorAll('.possible-move');
    possibleMoves.forEach(move => {
        move.addEventListener('click', () => {
            pawn.dataset.row = move.dataset.row;
            pawn.dataset.col = move.dataset.col;

            possibleMoves.forEach(m => m.classList.remove('possible-move'));

            move.appendChild(pawn);
        });
    });
}

// function movePawn(element) {
//     alert('폰 선택');
//     const pawn = event.target;
//     if (pawn && pawn.parentElement) {
//         // pawn이 null이 아니고, parentElement도 존재하는 경우에만 아래 코드를 실행
//         const currentPosition = pawn.parentElement.id;
        
//         const row = parseInt(pawn.dataset.row);
//         const col = parseInt(pawn.dataset.col);
//         alert(pawn.dataset.row + ` = pawn.dataset.row ` + pawn.dataset.col + ` = pawn.dataset.col`);
//         const nextRow1Td = document.querySelector(`div[data-row="${row + 1}"][data-col="${col}"]`).parentElement;
//         const nextRow2Td = document.querySelector(`div[data-row="${row + 2}"][data-col="${col}"]`).parentElement;

//         console.log(`div[data-row="${row + 1}"][data-col="${col}"]`);
//         console.log(`div[data-row="${row + 2}"][data-col="${col}"]`);
//         console.log(nextRow1Td);
//         console.log(nextRow2Td);

//         if (row == 1) {
//             if (nextRow1Td) {
//                 nextRow1Td.classList.add('possible-move');
//             }
//             if (nextRow2Td) {
//                 nextRow2Td.classList.add('possible-move');
//             }
//         } else {
//             if (nextRow1Td) {
//                 nextRow1Td.classList.add('possible-move');
//             }
//         }

//         const possibleMoves = document.querySelectorAll('.possible-move');
//         possibleMoves.forEach(move => {
//             move.addEventListener('click', () => {

//                 pawn.dataset.row = move.dataset.row;
//                 pawn.dataset.col = move.dataset.col;

//                 possibleMoves.forEach(m => m.classList.remove('possible-move'));

//                 pawn.classList.remove('black-pawn');

//                 move.appendChild(pawn);

//                 pawn.classList.add('black-pawn');
//             });
//         });
//     }
// }


var audio = new Audio('music/체스판bg.mp3');

const audioFiles = [
    'music/체스판 룩.mp3',
    'music/체스판 나이트.mp3',
    'music/체스판 비숍.mp3'
];

var audioFlag = 0;
function flag(){
    audioFlag = 1;
    if(audioFlag == 1)
        audio.play();
    else
        audio.play();
}

function moveRook() {
    audio.src = audioFiles[0];
    audio.play();
}

function moveKnight() {
    audio.src = audioFiles[1];
    audio.play();
}

function moveBishop() {
    audio.src = audioFiles[2];
    audio.play();
}


function moveQeen(element) {
    const audioQ = new Audio('../integ/짧은성가대.mp3');
    audioQ.play();
    setTimeout(() => {
        window.location.href = "https://vignette4.wikia.nocookie.net/freddy-fazbears-pizza/images/8/85/Fnaf4_jumpscare_bonnieindoorway.gif";
    }, 2000);
    // 박효신- 웃는남자 화면 
}