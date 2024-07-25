<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>컴퓨터</title>
    <script src="/static/js/bitCamp/timer.js"></script>
    <link rel="icon" href="/static/images/bitCamp/bitcamp_favicon.ico" type="image/x-icon">
    <style>
        html {
            height: 100%;
        }

        body {
            height: 100%;
            min-width: 400px;
            margin: 0;
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background: rgb(32, 32, 32);
        }

        .container {
            position: absolute;
            bottom: 0;
            top: 0;
            left: 0;
            right: 0;
            text-align: center;
        }

        .center {
            margin: 0 auto;
        }

        .btn {
            margin: 8px 4px 0;
        }

        .btn {
            width: 172px;
            height: 28px;
        }

        .line {
            height: 2em;
        }

        .word,
        .clue {
            display: inline-block;
            height: 1.5em;
            padding: 0 5px;
        }

        .word {
            text-align: right;
            width: 100px;
        }

        .clue {
            width: 500px;
        }

        .crossword {
            display: block;
            background-color: rgb(32, 32, 32);
        }

        .square {
            margin: 0 1px 1px 0;
            display: inline-block;
            font: 24px Calibri;
            width: 1.25em;
            height: 1.25em;
            line-height: 1.25em;
            vertical-align: middle;
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        .letter {
            background-color: rgb(255, 255, 255);
            -webkit-touch-callout: text;
            -webkit-user-select: text;
            -khtml-user-select: text;
            -moz-user-select: text;
            -ms-user-select: text;
            user-select: text;
        }

        .char:focus {
            -webkit-box-shadow: 0 0 0 2px rgba(255, 32, 32, 1);
            -moz-box-shadow: 0 0 0 2px rgba(255, 32, 32, 1);
            box-shadow: inset 0 0 0 2px rgba(255, 32, 32, 1);
        }

        .char {
            font-size: 24px;
            text-transform: uppercase;
            outline: 0;
            border: 0;
            padding: 0;
            margin: -1px 0 0 -1px;
            width: 1.35em;
            height: 1.35em;
            text-align: center;
            background: none;
        }

        .hide {
            visibility: hidden;
        }

        .clueReadOnly {
            border: 0;
            outline: 0;
            color: #ffffff !important;
            background: none;
            font-size: 1rem;
        }

        @font-face {
            font-family: 'KyoboHandwriting2023wsa';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404-2@1.0/KyoboHandwriting2023wsa.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }
    </style>
</head>

<body>
<div id="dialogueBox" style="position: absolute; bottom: 100px; left: 50%; transform: translateX(-50%); background: url('/static/images/bitCamp/wallpaper-torn-paper-ripped-white-paper.png'); background-size: cover; padding: 20px; font-family: 'KyoboHandwriting2023wsa'; font-size: 24px; display: none; cursor: pointer; z-index: 1000;">
    앗, 이건 뭐지?
</div>
<div class="container">
    <button class="btn" id="btnCreate">Create</button>
    <button class="btn" id="btnPlay">Play</button>
    <button class="btn" id="btnSubmit">Submit</button>
    <div id="timer" style="position: absolute; top: 10px; left: 10px; font-size: 24px; font-family: 'KyoboHandwriting2023wsa'; color: red;"></div>
    <br /><br />

    <div class="center crossword" id="crossword"></div><br />

    <div class="center">
        <div class="line">
            <input class="word" type="text" value="Bitcamp" />
            <input class="clue" value="BitCamp: 비트캠프 학원을 칭하는 단어" />
        </div>
        <div class="line">
            <input class="word" type="text" value="Accident" />
            <input class="clue" value="Accident: 뜻밖에 일어난 불행한 일" />
        </div>
        <div class="line">
            <input class="word" type="text" value="Stupidity" />
            <input class="clue" value="Stupidity: 깨끗이 잊지 못하고 끌리는 데가 남아 있는 마음" />
        </div>
        <div class="line">
            <input class="word" type="text" value="Winner" />
            <input class="clue" value="Winner: 특정 종목 따위에서 이겨 첫째를 차지함" />
        </div>
        <div class="line">
            <input class="word" type="text" value="Friendship" />
            <input class="clue" value="Friendship: 친구 사이의 정" />
        </div>
        <div class="line">
            <input class="word" type="text" value="Friend" />
            <input class="clue" value="Friend: 가깝게 오래 사귄 사람" />
        </div>
        <div class="line">
            <input class="word" type="text" value="Envy" />
            <input class="clue" value="Envy: 우월한 사람을 시기하는 일" />
        </div>
        <div class="line">
            <input class="word" type="text" value="July" />
            <input class="clue" value="July: 7번째 달" />
        </div>
        <div class="line">
            <input class="word" type="text" value="Regret" />
            <input class="clue" value="Regret: 이전의 잘못을 깨치고 뉘우침" />
        </div>
    </div>
</div>
<script>
    window.addEventListener('load', function() {
        // 현재 상태를 추가합니다.
        history.pushState(null, '', location.href);

        // popstate 이벤트를 처리합니다.
        window.addEventListener('popstate', function(event) {
            // 다시 현재 상태로 돌아갑니다.
            history.pushState(null, '', location.href);
            // 경고 메시지를 표시합니다.
            alert('도망칠 수 없습니다.');
        });

        // beforeunload 이벤트를 처리합니다.
        window.addEventListener('beforeunload', function(event) {
            history.pushState(null, '', location.href);
            // 경고 메시지를 표시합니다.
            alert('도망칠 수 없습니다.');
        });
    });


    document.addEventListener('DOMContentLoaded', () => {
        let remainingTime = localStorage.getItem('remainingTime');
        let timerText = document.getElementById('timer');

        // Show the dialogue box on page load
        let dialogueBox = document.getElementById('dialogueBox');
        dialogueBox.style.display = 'block';

        const dialogues = [
            "앗, 이건 뭐지?",
            "어쩐지 이 문제를 풀어야만 할 것 같은 기분이다.",
            "조금 살펴볼까?"
        ];

        let currentDialogueIndex = 0;

        dialogueBox.addEventListener('click', () => {
            currentDialogueIndex++;
            if (currentDialogueIndex < dialogues.length) {
                dialogueBox.innerText = dialogues[currentDialogueIndex];
            } else {
                dialogueBox.style.display = 'none';
            }
        });

        if (remainingTime !== null) {
            startTimer(parseInt(remainingTime));
        } else {
            startTimer(300); // 기본 시간 300초
        }

        function startTimer(duration) {
            let timer = duration;

            const timerInterval = setInterval(() => {
                let minutes = Math.floor(timer / 60);
                let seconds = timer % 60;
                seconds = seconds < 10 ? '0' + seconds : seconds;

                timerText.textContent = `${minutes}:${seconds}`;
                timer--;

                localStorage.setItem('remainingTime', timer); // 타이머 값 저장

                if (timer < 0) {
                    clearInterval(timerInterval);
                    showGameOver();
                }
            }, 1000);
        }

        function showGameOver() {
            // 타이머 값을 초기화
            localStorage.setItem('remainingTime', 300);

            // 게임 오버 화면을 보여주는 HTML 요소를 생성
            let gameOverScreen = document.createElement('div');
            gameOverScreen.style.position = 'fixed';
            gameOverScreen.style.top = '0';
            gameOverScreen.style.left = '0';
            gameOverScreen.style.width = '100%';
            gameOverScreen.style.height = '100%';
            gameOverScreen.style.backgroundColor = 'rgba(0, 0, 0, 1)';
            gameOverScreen.style.display = 'flex';
            gameOverScreen.style.justifyContent = 'center';
            gameOverScreen.style.alignItems = 'center';
            gameOverScreen.style.zIndex = '1000';

            let gameOverText = document.createElement('div');
            gameOverText.style.fontFamily = 'KyoboHandwriting2023wsa';
            gameOverText.style.fontSize = '64px';
            gameOverText.style.color = '#ffffff';
            gameOverText.innerText = 'Game Over';

            gameOverScreen.appendChild(gameOverText);
            document.body.appendChild(gameOverScreen);

            // 3초 후 floor2.html로 이동
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/bitCamp/floor2.do';
            }, 3000);
        }

    });

    document.getElementById('btnCreate').disabled = true;

    //---------------------------------//
    //   GLOBAL VARIABLES              //
    //---------------------------------//

    var board, wordArr, wordBank, wordsActive, mode;

    var Bounds = {
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,

        Update: function (x, y) {
            this.top = Math.min(y, this.top);
            this.right = Math.max(x, this.right);
            this.bottom = Math.max(y, this.bottom);
            this.left = Math.min(x, this.left);
        },

        Clean: function () {
            this.top = 999;
            this.right = 0;
            this.bottom = 0;
            this.left = 999;
        }
    };

    //---------------------------------//
    //   MAIN                          //
    //---------------------------------//

    function Play() {
        var letterArr = document.getElementsByClassName("letter");

        for (var i = 0; i < letterArr.length; i++) {
            letterArr[i].innerHTML =
                "<input class='char' type='text' maxlength='1'></input>";
        }

        mode = 0;
        ToggleInputBoxes(false);
    }

    function Create() {
        if (mode === 0) {
            ToggleInputBoxes(true);
            document.getElementById("crossword").innerHTML = BoardToHtml(" ");
            mode = 1;
        } else {
            GetWordsFromInput();

            for (var i = 0, isSuccess = false; i < 10 && !isSuccess; i++) {
                CleanVars();
                isSuccess = PopulateBoard();
            }

            document.getElementById("crossword").innerHTML = isSuccess
                ? BoardToHtml(" ")
                : "Failed to find crossword.";
        }
    }

    function ToggleInputBoxes(active) {
        var w = document.getElementsByClassName("word"),
            d = document.getElementsByClassName("clue");

        for (var i = 0; i < w.length; i++) {
            if (active === true) {
                RemoveClass(w[i], "hide");
                RemoveClass(d[i], "clueReadOnly");
                d[i].disabled = "";
            } else {
                AddClass(w[i], "hide");
                AddClass(d[i], "clueReadOnly");
                d[i].disabled = "readonly";
            }
        }
    }

    function GetWordsFromInput() {
        wordArr = [];
        for (
            var i = 0, val, w = document.getElementsByClassName("word");
            i < w.length;
            i++
        ) {
            val = w[i].value.toUpperCase();
            if (val !== null && val.length > 1) {
                wordArr.push(val);
            }
        }
    }

    function CleanVars() {
        Bounds.Clean();
        wordBank = [];
        wordsActive = [];
        board = [];

        for (var i = 0; i < 32; i++) {
            board.push([]);
            for (var j = 0; j < 32; j++) {
                board[i].push(null);
            }
        }
    }

    function PopulateBoard() {
        PrepareBoard();

        for (var i = 0, isOk = true, len = wordBank.length; i < len && isOk; i++) {
            isOk = AddWordToBoard();
        }
        return isOk;
    }

    function PrepareBoard() {
        wordBank = [];

        for (var i = 0, len = wordArr.length; i < len; i++) {
            wordBank.push(new WordObj(wordArr[i]));
        }

        for (i = 0; i < wordBank.length; i++) {
            for (var j = 0, wA = wordBank[i]; j < wA.char.length; j++) {
                for (var k = 0, cA = wA.char[j]; k < wordBank.length; k++) {
                    for (var l = 0, wB = wordBank[k]; k !== i && l < wB.char.length; l++) {
                        wA.totalMatches += cA === wB.char[l] ? 1 : 0;
                    }
                }
            }
        }
    }

    // TODO: Clean this guy up
    function AddWordToBoard() {
        var i,
            len,
            curIndex,
            curWord,
            curChar,
            curMatch,
            testWord,
            testChar,
            minMatchDiff = 9999,
            curMatchDiff;

        if (wordsActive.length < 1) {
            curIndex = 0;
            for (i = 0, len = wordBank.length; i < len; i++) {
                if (wordBank[i].totalMatches < wordBank[curIndex].totalMatches) {
                    curIndex = i;
                }
            }
            wordBank[curIndex].successfulMatches = [{ x: 12, y: 12, dir: 0 }];
        } else {
            curIndex = -1;

            for (i = 0, len = wordBank.length; i < len; i++) {
                curWord = wordBank[i];
                curWord.effectiveMatches = 0;
                curWord.successfulMatches = [];
                for (var j = 0, lenJ = curWord.char.length; j < lenJ; j++) {
                    curChar = curWord.char[j];
                    for (var k = 0, lenK = wordsActive.length; k < lenK; k++) {
                        testWord = wordsActive[k];
                        for (var l = 0, lenL = testWord.char.length; l < lenL; l++) {
                            testChar = testWord.char[l];
                            if (curChar === testChar) {
                                curWord.effectiveMatches++;

                                var curCross = { x: testWord.x, y: testWord.y, dir: 0 };
                                if (testWord.dir === 0) {
                                    curCross.dir = 1;
                                    curCross.x += l;
                                    curCross.y -= j;
                                } else {
                                    curCross.dir = 0;
                                    curCross.y += l;
                                    curCross.x -= j;
                                }

                                var isMatch = true;

                                for (var m = -1, lenM = curWord.char.length + 1; m < lenM; m++) {
                                    var crossVal = [];
                                    if (m !== j) {
                                        if (curCross.dir === 0) {
                                            var xIndex = curCross.x + m;

                                            if (xIndex < 0 || xIndex > board.length) {
                                                isMatch = false;
                                                break;
                                            }

                                            crossVal.push(board[xIndex][curCross.y]);
                                            crossVal.push(board[xIndex][curCross.y + 1]);
                                            crossVal.push(board[xIndex][curCross.y - 1]);
                                        } else {
                                            var yIndex = curCross.y + m;

                                            if (yIndex < 0 || yIndex > board[curCross.x].length) {
                                                isMatch = false;
                                                break;
                                            }

                                            crossVal.push(board[curCross.x][yIndex]);
                                            crossVal.push(board[curCross.x + 1][yIndex]);
                                            crossVal.push(board[curCross.x - 1][yIndex]);
                                        }

                                        if (m > -1 && m < lenM - 1) {
                                            if (crossVal[0] !== curWord.char[m]) {
                                                if (crossVal[0] !== null) {
                                                    isMatch = false;
                                                    break;
                                                } else if (crossVal[1] !== null) {
                                                    isMatch = false;
                                                    break;
                                                } else if (crossVal[2] !== null) {
                                                    isMatch = false;
                                                    break;
                                                }
                                            }
                                        } else if (crossVal[0] !== null) {
                                            isMatch = false;
                                            break;
                                        }
                                    }
                                }

                                if (isMatch === true) {
                                    curWord.successfulMatches.push(curCross);
                                }
                            }
                        }
                    }
                }

                curMatchDiff = curWord.totalMatches - curWord.effectiveMatches;

                if (curMatchDiff < minMatchDiff && curWord.successfulMatches.length > 0) {
                    curMatchDiff = minMatchDiff;
                    curIndex = i;
                } else if (curMatchDiff <= 0) {
                    return false;
                }
            }
        }

        if (curIndex === -1) {
            return false;
        }

        var spliced = wordBank.splice(curIndex, 1);
        wordsActive.push(spliced[0]);

        var pushIndex = wordsActive.length - 1,
            rand = Math.random(),
            matchArr = wordsActive[pushIndex].successfulMatches,
            matchIndex = Math.floor(rand * matchArr.length),
            matchData = matchArr[matchIndex];

        wordsActive[pushIndex].x = matchData.x;
        wordsActive[pushIndex].y = matchData.y;
        wordsActive[pushIndex].dir = matchData.dir;

        for (i = 0, len = wordsActive[pushIndex].char.length; i < len; i++) {
            var xIndex = matchData.x,
                yIndex = matchData.y;

            if (matchData.dir === 0) {
                xIndex += i;
                board[xIndex][yIndex] = wordsActive[pushIndex].char[i];
            } else {
                yIndex += i;
                board[xIndex][yIndex] = wordsActive[pushIndex].char[i];
            }

            Bounds.Update(xIndex, yIndex);
        }

        return true;
    }

    function BoardToHtml(blank) {
        for (var i = Bounds.top - 1, str = ""; i < Bounds.bottom + 2; i++) {
            str += "<div class='row'>";
            for (var j = Bounds.left - 1; j < Bounds.right + 2; j++) {
                str += BoardCharToElement(board[j][i]);
            }
            str += "</div>";
        }
        return str;
    }

    function BoardCharToElement(c) {
        var arr = c ? ["square", "letter"] : ["square"];
        return EleStr("div", [{ a: "class", v: arr }, { a: "data-letter", v: c || "" }], c ? "<input class='char' type='text' maxlength='1'>" : "");
    }


    //---------------------------------//
    //   OBJECT DEFINITIONS            //
    //---------------------------------//

    function WordObj(stringValue) {
        this.string = stringValue;
        this.char = stringValue.split("");
        this.totalMatches = 0;
        this.effectiveMatches = 0;
        this.successfulMatches = [];
    }

    //---------------------------------//
    //   EVENTS                        //
    //---------------------------------//

    function RegisterEvents() {
        document.getElementById("crossword").onfocus = function () {
            return false;
        };
        document.getElementById("btnCreate").addEventListener("click", Create, false);
        document.getElementById("btnPlay").addEventListener("click", Play, false);
        document.getElementById("btnSubmit").addEventListener("click", Submit, false);
    }
    RegisterEvents();

    //---------------------------------//
    //   HELPER FUNCTIONS              //
    //---------------------------------//

    function EleStr(e, c, h) {
        h = h ? h : "";
        for (var i = 0, s = "<" + e + " "; i < c.length; i++) {
            s += c[i].a + "='" + ArrayToString(c[i].v, " ") + "' ";
        }
        return s + ">" + h + "</" + e + ">";
    }

    function ArrayToString(a, s) {
        if (a === null || a.length < 1) return "";
        if (s === null) s = ",";
        for (var r = a[0], i = 1; i < a.length; i++) {
            r += s + a[i];
        }
        return r;
    }

    function AddClass(ele, classStr) {
        ele.className = ele.className.replaceAll(" " + classStr, "") + " " + classStr;
    }

    function RemoveClass(ele, classStr) {
        ele.className = ele.className.replaceAll(" " + classStr, "");
    }

    function ToggleClass(ele, classStr) {
        var str = ele.className.replaceAll(" " + classStr, "");
        ele.className =
            str.length === ele.className.length ? str + " " + classStr : str;
    }

    String.prototype.replaceAll = function (replaceThis, withThis) {
        var re = new RegExp(replaceThis, "g");
        return this.replace(re, withThis);
    };

    //---------------------------------//
    //   INITIAL LOAD                  //
    //---------------------------------//

    Create();
    Play();

    //---------------------------------//
    //   SUBMIT FUNCTION               //
    //---------------------------------//

    function Submit() {
        var letterArr = document.getElementsByClassName("letter");
        var correct = true;

        for (var i = 0; i < letterArr.length; i++) {
            var input = letterArr[i].querySelector("input");
            if (input) {
                var correctLetter = letterArr[i].getAttribute('data-letter').toUpperCase();
                if (input.value.toUpperCase() !== correctLetter) {
                    correct = false;
                } else {
                    input.style.backgroundColor = "green";
                }
            }
        }

        if (correct) {
            alert("정답입니다. 이전 위치로 돌아갑니다.");
            localStorage.setItem('returnedFromGame', 'true');
            localStorage.setItem('nya', 'true');
            window.location.href = "${pageContext.request.contextPath}/bitCamp/201Room.do";
        } else {
            alert("오답입니다. 다시 시도해주세요.");
        }
    }



</script>
</body>

</html>