<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="icon" href="../favicon-16x16.png">
    <style>
        body {
            background-color: black;
            color: white;
            position: relative;
            overflow: hidden;
        }
        .text_box {
            display: flex;
            justify-content: left;
            align-items: center;
            height: 100px;
            font-size: 1rem;
            margin: 20%;
            z-index: 1; /* 텍스트 박스를 이미지 위에 표시 */
        }
        .redirect-button {
            display: none; /* 초기에는 버튼을 숨깁니다. */
            margin-top: 20px;
            padding: 10px 20px;
            background-color: white;
            color: black;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            z-index: 2; /* 버튼을 이미지 위에 표시 */
        }
        .scary-image {
            display: none; /* 초기에는 이미지를 숨깁니다. */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: 0; /* 이미지가 텍스트 박스와 버튼 뒤에 표시 */
            opacity: 1; /* 초기 불투명도 */
            transition: opacity 4s ease-out; /* 4초 동안 천천히 사라지게 설정 */
        }
        .fade-out {
            opacity: 0; /* 사라지는 상태의 불투명도 */
        }
        .red-overlay {
            display: none; /* 초기에는 오버레이를 숨깁니다. */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: red;
            opacity: 0;
            z-index: 3; /* 오버레이가 텍스트 박스, 버튼 위에 표시 */
            transition: opacity 4s ease-out; /* 4초 동안 천천히 나타나게 설정 */
        }
        .fade-in-red {
            display: block;
            opacity: 0.5; /* 붉은 오버레이의 불투명도 */
        }
    </style>
</head>
<body>
    <div class="text_box" data-trigger>
        <span class="text"></span>
    </div>
    <audio id="audio"></audio>
<%--    링크이동만들기--%>
    <button class="redirect-button" onclick="location.href='the_door_main.html'">Go to Main Door</button>
    <img src="/static/images/rozer/integ/귀신2.gif" class="scary-image" id="scaryImage">
    <div class="red-overlay" id="redOverlay"></div>

    <script>
        const content = [
            { text: "   ", audio: "/static/sounds/rozer/integ/door-2.mp3" },
            { text: "....?" },
            { text: "소름돋는 여자는 내 눈을 파버린다.", audio: "/static/sounds/rozer/integ/성냥2.mp3" }
        ];
        const textElement = document.querySelector(".text");
        const audioElement = document.getElementById("audio");
        const redirectButton = document.querySelector(".redirect-button");
        const scaryImage = document.getElementById("scaryImage");
        const redOverlay = document.getElementById("redOverlay");

        let index = 0;
        let charIndex = 0;
        let isDeleting = false;

        function typing() {
            if (index < content.length) {
                if (!isDeleting && charIndex < content[index].text.length) {
                    textElement.innerHTML += content[index].text.charAt(charIndex);
                    charIndex++;
                } else if (isDeleting && charIndex > 0) {
                    textElement.innerHTML = content[index].text.substring(0, charIndex - 1);
                    charIndex--;
                } else if (!isDeleting && charIndex === content[index].text.length) {
                    playAudio(content[index].audio);
                    if (index === content.length - 1) {
                        setTimeout(() => {
                            redirectButton.style.display = 'block';
                        }, 3000);
                    }
                    if (index === 2) { // 마지막 텍스트가 시작되면 이미지 표시 및 붉은 오버레이
                        scaryImage.style.display = 'block';
                        redOverlay.style.display = 'block';
                        setTimeout(() => {
                            scaryImage.classList.add('fade-out');
                            redOverlay.classList.add('fade-in-red');
                        }, 4000); // 4초 후에 페이드 아웃 시작 및 붉은 오버레이 나타남
                    }
                    isDeleting = true;
                    setTimeout(typing, 4000);
                    return;
                } else if (isDeleting && charIndex === 0) {
                    isDeleting = false;
                    index++;
                    if (index < content.length) {
                        textElement.innerHTML += '<br>';
                    }
                }
            } else {
                clearInterval(typingInterval);
            }
            setTimeout(typing, isDeleting ? 10 : 100);
        }

        function playAudio(audioSrc) {
            if (audioSrc) {
                audioElement.src = audioSrc;
                audioElement.play();
            }
        }

        typing();
    </script>
</body>
</html>
