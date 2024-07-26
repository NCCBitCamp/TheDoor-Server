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
            background-image: url("/static/images/rozer/integ/floor1_bg_dark.png");
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
            right: 48%;
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
        .candle {
            position: absolute;
            z-index: 1;
            width: 2vw;
            height: 6vh;
            right: 46%;
            top: 41%;
        }
        .paper1 {
            z-index: 2;
            width: 5vw;
            height: 5vh;
            right: 43%;
            top: 48%;
         }
        .paper10 {
            z-index: 2;
            width: 4vw;
            height: 3vh;
            right: 55%;
            top: 48%;
        }
        .book1 {
            z-index: 3;
            width: 5vw;
            height: 5vh;
            right: 46%;
            top: 45%;
            rotate: -30deg;
        }
        .book23 {
            z-index: 2;
            width: 4vw;
            height: 4vw;
            right: 44%;
            top: 44%;
        }
        .book3{
            right: 54%;
            height: 4vh;
            top: 46%;
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
            <img src="/static/images/rozer/floor1/Part_1_Center.png" class="middle bgimg">
            <img src="/static/images/rozer/floor1/종이1.png" class="middle paper1" onclick="getPaper1()">
            <img src="/static/images/rozer/floor1/종이10.png" class="middle paper10" onclick="getPaper2()">
            <img src="/static/images/rozer/floor1/양초.png" class="middle candle" onclick="getcandle()">
            <img src="/static/images/rozer/floor1/책상위맨위책.png" class="middle book1" onclick="getBook1()">
            <img src="/static/images/rozer/floor1/책상위책2.png" class="middle book23" onclick="getBook2()">
            <img src="/static/images/rozer/floor1/책상위책3.png" class="middle book23 book3" onclick="getBook3()">
            <img src="/static/images/rozer/floor1/comment_area_bloody.png" class="comment_area">
        </div>
        <!--링크 이동 수정-->
        <a href="/part1CToPart1L.do" class="carousel-control-prev" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <!--링크 이동 수정-->
        <a href="/part1CToPart1R.do" class="carousel-control-next" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
        <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
    </span>
    <script>
        const content = "오래된 책상 위에는 책들이 놓여 있다...";
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

        function redirectToNaver() {
            <!--링크 이동 수정-->
            window.location.href = "/part1CToPart1R.do";
        }
        
        function getItem(imageSrc) {
            const audio = new Audio('/static/sounds/rozer/integ/아이템획득소리2.mp3');
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

        function getPaper1() {
            showPaper1();
        }

        function getPaper2() {
            showPaper2();
        }

        function showPaper1() {
            const audio = new Audio('/static/sounds/rozer/integ/종이상호작용.mp3');
            audio.play();
            const parchment = document.createElement('img');
            parchment.src = "/static/images/rozer/integ/양피지1.png";
            parchment.classList.add('middle');
            parchment.style.zIndex = 4;
            parchment.style.width = '30vw';
            parchment.style.height = 'auto';
            parchment.style.right = '35%';
            parchment.style.top = '3%';
            parchment.id = 'parchment';
            parchment.onclick = function() {
                document.body.removeChild(parchment);
            };
            document.body.appendChild(parchment);
        }

        function showPaper2() {
            const audio = new Audio('/static/sounds/rozer/integ/종이상호작용.mp3');
            audio.play();
            const parchment = document.createElement('img');
            parchment.src = "/static/images/rozer/integ/양피지2.png";
            parchment.classList.add('middle');
            parchment.style.zIndex = 4;
            parchment.style.width = '30vw';
            parchment.style.height = 'auto';
            parchment.style.right = '35%';
            parchment.style.top = '3%';
            parchment.id = 'parchment';
            parchment.onclick = function() {
                document.body.removeChild(parchment);
            };
            document.body.appendChild(parchment);
        }

        function getcandle(){
            alert("양초. 타오르는 양초")
        }

        function getBook1(){
            const audio = new Audio('/static/sounds/rozer/integ/종이상호작용.mp3');
            audio.play();
            const parchment = document.createElement('img');
            parchment.src = "/static/images/rozer/integ/책1-1.png";
            parchment.classList.add('middle');
            parchment.style.zIndex = 4;
            parchment.style.width = '75vw';
            parchment.style.height = 'auto';
            parchment.style.right = '10%';
            parchment.style.top = '3%';
            parchment.id = 'parchment';
            parchment.onclick = function() {
                document.body.removeChild(parchment);
            };
            document.body.appendChild(parchment);
        }

        function getBook2(){
            const audio = new Audio('/static/sounds/rozer/integ/종이상호작용.mp3');
            audio.play();
            const parchment = document.createElement('img');
            parchment.src = "/static/images/rozer/integ/책2.png";
            parchment.classList.add('middle');
            parchment.style.zIndex = 4;
            parchment.style.width = '75vw';
            parchment.style.height = 'auto';
            parchment.style.right = '10%';
            parchment.style.top = '3%';
            parchment.id = 'parchment';
            parchment.onclick = function() {
                document.body.removeChild(parchment);
            };
            document.body.appendChild(parchment);
        }

        function getBook3(){
            const audio = new Audio('/static/sounds/rozer/integ/종이상호작용.mp3');
            audio.play();
            const parchment = document.createElement('img');
            parchment.src = "/static/images/rozer/integ/양피지4.png";
            parchment.classList.add('middle');
            parchment.style.zIndex = 4;
            parchment.style.width = '55vw';
            parchment.style.height = 'auto';
            parchment.style.right = '23%';
            parchment.style.top = '3%';
            parchment.id = 'parchment';
            parchment.onclick = function() {
                document.body.removeChild(parchment);
            };
            document.body.appendChild(parchment);
        }


        function playmusic() {
            alert("음악을 재생합니다.");
            const audio = new Audio('/static/sounds/rozer/integ/성냥1.mp3');
            audio.play();
        }

        function goToInventory() {
            // 링크 이동 수정
            window.location.href = "/inventory.do";
        }
    </script>
</body>
</html>
