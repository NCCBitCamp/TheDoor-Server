<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>picture_locker</title>
    <link rel="stylesheet" href="/static/game/locker/lockerStyle.css">
</head>

<body>

    <div class="container">
        <div class="patternbox" id="patternbox1"></div>
        <div class="patternbox" id="patternbox2"></div>
    </div>
    <div class="container">
        <div class="patternbox" id="patternbox3"></div>
        <div class="patternbox" id="patternbox4"></div>
    </div>
    <button type="button" class="clearbtn">🔑</button>
    
    <!-- 뒤로가기 -->
    <button id="back-button">Back</button>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="/static/game/locker/lockerScript.js" type="module"></script>
</body>
</html>