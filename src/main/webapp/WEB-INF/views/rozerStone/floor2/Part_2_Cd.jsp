<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
    <script src="/static/js/rozer/timer.js"></script>
    <link rel="icon" href="../favicon-16x16.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <div class="time-left" style="color: brown;"></div>
    <script src="/static/js/rozer/sharedTimer.js"></script>

    <!-- <script type="module">
        import { sharedTimer } from './sharedTimer.js';
      
        const urlParams = new URLSearchParams(window.location.search);
        const initialTimeLeft = parseInt(urlParams.get('timeLeft')) || 10;
        sharedTimer.startTimer(initialTimeLeft);
    </script> -->
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
        .middle{
            position: absolute;
            right: 32%;
            bottom: 35%;
            width: 35%;
        }
        .bgimg {
            z-index: 0;

            width: 672px;
        }
        img:hover{
            pointer-events: visiblePainted;
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
            <img src="/static/images/rozer/integ/Part_2_C_Dark.png" class="middle bgimg">
            <img src="/static/images/rozer/integ/comment_area_bloody.png" class="comment_area" onclick="redirectToNaver()">
        </div>
        <a href="/darkToLeft.do" class="carousel-control-prev" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a href="/darkToRight.do" class="carousel-control-next" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
        <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
    </div>
    </span>
    <script>
        const content = "너무 어둡다.. 어딘가 또 양초가 있지 않을까..?";
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

        // function redirectToNaver() {
        //     window.location.href = "Part_1_R.html";
        // }
        
        function getItem(imageSrc) {
            const audio = new Audio('/static/sounds/rozer/integ/아이템을획득.mp3');
            audio.play();
            let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
            if (inventory.length < 6) { // 인벤토리에 아이템이 6개 이하인 경우만 추가
                inventory.push(imageSrc);
                localStorage.setItem('inventory', JSON.stringify(inventory));
                alert("아이템이 추가되었습니다.");
            } else {
                alert("인벤토리가 가득 찼습니다.");
            }
        }

        function goToInventory() {
            window.location.href = "/inventory.do";
        }// 링크이동만들기
    </script>
</body>
</html>
