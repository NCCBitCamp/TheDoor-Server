<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Door</title>
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
            display: none;
        }

        #login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            position: absolute;
            width: 200px;
            height: 200px;
            color: white;
            border-radius: 15px;
            padding: 30px;
            background-color: black;
        }

        #login-container input {
            margin: 5px 0;
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
        }

        #login-container button {
            margin: 5px 0;
            padding: 10px;
            width: 100%;
            cursor: pointer;
            border: none;
            background-color: #FBC70E;
            color: black;
        }

        #login-container button:hover {
            background-color: rgb(255, 187, 0);
        }

        #login-error {
            color: red;
            display: none;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 300px;
            text-align: center;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        p {
            font-family: GmarketSansMedium;
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
<div id="login-container">
    <h2>LOGIN</h2>
    <input type="text" id="username" placeholder="username">
    <input type="password" id="password" placeholder="password">
    <button onclick="login()">로그인</button>
    <p id="login-error">아이디 혹은 비밀번호가 잘못되었습니다.</p>
</div>

<div id="game-container"></div>

<div id="volumeModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <p>볼륨 조절</p>
        <input type="range" id="volumeControl" min="0" max="1" step="0.01" value="0.5">
    </div>
</div>

<script>
    window.onload = function() {
        if (localStorage.getItem('isLoggedIn') === 'true') {
            document.getElementById('login-container').style.display = 'none';
            document.getElementById('game-container').style.display = 'block';
        }
    };

    function login() {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        if (username === 'user' && password === 'pass') {
            localStorage.setItem('isLoggedIn', 'true');
            localStorage.setItem('username', username);
            document.getElementById('login-container').style.display = 'none';
            document.getElementById('game-container').style.display = 'block';
        } else {
            document.getElementById('login-error').style.display = 'block';
        }
    }

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
    let bg, bgm, scene;

    function preload() {
        this.load.image('door', 'static/images/main/door.png');
        this.load.image('door2', 'static/images/main/door2.png');
        this.load.image('settings', 'static/images/main/settings.svg');
        this.load.image('rank', 'static/images/main/rank.svg');
        this.load.audio('bgm', 'static/sounds/main/in-the-embrace-of-darkness-197925.mp3');
    }

    function create() {
        scene = this;
        this.cameras.main.setBackgroundColor('#000000');

        bg = this.add.image(0, 0, 'door').setOrigin(0, 0);
        const scale = Math.min(config.width / bg.width, config.height / bg.height);
        bg.setScale(scale);
        bg.setPosition((config.width - bg.displayWidth) / 2, (config.height - bg.displayHeight) / 2);

        const settingsIcon = this.add.image(1240, 40, 'settings').setInteractive().setScale(1);
        const rankIcon = this.add.image(1180, 40, 'rank').setInteractive().setScale(1);

        bgm = this.sound.add('bgm', { loop: true });
        bgm.play();

        settingsIcon.on('pointerdown', () => {
            showModal();
        });

        rankIcon.on('pointerdown', () => {
            window.location.href = '/';
        });

        const zone502 = this.add.zone(586, 232, 117, 244).setOrigin(0).setInteractive();
        zone502.on('pointerdown', () => {
            saveAudioProgress();
            window.location.href = '/main/502Door.do';
        });
        zone502.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        zone502.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });

        const zoneHostel = this.add.zone(314, 256, 113, 271).setOrigin(0).setInteractive();
        zoneHostel.on('pointerdown', () => {
            saveAudioProgress();
            window.location.href = '/main/hostelDoor.do';
        });
        zoneHostel.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        zoneHostel.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });

        let clickedRoger = false;
        const zoneRoger = this.add.zone(869, 292, 179, 248).setOrigin(0).setInteractive();
        zoneRoger.on('pointerdown', () => {
            if (!clickedRoger) {
                bg.setTexture('door2');
                clickedRoger = true;
            } else {
                saveAudioProgress();
                window.location.href = '/main/rogerDoor.do';
            }
        });
        zoneRoger.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        zoneRoger.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });

        const modal = document.getElementById('volumeModal');
        const span = document.getElementsByClassName('close')[0];
        const volumeControl = document.getElementById('volumeControl');

        span.onclick = function () {
            closeModal();
        };

        window.onclick = function (event) {
            if (event.target === modal) {
                closeModal();
            }
        };

        volumeControl.oninput = function () {
            bgm.setVolume(this.value);
        };

        function showModal() {
            modal.style.display = 'flex';
            volumeControl.value = bgm.volume;
            scene.input.enabled = false;
        }

        function closeModal() {
            modal.style.display = 'none';
            scene.input.enabled = true;
        }
    }

    function saveAudioProgress() {
        if (bgm) {
            localStorage.setItem('bgmCurrentTime', bgm.seek);
        }
    }
</script>
</body>

</html>
