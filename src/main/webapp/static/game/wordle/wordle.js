const WORDS = "crush"; // 정답 단어 설정
const NUMBER_OF_GUESSES = 6; // 최대 시도 횟수
let guessesRemaining = NUMBER_OF_GUESSES; // 남은 시도 횟수
let currentGuess = []; // 현재 시도 중인 단어
let nextLetter = 0; // 현재 시도 중인 단어의 다음 글자 위치
let rightGuessString = WORDS; // 정답 단어

// 게임 보드를 초기화하는 함수
function initBoard() {
    let board = document.getElementById("game-board");

    // 게임 보드 행 초기화
    for (let i = 0; i < NUMBER_OF_GUESSES; i++) {
        let row = document.createElement("div");
        row.className = "letter-row";

        // 각 행에 5개의 상자 생성
        for (let j = 0; j < 5; j++) {
            let box = document.createElement("div");
            box.className = "letter-box";
            row.appendChild(box);
        }

        board.appendChild(row);
    }
}

// 키보드의 색상을 변경하는 함수
function shadeKeyBoard(letter, color) {
    for (const elem of document.getElementsByClassName("keyboard-button")) {
        if (elem.textContent === letter) {
            let oldColor = elem.style.backgroundColor;

            // 이미 초록색인 경우 변경하지 않음
            if (oldColor === "green") {
                return;
            }

            // 노란색이면서 새로운 색이 초록색이 아닌 경우 변경하지 않음
            if (oldColor === "yellow" && color !== "green") {
                return;
            }

            // 색상을 지정된 색으로 변경
            elem.style.backgroundColor = color;
            break;
        }
    }
}

// 마지막 입력된 글자를 삭제하는 함수
function deleteLetter() {
    let row = document.getElementsByClassName("letter-row")[6 - guessesRemaining];
    let box = row.children[nextLetter - 1];

    // 상자의 내용을 지우고 클래스 제거
    box.textContent = "";
    box.classList.remove("filled-box");

    // 현재 시도 중인 단어에서 마지막 글자 제거
    currentGuess.pop();
    nextLetter -= 1;
}

// 사용자가 입력한 단어를 검사하는 함수
function checkGuess() {
    let row = document.getElementsByClassName("letter-row")[6 - guessesRemaining];
    let guessString = "";
    let rightGuess = Array.from(rightGuessString);

    // 현재 시도 중인 단어 문자열 생성
    for (const val of currentGuess) {
        guessString += val;
    }

    // 입력된 글자가 5개가 아닌 경우 오류 메시지 출력
    if (guessString.length != 5) {
        toastr.error("Not enough letters!");
        return;
    }

    var letterColor = ["gray", "gray", "gray", "gray", "gray"];

    // 정답과 비교하여 초록색 및 노란색으로 색칠
    for (let i = 0; i < 5; i++) {
        if (rightGuess[i] == currentGuess[i]) {
            letterColor[i] = "green";
            rightGuess[i] = "#"; // 이미 사용된 정답 글자는 '#'으로 표시
        }
    }

    for (let i = 0; i < 5; i++) {
        if (letterColor[i] == "green") continue;

        for (let j = 0; j < 5; j++) {
            if (rightGuess[j] == currentGuess[i]) {
                letterColor[i] = "yellow";
                rightGuess[j] = "#"; // 이미 사용된 정답 글자는 '#'으로 표시
            }
        }
    }

    // 각 상자에 애니메이션과 색상 적용
    for (let i = 0; i < 5; i++) {
        let box = row.children[i];
        let delay = 250 * i;

        setTimeout(() => {
            animateCSS(box, "flipInX"); // 상자에 회전 애니메이션 적용
            box.style.backgroundColor = letterColor[i]; // 상자 색상 변경
            shadeKeyBoard(guessString.charAt(i) + "", letterColor[i]); // 키보드 버튼 색상 변경
        }, delay);
    }

    // 정답을 맞췄을 경우 처리
    if (guessString === rightGuessString) {
        toastr.success("collect!! you won!!");
        console.log("winner");

        // 레시피 정보를 localStorage에 저장
        localStorage.setItem("recipeWon", "true");

        // 보라술 관련 로직 추가
        // if (someConditionToCheckPurpleDrink) {
        //   localStorage.setItem("purpleDrinkWon", "true");
        // }
        setTimeout(() => {
            window.location.href = "/theHostel/the-bar.do";
        }, 2000);
        return;
    } else {
        // 정답이 아닌 경우 시도 횟수 감소 및 초기화
        guessesRemaining -= 1;
        currentGuess = [];
        nextLetter = 0;

        // 시도 횟수가 남아있지 않은 경우 게임 종료 메시지 표시
        // if (guessesRemaining === 0) {
        //   toastr.error("You've run out of guesses! Game over!");
        //   toastr.info(`The right word was: "${rightGuessString}"`);
        // }
    }
}

// 사용자가 입력한 글자를 상자에 추가하는 함수
function insertLetter(pressedKey) {
    if (nextLetter === 5) {
        return;
    }
    pressedKey = pressedKey.toLowerCase();

    let row = document.getElementsByClassName("letter-row")[6 - guessesRemaining];
    let box = row.children[nextLetter];

    animateCSS(box, "pulse"); // 상자에 펄스 애니메이션 적용
    box.textContent = pressedKey; // 상자에 글자 추가
    box.classList.add("filled-box"); // 상자에 클래스 추가

    currentGuess.push(pressedKey); // 사용자가 입력한 글자를 현재 시도 중인 단어에 추가
    nextLetter += 1; // 다음 위치로 이동
}

// CSS 애니메이션을 적용하는 함수
const animateCSS = (element, animation, prefix = "animate__") =>
    new Promise((resolve, reject) => {
        const animationName = `${prefix}${animation}`;
        const node = element;
        node.style.setProperty("--animate-duration", "0.3s");

        node.classList.add(`${prefix}animated`, animationName);

        function handleAnimationEnd(event) {
            event.stopPropagation();
            node.classList.remove(`${prefix}animated`, animationName);
            resolve("Animation ended");
        }

        node.addEventListener("animationend", handleAnimationEnd, { once: true });
    });

// 키보드 입력 이벤트 리스너
document.addEventListener("keyup", (e) => {
    if (guessesRemaining === 0) {
        return;
    }

    let pressedKey = String(e.key);
    if (pressedKey === "Backspace" && nextLetter !== 0) {
        deleteLetter(); // Backspace 키가 눌리면 마지막 글자 삭제
        return;
    }

    if (pressedKey === "Enter") {
        checkGuess(); // Enter 키가 눌리면 단어 검사
        return;
    }

    let found = pressedKey.match(/[a-z]/gi);
    if (!found || found.length > 1) {
        return; // 알파벳이 아닌 키는 무시
    } else {
        insertLetter(pressedKey); // 알파벳 키가 눌리면 글자 추가
    }
});

// 화면의 키보드 버튼 클릭 이벤트 리스너
document.getElementById("keyboard-cont").addEventListener("click", (e) => {
    const target = e.target;

    if (!target.classList.contains("keyboard-button")) {
        return;
    }
    let key = target.textContent;

    if (key === "Del") {
        key = "Backspace";
    }

    document.dispatchEvent(new KeyboardEvent("keyup", { key: key })); // 클릭된 키를 가상으로 입력
});

initBoard(); // 게임 보드 초기화



// 뒤로 가기 버튼 클릭 이벤트 리스너
document.getElementById('back-button').addEventListener('click', function () {
    window.location.href = '/theHostel/the-bar.do'; // 이전 페이지로 이동
});
