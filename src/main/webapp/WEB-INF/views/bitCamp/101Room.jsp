<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1층 제어실</title>
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
            position: fixed;  /* fixed 위치 */
            top: 10px;        /* 상단에서 10px */
            left: 10px;       /* 왼쪽에서 10px */
            transform: none;  /* transform 속성 제거 */
            font-family: 'KyoboHandwriting2023wsa';
            display: block;   /* block으로 설정하여 표시 */
            background: transparent;
            border: none;
            cursor: pointer;
        }

        #back-button img {
            width: 60px;
            height: 60px;
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
    <button id="back-button" class="nav-button" style="display:block;" onclick="goBack()">
        <img src="/static/images/bitCamp/back_button.svg" alt="Back">
    </button>
    <button id="settings-button" onclick="openSettings()"><img src="/static/images/bitCamp/settings-icon.svg" alt="Settings"></button>
</div>
<script>
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
        const storedInventory = JSON.parse(localStorage.getItem('inventory')) || [];
        const storedInventoryImages = JSON.parse(localStorage.getItem('inventoryImages')) || [];

        storedInventory.forEach((item, index) => {
            inventory.push(item);
            inventoryImages.push(storedInventoryImages[index]);
        });

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
                dialogBox.off('pointerdown', advanceText); // 이벤트 리스너 제거
            }
        };

        advanceText();

        dialogBox.on('pointerdown', advanceText);
    }

    function hideNavButtons() {
        document.getElementById('prev-button').style.display = 'none';
        document.getElementById('next-button').style.display = 'none';
    }

    function preload() {
        this.load.image('dialogueBox', '/static/images/bitCamp/wallpaper-torn-paper-ripped-white-paper.png');
        this.load.image('background', '/static/images/bitCamp/cctvRoom.png');
        this.load.image('bag', '/static/images/bitCamp/bag.svg');
        this.load.image('photo', '/static/images/bitCamp/photo.png');
        this.load.image('photo_enlarge', '/static/images/bitCamp/photograph.png');
        this.load.image('newspaper', '/static/images/bitCamp/newspaper.png');
        this.load.image('newspaper_enlarge', '/static/images/bitCamp/newspaper_enlarge.png');
        this.load.image('confirmBox', '/static/images/bitCamp/dialogueBox.png');
        this.load.audio('bagSound', '/static/sounds/bitCamp/가방 여는 소리.wav');
        this.load.audio('itemSound', '/static/sounds/bitCamp/아이템 획득 소리.mp3');
    }

    function create() {
        bgImage = this.add.image(0, 0, 'background').setOrigin(0, 0);

        const scaleX = this.cameras.main.width / bgImage.width;
        const scaleY = this.cameras.main.height / bgImage.height;

        const scale = Math.max(scaleX, scaleY);
        bgImage.setScale(scale).setScrollFactor(0);

        bgImage.x = this.cameras.main.width / 2 - (bgImage.displayWidth / 2);
        bgImage.y = this.cameras.main.height / 2 - (bgImage.displayHeight / 2);

        createInventory(this);
        hideNavButtons();

        // 엘리베이터 관리 영역
        createClickableZone(this, 570.5, 128, 347, 240, () => {
            const choices = [
                { text: "예", nextAction: () => { window.location.href = '${pageContext.request.contextPath}/bitCamp/cable_game.do'; } },
                { text: "아니오", nextAction: () => { showDialogue(["일단 다른 곳부터 조사해보자."]); } }
            ];
            showChoicesDialog(this, choices, "여기서 엘리베이터를 수리할 수 있는 듯하다. \n 엘리베이터 수리를 시도해볼까?", (choice) => {
                choice.nextAction();
            });
        });

        // cctv 관리 영역
        createClickableZone(this, 1032, 169.5, 276, 195, () => {
            showDialogue(["CCTV 화면이 비춰지고 있다.", "...", "응?", "저건.. 강사님?", "노이즈가 껴서 잘 안보이지만 \n 누군가와 대화하고 있는 것처럼 보인다.", "이 건물에 누가 더 있었나?", "5층으로 가서 확인해봐야겠다.", "콰과과과광", "?", "이게 무슨 소리지?"]);
            localStorage.setItem('cctvChecked', 'true');
        });

        // 비상벨 영역
        createClickableZone(this, 1064, 608.5, 428, 219, () => {
            if (localStorage.getItem('cctvChecked') === 'true') {
                showDialogue(["비상벨 같아 보인다.", "무슨 일인지 아까까지만 해도 아무 문제 없던 비상벨이 \n 큰소리를 내며 울리고 있다.", "바깥에서 난 소리와 관련이 있는 걸까?"]);
            } else {
                showDialogue(["비상벨 같아 보인다.", "이런 비상 사태에서도 울리지 않다니\n 정말 쓸모없는 비상벨이다."]);
            }
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

        // 추가된 부분: 클릭 시 마우스 좌표를 콘솔에 출력
        this.input.on('pointerdown', function (pointer) {
            console.log(`Mouse X: ${pointer.x}, Mouse Y: ${pointer.y}`);
        });

        // back-button 설정
        document.getElementById('back-button').style.display = 'block';
    }


    function createClickableZone(scene, x, y, width, height, clickHandler) {
        const zone = scene.add.zone(x, y, width, height).setOrigin(0.5).setInteractive();
        zone.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        zone.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });
        zone.on('pointerdown', clickHandler);
    }

    function showChoicesDialog(scene, choices, promptText, callback) {
        dialogText.setText(promptText);
        dialogBox.setVisible(true);
        dialogText.setVisible(true);

        const baseY = 460; // Y 시작점 설정
        const spacingY = 70; // 간격 설정
        const buttonX = config.width - 300; // 버튼 X 위치

        // 선택지 버튼 생성
        const choiceButtons = [];
        choices.forEach((choice, index) => {
            const buttonY = baseY + index * spacingY;

            const button = scene.add.text(buttonX, buttonY, choice.text, {
                fontFamily: 'KyoboHandwriting2023wsa',
                fontSize: '24px',
                fill: '#000',
                backgroundColor: '#fff',
                padding: { x: 20, y: 10 },
                fixedWidth: 250
            }).setOrigin(0.5).setInteractive().setScrollFactor(0);

            button.on('pointerover', () => {
                document.body.style.cursor = 'pointer'; // 마우스 오버 시 손모양 커서로 변경
            });

            button.on('pointerout', () => {
                document.body.style.cursor = 'default'; // 마우스 아웃 시 기본 커서로 복원
            });

            button.on('pointerdown', () => {
                choiceButtons.forEach(btn => btn.destroy()); // 선택지 버튼 제거
                document.body.style.cursor = 'default'; // 선택 후 커서를 기본 상태로 복원
                callback(choice);
            });

            choiceButtons.push(button); // 생성된 버튼을 배열에 추가
        });
    }

    // 뒤로가기 버튼 기능 함수
    function goBack() {
        window.location.href = '${pageContext.request.contextPath}/bitCamp/floor1.do';
    }

    function update() {
        dialogBox.x = this.cameras.main.scrollX + this.cameras.main.width / 2;
        dialogBox.y = this.cameras.main.scrollY + 800;

        dialogText.x = this.cameras.main.scrollX + this.cameras.main.width / 2;
        dialogText.y = this.cameras.main.scrollY + this.cameras.main.height - 70;
    }
</script>
</body>

</html>