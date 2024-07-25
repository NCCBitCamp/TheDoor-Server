<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>엘레베이터 수리</title>
    <script src="/static/js/bitCamp/timer.js"></script>
    <link rel="icon" href="/static/images/bitCamp/bitcamp_favicon.ico" type="image/x-icon">
    <meta name="author" content="Lewis Nakao">
    <meta name="description" content="The Fixing Wiring mini game from Among Us written in JavaScript canvas">

    <!-- Twitter -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="🛰️ Fix Wiring Among Us game">
    <meta name="twitter:description" content="The Fixing Wiring mini game from Among Us written in JavaScript canvas">
    <meta name="twitter:site" content="@lewdev">
    <meta name="twitter:creator" content="@lewdev">
    <meta name="twitter:image" content="">

    <!-- Open Graph general (Facebook, Pinterest)-->
    <meta property="og:title" content="🛰️ Fix Wiring Among Us game">
    <meta property="og:description" content="The Fixing Wiring mini game from Among Us written in JavaScript canvas">
    <meta property="og:url" content="https://lewdev.github.io/apps/fix-wires-js">
    <meta property="og:site_name" content="lewdev.github.io">
    <meta property="og:type" content="website">
    <meta property="og:image" content="">

    <!-- Emoji SVG favicon -->
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🛰️</text></svg>">

    <style>
        html, body {
            background: #222;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            margin: 0;
        }

        #canvas {
            background: white;
            max-height: 100%;
            max-width: 100%;
        }

        #sourceBtn {
            position: fixed;
            top: 0;
            right: 0;
            width: 8rem;
            background-color: #CCC;
        }
    </style>
</head>
<body>
<div id="sourceBtn">
    <a href="https://github.com/lewdev/fix-wires-js" target="_blank" title="Source code">👨🏻‍💻 Source Code</a>
</div>

