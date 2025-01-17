<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
    <script src="/static/js/rozer/timer.js"></script>
    <link rel="icon" href="../favicon-16x16.png">
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
        }
        .comment_area {
            position: absolute;
            bottom: 20%;
            width: 45%;
            z-index: 1; /* 이미지는 텍스트 아래로 배치 */
        }
        .middle{
            position: absolute;
            align-items: center;
            bottom: 35%;
            width: 35%;
        }
        img .middle{
            background: black;
            z-index: 2;
        }

        @keyframes flash {
            0% {
                background-color: white;
            }
            20% {
                background-color: black;
            }
            60% {
                background-color: white;
            }
        }
        .flashing {
            animation: flash 1s infinite;
        }

    </style>
</head>
<body>
    <div class="text_box" data-trigger>
        <span class="text"></span>
    </div>
    <img class="middle">
    <img class="comment_area">
    <script>
        const content = ". . .";
        const text = document.querySelector(".text");
        const comment_area = document.querySelector(".comment_area");
        let i = 0;

        function typing() {
            comment_area.src = "/static/images/rozer/integ/comment_area_bloody.png";
            if (i < content.length) {
                let txt = content.charAt(i);
                text.innerHTML += txt;
                i++;
            } 
            else {
                // playAudio('성냥1.mp3'); // 성냥 소리 재생 소리 키우기 가능한가?
                document.body.classList.add('flashing');
                setTimeout(() => {
                    document.body.classList.remove('flashing');
                    }, 1000)

                // 클릭 이벤트 종료 후 0.5초 후에 페이지 이동
                setTimeout(function() {
                    window.location.href = '/lightToRight.do'; // 링크이동만들기
                    }, 500)
            }
        }


        setInterval(typing, 100);

        function playAudio(audioSrc) {
            const audio = new Audio(audioSrc);
            audio.play();
        }

    </script>
</body>
</html>
