<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>5층</title>
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
    <button id="settings-button" onclick="openSettings()"><img src="/static/images/bitCamp/settings-icon.svg" alt="Settings"></button>
    <button id="prev-button" class="nav-button" onclick="viewSection(-1); event.stopPropagation();"><</button>
    <button id="next-button" class="nav-button" onclick="viewSection(1); event.stopPropagation();">></button>
</div>

<script>
    var config = {
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

    var game = new Phaser.Game(config);
    var camera;
    var bgImage;
    var currentSection = 0;
    var totalSections = 3;
    var sectionWidth;
    var alertIcon;
    var dialogBox;
    var dialogText;
    var teacherImage;
    var noteImage;
    var clickAreas = []; // 클릭 가능한 영역을 저장하는 배열
    var isDialogActive = false; // 다이얼로그 진행 중 여부를 나타내는 변수

    const texts0 = [
        "???: 아니 이게 왜 안되지?",
        "문을 여니 컴퓨터 키보드를 두드리는 소리와 함께 익숙한 목소리가 들려온다.",
        "분명 이게 맞을텐데.. 어?",
        "우리 반의 코딩교육을 담당하시는 고강사님, 학생들보다 열심히 공부하실만큼 성실하시지만 살짝 허당끼도 있으셔서 많은 학생들에게 인기있는 강사님이다.",
        "xx님이 어떻게 여길..",
        "(지금까지의 일을 설명한다.)",
        "그렇게 된거군요. 저도 밤늦게까지 다음주 수업 자료를 준비하다가..",
        "노트북 배터리가 다 되는 바람에 파일을 날려버려서\n다시 작성하다보니 어느샌가 이 곳에 갇혀있었네요.",
        "(이 곳에서 탈출할 방법에 대해 묻는다.)",
        "아마 비상구도 엘리베이터도 사용하기 힘든 상황일 거에요. \n저도 같이 돌아다니고 싶지만 자리를 떠나기 힘든 상황이라..",
        "일단 혼자서라도 주위를 살펴보자. 뭔가 탈출의 단서가 될만한 게 있을지도 모른다."
    ];
    const texts1 = ["불이 꺼져 있으니 으스스한 상담실이다.", "이곳에서 무언가를 찾을 수 있어 보이진 않는다."];
    const texts2 = ["북카트...?", "제법 오래되어 보이는 책이 쌓여있다.", "우리건 아닌 것 같은데..."];
    const texts3 = ["[501호]", "문이 잠겨있다. 딱히 들어갈 이유도 없어보인다."];
    const texts4 = ["502호... 다시 들어가고 싶지 않다."];
    const texts5 = ["비상구 문은 단단히 잠겨있다.", "문을 부순다기엔 가능성이 없어보이고...", "아무래도 열쇠가 필요할 것 같다."];
    const texts6 = ["엘리베이터다! 내려갈 수 있을까?", "...라는 희망에 버튼을 눌러보았지만 버튼은 눌리지 않았다.", "아무래도 이곳에서 나가는 건 불가능해 보인다."];
    const texts7 = ["음, 분명 매니저님들이 열쇠를 관리하셨었죠.", "비상구 열쇠도 아마 한곳에 있을 거예요."];
    const texts8 = ["[비상구 열쇠]를 획득했다.", "이제 비상구 문을 열 수 있을 거예요.", "7층으로 올라가보세요. 분명 도움이 될 겁니다."];

    const choices = [
        {
            text: "1. 왼쪽 책상을 둘러본다.",
            newChoices: [
                { text: "1. 필통을 조사한다.", nextTexts: ["필통 안은 무척 정돈되어 있다.", "볼펜, 샤프, 연필...", "이런걸 쓸 곳은 딱히 없겠지."] },
                { text: "2. 선반을 조사한다.", nextTexts: ["선반에는 인원수에 맞춰 코딩책이 채워져있다.", "아직 교재가 이만큼이나 더 남았다고?", "... ...(하)", "아쉽지만 유용한 물건은 없는 듯 하다."] },
                { text: "3. 컴퓨터를 조사한다.", nextTexts: ["깔끔하게 정돈되어 있는 느낌의 자리이다.", "어?", "모니터 하단에 메모가 하나 붙어있다.", "[메모4]을 획득했다.", "책상 주인이 쓴 거겠지..."] }
            ]
        },
        {
            text: "2. 오른쪽 책상을 둘러본다.",
            newChoices: [
                { text: "1. 책상 위를 조사한다.", nextTexts: ["각종 사무용품이 늘어져있다.", "난잡한 책상 위에 메모 하나가 가지런히 놓여있다.", "[메모3]을 획득했다.", "강매니저님의 글씨체처럼 반듯해 보인다."] },
                { text: "2. 파일철을 조사한다.", nextTexts: ["12기의 관리 명부이다.", "\"성실하고 의욕이 넘치는 학생들\", \"매사 열심히 하는 학생 ㅇㅇㅇ\"", "...노력 해야지."] },
                { text: "3. 서랍을 조사한다.", nextTexts: ["굳게 닫혀있다.", "열쇠로 열 수 있어보인다."] }
            ]
        },
        {
            text: "3. 직원공용 사물함을 본다.",
            newChoices: [
                { text: "1. 선반 위를 조사한다.", nextTexts: ["간단한 차와 다과가 올려져 있다.", "...꼬르륵", "곧 나갈 수 있겠지..."] },
                { text: "2. 키패드를 조사한다.", nextTexts: ["번호키 방식의 잠금 장치로 보인다.", "문을 열려면 비밀번호가 필요해보인다.", "1부터 계속 눌러봐야 하려나?"] },
                { text: "3. 비밀번호를 입력한다." }
            ]
        }
    ];

    var currentLineIndex = 0;
    var currentTextIndex = 0;
    var currentTexts = [];
    var initialDialogClick = true;
    var choiceSelected = false;
    var currentIndex = 0;
    var isChoicesVisible = false;
    var gamePhase = 'dialogue';

    let inventory = [];
    let inventoryImages = [];
    let inventoryText, inventoryBag, modal, modalBackground, modalText;
    let modalItems = [];
    let alertIconClicked = false;
    let secondDialogTriggered = false;
    let thirdDialogTriggered = false;

    const showItemImage = (imageKey) => {
        const scene = game.scene.scenes[0];
        const itemImage = scene.add.image(scene.cameras.main.scrollX + scene.cameras.main.centerX, scene.cameras.main.scrollY + scene.cameras.main.centerY, imageKey).setScale(0.5).setAlpha(0);

        if (imageKey === 'memo3' || imageKey === 'memo4') {
            scene.sound.play('paperSound'); // 사운드 재생
        }

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

    const addItemToInventory = (item, imageKey) => {
        if (!inventory.some(inventoryItem => inventoryItem.name === item)) {
            inventory.push({ name: item, key: imageKey });
            inventoryImages.push({ key: imageKey, name: item });
            updateInventoryDisplay();
            if (hasBothMemos()) {
                showAlertIcon(); // 메모3과 메모4를 동시에 얻으면 alert.png 다시 보이기
                secondDialogTriggered = true;
            }
            if (item === '비상구 열쇠') {
                showDialog(texts8, true); // 비상구 열쇠를 얻으면 texts8을 출력
                thirdDialogTriggered = true;
            }
        } else {
            console.log('아이템이 이미 소지품에 있습니다.');
        }
    };

    const updateInventoryDisplay = () => {
        if (inventoryText) {
            inventoryText.setText(inventory.map(item => item.name).join('\n'));
        }
    };

    const toggleInventoryModal = (scene) => {
        scene.sound.play('bagSound'); // 가방 소리 재생

        if (modal.alpha === 0) {
            modal.setAlpha(1);
            modalBackground.setAlpha(0.8);
            modalText.setAlpha(1);
            overlay.setAlpha(0.5); // Show overlay

            inventoryImages.forEach((imageObj, index) => {
                const itemImage = scene.add.image(scene.cameras.main.scrollX + scene.cameras.main.centerX - 300 + (index % 4) * 200, scene.cameras.main.scrollY + scene.cameras.main.centerY - 190 + Math.floor(index / 4) * 140, imageObj.key).setScale(0.3);
                const itemText = scene.add.text(scene.cameras.main.scrollX + scene.cameras.main.centerX - 300 + (index % 4) * 200, scene.cameras.main.scrollY + scene.cameras.main.centerY - 100 + Math.floor(index / 4) * 140, imageObj.name, {
                    fontFamily: 'KyoboHandwriting2023wsa',
                    fontSize: '25px',
                    fill: '#000000'
                }).setOrigin(0.5);
                modal.add([itemImage, itemText]);
                modalItems.push(itemImage);
                modalItems.push(itemText);

                if (imageObj.key === 'memo3' || imageObj.key === 'memo4') {
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

    const hasBothMemos = () => {
        return inventory.some(item => item.name === '메모3') && inventory.some(item => item.name === '메모4');
    };

    function showNewChoices(newChoices) {
        isChoicesVisible = true;
        setClickableAreasActive(false); // Disable other interactive elements

        newChoices.forEach((choice, index) => {
            if (choice.text === "3. 비밀번호를 입력한다." && !hasBothMemos()) {
                return;
            }
            const buttonY = 400 + index * 60;
            const button = game.scene.scenes[0].add.text(camera.scrollX + config.width / 2 + 200, buttonY, choice.text, {
                fontFamily: 'KyoboHandwriting2023wsa',
                fontSize: '24px',
                color: '#000',
                backgroundColor: '#fff',
                padding: { x: 20, y: 10 },
                fixedWidth: 300
            }).setInteractive();

            button.on('pointerover', () => {
                document.body.style.cursor = 'pointer';
            });

            button.on('pointerout', () => {
                document.body.style.cursor = 'default';
            });

            button.on('pointerdown', () => {
                dialogBox.setVisible(true);
                isChoicesVisible = false;
                setClickableAreasActive(true); // Re-enable other interactive elements

                newChoices.forEach((choice, idx) => {
                    const btn = game.scene.scenes[0].children.getByName(`newChoiceButton${idx}`);
                    if (btn) btn.destroy();
                });
                document.body.style.cursor = 'default';

                if (choice.nextTexts) {
                    currentTexts = choice.nextTexts;
                    currentTextIndex = 0;
                    gamePhase = 'nextTexts';
                    advanceNextTexts(); // 다이얼로그를 진행하는 함수 호출
                }

                if (choice.text === "3. 비밀번호를 입력한다.") {
                    showPasswordPrompt();
                }

                if (choice.onSelect) {
                    choice.onSelect();
                }
            }).setName(`newChoiceButton${index}`);
        });
    }

    const createInventory = (scene) => {
        inventoryBag = scene.add.image(1150, 40, 'bag').setInteractive();
        inventoryBag.setScale(0.5);
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

        modalBackground = scene.add.rectangle(scene.cameras.main.centerX, scene.cameras.main.centerY - 180, 800, 300, 0xFFFAFA).setAlpha(0).setInteractive();
        modalText = scene.add.text(scene.cameras.main.centerX, 60, '소지품', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '24px',
            fill: '#000000'
        }).setAlpha(0).setOrigin(0.5);
        modal = scene.add.container(0, 0, [modalBackground, modalText]).setAlpha(0);
    };

    function hideAlertIcon() {
        alertIcon.setVisible(false);
    }

    function showAlertIcon() {
        alertIcon.setVisible(true);
    }

    function showDialog(texts, showTeacher) {
        dialogBox.setVisible(true);
        dialogText.setVisible(true);
        if (showTeacher) {
            teacherImage.setVisible(true);
        } else {
            teacherImage.setVisible(false);
        }
        currentTexts = texts;
        currentTextIndex = 0;
        advanceDialogue();
        initialDialogClick = false;
        isDialogActive = true; // 다이얼로그 활성화 상태로 설정
        setClickableAreasActive(false); // 클릭 영역 비활성화
    }

    const showItemDetails = (scene, itemKey) => {
        let enlargedImageKey;
        if (itemKey === 'memo3') {
            enlargedImageKey = 'memo3-1';
        } else if (itemKey === 'memo4') {
            enlargedImageKey = 'memo4-1';
        }

        const fullscreenImage = scene.add.image(scene.cameras.main.scrollX + scene.cameras.main.centerX, scene.cameras.main.scrollY + scene.cameras.main.centerY, enlargedImageKey)
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

    function preload() {
        this.load.image('background', '/static/images/bitCamp/5floorBD.png');
        this.load.image('alert', '/static/images/bitCamp/alert.png');
        this.load.image('teacher', '/static/images/bitCamp/teacher.png');
        this.load.image('dialogueBox', '/static/images/bitCamp/wallpaper-torn-paper-ripped-white-paper.png');
        this.load.image('bag', '/static/images/bitCamp/bag.svg');
        this.load.image('memo3', '/static/images/bitCamp/memo3.png');
        this.load.image('memo3-1', '/static/images/bitCamp/memo3-1.png');
        this.load.image('memo4', '/static/images/bitCamp/memo4.png');
        this.load.image('memo4-1', '/static/images/bitCamp/memo4-1.png');
        this.load.image('key', '/static/images/bitCamp/key.png');
        this.load.image('exitkey', '/static/images/bitCamp/key.png');
        this.load.audio('paperSound', '/static/sounds/bitCamp/종이 넘기는 소리.mp3');
        this.load.audio('drawerSound', '/static/sounds/bitCamp/서랍 여는 소리.mp3');
        this.load.audio('openDoorSound', '/static/sounds/bitCamp/열쇠로 문여는소리.mp3');
        this.load.audio('stairWalkSound', '/static/sounds/bitCamp/계단 올라가는 소리.mp3');
        this.load.audio('bagSound', '/static/sounds/bitCamp/가방 여는 소리.wav');
        this.load.audio('itemSound', '/static/sounds/bitCamp/아이템 획득 소리.mp3');
    }

    function handleAlertClick() {
        if (!alertIconClicked) {
            showDialog(texts0, true);
            alertIconClicked = true;
        } else if (secondDialogTriggered) {
            showDialog(texts7, true);
            secondDialogTriggered = false;
        } else if (thirdDialogTriggered) {
            showDialog(texts8, true); // 비상구 열쇠를 얻으면 texts8을 출력
            thirdDialogTriggered = false;
        }
    }

    function create() {
        bgImage = this.add.image(0, 0, 'background').setOrigin(0, 0);

        var scaleX = config.width / bgImage.width;
        var scaleY = config.height / bgImage.height;
        var scale = Math.max(scaleX, scaleY);

        bgImage.setScale(scale).setOrigin(0, 0);

        camera = this.cameras.main;
        camera.setViewport(0, 0, config.width, config.height);

        sectionWidth = (bgImage.displayWidth - config.width) / (totalSections - 1);

        alertIcon = this.add.image(1000, 200, 'alert').setInteractive();
        alertIcon.setScale(0.5);
        alertIcon.on('pointerdown', handleAlertClick);

        teacherImage = this.add.image(920, 400, 'teacher');
        teacherImage.setScale(0.25);
        teacherImage.setVisible(false);

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

        createClickableArea(this, 1055, 180, 425, 140, showClickDialog);
        createClickableArea(this, 20, 175, 460, 240, texts1); // 상담실
        createClickableArea(this, 510, 310, 90, 100, texts2); // 북트럭
        createClickableArea(this, 610, 215, 125, 200, texts3); // 501호
        createClickableArea(this, 760, 215, 125, 200, texts4); // 502호
        createClickableArea(this, 1760, 215, 125, 200, texts5, true); // 비상구
        createClickableArea(this, 2030, 215, 125, 200, texts6); // 엘레베이터

        this.input.on('pointerdown', (pointer) => {
            if (isChoicesVisible || isDialogActive) return;

            if (gamePhase === 'dialogue') {
                if (currentIndex < currentTexts.length) {
                    dialogText.setText(currentTexts[currentIndex]);
                    currentIndex++;
                }
            } else if (gamePhase == 'nextTexts') {
                if (currentIndex < currentTexts.length) {
                    dialogText.setText(currentTexts[currentIndex]);
                    if (currentTexts[currentIndex] === "[메모3]을 획득했다.") {
                        console.log('메모3 조건 충족');
                        showItemImage('memo3');
                        addItemToInventory('메모3', 'memo3');
                    }
                    if (currentTexts[currentIndex] === "[메모4]을 획득했다.") {
                        console.log('메모4 조건 충족');
                        showItemImage('memo4');
                        addItemToInventory('메모4', 'memo4');
                    }
                    currentIndex++;
                    if (currentIndex < currentTexts.length) {
                        dialogText.setText(currentTexts[currentIndex]);
                    } else {
                        dialogBox.setVisible(false);
                        dialogText.setVisible(false);
                        initialDialogClick = true;
                        isDialogActive = false; // 다이얼로그 비활성화 상태로 설정
                        setClickableAreasActive(true); // 클릭 영역 활성화
                    }
                }
            }
        });

        dialogBox.on('pointerdown', () => {
            if (!isChoicesVisible) { // 선택지가 없을 때만 클릭 가능
                if (gamePhase === 'nextTexts') {
                    advanceNextTexts();
                } else {
                    advanceDialogue();
                }
            }
        });
    }
    function createClickableArea(scene, x, y, width, height, callbackOrTexts, isEmergencyExit = false) {
        const clickArea = scene.add.zone(x, y, width, height).setOrigin(0).setInteractive();
        if (isEmergencyExit) {
            clickArea.on('pointerdown', () => {
                if (inventory.some(item => item.name === '비상구 열쇠')) {
                    game.scene.scenes[0].sound.play('openDoorSound');
                    game.scene.scenes[0].time.delayedCall(3000, () => {
                        game.scene.scenes[0].sound.play('stairWalkSound');
                    });
                    game.scene.scenes[0].time.delayedCall(5000, () => {
                        window.location.href = '${pageContext.request.contextPath}/bitCamp/floor7.do';
                    });
                } else {
                    showDialog(["비상구 문은 단단히 잠겨있다. \n아무래도 열쇠가 필요할 것 같다."]);
                }
            });
        } else {
            if (typeof callbackOrTexts === 'function') {
                clickArea.on('pointerdown', callbackOrTexts);
            } else {
                clickArea.on('pointerdown', () => showDialog(callbackOrTexts));
            }
        }
        clickAreas.push(clickArea); // 클릭 가능한 영역을 배열에 추가
    }

    function update() {
        dialogBox.x = camera.scrollX + config.width / 2;
        dialogBox.y = camera.scrollY + 530;

        dialogText.x = camera.scrollX + config.width / 2;
        dialogText.y = camera.scrollY + config.height - 70;

        teacherImage.x = camera.scrollX + 920;
        teacherImage.y = camera.scrollY + 400;

        modalBackground.x = camera.scrollX + config.width / 2;
        modalBackground.y = camera.scrollY + config.height / 2 - 180;
        modalText.x = camera.scrollX + config.width / 2;
        modalText.y = camera.scrollY + config.height / 2 - 300;

        if (inventoryBag) {
            inventoryBag.x = camera.scrollX + 1150;
            inventoryBag.y = camera.scrollY + 40;
        }
    }

    function viewSection(direction) {
        if (dialogBox.visible) return;

        currentSection += direction;
        if (currentSection < 0) currentSection = 0;
        if (currentSection >= totalSections) currentSection = totalSections - 1;

        camera.scrollX = sectionWidth * currentSection;
        camera.scrollY = 0;
    }

    function showDialog(texts, showTeacher) {
        dialogBox.setVisible(true);
        dialogText.setVisible(true);
        if (showTeacher) {
            teacherImage.setVisible(true);
        } else {
            teacherImage.setVisible(false);
        }
        currentTexts = texts;
        currentTextIndex = 0;
        advanceDialogue();
        initialDialogClick = false;
        isDialogActive = true; // 다이얼로그 활성화 상태로 설정
        setClickableAreasActive(false); // 클릭 영역 비활성화
    }

    function advanceDialogue() {
        if (currentTextIndex == 2 && currentTexts == texts0) {
            teacherImage.setVisible(true);
        }
        if (currentTextIndex < currentTexts.length) {
            dialogText.setText(currentTexts[currentTextIndex]);
            console.log('currentTextIndex:', currentTextIndex);
            console.log('currentTexts[currentTextIndex]:', currentTexts[currentTextIndex]);
            currentTextIndex++;
        } else {
            dialogBox.setVisible(false);
            dialogText.setVisible(false);
            teacherImage.setVisible(false);
            initialDialogClick = true;
            isDialogActive = false; // 다이얼로그 비활성화 상태로 설정
            setClickableAreasActive(true); // 클릭 영역 활성화
            if (currentTexts === texts0 || currentTexts === texts7 || currentTexts === texts8) {
                hideAlertIcon();
            }
        }
    }

    function advanceNextTexts() {
        if (currentTextIndex < currentTexts.length) {
            dialogText.setText(currentTexts[currentTextIndex]);
            if (currentTexts[currentTextIndex] === "[메모3]을 획득했다.") {
                showItemImage('memo3');
                addItemToInventory('메모3', 'memo3');
            }
            if (currentTexts[currentTextIndex] === "[메모4]을 획득했다.") {
                showItemImage('memo4');
                addItemToInventory('메모4', 'memo4');
            }
            if (currentTexts[currentTextIndex] === "[비상구 열쇠]를 획득했다.") {
                addItemToInventory('비상구 열쇠', 'key');
                thirdDialogTriggered = true; // 비상구 열쇠를 얻었을 때 상태 업데이트
            }
            currentTextIndex++;
        } else {
            dialogBox.setVisible(false);
            dialogText.setVisible(false);
            teacherImage.setVisible(false);
            initialDialogClick = true;
            isDialogActive = false; // 다이얼로그 비활성화 상태로 설정
            setClickableAreasActive(true); // 클릭 영역 활성화
            // 다이얼로그가 끝난 후 alertIcon을 숨기도록 설정
            if (currentTexts === texts0 || currentTexts === texts7 || currentTexts === texts8) {
                hideAlertIcon();
            }
        }
    }

    function showClickDialog() {
        dialogBox.setVisible(true);
        dialogText.setVisible(true);
        dialogText.setText("매니저님의 책상이다. 어디를 먼저 조사할까?");
        document.getElementById("prev-button").disabled = true;
        document.getElementById("next-button").disabled = true;

        showChoices();
        document.getElementById("prev-button").disabled = false;
        document.getElementById("next-button").disabled = false;
    }

    function showChoices() {
        isChoicesVisible = true;
        setClickableAreasActive(false); // Disable other interactive elements

        choices.forEach((choice, index) => {
            const buttonY = 400 + index * 60;
            const button = game.scene.scenes[0].add.text(camera.scrollX + config.width / 2 + 200, buttonY, choice.text, {
                fontFamily: 'KyoboHandwriting2023wsa',
                fontSize: '24px',
                color: '#000',
                backgroundColor: '#fff',
                padding: { x: 20, y: 10 },
                fixedWidth: 250
            }).setInteractive();

            button.on('pointerover', () => {
                document.body.style.cursor = 'pointer';
            });

            button.on('pointerout', () => {
                document.body.style.cursor = 'default';
            });

            button.on('pointerdown', () => {
                dialogBox.setVisible(true);
                if (choice.response) {
                    dialogText.setText(choice.response);
                }
                isChoicesVisible = false;
                setClickableAreasActive(true); // Re-enable other interactive elements

                choices.forEach((choice, idx) => {
                    const btn = game.scene.scenes[0].children.getByName(`choiceButton${idx}`);
                    if (btn) btn.destroy();
                });
                document.body.style.cursor = 'default';

                if (choice.nextTexts) {
                    currentTexts = choice.nextTexts;
                    currentTextIndex = 0;
                    gamePhase = 'nextTexts';
                    advanceNextTexts(); // 다이얼로그를 진행하는 함수 호출
                }

                if (choice.newChoices) {
                    game.scene.scenes[0].time.delayedCall(500, () => {
                        showNewChoices(choice.newChoices);
                    });
                }
            }).setName(`choiceButton${index}`);
        });
    }

    function showPasswordPrompt() {
        const promptContainer = document.createElement('div');
        promptContainer.style.position = 'fixed';
        promptContainer.style.top = '50%';
        promptContainer.style.left = '50%';
        promptContainer.style.transform = 'translate(-50%, -50%)';
        promptContainer.style.padding = '20px';
        promptContainer.style.backgroundColor = 'white';
        promptContainer.style.border = '2px solid black';
        promptContainer.style.zIndex = '1000';

        const promptLabel = document.createElement('label');
        promptLabel.innerText = '비밀번호를 입력하세요: ';
        promptLabel.style.fontFamily = 'KyoboHandwriting2023wsa';
        promptLabel.style.fontSize = '24px';

        const promptInput = document.createElement('input');
        promptInput.type = 'text';
        promptInput.maxLength = '4';
        promptInput.style.fontFamily = 'KyoboHandwriting2023wsa';
        promptInput.style.fontSize = '24px';
        promptInput.style.marginLeft = '10px';

        const promptButton = document.createElement('button');
        promptButton.innerText = '확인';
        promptButton.style.fontFamily = 'KyoboHandwriting2023wsa';
        promptButton.style.fontSize = '24px';
        promptButton.style.marginLeft = '10px';
        promptButton.onclick = () => {
            const password = promptInput.value;
            if (password === '1003') {
                dialogText.setText('철컥!하는 소리와 잠금이 풀렸다.\n[열쇠]를 획득했다.');
                addItemToInventory('열쇠', 'key');
                updateChoices();
                hideAlertIcon(); // 비밀번호 입력 후 열쇠를 얻으면 alertIcon을 숨기도록 설정
            } else {
                dialogText.setText('삐삑! 비밀번호가 틀린 것 같다.');
            }
            document.body.removeChild(promptContainer);
        };

        promptContainer.appendChild(promptLabel);
        promptContainer.appendChild(promptInput);
        promptContainer.appendChild(promptButton);
        document.body.appendChild(promptContainer);
    }

    function updateChoices() {
        choices.forEach(choice => {
            if (choice.text === "2. 오른쪽 책상을 둘러본다.") {
                choice.newChoices.forEach(newChoice => {
                    if (newChoice.text === "3. 서랍을 조사한다.") {
                        newChoice.text = "3. 열쇠로 서랍을 연다.";
                        newChoice.nextTexts = ["서랍이 열렸다.", "[비상구 열쇠]를 획득했다."];
                        newChoice.response = "[비상구 열쇠]를 획득했다.";
                        newChoice.onSelect = () => {
                            showDialog(newChoice.nextTexts, true); // 다이얼로그 출력 추가
                            addItemToInventory('비상구 열쇠', 'key');
                            removeItemFromInventory('열쇠');
                            game.scene.scenes[0].sound.play('drawerSound');
                            // 비상구 열쇠를 얻는 다이얼로그가 끝난 후 alertIcon을 숨기도록 설정
                            if (!thirdDialogTriggered) {
                                hideAlertIcon();
                            }
                        };
                    }
                });
            }
        });
    }

    const removeItemFromInventory = (itemName) => {
        inventory = inventory.filter(item => item.name !== itemName);
        inventoryImages = inventoryImages.filter(image => image.name !== itemName);
        updateInventoryDisplay();
    };

    function setClickableAreasActive(active) {
        clickAreas.forEach(area => {
            area.input.enabled = active;
        });
        alertIcon.input.enabled = active;
    }
</script>
</body>

</html>
