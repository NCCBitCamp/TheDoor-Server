<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/static/game/clock/clock.css">
  <title>CLOCK</title>
</head>
<body>
  <div class="container">
    <div id="circle1" class="circle1"></div>
    <div class="circle2"></div>
    <div id="circle3" class="circle3"></div>
    <div id="circle4" class="circle4"></div>
    <div id="hour-hand" class="hour-hand">
      <div class="white-space"></div>
    </div>
    <div id="minute-hand" class="minute-hand">
      <div class="white-space"></div>
    </div>
  </div>
  <br>
  <div>
    <button type="button" class="button1" id="hour-plus-btn" >H +</button>
    <button type="button" class="button2" id="clearBtn">🔑</button>
    <button type="button" class="button3" id="minute-plus-btn">M +</button>
  </div>

  <!-- 뒤로가기 -->
  <br>
  <button id="back-button">Back</button>
  
  <script src="/static/game/clock/clock.js"></script>
</body>
</html>