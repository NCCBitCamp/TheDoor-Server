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
        @keyframes flashing {
            0% { background-color: black; }
            50% { background-color: transparent; }
            100% { background-color: black; }
        }

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
            animation: flashing 1s infinite;
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
        .door1{
            position: absolute;
            width: 3.6%;
            right: 47.4%;
            bottom: 55%;
            /*위치 지정 완료*/
        }
        .door1maze{
            position: absolute;
            width: 1%;
            right: 45.1%;
            bottom: 57%;
            /*위치 지정 완료*/
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 4;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 95%;
            overflow: auto;
            background-color: rgba(0,0,0,0.8);
        }
        .modal-content {
            background-color: #333;
            color: rgb(114, 0, 0);
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            text-align: center;
            font-family: 'Creepster', cursive;
        }
        .modal img {
            position: relative;
            align-items: center;
            width: 50%;
            border: 2px solid rgb(114, 0, 0);
        }
        .close {
            color: rgb(114, 0, 0);
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: white;
            text-decoration: none;
            cursor: pointer;
        }
        .modal input {
            background-color: #444;
            color: white;
            border: 1px solid rgb(114, 0, 0);
            padding: 10px;
            margin-top: 20px;
            margin-bottom: 20px;
            width: 80%;
        }
        .modal button {
            background-color: rgb(114, 0, 0);
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }
        .modal button:hover {
            background-color: darkred;
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
        <div class="text_box" data-trigger>
            <span class="text"></span>
        </div>
        <div class="overlay-container">
            <img src="/static/images/rozer/integ/Part_2_C_UNLOCK.png" class="middle bgimg">
            <img src="/static/images/rozer/integ/square1.png" class="door1" onclick="doorclick()">
            <img src="/static/images/rozer/integ/square1.png" class="door1maze" onclick="mazeclick()">
            <img src="/static/images/rozer/integ/comment_area_bloody.png" class="comment_area">
        </div>
        <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
    </span>

    <!-- The Modal -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <img src="/static/images/rozer/integ/비밀문미로돌판.png" alt="Maze Image">
            <input type="text" id="codeInput" placeholder="number">
            <button onclick="submitCode()">Submit</button>
        </div>
    </div>

    <script>
        const content = "저 문이야!!! 빨리 가서 열어야하는데....!";
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

        let isSolvemaze = false;

        function doorclick(){
            if (!isSolvemaze) {
                alert("미는 건 어림도 없을 것 같다.....");
            } else {
                const audio = new Audio('/static/sounds/rozer/integ/돌밀기1.mp3');
                audio.play();
                window.location.href = "/blindP3Pre.do";
            }// 링크이동만들기
        }

        function mazeclick(){
            const modal = document.getElementById('myModal');
            modal.style.display = 'block';

            setTimeout(() => {
                if (!isSolvemaze) {
                    window.location.href = "/ToDD.do";
                }// 링크이동만들기
            }, 10000); // 10초 후 실행
        }

        function submitCode() {
            const codeInput = document.getElementById('codeInput').value;
            const correctCode = "8"; // 정해진 숫자

            if (codeInput === correctCode) {
                isSolvemaze = true;
                closeModal();
                alert("성공! 문이 열렸습니다.");
            } else {
                alert("틀렸습니다. 다시 시도하세요.");
            }
        }

        function closeModal() {
            const modal = document.getElementById('myModal');
            modal.style.display = 'none';
        }

        function goToInventory() {
            window.location.href = "/inventory.do";
        }// 링크이동만들기
    </script>
</body>
</html>
