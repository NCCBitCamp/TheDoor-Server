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
        .lock {
            position: absolute;
            bottom: 58.7%; 
            left: 43.3%; 
            width: 1%;
            z-index: 3; 
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
        .carousel-control-next {
            display: none; /* Initially hidden */
            top: 50%;
        }
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7); /* 30% 투명도의 검정색 */
            z-index: 9999; /* 다른 요소들 위에 올라오도록 설정 */
            pointer-events: none; /* 클릭 등의 이벤트가 하위 요소로 전달되도록 함 */
        }
        .overlay-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 40%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 9999;
            pointer-events: none;
        }
    </style>
</head>
<body>
    <span>
        <div class="content">
            <div class="text_box" data-trigger>
                <span class="text"></span>
            </div>
            <div class="overlay-container">
                <img src="/static/images/rozer/integ/Part2_L_UNLOCK.png" class="middle bgimg">
                <img src="/static/images/rozer/integ/square1.png" class="lock" onclick="switchclick()">
                <img src="/static/images/rozer/integ/comment_area_bloody2.png" class="comment_area">
            </div>
<%--            링크이동 만들기--%>
            <a href="/toCenterUNLOCK.do" class="carousel-control-next" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </a>
            <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
        </div>
    </span>

    <!-- The Modal -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p>unnecessary position</p>
            <input type="text" id="codeInput" />
            <button onclick="checkCode()">Submit</button>
        </div>
    </div>

    <script>
        const content = "서둘러야 해...! 뭔가 오고 있어!!!!!!!";
        const text = document.querySelector(".text");
        let i = 0;

        function typing() {
            if (i < content.length) {
                let txt = content.charAt(i);
                text.innerHTML += txt;
                i++;
            }
        }
        setInterval(typing, 50);

        function switchclick() {
            // Play the sound
            const audio = new Audio('/static/sounds/rozer/integ/돌버튼2.mp3');
            const audio2 = new Audio('/static/sounds/rozer/integ/문열기5.mp3');
            audio.play();

            // Show the next control after 1 second
            setTimeout(() => {
                audio2.play();
                document.querySelector('.carousel-control-next').style.display = 'block';
            }, 2000);
        }

        function goToInventory() {
            window.location.href = "/inventory.do";
        } // 링크이동만들기
    </script>
</body>
</html>
