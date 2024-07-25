<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
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
        .modal {
            display: none; /* 기본적으로 숨김 */
            position: fixed; 
            z-index: 3; 
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto; 
            background-color: rgb(75,0,0); 
            background-color: rgba(75,0,0,0.4); 
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: rgb(75, 0, 0);
            margin: 15% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 80%; 
            max-width: 400px; 
            text-align: center; 
        }
        .modal-buttons {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }
        .modal-button {
            padding: 10px 20px;
            cursor: pointer;
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
    <img src="/static/images/rozer/integ/floor_1_dark.png" class="middle">
    <img src="/static/images/rozer/integ/comment_area_bloody.png" class="comment_area">

    <!-- Modal HTML -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <p>성냥을 사용하시겠습니까?</p>
            <div class="modal-buttons">
                <div class="modal-button" id="yesButton">예</div>
                <div class="modal-button" id="noButton">아니오</div>
            </div>
        </div>
    </div>

    <script>
        const content = "주머니에 성냥이 있다. 개당 3초 정도 볼 수 있을 것 같다.";
        const text = document.querySelector(".text");
        let i = 0;

        function typing(){
            if (i < content.length) {
                let txt = content.charAt(i);
                text.innerHTML += txt;
                i++;
            }
        }
        setInterval(typing, 100);

        const commentArea = document.querySelector('.comment_area');
        const modal = document.getElementById('myModal');
        const yesButton = document.getElementById('yesButton');
        const noButton = document.getElementById('noButton');

        commentArea.addEventListener('click', function() {
            modal.style.display = "flex"; // 모달 창 열기
        });

        yesButton.addEventListener('click', function() {
            playAudio('/static/sounds/rozer/integ/성냥1.mp3'); // 성냥 소리 재생 소리 키워야될듯
            modal.style.display = "none"; // 모달 창 닫기

        // 화면 반짝이는 효과 추가
        document.body.classList.add('flashing');
        setTimeout(() => {
            document.body.classList.remove('flashing');
            }, 1000);

        // 클릭 이벤트 종료 후 0.5초 후에 페이지 이동
        setTimeout(function() {
            // 링크 이동 수정
            window.location.href = 'Part_1_C.jsp';
            }, 500);
        });



        noButton.addEventListener('click', function() {
            modal.style.display = "none"; // 모달 창 닫기
            // 링크 이동 수정
            window.location.href = 'Dead_In_Dark.jsp'; // '아니오' 선택 시 이동
        });

        // 모달 창 외부를 클릭하면 닫기
        window.addEventListener('click', function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        });

        function playAudio(audioSrc) {
            const audio = new Audio(audioSrc);
            audio.play();
        }
    </script>
</body>
</html>
