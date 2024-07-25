<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1층</title>
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
            top: 8%;
            left: 8%;
            transform: translateX(-50%);
            font-family: 'KyoboHandwriting2023wsa';
            background: transparent;
            border: none;
            cursor: pointer;
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

    // 글로벌 변수로 정의
    let cctvChecked = localStorage.getItem('cctvChecked') === 'true';
    let elevatorRepairCompleted = localStorage.getItem('elevatorRepairCompleted') === 'true';

    function createClickableAreas(scene) {
        // 정문 클릭 영역
        createClickableZone(scene, 142, 310.5, 126, 201, () => {
            showDialogueWithChoices(scene, ["드디어 건물의 정문이다.", "(아직 강사님이 5층에 계시긴 한데..)", "먼저 한 번 나가볼까?"], handleTexts);
        });

        // 방재실(CCTV) 클릭 영역
        createClickableZone(scene, 387.5, 311, 129, 198, () => {
            window.location.href = '${pageContext.request.contextPath}/bitCamp/101Room.do';
        });

        // 비상계단 클릭 영역
        createClickableZone(scene, 611.5, 281.5, 133, 253, () => {
            if (localStorage.getItem('cctvChecked') === 'true') {
                showDialogue(["빨리 5층으로 이동해보자.", "...!", "천장에서 무너져내린 돌덩이 때문에 계단이 막혀있다.", "아무래도 아까 난 소리는 이것 때문인듯 하다.", "5층으로 올라갈 다른 방법을 찾아보자."]);
            } else {
                showDialogue(["여기까지 왔는데 굳이 돌아갈 필요는 없어보인다.", "빠져나갈 방법을 좀 더 찾아보자."]);
            }
        });

        // 엘리베이터 클릭 영역
        createClickableZone(scene, 1309.5, 261, 321, 296, () => {
            const hasNewspaper = inventory.includes("옛날 신문기사");
            const hasPhoto = inventory.includes("누군가의 옛날 사진");
            if (cctvChecked && elevatorRepairCompleted) {
                showDialogue(["엘리베이터는 이제 작동한다.", "5층으로 이동할 수 있다."]);
                localStorage.setItem('cctvChecked', 'false');
                localStorage.setItem('elevatorRepairCompleted', 'false');
                setTimeout(() => {
                    if (hasNewspaper && hasPhoto) {
                        window.location.href = '${pageContext.request.contextPath}/bitCamp/floor5_endT.do';
                    } else {
                        window.location.href = '${pageContext.request.contextPath}/bitCamp/floor5_endN.do';
                    }
                }, 3000); // 3초 후 페이지 이동
            } else if (localStorage.getItem('cctvChecked') === 'true') {
                showDialogue(["아직도 엘리베이터는 작동할 기미가 보이지 않는다.", "방재실에서 수리할 방법을 찾아봐야할 것 같다."]);
            } else if (localStorage.getItem('cctvChecked') === 'true') {
                showDialogue(["굳이 엘리베이터를 탈 필요는 없어보인다.", "다른 곳을 좀 더 조사해보자."]);
            } else {
                showDialogue(["아직도 엘리베이터는 작동할 기미가 보이지 않는다.", "1층에 엘리베이터 관리하는 곳이 있었던 것 같긴 한데.."]);
            }
        });

        // 화장실 클릭 영역
        createClickableZone(scene, 1816, 306.5, 400, 203, () => showDialogue(["화장실이다.", "잠겨서 들어갈 수 없지만, 다행히 볼 일이 있진 않다."]));
    }

    const handleTexts = (scene) => {
        const choices = [
            {
                text: "예",
                nextTexts: ["정문을 열자 갑자기 눈앞이 빙그르르 돌기 시작한다."],
                action: () => {
                    dialogText.setText(choices[0].nextTexts[0]);
                    createSwirlEffect(scene, () => {
                        let textSequence = [
                            "정문에서 빠져나가지 못하고 다시 원래대로 돌아왔다.",
                            "이곳에 갇혀버린 것 같다. 다른 출구를 찾아보자."
                        ];
                        let currentIndex = -1; // 초기 인덱스 설정

                        const advanceText = () => {
                            currentIndex++;
                            if (currentIndex < textSequence.length) {
                                dialogText.setText(textSequence[currentIndex]);
                                dialogBox.once('pointerdown', advanceText);
                            } else {
                                dialogBox.setVisible(false);
                                dialogText.setVisible(false);
                            }
                        };

                        advanceText(); // 최초 호출로 텍스트 시작
                    });
                }
            },
            {
                text: "아니오",
                nextTexts: ["다른 곳부터 살펴보자."],
                action: () => {
                    dialogText.setText(choices[1].nextTexts[0]);
                    dialogBox.once('pointerdown', () => {
                        dialogBox.setVisible(false);
                        dialogText.setVisible(false);
                    });
                }
            }
        ];

        showChoicesDialog(scene, choices, "정문을 통해 건물에서 나가시겠습니까?");
    };

    // 배경 이미지 소용돌이 효과 및 텍스트 업데이트
    const createSwirlEffect = (scene, onComplete) => {
        // bgImage의 원점을 중앙으로 설정
        bgImage.setOrigin(0.28, 0.5);
        bgImage.setPosition(scene.cameras.main.width / 2, scene.cameras.main.height / 2);

        // 이미지가 중앙에서 일그러지면서 축소되고 회전하는 효과
        scene.tweens.add({
            targets: bgImage,
            scaleX: 0.1, // 축소
            scaleY: 0.1, // 축소
            rotation: Phaser.Math.DegToRad(3600), // 360도 10번 회전
            duration: 2000, // 2초 동안
            ease: 'Cubic.easeInOut',
            onComplete: () => {
                // 축소 및 회전 후 다시 원래 크기와 각도로 복구
                scene.tweens.add({
                    targets: bgImage,
                    scaleX: 1, // 원래 스케일로 확대
                    scaleY: 1, // 원래 스케일로 확대
                    rotation: 0,  // 각도 초기화
                    duration: 2000,
                    ease: 'Cubic.easeInOut',
                    onComplete: () => {
                        bgImage.setOrigin(0, 0);
                        bgImage.setPosition(0, 0); // 원래 위치로 복귀
                        changeBackground(scene, 'background');
                        if (onComplete) onComplete();
                        createClickableAreas(scene);  // 클릭 영역을 다시 생성
                    }
                });
            }
        });
    };

    function showDialogueWithChoices(scene, texts, onComplete) {
        resetDialog(scene);  // 대화 상자 초기화 함수 호출
        let textIndex = 0;
        dialogText.setText(texts[textIndex]);

        dialogBox.on('pointerdown', () => {
            if (textIndex < texts.length - 1) {
                textIndex++;
                dialogText.setText(texts[textIndex]);
            } else {
                dialogBox.off('pointerdown');
                onComplete(scene);
            }
        });
    }

    function resetDialog(scene) {
        dialogBox.setVisible(true);
        dialogText.setVisible(true);
        dialogBox.clearTint();
        dialogBox.removeAllListeners();  // 기존 이벤트 리스너 제거
        dialogText.setText('');
    }

    function showChoicesDialog(scene, choices, promptText) {
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
                // 선택지에 연결된 액션 실행 (있는 경우)
                if (choice.action) {
                    choice.action(scene, button);
                } else {
                    dialogText.setText(choice.nextTexts.join("\n")); // 선택지 결과로 대화 업데이트
                    dialogBox.once('pointerdown', () => {
                        dialogBox.setVisible(false);
                        dialogText.setVisible(false);
                        document.body.style.cursor = 'default'; // 커서를 기본 상태로 복원
                    });
                }
                // 선택지 버튼 제거
                choiceButtons.forEach(btn => btn.destroy());
                document.body.style.cursor = 'default'; // 선택 후 커서를 기본 상태로 복원
            });

            choiceButtons.push(button); // 생성된 버튼을 배열에 추가
        });
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
        this.load.image('background', '/static/images/bitCamp/1floorBD.png');
        this.load.image('dialogueBox', '/static/images/bitCamp/wallpaper-torn-paper-ripped-white-paper.png');
        this.load.image('bag', '/static/images/bitCamp/bag.svg');
        this.load.image('key', '/static/images/bitCamp/key.png');
        this.load.image('photo', '/static/images/bitCamp/photo.png');
        this.load.image('photo_enlarge', '/static/images/bitCamp/photograph.png');
        this.load.image('newspaper', '/static/images/bitCamp/newspaper.png');
        this.load.image('newspaper_enlarge', '/static/images/bitCamp/newspaper_enlarge.png');
        this.load.audio('doorstopSound', '/static/sounds/bitCamp/문 덜컹덜컹.mp3');
        this.load.audio('bagSound', '/static/sounds/bitCamp/가방 여는 소리.wav');
        this.load.audio('itemSound', '/static/sounds/bitCamp/아이템 획득 소리.mp3');
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

        // 마우스 클릭 이벤트 리스너 수정
        this.input.on('pointerdown', function (pointer) {
            const x = pointer.x + camera.scrollX; // 현재 카메라의 스크롤 위치를 고려한 X 좌표
            const y = pointer.y + camera.scrollY; // 현재 카메라의 스크롤 위치를 고려한 Y 좌표
            console.log(`Mouse X: ${x}, Mouse Y: ${y}`);
        });
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

