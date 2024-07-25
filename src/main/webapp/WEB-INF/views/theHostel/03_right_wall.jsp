<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Right Wall</title>
    <script src="/static/js/theHostel/timer.js"></script>
    <link rel="stylesheet" href="/static/css/theHostel/01_the_hostel.css">
    <link rel="icon" href="/static/images/theHostel/favicon.ico" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>

<body>
    <div id="overlay-top"></div>
    <div id="game-container">
        <img id="right-wall-image" src="/static/images/theHostel/rightwall/오른쪽벽.png" alt="Right Wall" style="width: 100%; height: 100%;">
        <button id="left-button" class="nav-button" onclick="location.href='/theHostel/the-bar.do'">　</button>
        <button id="right-button" class="nav-button" onclick="location.href='/theHostel/stage.do'">　</button>

        <!-- 아이템 버튼 추가 -->
        <!-- <button type="button" class="btn btn-primary-item" id="button-item" data-bs-toggle="modal" data-bs-target="#intro">💼</button> -->
        <button type="button" class="btn btn-primary-item" id="button-item" onclick="goToInventory()">💼</button>
    </div>
    <div id="overlay-bottom"></div>
    <div class="shadow-overlay"></div>

    <!-- 추가적으로 필요한 스크립트 등을 불러오기 -->
    <script src="/static/js/theHostel/03_right_wall.js"></script>
    <script src="/static/js/theHostel/inventory.js"></script>
</body>
</html>
