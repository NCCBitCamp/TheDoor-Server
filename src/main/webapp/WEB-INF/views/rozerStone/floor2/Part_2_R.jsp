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
    <style>
        body {
            background-color: black;
            display: flex;
            justify-content: center;
            align-items: flex-end;
            height: 100vh; /* 화면 전체 높이로 설정 */
            margin: 0;
            background-image: url("/static/images/rozer/integ/Part_2_bg.png");
            background-size: cover; /* 이미지를 화면에 꽉 차게 설정 */
            background-position: center; /* 이미지를 화면 중앙에 위치 */
            background-repeat: no-repeat; /* 이미지를 반복하지 않게 설정 */
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
        .ironmaiden {
            position: absolute;
            z-index: 1;
            width: 10vw;
            height: 30vh;
            right: 53%;
            top: 31%;
        }
        .seklHand5 {
            position: absolute;
            z-index: 1;
            width: 2vw;
            height: 9vh;
            right: 44.4%;
            top: 34%;
            rotate: 180deg;
        }
        .seklLeg4 {
            position: absolute;
            z-index: 2;
            width: 5vw;
            height: 11vh;
            right: 40%;
            top: 30%;
            rotate: 180deg;
        }
        .chess {
            position: absolute;
            z-index: 1;
            width: 11vw;
            height: 14vh;
            right: 36%;
            top: 47%;
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
        .red-overlay {
            display: none; /* 초기에는 오버레이를 숨깁니다. */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: darkred;
            opacity: 0;
            z-index: 10; /* 오버레이가 텍스트 박스, 버튼 위에 표시 */
            transition: opacity 300ms ease-out; /* 1초 동안 천천히 나타나게 설정 */
        }
        .fade-in-red {
            display: block;
            opacity: 0.8; /* 붉은 오버레이의 불투명도 */
        }
    </style>
</head>
<body>
    <span>
        <div class="text_box" data-trigger>
            <span class="text"></span>
        </div>
        <div>
            <img src="/static/images/rozer/integ/Part_2_R.png" class="middle bgimg">
            <img src="/static/images/rozer/integ/아이언메이든.png" class="ironmaiden" onclick="clkironmaiden()">
            <img src="/static/images/rozer/integ/해골5.png" class="seklHand5" onclick="getMessaggeSkel()">
            <img src="/static/images/rozer/integ/해골4.png" class="seklLeg4" onclick="getMessaggeSkel()">
            <img src="/static/images/rozer/integ/체스판.png" class="chess" onclick="clickChess()">
            <img src="/static/images/rozer/integ/comment_area_bloody2.png" class="comment_area" onclick="redirectToNaver()">
        </div>
        <a href="/lightToCenter.do" methods="post" class="carousel-control-prev" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
<%--        링크이동만들기--%>
        <a href="/lightToBack.do" methods="post" class="carousel-control-next" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
        <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
    </div>
    </span>
    <div class="red-overlay" id="redOverlay"></div>
    <script>
        const content = "아이언 메이든 무섭다..";
        const text = document.querySelector(".text");
        let i = 0;

        function typing(){
            if (i < content.length) {
                let txt = content.charAt(i);
                text.innerHTML += txt;
                i++;
            }
        }
        setInterval(typing, 50);

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

        function clickChess() {
            const audio = new Audio('/static/sounds/rozer/integ/딸깍2.mp3');
            audio.play();
            window.location.href = "/lightChess.do";
        } // 링크이동만들기

        function getMessaggeSkel() {
            const audio = new Audio('/static/sounds/rozer/integ/쇠사슬소리.mp3');
            audio.play();
        }

        const audio = new Audio('/static/sounds/rozer/integ/짧은성가대.mp3');
        function clkironmaiden() {
            audio.play();
            alert('아이언메이든에서 왠지 시선이 느껴진다..');
            const redOverlay = document.getElementById("redOverlay");
            redOverlay.classList.add('fade-in-red');
            setTimeout(() => {
                window.location.href = "/lightOpenMaiden.do";
            },200);
        }
        // 링크이동만들기
        function goToInventory() {
            window.location.href = "/inventory.do";
        }
    </script>
</body>
</html>
