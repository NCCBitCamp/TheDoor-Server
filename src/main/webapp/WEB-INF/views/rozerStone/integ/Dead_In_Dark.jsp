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
        }
        .text_box {
            display: flex;
            justify-content: left;
            align-items: center;
            height: 100px;
            font-size: 1rem;
            margin: 20%;
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
        }
        .scary-image {
            display: none; /* 초기에는 이미지를 숨깁니다. */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 10;
            width: 50%;
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
    <img src="/static/images/rozer/integ/귀신1.png" class="scary-image" id="scaryImage">

    <script>
        const content = [
            { text: "쇠사슬 소리   ", audio: "/static/sounds/rozer/integ/쇠사슬소리.mp3" },
            { text: "바람소리", audio: "/static/sounds/rozer/integ/wind1.mp3" },
            { text: "끔찍한 소리"},
            { text: "곧이어 당신의 목을 누군가 조른다. 숨을 쉴 수 없다. 영원히...."}
        ];
        const textElement = document.querySelector(".text");
        const audioElement = document.getElementById("audio");
        const redirectButton = document.querySelector(".redirect-button");
        const scaryImage = document.getElementById("scaryImage");

        let index = 0;
        let charIndex = 0; //문장 길이
        let isDeleting = false; //지울까요? 물어보기

        function typing() {
            if (index < content.length) {
                if (!isDeleting && charIndex < content[index].text.length) {
                    textElement.innerHTML += content[index].text.charAt(charIndex); // 한 글자씩 출력
                    charIndex++; //그 다음 글자 대령
                } else if (isDeleting && charIndex > 0) {
                    textElement.innerHTML = content[index].text.substring(0, charIndex - 1); // 한 글자씩 지워
                    charIndex--; // 그 전 글자 대령
                } else if (!isDeleting && charIndex === content[index].text.length) {
                    playAudio(content[index].audio);
                    if (index === content.length - 1) { // 마지막 텍스트가 끝나면
                        setTimeout(() => {
                            redirectButton.style.display = 'block'; // 버튼을 보여줍니다.
                            scaryImage.style.display = 'block'; // 이미지 표시
                        }, 3000); // 3초 후에 버튼과 이미지를 나타냅니다.
                    }
                    isDeleting = true; // 지울까요?를 true 변환
                    setTimeout(typing, 4000); // 잠시 멈춤 후 지우기 시작
                    return;
                } else if (isDeleting && charIndex === 0) {
                    isDeleting = false; // 이제 그만지워라. 지울가요?를 false 변환
                    index++; // 다음줄로~
                    if (index < content.length) {
                        textElement.innerHTML += '<br>'; // 줄 바꿈 추가
                    }
                }
            } else {
                clearInterval(typingInterval);
            }
            setTimeout(typing, isDeleting ? 10 : 10); // 타이핑 속도와 지우기 속도 설정
        }

        function playAudio(audioSrc) {
            audioElement.src = audioSrc;
            audioElement.play();
        }

        typing(); // 글자 타이핑 시작
    </script>

</body>
</html>
