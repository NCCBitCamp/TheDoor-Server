<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
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
            bottom: 60%; 
            left: 46%; 
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
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(73, 8, 8); /* Fallback color */
            background-color: rgba(80, 6, 6, 0.4); /* Black w/ opacity */
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 80%; /* Could be more or less, depending on screen size */
            max-width: 400px;
            text-align: center;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .ghost {
            display: none;
            position: fixed;
            top: 47%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1100; /* Above the modal */
            width: 100%; /* Adjust as needed */
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
                <img src="/static/images/rozer/integ/Part_2_L_UNLOCK_0.png" class="middle bgimg">
                <img src="/static/images/rozer/integ/초상화뒤자물쇠.png" class="lock" onclick="lock()">
                <img src="/static/images/rozer/integ/comment_area_bloody2.png" class="comment_area">
            </div>
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

    <!-- Ghost Image -->
    <img src="/static/images/rozer/integ/귀신1.png" class="ghost" id="ghostImage">

    <script>
        const content = "시선을 돌릴 수 없다... 여기에 뭔가 있어!";
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

        function lock() {
            // Display the modal
            document.getElementById('myModal').style.display = "block";
        }

        // Get the modal
        const modal = document.getElementById("myModal");

        // Get the <span> element that closes the modal
        const span = document.getElementsByClassName("close")[0];

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        function checkCode() {
            const code = document.getElementById('codeInput').value;
            if (code.toLowerCase() === 'king') {
                //링크이동만들기
                window.location.href = "Part_2_blindL_UNLOCK.html";
            } else {
                modal.style.display = "none";
                showGhost();
            }
        }

        function showGhost() {
            const ghost = document.getElementById('ghostImage');
            ghost.style.display = "block";
            const laughAudio = new Audio('/static/sounds/rozer/integ/웃음소리1.mp3');
            laughAudio.play();
            setTimeout(() => {
                ghost.style.display = "none";
            }, 500);
        }

        function goToInventory() { // 링크이동만들기
            window.location.href = "../integ/Inventory_temp.html";
        }
    </script>
</body>
</html>