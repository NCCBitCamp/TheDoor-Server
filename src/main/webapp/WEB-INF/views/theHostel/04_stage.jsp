<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stage</title>
    <script src="/static/js/theHostel/timer.js"></script>
    <link rel="stylesheet" href="/static/css/theHostel/01_the_hostel.css">
    <link rel="icon" href="/static/images/theHostel/favicon.ico" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        /* 아이템 존을 중앙 위쪽에 배치하는 컨테이너 */
        .itemzone-container {
            position: absolute;
            top: 20px;  /* 화면 위에서 20px 아래에 배치 */
            margin: auto;
            width: 100%;
            display: flex;
            justify-content: center;
            opacity: 100%;
            border: transparent;
            padding: 20px;  /* 패딩 20px */
            box-sizing: border-box;  /* 패딩 포함한 너비 계산 */
        }

        /* 드래그 가능한 요소 스타일 */
        .draggable {
            width: 100px;  /* 요소 너비 */
            height: 100px;  /* 요소 높이 */
            text-align: center;  /* 텍스트 중앙 정렬 */
            line-height: 100px;  /* 텍스트 수직 정렬 */
            cursor: grab;  /* 커서 모양 변경 */
            position: relative !important;
            transform: none !important;
            top: 0 !important;
            left: 0 !important;
            /* border: 1px solid black; */
            border: transparent;
        }

        /* 드롭 가능한 영역을 화면 중앙에 배치하는 컨테이너 */
        .dropzone-container {
            position: absolute;
            top: 50%;  /* 화면의 50% 지점에 배치 */
            left: 50%;  /* 화면의 50% 지점에 배치 */
            transform: translate(-50%, -50%);  /* 정확히 중앙에 배치되도록 조정 */
            display: flex;
            justify-content: center;
            box-sizing: border-box;  /* 패딩 포함한 너비 계산 */
            width: 700px;  /* 고정 너비 */
        }

        /* 드롭 가능한 영역 스타일 */
        .dropzone {
            width: 100px;  /* 영역 너비 */
            height: 100px;  /* 영역 높이 */
            background-color: none;  /* 배경 색상 */
            text-align: center;  /* 텍스트 중앙 정렬 */
            line-height: 200px;  /* 텍스트 수직 정렬 */
            margin: 10px;  /* 외부 여백 */
            border: 2px dashed #aaa;  /* 점선 테두리 */
            position: relative;  /* 상대적 위치 설정 */
            display: flex;
            justify-content: center;
            align-items: center;
            background-size: cover;
        }

        /* 숨기기 위한 클래스 */
        .hidden {
            display: none;
        }

        /* 편지봉투 이미지를 중앙에 배치하는 스타일 */
        #envelope-image {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 100;  /* 맨 위에 배치 */
            display: none;  /* 초기에는 숨김 */
        }
    </style>
</head>
<body>
  <div id="overlay-top"></div>
    <div id="game-container">
        <img id="stage-image" src="/static/images/theHostel/stage/무대배경.jpg" alt="Stage" style="width: 100%; height: 100%;">
        <button id="left-button" class="nav-button" onclick="location.href='/theHostel/right-wall.do'" style="top: 51.30%;">　</button>
        <button id="right-button" class="nav-button" onclick="location.href='/theHostel/left-wall.do'" style="top: 51.30%;">　</button>

        <div class="itemzone-container" id="item-zone">
            <!-- 드래그 가능한 아이템들 -->
            <div id="draggable1" class="draggable" draggable="true" data-id="1">　</div>
            <div id="draggable2" class="draggable" draggable="true" data-id="2">　</div>
            <div id="draggable3" class="draggable" draggable="true" data-id="3">　</div>
            <div id="draggable4" class="draggable" draggable="true" data-id="4">　</div>
        </div>

        <div class="dropzone-container" id="dropzone-container">
            <!-- 드롭 가능한 영역들 -->
            <div id="dropzone1" class="dropzone" data-id="4"></div>
            <div id="dropzone2" class="dropzone" data-id="3"></div>
            <div id="dropzone3" class="dropzone" data-id="1"></div>
            <div id="dropzone4" class="dropzone" data-id="2"></div>
        </div>

        <!-- 아이템 버튼 추가 -->
        <button type="button" class="btn btn-primary-item" id="button-item" onclick="goToInventory()">💼</button>
    </div>
    <div id="overlay-bottom"></div>
    <div class="shadow-overlay"></div>

    <!-- 편지봉투 이미지 -->
    <img id="envelope-image" src="/static/images/theHostel/stage/열리편지봉투.png" alt="Envelope" />

    <script src="/static/js/theHostel/04_stage.js"></script>
    <!-- <script src="inventory.js"></script> -->
</body>
</html>
