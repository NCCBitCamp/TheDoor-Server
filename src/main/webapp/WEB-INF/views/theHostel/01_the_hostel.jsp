<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Hostel</title>
    <link rel="stylesheet" href="/static/css/theHostel/01_the_hostel.css">
    <link rel="icon" href="/static/images/theHostel/favicon.ico" type="image/x-icon">
</head>
<body>
    <div id="overlay-top"></div>
    <div id="game-container">
        <!-- 게임 요소들을 이곳에 추가합니다. -->
        <div id="title-box">The Hostel</div>
        <img id="hostel-image" src="/static/images/theHostel/main/어두운호스텔외관.jpg" alt="호스텔외관(첫페이지)" style="width: 100%; height: 100%;">
        <div id="text-box"></div>
        
    </div>
    <div id="overlay-bottom"></div>
    
    <div class="shadow-overlay"></div>

    <!-- 추가적으로 필요한 스크립트 등을 불러오기 -->
    <script src="/static/js/theHostel/01_the_hostel.js"></script>
    <script>
        window.onload = function() {
            localStorage.removeItem("drawerUnlocked");
            localStorage.removeItem("clockSolved");
        }
    </script>

</body>
</html>