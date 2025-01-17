<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
    <script src="/static/js/rozer/timer.js"></script>
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
        .square_L{
            position: absolute;
            bottom: 40%;
            left: 33%;
            width: 6%;
            z-index: 2;
        }
        .square_R{
            position: absolute;
            bottom: 40%;
            right: 33%;
            width: 6%;
            z-index: 2;
        }
    </style>
</head>
<body>
    <span>
        <div class="text_box" data-trigger>
            <span class="text"></span>
        </div>
        <div>
            <img src="/static/images/rozer/integ/Part_2_B.png" class="middle bgimg">
            <img src="/static/images/rozer/integ/square1.png" class="square_L" onclick="badskullending()">
            <img src="/static/images/rozer/integ/square1.png" class="square_R" onclick="Story()">
            <img src="/static/images/rozer/integ/comment_area_bloody2.png" class="comment_area" onclick="redirectToNaver()">
        </div>
        <a href="/lightToRight.do" class="carousel-control-prev" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
<%--        링크만들기--%>
        <a href="/lightToLeft.do" class="carousel-control-next" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
        <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
    </div>
    </span>
    <script>
        const content = "수많은 사람들이 죽어간 곳인 것 같다...";
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
            const audio = new Audio('/static/sound/rozer/integ/아이템을획득.mp3');
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

        function badskullending(){
            // 이거랑 상응하는 엔딩 씬 하나 더 만들어야 함
            window.location.href = "/lightToJail.do" // 링크만들기
        }

        function Story(){
            alert("검은 구슬을 얻었다....!");
            const audio = new Audio('/static/sound/rozer/integ/치는소리6.mp3');
            audio.play();
            const imageSrc = "/static/images/rozer/integ/검정킹.png";
            getItem(imageSrc);
        }

        function goToInventory() {
            window.location.href = "/inventory.do"; // 링크만들기
        }
    </script>
</body>
</html>
