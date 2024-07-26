<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Door of BitCamp</title>
    <link rel="icon" type="image/x-icon" href="static/images/main/favicon.ico">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.55.2/phaser.min.js"></script>
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
        @font-face {
            font-family: 'KyoboHandwriting2023wsa';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404-2@1.0/KyoboHandwriting2023wsa.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }
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
        this.load.image('door', '/static/images/main/502doorcrop.png');
        this.load.audio('502DoorOpen', '/static/sounds/main/일반문 여는 소리.mp3');
        this.load.audio('bgm', '/static/sounds/main/in-the-embrace-of-darkness-197925.mp3');
    }

    function create() {
        this.cameras.main.setBackgroundColor('#000000');

        const bg = this.add.image(0, 0, 'door').setOrigin(0, 0);
        const scale = Math.min(config.width / bg.width, config.height / bg.height);
        bg.setScale(scale);
        bg.setPosition((config.width - bg.displayWidth) / 2, (config.height - bg.displayHeight) / 2);

        const titleText = this.add.text(300, 238, "502호의 문", {
            fontFamily: 'KyoboHandwriting2023wsa',
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

        const subText = this.add.text(300, 350, "당신은 익숙한 방 안에서 깨어납니다.\n\n방 안은 컴퓨터, 교재, 화이트보드 등\n 익숙한 물건들로 가득차 있습니다.\n\n문에 달려있는 자물쇠를 뺀다면 말이죠.", {
            fontFamily: 'KyoboHandwriting2023wsa',
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
            window.location.href = '${pageContext.request.contextPath}/main/hostelDoor.do';
        });

        rightButton.on('pointerdown', () => {
            window.location.href = '${pageContext.request.contextPath}/main/rogerDoor.do';
        });

        const zone502 = this.add.zone(530, 50, 270, 560).setOrigin(0).setInteractive();
        zone502.on('pointerdown', () => {
            game.scene.scenes[0].sound.play('502DoorOpen');
            game.scene.scenes[0].time.delayedCall(1500, () => {
                window.location.href = '${pageContext.request.contextPath}/bitCamp/502Room.do';
            });
        });
        zone502.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        zone502.on('pointerout', () => {
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
