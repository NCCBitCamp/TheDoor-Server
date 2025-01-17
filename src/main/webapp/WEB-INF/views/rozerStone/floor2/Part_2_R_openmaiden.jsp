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
        .key {
            position: absolute;
            z-index: 2;
            width: 0.9vw;
            height: 1.9vh;
            right: 59.7%;
            top: 52.8%;
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
            top: 31%;
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
    </style>
</head>
<body>
    <span>
        <div class="text_box" data-trigger>
            <span class="text"></span>
        </div>
        <div>
            <img src="/static/images/rozer/integ/Part_2_R_openmaiden2.png" class="middle bgimg">
            <img src="/static/images/rozer/integ/뚜껑열린가시메이든.png" class="ironmaiden" onclick="clkironmaiden()">
            <img src="/static/images/rozer/integ/가시6.png" class="key" onclick="clkironmaidenkey()">
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
        // HTML 문서가 완전히 로드되고 인벤에 로저크리스탈 있으면
        // 화면에 가시 안보이기(못뽑음) 없으면 화면에 가시 보이기(뽑을지 선택지 줌)
            const targetItem = "/static/images/rozer/integ/RozerCrystal.png";
            let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
            if (inventory.includes(targetItem)) {
                const key = document.querySelector(".key");
                key.style.display="none";
            }
        });


        const content = "어.. 갑자기 열린거같은데?..";
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
            window.location.href = "/lightChess.do";
        } // 링크이동만들기

        function getMessaggeSkel() {
            const audio = new Audio('/static/sounds/rozer/integ/쇠사슬소리.mp3');
            audio.play();
        }

        function clkironmaiden() {
            const die = confirm("체험 해 볼까?");
            
            if(die){
                window.location.href = "/ToDS.do";
            }
            alert("아니다..그러지말자..");
        } // 링크이동만들기

        function clkironmaidenkey() {
            const take = confirm("가시를 뽑아보겠습니까?")
            
            if(take){
                const audio = new Audio('/static/sounds/rozer/integ/만능키소리.mp3');
                audio.play();

                const key = document.querySelector(".key");
                key.style.display="none";
                getItem("/static/images/rozer/integ/RozerCrystal.png");
                alert("손에 구슬이 흘러들어왔다!");
            }
        }

        function goToInventory() {
            window.location.href = "/inventory.do";
        } // 링크이동만들기
    </script>
</body>
</html>
