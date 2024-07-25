<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2층 유리실</title>
    <script src="/static/js/bitCamp/timer.js"></script>
    <link rel="icon" href="/static/images/bitCamp/bitcamp_favicon.ico" type="image/x-icon">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.55.2/phaser.min.js"></script>
    <style>
        body {
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            font-family: 'KyoboHandwriting2023wsa', sans-serif;
            cursor: default;
            background-color: rgba(0, 0, 0, 1);
        }

        #game-container {
            position: relative;
            width: 1280px;
            height: 720px;
            margin: 0 auto;
            overflow: hidden;
        }

        .nav-button {
            position: absolute;
            top: 78%;
            transform: translateY(-50%);
            background-color: white;
            color: black;
            border: none;
            font-size: 24px;
            cursor: pointer;
            padding: 10px;
        }

        #prev-button {
            position: fixed;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-family: 'KyoboHandwriting2023wsa';
        }

        #next-button {
            position: fixed;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-family: 'KyoboHandwriting2023wsa';
        }

        #back-button {
            top: 0%;
            left: 50%;
            transform: translateX(-50%);
            font-family: 'KyoboHandwriting2023wsa';
            display: none;
        }

        #settings-button {
            position: absolute;
            top: 18px;
            right: 25px;
            background: transparent;
            border: none;
            cursor: pointer;
        }

        #settings-button img {
            width: 50px;
            height: 50px;
        }

        @font-face {
            font-family: 'KyoboHandwriting2023wsa';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404-2@1.0/KyoboHandwriting2023wsa.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }
    </style>
</head>

<body>
<div id="game-container">
    <button id="prev-button" class="nav-button" onclick="viewSection(-1)"><</button>
    <button id="next-button" class="nav-button" onclick="viewSection(1)">></button>
    <button id="back-button" class="nav-button" style="display:none;" onclick="goBack()">Back</button>
    <button id="settings-button" onclick="openSettings()"><img src="/static/images/bitCamp/settings-icon.svg" alt="Settings"></button>
