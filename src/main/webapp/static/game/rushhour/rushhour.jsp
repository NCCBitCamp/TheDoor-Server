<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rush Hour Game</title>
    <style>
        button {
            background-color: #343B44;
            color: #E6C99B;
            border: 3px solid #202020;
            font-family: "Homemade Apple", 'yleeMortalHeartImmortalMemory', cursive;
            font-style: bold;
            cursor: pointer;
            position: absolute;
            bottom: 9rem;
        }

        body {
            /* margin-top: 30rem; */
            background-image: url(images/버건디벽지3.JPG);
            /* background-color: bisque; */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        canvas {
            height: 95vh;
            width: 95%;
            border: 4px solid #202020;
            margin: auto;
            display: block;
        }

        #game-container {
            width: 200px;
            height: 200px;
        }

        #win-message {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.8);
            color: #E6C99B;
            padding: 20px;
            font-size: 24px;
            display: none;
            z-index: 1;
        }
    </style>
</head>
<body>
    <div id="game-containr"></div>
    <div id="win-message">You Won!</div>

    <!-- 뒤로가기 -->
    <button id="back-button">Back</button>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/2.6.2/phaser.min.js"></script>
    <script src="/static/game/rushhour/rushhour_main.js"></script>

</body>
</html>