<canvas id="canvas" width="1920" height="1080"></canvas>
<script>
    const context = canvas.getContext('2d');
    const W = 1920;
    const T = 1080;
    const colors = ["red", "#0F0", "#00F", "#FF0", "#F0F"];
    const letters = "     ";
    let completedMatches = [];
    let shuffledColors = [];
    let isDone = false;
    let startX, startY;
    let selectedIndex = -1;
    let lastCheckTime = 0;
    const checkInterval = 1000; // 1초 간격으로 체크

    // 캔버스 크기 재설정
    const setBoundingRect = () => canvasRect = canvas.getBoundingClientRect();
    addEventListener("resize", setBoundingRect);
    addEventListener("scroll", setBoundingRect);
    setBoundingRect();

    // 배열 섞기
    const shuffleArray = (array) => {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
        return array;
    };

    // 선 그리기
    const drawLine = (color, x1, y1, x2, y2, lineWidth = 20) => {
        if (lineWidth === 20) drawLine("#000", x1, y1, x2, y2, 25);
        context.strokeStyle = color;
        context.beginPath();
        context.moveTo(x1, y1);
        context.lineTo(x2, y2);
        context.lineWidth = lineWidth;
        context.stroke();
    };

    // 사각형 그리기
    const drawRect = (color, x, y, width, height) => {
        if (color !== "#000") drawRect("#000", x - 5, y - 5, width + 10, height + 10);
        context.fillStyle = color;
        context.fillRect(x, y, width, height);
    };

    // 텍스트 그리기
    const drawText = (text, x, y, fontSize = '1in') => {
        context.font = fontSize;
        context.fillStyle = "#000";
        context.fillText(text, x, y);
    };

    // 게임 초기화
    const initializeGame = () => {
        completedMatches = [];
        shuffledColors = shuffleArray([...colors]);
    };

    // 마우스 좌표 업데이트
    const updateMouseCoordinates = (clientX, clientY) => {
        const { left, top, width, height } = canvasRect;
        startX = (clientX - left) * W / width;
        startY = (clientY - top) * T / height;
    };

    // 마우스 이동 이벤트
    canvas.onmousemove = (e) => updateMouseCoordinates(e.clientX, e.clientY);

    // 마우스 다운 이벤트 처리
    const handleMouseDown = () => {
        if (isDone) {
            initializeGame();
        } else if (startX < 216 && !completedMatches[selectedIndex = Math.floor(startY / 216)]) {
            selectedIndex = Math.floor(startY / 216);
        }
    };

    let alertTriggered = false; // 플래그 추가

    // 마우스 업 이벤트 처리
    const handleMouseUp = () => {
        if (startX > W - 216 && shuffledColors[Math.floor(startY / 216)] === colors[selectedIndex]) {
            completedMatches[selectedIndex] = 1;
            selectedIndex = -1;
        } else {
            selectedIndex = -1;
        }
    };

    let touchStartTimeout1 = null;
    let touchStartTimeout2 = null;

    // 터치 시작 이벤트 처리
    const handleTouchStart = (e) => {
        const touch = e.changedTouches[0];
        updateMouseCoordinates(touch.clientX, touch.clientY);
        if (!touchStartTimeout1) {
            handleMouseDown();
            touchStartTimeout1 = setTimeout(() => touchStartTimeout1 = null, 300);
        }
    };

    // 터치 종료 이벤트 처리
    const handleTouchEnd = (e) => {
        const touch = e.changedTouches[0];
        updateMouseCoordinates(touch.clientX, touch.clientY);
        if (!touchStartTimeout2) {
            handleMouseUp();
            touchStartTimeout2 = setTimeout(() => touchStartTimeout2 = null, 300);
        }
    };

    canvas.onmousedown = handleMouseDown;
    canvas.onmouseup = handleMouseUp;
    canvas.addEventListener("touchstart", handleTouchStart);
    canvas.addEventListener("touchend", handleTouchEnd);
    canvas.addEventListener("touchmove", (e) => {
        const touch = e.changedTouches[0];
        updateMouseCoordinates(touch.clientX, touch.clientY);
    });

    // 게임 화면 그리기
    const drawGame = () => {
        context.clearRect(0, 0, W, T);
        drawRect("#888", 0, 0, W, T);

        // 오른쪽 사각형 그리기
        shuffledColors.forEach((color, i) => drawRect(color, W - 216, i * 216, 216, 216));

        // 왼쪽 사각형 및 완료된 선 그리기
        colors.forEach((color, i) => {
            drawRect(color, 0, i * 216, 216, 216);
            if (completedMatches[i]) {
                drawLine(color, 108, i * 216 + 108, W - 108, shuffledColors.indexOf(color) * 216 + 108);
            }
            drawText(letters[i], 54, i * 216 + 108 + 20);
            drawText(letters[i], W - 162, shuffledColors.indexOf(color) * 216 + 108 + 20);
        });

        // 클릭된 선 그리기
        if (selectedIndex > -1) {
            drawLine(colors[selectedIndex], 108, selectedIndex * 216 + 108, startX, startY);
        }

        // 완료 상태 체크 및 경고 메시지
        if (completedMatches.filter(Boolean).length === colors.length && !alertTriggered) {
            isDone = true;
            alertTriggered = true; // 플래그 설정
            localStorage.setItem('elevatorRepairCompleted', 'true'); // 로컬 스토리지에 완료 상태 저장
            alert("엘리베이터 수리를 완료했습니다!");
            window.location.href = '${pageContext.request.contextPath}/bitCamp/101Room.do';
        }
    };

    // 게임 루프
    const gameLoop = () => {
        requestAnimationFrame(gameLoop);
        drawGame();
    };

    initializeGame();
    gameLoop();
</script>
<script async src="https://www.googletagmanager.com/gtag/js?id=G-GNP8ER8985"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }
    gtag('js', new Date());
    gtag('config', 'G-GNP8ER8985');
</script>
</body>
</html>