</div>
<script>
    window.addEventListener('load', function () {
        history.pushState(null, '', location.href);

        window.addEventListener('popstate', function (event) {
            history.pushState(null, '', location.href);
            alert('도망칠 수 없습니다');
        });

        window.addEventListener('beforeunload', function (event) {
            history.pushState(null, '', location.href);
            alert('도망칠 수 없습니다');
        });
    });

    const config = {
        type: Phaser.AUTO,
        width: 1280,
        height: 720,
        parent: 'game-container',
        scene: {
            preload: preload,
            create: create,
            update: update
        }
    };

    const game = new Phaser.Game(config);

    let bgImage;
    let inventory = [];
    let inventoryImages = [];
    let inventoryText, inventoryBag, modal, modalBackground, modalText;
    let modalItems = [];
    let dialogBox, dialogText;
    let confirmBox, confirmText, yesButton, noButton;

    const showItemImage = (imageKey) => {
        const scene = game.scene.scenes[0];
        const itemImage = scene.add.image(scene.cameras.main.scrollX + scene.cameras.main.centerX, scene.cameras.main.scrollY + scene.cameras.main.centerY, imageKey).setScale(0.5).setAlpha(0);
        scene.tweens.add({
            targets: itemImage,
            alpha: 1,
            duration: 150,
            yoyo: true,
            hold: 500,
            onComplete: () => {
                itemImage.destroy();
            }
        });
    };

    const createInventory = (scene) => {
        inventoryBag = scene.add.image(1150, 40, 'bag').setInteractive();
        inventoryBag.setScale(0.5).setScrollFactor(0);
        inventoryBag.on('pointerdown', () => {
            toggleInventoryModal(scene);
        });
        inventoryBag.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        inventoryBag.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });

        overlay = scene.add.rectangle(scene.cameras.main.centerX, scene.cameras.main.centerY, bgImage.width, bgImage.height, 0x000000, 0.5);
        overlay.setAlpha(0);

        modalBackground = scene.add.rectangle(scene.cameras.main.centerX, scene.cameras.main.centerY - 180, 800, 300, 0xFFFAFA).setAlpha(0).setInteractive().setScrollFactor(0);
        modalText = scene.add.text(scene.cameras.main.centerX, 60, '소지품', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '24px',
            fill: '#000000'
        }).setAlpha(0).setOrigin(0.5).setScrollFactor(0);
        modal = scene.add.container(0, 0, [modalBackground, modalText]).setAlpha(0);

        // Load items from local storage
        inventory = JSON.parse(localStorage.getItem('inventory')) || [];
        inventoryImages = JSON.parse(localStorage.getItem('inventoryImages')) || [];
        updateInventoryDisplay();
    };


    const addItemToInventory = (item, imageKey) => {
        if (!inventory.includes(item)) {
            inventory.push(item);
            inventoryImages.push({ key: imageKey, name: item });
            updateInventoryDisplay();
            localStorage.setItem('inventory', JSON.stringify(inventory));
            localStorage.setItem('inventoryImages', JSON.stringify(inventoryImages));
        } else {
            console.log('아이템이 이미 소지품에 있습니다.');
        }
    };

    const updateInventoryDisplay = () => {
        if (inventoryText) {
            inventoryText.setText(inventory.map(item => item.name).join('\n'));
        }
    };

    const showItemDetails = (scene, itemKey) => {
        let enlargedImageKey;
        if (itemKey === 'memo1') {
            enlargedImageKey = 'memo1-1';
        } else if (itemKey === 'memo2') {
            enlargedImageKey = 'memo2-1';
        }

        const fullscreenImage = scene.add.image(scene.cameras.main.centerX, scene.cameras.main.centerY, enlargedImageKey)
            .setDisplaySize(scene.cameras.main.width * 0.9, scene.cameras.main.height * 0.9)
            .setAlpha(0)
            .setInteractive();

        scene.tweens.add({
            targets: fullscreenImage,
            alpha: 1,
            duration: 500
        });

        fullscreenImage.on('pointerdown', () => {
            scene.tweens.add({
                targets: fullscreenImage,
                alpha: 0,
                duration: 500,
                onComplete: () => {
                    fullscreenImage.destroy();
                }
            });
        });
    };


    const useYuriRoomKey = (scene) => {
        inventory = inventory.filter(item => item !== '유리실 열쇠');
        inventoryImages = inventoryImages.filter(imageObj => imageObj.name !== '유리실 열쇠');
        updateInventoryDisplay();

        localStorage.setItem('inventory', JSON.stringify(inventory));
        localStorage.setItem('inventoryImages', JSON.stringify(inventoryImages));

        const storedInventory = JSON.parse(localStorage.getItem('inventory')) || [];
        const updatedInventory = storedInventory.filter(item => item !== '유리실 열쇠');
        localStorage.setItem('inventory', JSON.stringify(updatedInventory));

        hideConfirmationDialog();
        window.location.href = '${pageContext.request.contextPath}/bitCamp/floor2.do';
    };

    const useExitKey = (scene) => {
        inventory = inventory.filter(item => item !== '비상구 열쇠');
        inventoryImages = inventoryImages.filter(imageObj => imageObj.name !== '비상구 열쇠');
        updateInventoryDisplay();

        localStorage.setItem('inventory', JSON.stringify(inventory));
        localStorage.setItem('inventoryImages', JSON.stringify(inventoryImages));

        const storedInventory = JSON.parse(localStorage.getItem('inventory')) || [];
        const updatedInventory = storedInventory.filter(item => item !== '비상구 열쇠');
        localStorage.setItem('inventory', JSON.stringify(updatedInventory));

        hideConfirmationDialog();
        // 비상구 열쇠 사용 시 이동할 페이지로 변경합니다.
    };

    const toggleInventoryModal = (scene) => {
        scene.sound.play('bagSound'); // 가방 소리 재생

        if (modal.alpha === 0) {
            modal.setAlpha(1);
            modalBackground.setAlpha(0.8);
            modalText.setAlpha(1);
            overlay.setAlpha(0.5); // Show overlay

            inventoryImages.forEach((imageObj, index) => {
                const itemImage = scene.add.image(scene.cameras.main.centerX - 300 + (index % 4) * 200, scene.cameras.main.centerY - 190 + Math.floor(index / 4) * 140, imageObj.key).setScale(0.3).setScrollFactor(0);
                const itemText = scene.add.text(scene.cameras.main.centerX - 300 + (index % 4) * 200, scene.cameras.main.centerY - 100 + Math.floor(index / 4) * 140, imageObj.name, {
                    fontFamily: 'KyoboHandwriting2023wsa',
                    fontSize: '25px',
                    fill: '#000000'
                }).setOrigin(0.5).setScrollFactor(0);
                modal.add([itemImage, itemText]);
                modalItems.push(itemImage);
                modalItems.push(itemText);

                if (imageObj.name === '유리실 열쇠') {
                    itemImage.setInteractive();
                    itemImage.on('pointerdown', () => {
                        showConfirmationDialog(scene, '유리실 열쇠');
                    });
                }

                if (imageObj.name === '비상구 열쇠') {
                    itemImage.setInteractive();
                    itemImage.on('pointerdown', () => {
                        showConfirmationDialog(scene, '비상구 열쇠');
                    });
                }
            });

            clickArea1.disableInteractive();
            clickArea2.disableInteractive();
            clickArea3.disableInteractive();
        } else {
            modal.setAlpha(0);
            modalBackground.setAlpha(0);
            modalText.setAlpha(0);
            overlay.setAlpha(0); // Hide overlay

            modalItems.forEach(item => item.destroy());
            modalItems = [];

            clickArea1.setInteractive();
            clickArea2.setInteractive();
            clickArea3.setInteractive();
        }
    };


    function showDialogue(texts) {
        let currentTextIndex = 0;

        const advanceText = () => {
            if (currentTextIndex < texts.length) {
                dialogText.setText(texts[currentTextIndex]);
                dialogBox.setVisible(true);
                dialogText.setVisible(true);
                currentTextIndex++;
            } else {
                dialogBox.setVisible(false);
                dialogText.setVisible(false);
            }
        };

        advanceText();

        dialogBox.setInteractive().on('pointerdown', () => {
            advanceText();
        });
    }

    function hideNavButtons() {
        document.getElementById('prev-button').style.display = 'none';
        document.getElementById('next-button').style.display = 'none';
    }

    function preload() {
        this.load.image('dialogueBox', '/static/images/bitCamp/wallpaper-torn-paper-ripped-white-paper.png');
        this.load.image('locked', '/static/images/bitCamp/locked.png');
        this.load.image('bag', '/static/images/bitCamp/bag.svg');
        this.load.image('key', '/static/images/bitCamp/key.png');
        this.load.image('exitkey', '/static/images/bitCamp/exitkey.png');
        this.load.image('confirmBox', '/static/images/bitCamp/dialogueBox.png');
        this.load.image('photo', '/static/images/bitCamp/photo.png');
        this.load.image('photo_enlarge', '/static/images/bitCamp/photograph.png');
        this.load.image('newspaper', '/static/images/bitCamp/newspaper.png');
        this.load.image('newspaper_enlarge', '/static/images/bitCamp/newspaper_enlarge.png');
        this.load.audio('drawerSound', '/static/sounds/bitCamp/서랍 여는 소리.mp3');
        this.load.audio('doorstopSound', '/static/sounds/bitCamp/문 덜컹덜컹.mp3');
        this.load.audio('bagSound', '/static/sounds/bitCamp/가방 여는 소리.wav');
    }


    function create() {
        bgImage = this.add.image(0, 0, 'locked').setOrigin(0, 0);

        const scaleX = this.cameras.main.width / bgImage.width;
        const scaleY = this.cameras.main.height / bgImage.height;

        const scale = Math.max(scaleX, scaleY);
        bgImage.setScale(scale).setScrollFactor(0);

        bgImage.x = this.cameras.main.width / 2 - (bgImage.displayWidth / 2);
        bgImage.y = this.cameras.main.height / 2 - (bgImage.displayHeight / 2);

        createInventory(this);
        hideNavButtons();

        timerText = this.add.text(50, 25, '0:00', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '40px',
            fill: '#ff0000'
        }).setScrollFactor(0);

        let remainingTime = localStorage.getItem('remainingTime');
        if (remainingTime !== null) {
            startTimer(this, parseInt(remainingTime));
        } else {
            startTimer(this, 300); // 기본 시간 300초
        }

        clickArea1 = this.add.zone(650, 95, 650, 190).setOrigin(0.5).setInteractive();
        clickArea1.on('pointerdown', () => {
            window.location.href = '${pageContext.request.contextPath}/bitCamp/game.do';
        });

        clickArea2 = this.add.zone(130, 590, 100, 90).setOrigin(0.5).setInteractive();
        if (localStorage.getItem('returnedFromGame') === 'true') {
            clickArea2.on('pointerdown', () => {
                game.scene.scenes[0].sound.play('drawerSound');
                showDialogue(["[유리실 열쇠]를 획득했다."]);
                showItemImage('exitkey');
                addItemToInventory('유리실 열쇠', 'exitkey');
            });
            localStorage.removeItem('returnedFromGame');
        }

        clickArea3 = this.add.zone(140, 680, 100, 70).setOrigin(0.5).setInteractive();
        clickArea3.on('pointerdown', () => {
            game.scene.scenes[0].sound.play('drawerSound');
            showDialogue(["[비상구 열쇠]를 획득했다."]);
            showItemImage('key');
            addItemToInventory('비상구 열쇠', 'key');
        });

        dialogBox = this.add.image(this.cameras.main.width / 2, this.cameras.main.height - 100, 'dialogueBox').setOrigin(0.5, 1).setInteractive();
        dialogText = this.add.text(this.cameras.main.width / 2, this.cameras.main.height - 120, '', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '35px',
            fill: '#000000',
            wordWrap: { width: 600, useAdvancedWrap: true }
        }).setOrigin(0.5);

        dialogBox.setVisible(false);
        dialogText.setVisible(false);

        confirmBox = this.add.image(this.cameras.main.centerX, this.cameras.main.centerY, 'confirmBox').setOrigin(0.5).setAlpha(0).setScale(0.5);
        confirmText = this.add.text(this.cameras.main.centerX, this.cameras.main.centerY - 40, '사용하시겠습니까?', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '24px',
            fill: '#000000',
            wordWrap: { width: 600, useAdvancedWrap: true }
        }).setOrigin(0.5).setAlpha(0);

        yesButton = this.add.text(this.cameras.main.centerX - 50, this.cameras.main.centerY + 20, '네', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '24px',
            fill: '#00ff00'
        }).setInteractive().setOrigin(0.5).setAlpha(0).on('pointerdown', () => {
            useYuriRoomKey(game.scene.scenes[0]);
        });

        noButton = this.add.text(this.cameras.main.centerX + 50, this.cameras.main.centerY + 20, '아니오', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '24px',
            fill: '#ff0000'
        }).setInteractive().setOrigin(0.5).setAlpha(0).on('pointerdown', () => {
            hideConfirmationDialog();
        });

        if (localStorage.getItem('nya') === 'true') {
            const initialDialogue = ["컴퓨터에는 별 게 없는 것 같다.", "이제 주변을 좀 더 살펴볼까?"];
            showDialogue(initialDialogue);
        } else {
            game.scene.scenes[0].sound.play('doorstopSound');
            const initialDialogue = ["?", "앗, 갇혔다!", "어떻게 나가야 하지?", "주변을 잘 살펴보자."];
            showDialogue(initialDialogue);
        }
    }



    function showConfirmationDialog(scene, itemName) {
        confirmBox.setAlpha(1);
        confirmText.setAlpha(1).setText(`유리실 열쇠를 사용하시겠습니까?`);
        yesButton.setAlpha(1);
        noButton.setAlpha(1);

        scene.tweens.add({
            targets: [confirmBox, confirmText, yesButton, noButton],
            alpha: 1,
            duration: 500
        });

        if (itemName === '유리실 열쇠') {
            yesButton.on('pointerdown', () => {
                useYuriRoomKey(scene);
            });
        }
    }


    function hideConfirmationDialog() {
        confirmBox.setAlpha(0);
        confirmText.setAlpha(0);
        yesButton.setAlpha(0);
        noButton.setAlpha(0);
    }

    function startTimer(scene, duration) {
        let timer = duration;

        const timerInterval = setInterval(() => {
            let minutes = Math.floor(timer / 60);
            let seconds = timer % 60;
            seconds = seconds < 10 ? '0' + seconds : seconds;

            timerText.setText(`${minutes}:${seconds}`);
            timer--;

            localStorage.setItem('remainingTime', timer); // 타이머 값 저장

            if (timer < 0) {
                clearInterval(timerInterval);
                showGameOver(scene);
            }
        }, 1000);
    }

    function showGameOver(scene) {
        let graphics = scene.add.graphics();
        graphics.fillStyle(0x000000, 1);
        graphics.fillRect(0, 0, config.width, config.height);

        gameOverText = scene.add.text(config.width / 2, config.height / 2, 'Game Over', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '64px',
            fill: '#ffffff'
        }).setOrigin(0.5).setScrollFactor(0);

        setTimeout(() => {
            localStorage.setItem('remainingTime', 300); // 타이머 값 리셋
            window.location.href = '${pageContext.request.contextPath}/bitCamp/floor2.do';
        }, 3000);
    }

    function update() {
        timerText.x = this.cameras.main.scrollX + 50;
        timerText.y = this.cameras.main.scrollY + 50;

        dialogBox.x = this.cameras.main.scrollX + this.cameras.main.width / 2;
        dialogBox.y = this.cameras.main.scrollY + 800;

        dialogText.x = this.cameras.main.scrollX + this.cameras.main.width / 2;
        dialogText.y = this.cameras.main.scrollY + this.cameras.main.height - 70;
    }
</script>
</body>

</html>