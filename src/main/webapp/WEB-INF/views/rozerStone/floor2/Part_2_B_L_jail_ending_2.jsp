<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
    <script src="/static/js/rozer/timer.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: black;
            display: flex;
            justify-content: center;
            align-items: flex-end;
            height: 100vh; /* 화면 전체 높이로 설정 */
            margin: 0;
        }
        .text_box { /*텍스트 디자인*/
            position: absolute;
            bottom: 25%; /* 텍스트가 이미지 위에 오도록 위치 조정 */
            color: black;
            z-index: 2; /* 텍스트를 이미지 위에 표시하기 위해 z-index 설정 */
            font-size: large;
            left: 38%;
        }
        .comment_area {
            position: absolute;
            bottom: 20%;
            width: 45%;
            left: 28%;
            z-index: 1; /* 이미지는 텍스트 아래로 배치 */
        }
        .bgimg {
            z-index: 0;
            width: 672px;
        }
        .fade-in-image {
            position: absolute;
            width: 10%;
            height: auto;
            top: 20%;
            left: 45%;
            opacity: 0;
            transition: opacity 1s;
            display: none;
            z-index: 3;
        }
        .fade-in {
            opacity: 1 !important;
        }
        .fullscreen {
            width: 100% !important;
            height: 100% !important;
            top: 0 !important;
            left: 0 !important;
        }
        .inventory_button {
            position: absolute;
            bottom: 5%;
            right: 5%;
            z-index: 3;
            background-color: white;
            color: black;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
        
    </style>
</head>
<body>
    <span>
        <div class="text_box" data-trigger>
            <span class="text"></span>
        </div>
        <div>
            <img src="/static/images/rozer/integ/comment_area_bloody2.png" class="comment_area" onclick="showNextDialogue()">
        </div>
        <img src="/static/images/rozer/integ/해골13.png" id="skull13" class="fade-in-image">
    </span>
    <script>
        const content = [
            { text: "뭐야...어디갔어", audio: "/static/sounds/rozer/integ/부스럭1.mp3" },
            { text: "어디갔어!!!!!!" },
            { text: "어디....어디로...어디로 간거야...", audio: "/static/sounds/rozer/integ/scream2.mp3" }
        ];
        const text = document.querySelector(".text");
        let dialogueIndex = 0;

        function showNextDialogue() {
            if (dialogueIndex < content.length) {
                const dialogue = content[dialogueIndex];
                text.innerHTML = dialogue.text;
                if (dialogue.audio) {
                    const audio = new Audio(dialogue.audio);
                    audio.play();
                }
                if (dialogueIndex === 2) {
                    showSkullSequence();
                }
                dialogueIndex++;
            }
        }

        function showSkullSequence() {
            const skullImages = ['skull13'];
            let index = 0;

            function showNextSkull() {
                if (index > 0 && index < skullImages.length - 1) {
                    document.getElementById(skullImages[index - 1]).style.display = 'none';
                }
                if (index < skullImages.length) {
                    const currentSkull = document.getElementById(skullImages[index]);
                    currentSkull.style.display = 'block';
                    setTimeout(() => {
                        currentSkull.classList.add('fade-in');
                    }, 100);
                    if (index === skullImages.length - 1) {
                        const laughAudio = new Audio('/static/sounds/rozer/integ/웃음소리1.mp3');
                        laughAudio.play();
                        document.body.style.backgroundColor = '#2A0A12'; // 검붉은색으로 배경 변경
                        setTimeout(() => {
                            text.innerHTML = "잠깐 다가오지 마... 다가오지 마........";
                            setTimeout(() => {
                                currentSkull.classList.add('fullscreen');
                                setTimeout(() => {
                                    document.body.style.backgroundColor = 'black';
                                    setTimeout(() => {
                                        window.location.href = "../../Main/index.html"; // 링크이동만들기
                                    }, 5000);
                                }, 1000);
                            }, 1000);
                        }, 2000);
                    }
                    index++;
                    setTimeout(showNextSkull, 2000);
                }
            }

            showNextSkull();
        }
        
    </script>
</body>
</html>
