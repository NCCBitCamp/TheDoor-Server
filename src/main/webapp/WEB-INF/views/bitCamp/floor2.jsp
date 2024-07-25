<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2층</title>
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
            /* 바깥 배경 어둡게 설정 */
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
    <button id="settings-button" onclick="openSettings()"><img src="/static/images/bitCamp/settings-icon.svg"
                                                               alt="Settings"></button>
</div>

<script>
    let config = {
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
    let camera;
    let bgImage;
    let currentSection = 0;
    let totalSections = 3;
    let sectionWidth;
    let dialogBox;
    let dialogText;
    let noteImage;
    let currentLineIndex = 0;
    let clickableZones = [];
    let lockedImage;
    let timerText;
    let gameOverText;

    let inventory = [];
    let inventoryImages = [];
    let inventoryText, inventoryBag, modal, modalBackground, modalText;
    let modalItems = [];

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

        // 모달 창 생성
        modalBackground = scene.add.rectangle(scene.cameras.main.centerX, scene.cameras.main.centerY - 180, 800, 300, 0xFFFAFA).setAlpha(0).setInteractive().setScrollFactor(0); // 배경색 변경 예시
        modalText = scene.add.text(scene.cameras.main.centerX, 60, '소지품', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '24px',
            fill: '#000000'
        }).setAlpha(0).setOrigin(0.5).setScrollFactor(0);
        modal = scene.add.container(0, 0, [modalBackground, modalText]).setAlpha(0);
    };

    const loadInventoryFromLocalStorage = () => {
        const savedInventory = JSON.parse(localStorage.getItem('inventory'));
        const savedInventoryImages = JSON.parse(localStorage.getItem('inventoryImages'));
        if (savedInventory && savedInventoryImages) {
            inventory = savedInventory;
            inventoryImages = savedInventoryImages;
        }
    };

    const addItemToInventory = (item, imageKey) => {
        if (!inventory.includes(item)) {
            inventory.push(item);
            inventoryImages.push({ key: imageKey, name: item }); // 소지품 이미지와 이름을 저장
            updateInventoryDisplay();
            saveInventoryToLocalStorage(); // Save to local storage
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
            enlargedImageKey = 'memo1-1'; // memo1 클릭 시 보여줄 이미지
        } else if (itemKey === 'memo2') {
            enlargedImageKey = 'memo2-1'; // memo2 클릭 시 보여줄 이미지
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

                if (imageObj.key === 'memo1' || imageObj.key === 'memo2') {
                    itemImage.setInteractive();
                    itemImage.on('pointerdown', () => {
                        showItemDetails(scene, imageObj.key);
                    });
                }
            });
        } else {
            modal.setAlpha(0);
            modalBackground.setAlpha(0);
            modalText.setAlpha(0);
            overlay.setAlpha(0); // Hide overlay

            modalItems.forEach(item => item.destroy());
            modalItems = [];
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

    function createClickableZone(scene, x, y, width, height, clickHandler) {
        const zone = scene.add.zone(x, y, width, height).setOrigin(0.5).setInteractive();
        zone.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        zone.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });
        zone.on('pointerdown', () => {
            clickHandler();
        });
        clickableZones.push(zone);
    }

    function clearClickableAreas() {
        clickableZones.forEach(zone => zone.destroy());
        clickableZones = [];
    }



    const removeItemFromInventory = (item) => {
        const itemIndex = inventory.indexOf(item);
        if (itemIndex !== -1) {
            inventory.splice(itemIndex, 1);
            inventoryImages = inventoryImages.filter(imageObj => imageObj.name !== item);
            updateInventoryDisplay();
            saveInventoryToLocalStorage(); // Save to local storage
        } else {
            console.log('아이템이 인벤토리에 없습니다.');
        }
    };

    const saveInventoryToLocalStorage = () => {
        localStorage.setItem('inventory', JSON.stringify(inventory));
        localStorage.setItem('inventoryImages', JSON.stringify(inventoryImages));
    };

    const useEmergencyExitKey = () => {
        if (inventory.includes('비상구 열쇠')) {
            removeItemFromInventory('비상구 열쇠');
            window.location.href = '${pageContext.request.contextPath}/bitCamp/floor1.do';
        } else {
            showDialogue(["비상계단의 문이 굳게 닫혀있다.", "이전처럼 문을 열 수 있는 방법이 없을까?"]);
        }
    };

    function createClickableAreas(scene) {
        // 유리실 클릭 영역
        createClickableZone(scene, 1080, 255, 470, 310, () => {
            window.location.href = '${pageContext.request.contextPath}/bitCamp/201Room.do';
        });
        // 강의실1 클릭 영역
        createClickableZone(scene, 220, 310, 120, 200, () => showDialogue(["창문 틈으로 교실이 보인다.", "시설이 좋아보이는 강의실이다...", "...", "엄청난 컴퓨터다..."]));
        // 강의실2 클릭 영역
        createClickableZone(scene, 405, 310, 120, 200, () => showDialogue(["강의실 내부가 조금 보인다.", "근사해보이는 강의실...", "의자가 편해보인다.", "문이 잠겨있어 들어갈 수는 없다."]));
        // 강의실3 클릭 영역
        createClickableZone(scene, 600, 310, 120, 200, () => {
            game.scene.scenes[0].sound.play('doorstopSound');
            showDialogue(["문이 잠겨있지만 창문으로 안이 보인다.", "...대단해보이는 강의실이다.", "자리가 넓어보인다.", "..."]);
        });
        // 비상계단 클릭 영역
        createClickableZone(scene, 1565, 282.5, 130, 255, () => {
            if (inventory.includes('비상구 열쇠')) {
                useEmergencyExitKey();
            } else {
                showDialogue(["비상계단의 문이 굳게 닫혀있다.", "이전처럼 문을 열 수 있는 방법이 없을까?"]);
            }
        });

        // 엘리베이터 클릭 영역
        createClickableZone(scene, 1944, 310, 346, 200, () => showDialogue(["엘리베이터다.", "움직이지 않을 것을 알기에 더이상 버튼은 누르지 않는다.", "어떻게 작동시킬 수 있지?"]));
    }

    function changeBackground(scene, textureKey) {
        clearClickableAreas();
        bgImage.setTexture(textureKey);
        let scaleX = config.width / bgImage.width;
        let scaleY = config.height / bgImage.height;
        let scale = Math.max(scaleX, scaleY);
        bgImage.setScale(scale).setOrigin(0, 0);

        document.body.style.cursor = 'default';
    }

    function hideNavButtons() {
        document.getElementById('prev-button').style.display = 'none';
        document.getElementById('next-button').style.display = 'none';
    }

    function preload() {
        this.load.image('background', '/static/images/bitCamp/2floorBD.png');
        this.load.image('dialogueBox', '/static/images/bitCamp/wallpaper-torn-paper-ripped-white-paper.png');
        this.load.image('bag', '/static/images/bitCamp/bag.svg');
        this.load.image('key', '/static/images/bitCamp/key.png');
        this.load.image('photo', '/static/images/bitCamp/photo.png');
        this.load.image('photo_enlarge', '/static/images/bitCamp/photograph.png');
        this.load.image('newspaper', '/static/images/bitCamp/newspaper.png');
        this.load.image('newspaper_enlarge', '/static/images/bitCamp/newspaper_enlarge.png');
        this.load.audio('doorstopSound', '/static/sounds/bitCamp/문 덜컹덜컹.mp3');
        this.load.audio('bagSound', '/static/sounds/bitCamp/가방 여는 소리.wav');

    }

    function create() {
        bgImage = this.add.image(0, 0, 'background').setOrigin(0, 0);

        let scaleX = config.width / bgImage.width;
        let scaleY = config.height / bgImage.height;
        let scale = Math.max(scaleX, scaleY);

        bgImage.setScale(scale).setOrigin(0, 0);

        camera = this.cameras.main;
        camera.setViewport(0, 0, config.width, config.height);

        sectionWidth = (bgImage.displayWidth - config.width) / (totalSections - 1);

        dialogBox = this.add.image(config.width / 2, 530, 'dialogueBox').setOrigin(0.5, 0).setInteractive();
        dialogBox.setVisible(false);

        dialogText = this.add.text(config.width / 2, config.height - 70, '', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '35px',
            fill: '#000000',
            wordWrap: { width: 1000, useAdvancedWrap: true }
        }).setOrigin(0.5).setAlign('center');
        dialogText.setVisible(false);

        createInventory(this);
        loadInventoryFromLocalStorage();
        updateInventoryDisplay();
        createClickableAreas(this);
    }

    function update() {
        dialogBox.x = camera.scrollX + config.width / 2;
        dialogBox.y = camera.scrollY + 530;

        dialogText.x = camera.scrollX + config.width / 2;
        dialogText.y = camera.scrollY + config.height - 70;
    }

    function viewSection(direction) {
        if (dialogBox.visible) return;

        currentSection += direction;
        if (currentSection < 0) currentSection = 0;
        if (currentSection >= totalSections) currentSection = totalSections - 1;

        camera.scrollX = sectionWidth * currentSection;
        camera.scrollY = 0;
    }
</script>
</body>

</html>
