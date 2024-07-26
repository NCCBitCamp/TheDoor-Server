<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Door of RozerStone</title>
    <link rel="icon" type="image/x-icon" href="static/images/main/favicon.ico">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.55.2/phaser.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            background-color: black;
        }
        #game-container {
            width: 1280px;
            height: 720px;
        }
        .black-and-white-picture-regular {
            font-family: "Black And White Picture", system-ui;
            font-weight: 400;
            font-style: normal;
        }
        @import url('https://fonts.googleapis.com/css2?family=Black+And+White+Picture&display=swap');
        @font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
    </style>
</head>
<body>
<div id="game-container"></div>
<script>
    const config = {
        type: Phaser.AUTO,
        width: 1280,
        height: 720,
        parent: 'game-container',
        scene: {
            preload: preload,
            create: create
        }
    };

    const game = new Phaser.Game(config);
    let bgm;

    function preload() {
        this.load.image('rogerDoor', '/static/images/main/rogerdoorcrop.png');
        this.load.audio('rozerDoorOpen', '/static/sounds/main/문열기5.mp3');
        this.load.audio('bgm', '/static/sounds/main/in-the-embrace-of-darkness-197925.mp3');
    }

    function create() {
        this.cameras.main.setBackgroundColor('#000000');

        const bg = this.add.image(0, 0, 'rogerDoor').setOrigin(0, 0);
        const scale = Math.min(config.width / bg.width, config.height / bg.height);
        bg.setScale(scale);
        bg.setPosition((config.width - bg.displayWidth) / 2, (config.height - bg.displayHeight) / 2);

        const titleText = this.add.text(300, 238, "RozerStone", {
            fontFamily: 'Black And White Picture',
            fontSize: '32px',
            color: '#ffffff',
            align: 'center',
            shadow: {
                offsetX: 0,
                offsetY: 0,
                color: '#ffffff',
                blur: 2,
                stroke: true,
                fill: true
            }
        }).setOrigin(0.5);

        const subText = this.add.text(300, 350, "중세시대 유적지를 탐험하다\n비밀스러운 장소를 찾아\n보물을 얻기 위해 떠나는\n흥미진진한 방탈출 모험!", {
            fontFamily: 'Black And White Picture',
            fontSize: '20px',
            color: '#ffffff',
            align: 'center',
            shadow: {
                offsetX: 0,
                offsetY: 0,
                color: '#ffffff',
                blur: 3,
                stroke: true,
                fill: true
            }
        }).setOrigin(0.5);

        const mainButton = this.add.text(20, 20, '⮐', {
            fontFamily: 'GmarketSansMedium',
            fontSize: '24px',
            color: '#ffffff',
            backgroundColor: 'transparent',
            padding: { x: 10, y: 5 },
            border: { width: 1, color: '#ffffff' },
            borderRadius: 5
        }).setInteractive();

        const leftButton = this.add.text(30, config.height / 2, '<', {
            fontFamily: 'GmarketSansMedium',
            fontSize: '32px',
            color: '#ffffff',
            padding: { x: 10, y: 5 },
            border: { width: 1, color: '#ffffff' },
            borderRadius: 5
        }).setInteractive();

        const rightButton = this.add.text(config.width - 70, config.height / 2, '>', {
            fontFamily: 'GmarketSansMedium',
            fontSize: '32px',
            color: '#ffffff',
            padding: { x: 10, y: 5 },
            border: { width: 1, color: '#ffffff' },
            borderRadius: 5
        }).setInteractive();

        mainButton.on('pointerdown', () => {
            window.location.href = '${pageContext.request.contextPath}/main/mainDoor.do';
        });

        leftButton.on('pointerdown', () => {
            window.location.href = '${pageContext.request.contextPath}/main/502Door.do';
        });

        rightButton.on('pointerdown', () => {
            window.location.href = '${pageContext.request.contextPath}/main/hostelDoor.do';
        });

        const zoneRoger = this.add.zone(500, 180, 330, 430).setOrigin(0).setInteractive();
        zoneRoger.on('pointerdown', () => {
            game.scene.scenes[0].sound.play('rozerDoorOpen');
            game.scene.scenes[0].time.delayedCall(1500, () => {
                window.location.href = '${pageContext.request.contextPath}/rozerStone/floor1/Nar_1.do';
            });
        });
        zoneRoger.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        zoneRoger.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });

        const bgmCurrentTime = localStorage.getItem('bgmCurrentTime');
        bgm = this.sound.add('bgm', { loop: true });

        if (bgmCurrentTime) {
            bgm.once('play', () => {
                bgm.setSeek(parseFloat(bgmCurrentTime));
            });
        }

        bgm.play();
    }
</script>
</body>
</html>
