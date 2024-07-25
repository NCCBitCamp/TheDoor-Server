<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>inventory</title>
    <link rel="icon" href="/static/images/theHostel/favicon.ico" type="image/x-icon">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Homemade+Apple&display=swap');

        @font-face {
            font-family: 'yleeMortalHeartImmortalMemory';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/yleeMortalHeartImmortalMemory.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }
         /* 기본적인 레이아웃과 스타일 설정 */
         /* * {
            cursor: url('../image/마우스커서.png') 1 1,
                     auto; /* 커서를 이미지로 변경 */
        
        body {
            background-color: black;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            
        }
        .inventory {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .inventoryImage {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .item {
            width: 70px;
            height: 70px;
            position: absolute;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        .back-button {
            position: absolute;
            bottom: 200px;
            left: 50%;
            transform: translateX(-50%);
            padding: 5px 10px;
            background-color: rgba(255, 255, 255, 0.8);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.5rem;
            font-family: "Homemade Apple", 'yleeMortalHeartImmortalMemory', cursive;
        }
        .intembox {
            position: absolute;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 120px;
            height: 120px;
            background-color: rgba(255, 255, 255, 0.5); /* 박스를 구분하기 위한 반투명 배경 */
        }
        /* #recipe-modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0, 0, 0, 0.8);
            padding: 20px;
            border-radius: 10px;
            z-index: 1000;
        } */

        /* 모달창 뒷 배경(?) */
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0, 0, 0, 0.8);
            padding: 20px;
            border-radius: 10px;
            z-index: 1000;
        }
        #modal-img {
            width: 300px;
            height: 400px;
        }
    </style>
</head>
<body>
    <div class="inventory">
        <!-- 인벤토리 이미지를 감싸는 div 요소 -->
        <img src="/static/images/theHostel/useritem/아이템창가로.jpg" class="inventoryImage">
        
        <!-- 아이템을 담을 박스 1 -->
        <div class="intembox" id="box1" style="left: 2.5%; top: 11%;"></div>
        
        <!-- 아이템을 담을 박스 2 -->
        <div class="intembox" id="box2" style="left: 16.2%; top: 11%;"></div>

        <!-- 아이템을 담을 박스 3 -->
        <div class="intembox" id="box3" style="left: 30.2%; top: 11%;"></div>

        <!-- 아이템을 담을 박스 4 -->
        <div class="intembox" id="box4" style="left: 44%; top: 11%;"></div>

        <!-- 아이템을 담을 박스 5 -->
        <div class="intembox" id="box5" style="left: 58%; top: 11%;"></div>

        <!-- 아이템을 담을 박스 6 -->
        <div class="intembox" id="box6" style="left: 71.8%; top: 11%;"></div>
        
        <!-- 아이템을 담을 박스 7 -->
        <div class="intembox" id="box7" style="left: 85.7%; top: 11%;"></div>
    </div>

    <!-- recipe Modal -->
    <div id="recipe-modal" class="modal">
        <span class="close">&times;</span>
        <img class="modal-content" id="modal-img">
    </div>

    <!-- heart Modal -->
    <div id="heart-modal" class="modal">
        <span class="close">&times;</span>
        <img class="modal-content" id="heart-img">
    </div>

    <!-- photo Modal -->
    <div id="photo-modal" class="modal">
        <span class="close">&times;</span>
        <img class="modal-content" id="photo-img">
    </div>

    <!-- Rose Modal -->
    <div id="rose-modal" class="modal">
        <span class="close">&times;</span>
        <img class="modal-content" id="rose-img">
    </div>

    <!-- watch Modal -->
    <div id="watch-modal" class="modal">
        <span class="close">&times;</span>
        <img class="modal-content" id="watch-img">
    </div>

    <!-- ring Modal -->
    <div id="ring-modal" class="modal">
        <span class="close">&times;</span>
        <img class="modal-content" id="ring-img">
    </div>

    <!-- 인벤토리에서 돌아가는 버튼 -->
    <div>
        <button type="button" class="back-button" onclick="getBack()">Back</button>
    </div>
    <script src="/static/js/theHostel/inventory.js"></script>
    <!-- <script src="/static/js/theHostel/_02_the_bar.js"></script> <<== 검토 후 삭제 결정 -->
</body>
</html>
