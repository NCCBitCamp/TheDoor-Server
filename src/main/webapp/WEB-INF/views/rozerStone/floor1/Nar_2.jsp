<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="../favicon-16x16.png">
    <title>RozerStone</title>
    <style>
        div {
            display: flex;
            justify-content: left;
            align-items: center;
            height: 100px;
            font-size: 1rem;
            color: rgb(121, 0, 0);
            margin: 20%;
        }
    </style>
</head>
<body style="background-color: black;">
    <div class="text_box" data-trigger>
        <span class="text"></span>
    </div>
    <audio id="audio"></audio>
    <script>
        const content = [
            { text: "그리고 현재"},
            { text: "수많은 사람들이 이 미스터리를 풀기 위해 도전했다.", audio: "static/sounds/rozer/integ/Nar_2_1.mp3" },
            { text: "하지만 미스터리를 풀기는커녕 대다수의 사람들이 이 미스터리를 풀다가 실종되고만다.", audio: "static/sounds/rozer/integ/Nar_2_2.mp3" },
            { text: "저주인걸까?", audio: "static/sounds/rozer/integ/Nar_2_3.mp3" },
            { text: "며칠 휴가를 사용해 나는 그곳을 방문해보기로 했다.", audio: "static/sounds/rozer/integ/Nar_2_4.mp3" },
            { text: ".....별일 있겠어?                  ", audio: "static/sounds/rozer/integ/Nar_2_5.mp3" }
        ];
        const textElement = document.querySelector(".text");
        const audioElement = document.getElementById("audio");

        let index = 0;
        let charIndex = 0;
        let typingInterval;

        function typing() {
            if (charIndex < content[index].text.length) {
                textElement.innerHTML += content[index].text.charAt(charIndex);
                charIndex++;
                setTimeout(typing, 100); // 타이핑 속도 설정
            } else {
                document.body.addEventListener('click', handleClick);
            }
        }

        function handleClick() {
            document.body.removeEventListener('click', handleClick);
            if (index < content.length - 1) {
                charIndex = 0;
                textElement.innerHTML = "";
                index++;
                playAudio(content[index].audio); // 오디오 재생
                typing(); // 다음 대사 타이핑 시작
            } else {
                location.href = 'Part_1_1_2.jsp'; // 마지막 대사 이후 페이지 이동
            }
        }

        function playAudio(audioSrc) {
            if (audioSrc) {
                audioElement.src = audioSrc;
                audioElement.load(); // 오디오 파일을 로드
                audioElement.play(); // 오디오 재생
            }
        }

        // 첫 번째 대사 및 오디오 재생 시작
        playAudio(content[index].audio);
        typing();
    </script>

</body>
</html>
