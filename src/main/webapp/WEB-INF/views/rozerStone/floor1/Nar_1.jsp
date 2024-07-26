<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
    <link rel="icon" href="../favicon-16x16.png">
    <style>
        body {
            height: 99%;
            width: 99%;
        }

        body div {
            display: flex;
            justify-content: left;
            align-items: center;
            height: 100px;
            font-size: 1rem;
            color: white;
            margin: 20%;
        }
        #skipButton {
            background: rgba(0, 0, 0, 0.5);
            color: rgb(238, 170, 170);
            font-weight: bold;
        }
    </style>
</head>
<body style="background-color: black;">
    <div style="display: flex; justify-content: center; align-items: center; margin-top: 10px; height: 12px;">
        <button type="button" id="skipButton" name="skipButton" onclick="location.href='Nar_2.jsp'">Skip</button>
    </div>
    <div class="text_box" data-trigger>
        <span class="text" style="color: brown;"></span>
    </div>
    <audio id="audio" autoplay></audio>
    <script>
        const content = [
            { text: " Rozer Stone " },
            { text: "1584년 월터 롤리 경은 로어노크 섬을 발견한다.", audio: "static/sounds/rozer/integ/Nar_1_1.mp3" },
            { text: "1587년 존 화이트가 이끄는 2차 식민지 원정대는 1차 원정대의 실패요인을 원주민과의 관계 악화가 원인이라고 판단했다.", audio: "static/sounds/rozer/integ/Nar_1_3.mp3" },
            { text: "2차 식민지 원정대는 원인을 분석해 그들과의 관계 개선을 시도하여 성공한다.", audio: "static/sounds/rozer/integ/드르륵1.mp3" },
            { text: "하지만 . . .", audio: "static/sounds/rozer/integ/Nar_1_4.mp3" },
            { text: "존 화이트가 본국인 영국에 보고하러간 사이 영국은 에스파냐와 100년 전쟁을 시작한다.", audio: "static/sounds/rozer/integ/Nar_1_5.mp3" },
            { text: "로어노크 식민지는 고립되었다.", audio: "static/sounds/rozer/integ/Nar_1_6.mp3" },
            { text: "화이트가 다시 왔을 땐 정적과 고요로 가득찼다. 모두 어디론가 증발했다.   >skip", audio: "static/sounds/rozer/integ/Nar_1_6_2.mp3" }
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
                location.href = '/nar1ToNar2.do'; // 마지막 대사 이후 페이지 이동
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

