<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>5층 502호</title>
    <link rel="icon" href="images/bitcamp_favicon.ico" type="image/x-icon">
    <script src="https://cdn.jsdelivr.net/npm/phaser@3.55.2/dist/phaser.js"></script>
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
            background-color: rgba(0, 0, 0, 1); /* 바깥 배경 어둡게 설정 */
        }
        #game-container {
            position: relative;
            width: 1280px;
            height: 720px;
            margin: 0 auto;
            overflow: hidden;
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
    <button id="settings-button" onclick="openSettings()"><img src="images/settings-icon.svg" alt="Settings"></button>
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
    let dialogueText, dialogueBox, backgrounds, currentBackgroundIndex = 0, isChoicesVisible = false, gamePhase = 'dialogue';

    // 인벤토리 관련 변수 및 함수
    let inventory = [];
    let inventoryImages = []; // 소지품 이미지들을 저장할 배열
    let inventoryText, inventoryBag, modal, modalBackground, modalText;
    let modalItems = []; // 모달에 추가된 소지품 이미지들을 저장할 배열
    let memo2Clicked = false; // memo2 클릭 여부를 추적하는 변수, 철사 얻는 직접적 힌트기 때문에

    // 소지품 칸을 초기화하는 함수
    const createInventory = (scene) => {
        // 가방 이미지 추가
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

        // 모달 창 생성
        modalBackground = scene.add.rectangle(scene.cameras.main.centerX, scene.cameras.main.centerY - 180, 800, 300, 0xFFFAFA).setAlpha(0).setInteractive(); // 배경색 변경 예시
        modalText = scene.add.text(scene.cameras.main.centerX, 60, '소지품', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '24px',
            fill: '#000000'
        }).setAlpha(0).setOrigin(0.5);
        modal = scene.add.container(0, 0, [modalBackground, modalText]).setAlpha(0);
    };

    // 소지품 칸에 아이템을 추가하는 함수
    const addItemToInventory = (item, imageKey) => {
        // 아이템이 이미 소지품에 있는지 확인
        if (!inventory.includes(item)) {
            inventory.push(item);
            inventoryImages.push({key: imageKey, name: item}); // 소지품 이미지와 이름을 저장
            updateInventoryDisplay();
        } else {
            console.log('아이템이 이미 소지품에 있습니다.');
        }
    };

    // 소지품 칸의 내용을 업데이트하는 함수
    const updateInventoryDisplay = () => {
        if (inventoryText) {
            inventoryText.setText(inventory.map(item => item.name).join('\n'));
        }
    };

    // 아이템 세부 정보를 표시하는 함수
    const showItemDetails = (scene, itemKey) => {
        // 확대해서 보여줄 이미지를 설정
        let enlargedImageKey;
        if (itemKey === 'memo1') {
            enlargedImageKey = 'memo1-1'; // memo1 클릭 시 보여줄 이미지
        } else if (itemKey === 'memo2') {
            enlargedImageKey = 'memo2-1'; // memo2 클릭 시 보여줄 이미지
        }

        // 전체화면 이미지를 추가하고 보이게 설정
        const fullscreenImage = scene.add.image(scene.cameras.main.centerX, scene.cameras.main.centerY, enlargedImageKey)
            .setDisplaySize(scene.cameras.main.width * 0.9, scene.cameras.main.height * 0.9)
            .setAlpha(0)
            .setInteractive();

        scene.tweens.add({
            targets: fullscreenImage,
            alpha: 1,
            duration: 500
        });

        // 클릭 이벤트를 추가하여 이미지를 클릭하면 페이드 아웃하고 제거
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

    // 인벤토리 모달 창을 토글하는 함수
    const toggleInventoryModal = (scene) => {
        scene.sound.play('bagSound'); // 가방 소리 재생

        if (modal.alpha === 0) {
            // 모달을 보이게 설정
            modal.setAlpha(1);
            modalBackground.setAlpha(0.8);
            modalText.setAlpha(1);

            // 소지품 이미지를 모달에 추가
            inventoryImages.forEach((imageObj, index) => {
                const itemImage = scene.add.image(scene.cameras.main.centerX - 300 + (index % 4) * 200, scene.cameras.main.centerY - 190 + Math.floor(index / 4) * 140, imageObj.key).setScale(0.3);
                const itemText = scene.add.text(scene.cameras.main.centerX - 300 + (index % 4) * 200, scene.cameras.main.centerY - 100 + Math.floor(index / 4) * 140, imageObj.name, {
                    fontFamily: 'KyoboHandwriting2023wsa',
                    fontSize: '25px', // 폰트 크기 조절
                    fill: '#000000'
                }).setOrigin(0.5);
                modal.add([itemImage, itemText]);
                modalItems.push(itemImage); // 추가된 소지품 이미지를 저장
                modalItems.push(itemText); // 추가된 소지품 텍스트를 저장

                // 메모 아이템에 대한 클릭 이벤트 추가
                if (imageObj.key === 'memo1' || imageObj.key === 'memo2') {
                    if (imageObj.key === 'memo2') {
                        memo2Clicked = true; // memo2가 클릭되었음을 기록
                    }
                    itemImage.setInteractive();
                    itemImage.on('pointerdown', () => {
                        showItemDetails(scene, imageObj.key);
                    });
                    // 마우스 커서를 올렸을 때 손모양 커서로, 빠져나가면 원래 커서로 변경
                    itemImage.on('pointerover', () => {
                        document.body.style.cursor = 'pointer';
                    });
                    itemImage.on('pointerout', () => {
                        document.body.style.cursor = 'default';
                    });
                }
            });
        } else {
            // 모달을 숨김
            modal.setAlpha(0);
            modalBackground.setAlpha(0);
            modalText.setAlpha(0);

            // 모달에 추가된 소지품 이미지를 제거
            modalItems.forEach(item => item.destroy());
            modalItems = []; // 소지품 이미지 배열 초기화
        }
    };


    function preload() {
        this.load.image('background1', 'static/images/bitCamp/wake01.png');
        this.load.image('background2', 'static/images/bitCamp/mySeat.png');
        this.load.image('background3', 'static/images/bitCamp/room502.png');
        this.load.image('background4', 'static/images/bitCamp/room502door.png');
        this.load.image('dialogueBox', 'static/images/bitCamp/wallpaper-torn-paper-ripped-white-paper.png');
        this.load.image('cable', 'static/images/bitCamp/cable.png');
        this.load.image('scissors', 'static/images/bitCamp/scissors.png');
        this.load.image('memo1', 'static/images/bitCamp/memo1.png');
        this.load.image('memo2', 'static/images/bitCamp/memo2.png');
        this.load.image('memo1-1', 'static/images/bitCamp/memo1-1.png');
        this.load.image('memo2-1', 'static/images/bitCamp/memo2-1.png');
        this.load.image('bag', 'static/images/bitCamp/bag.svg');
        this.load.audio('doorstopSound', 'static/sounds/bitCamp/문 덜컹덜컹.mp3');
        this.load.audio('paperSound', 'static/sounds/bitCamp/종이 넘기는 소리.mp3');
        this.load.audio('openDoorSound', 'static/sounds/bitCamp/열쇠로 문여는소리.mp3');
        this.load.audio('bagSound', 'static/sounds/bitCamp/가방 여는 소리.wav');
        this.load.audio('itemSound', 'static/sounds/bitCamp/아이템 획득 소리.mp3');
    }

    function create() {
        backgrounds = [
            this.add.image(config.width / 2, config.height / 2, 'background1').setDisplaySize(config.width, config.height),
            this.add.image(config.width / 2, config.height / 2, 'background2').setDisplaySize(config.width, config.height).setAlpha(0),
            this.add.image(config.width / 2, config.height / 2, 'background3').setDisplaySize(config.width, config.height).setAlpha(0),
            this.add.image(config.width / 2, config.height / 2, 'background4').setDisplaySize(config.width, config.height).setAlpha(0),
        ];

        dialogueBox = this.add.image(config.width / 2, 530, 'dialogueBox').setOrigin(0.5, 0);

        createInventory(this);  // 소지품 칸 초기화 호출

        // showItemDetails 함수를 바인딩
        this.showItemDetails = showItemDetails.bind(this);


        const texts1 = ["여긴 어디지..."];
        const texts2 = ["뭔가 익숙한... 내 자리?", "학원에서 공부하다가 깜박 잠들었구나"];
        const texts3 = ["얼마나 잔거지?", "불까지 전부 꺼져있는 걸 보니 한참을 잔 모양이다.", "경비원 아저씨가 내가 있는지 모르고 끄고 가신걸까?", "어쨌든 늦었으니 빨리 집으로 돌아가자.", "...어라?", "문이 열리지 않는다.", "잘보니 문에 못보던 자물쇠가 달려있다.", "이게 대체 무슨..."];
        const texts4 = ["문을 열어보려 했지만 강철문처럼 꼼짝도 하지 않는다.", "일단 주위에 쓸만한 물건이 없는지 살펴보자."];
        const texts5 = ["어디부터 조사해볼까?"];

        let currentIndex = 0;
        let currentTexts = texts1;

        dialogueText = this.add.text(config.width / 2, config.height - 70, '', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '35px',
            fill: '#000000'
        }).setOrigin(0.5).setAlign('center');

        // 검은색 사각형을 생성하여 화면 덮기
        const blackout = this.add.rectangle(0, 0, config.width, config.height, 0x000000).setOrigin(0).setAlpha(1);

        // 눈 깜빡임 상태를 나타내는 변수 추가
        let isBlinking = true;

        // 눈을 감았다 뜨는 효과 함수
        const blinkEffect = () => {
            return this.tweens.timeline({
                targets: blackout,
                tweens: [
                    { alpha: 1, duration: 300, ease: 'Linear' }, // 화면을 검게
                    { alpha: 0, duration: 300, ease: 'Linear', hold: 500 }, // 다시 밝게
                    { alpha: 1, duration: 300, ease: 'Linear', hold: 500 },
                    { alpha: 0, duration: 300, ease: 'Linear', onComplete: () => {
                            isBlinking = false; // 눈 깜빡임이 완료되었음을 나타냄
                            startDialogue(); // 대사 시작
                        } }
                ]
            });
        };

        // 대사를 시작하는 함수
        const startDialogue = () => {
            dialogueText.setText(currentTexts[currentIndex]);
            currentIndex++;
        };

        // 이미지 표시 함수
        const showItemImage = (imageKey) => {
            const itemImage = this.add.image(config.width / 2, config.height / 2, imageKey).setScale(0.5).setAlpha(0);

            if (imageKey === 'memo1' || imageKey === 'memo2') {
                this.sound.play('paperSound'); // 메모 획득 효과음
            } else {
                this.sound.play('itemSound'); // 아이템 획득 효과음
            }

            this.tweens.add({
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

        // 현재 배경을 페이드아웃하는 함수
        const fadeOutCurrentBackground = () => {
            return this.tweens.add({
                targets: backgrounds[currentBackgroundIndex],
                alpha: 0,
                duration: 150,
            });
        };

        // 다음 배경을 페이드인하는 함수
        const fadeInNextBackground = (nextIndex) => {
            currentBackgroundIndex = nextIndex;
            backgrounds[currentBackgroundIndex].setAlpha(0); // 미리 배경을 투명하게 설정
            return this.tweens.add({
                targets: backgrounds[currentBackgroundIndex],
                alpha: 1,
                duration: 150,
                onComplete: () => {
                    // 텍스트 할당 로직을 조건에 따라 수정
                    if (gamePhase === 'dialogue') {
                        switch (currentBackgroundIndex) {
                            case 1:
                                currentTexts = texts2;
                                break;
                            case 2:
                                currentTexts = currentTexts === texts4 ? texts5 : texts3;
                                break;
                            case 3:
                                currentTexts = texts4;
                                break;
                            default:
                                currentTexts = [];
                        }
                        currentIndex = 0;
                        dialogueText.setText(currentTexts[currentIndex]);
                        if (currentBackgroundIndex === 2 && currentTexts === texts5) {
                            // texts5가 끝나면 선택지를 표시하는 조건 추가
                            this.time.delayedCall(1000, () => {
                                showChoices();
                            });
                        }
                    }
                }
            });
        };

        // 선택지를 표시하는 함수
        const showChoices = () => {
            isChoicesVisible = true;
            gamePhase = 'choices';
            const choices = [
                {
                    text: "1. 책상을 둘러본다.",
                    newChoices: [
                        { text: "1. 필기도구함을 조사한다.", nextTexts: ["...", "[가위]를 획득했다.", "이걸로 자물쇠를 자를 수는 없겠지만 어딘가 쓸 데가 있지 않을까"] },
                        { text: "2. 누군가의 가방을 조사한다.", nextTexts: ["가방에는 온갖 코딩책들이 들어있다.", "이걸 6개월만에 다 배우려고 하니까 미쳐버린게 분명해", "...", "아쉽지만 유용한 물건은 없는 듯 하다."] },
                        { text: "3. 책상 위를 조사한다.", nextTexts: ["책상 위에는 학생들의 온갖 소지품들이 어지럽게 놓여져있다.", "...", "어?", "모니터에 메모가 하나 붙어있다.", "[수상한 메모1]을 획득했다.", "못보던 글씨체인데 누가 쓴걸까?"] }
                    ]
                },
                {
                    text: "2. 앞쪽을 둘러본다.",
                    newChoices: [
                        { text: "1. 메인 TV를 조사한다.", nextTexts: ["매일 강의할 때 보던 커다란 TV다.", "...", "[HDMI 케이블]을 획득했다.", "로프 대용으로 쓸 수 있지 않을까? 일단 챙겨두자."] },
                        { text: "2. 화이트보드를 조사한다.", nextTexts: ["화이트보드에 못 보던 글들이 적혀있다", "\"내보내줘내보내줘내보내줘\", \"Java를 Java볼 수 있을테면 Javava\"", "..."] },
                        { text: "3. 강사님 자리를 조사한다.", nextTexts: ["온갖 최신장비가 가득한 강사님의 자리다.", "이 키보드만 해도 100만원이 넘는다던데..", "...", "응?", "잘보니 키보드 아래에 뭔가 끼여져있다.", "[수상한 메모2]를 획득했다.", "강사님 글씨체는 아닌데 누가 여기 둔걸까?"] }
                    ]
                },
                {
                    text: "3. 문을 다시 살펴본다.",
                    newChoices: [
                        { text: "1. 자물쇠를 조사한다.", nextTexts: ["굉장히 옛날 자물쇠로 보인다.", "구멍이 있는 걸로 봐선 열쇠가 필요해보인다.", "여기서 열쇠를 어떻게 구하지.."] },
                        { text: "2. 주위를 둘러본다.", nextTexts: ["분명 매일 보던 장소일텐데 뭔가 위화감이 느껴진다.", "분위기도 이상하고, 건물 자체가 평소보다 낡아보이는 듯한..", "..기분 탓이겠지?"] }
                    ]
                }
            ];

            // 조건이 충족되면 새로운 선택지를 추가
            if (memo2Clicked && inventory.includes('가위') && inventory.includes('HDMI 케이블')) {
                choices[2].newChoices.push(
                    { text: "3. 특수한 방법을 사용한다.", nextTexts: ["(메모에서 본 대로라면..)", "가위로 HDMI 케이블의 피복을 벗겨내고 [철사]를 획득했다!", "[철사]를 이용해서 자물쇠를 해제했다.", "드디어 문이 열렸다!", ""], style: { fill: '#FF0000' }, action: () => { window.location.href = '../BitCamp/floor5.html'; } }
                );
            }

            choices.forEach((choice, index) => {
                const buttonY = 400 + index * 60; // 버튼 Y 위치 조정
                const button = this.add.text(config.width - 420, buttonY, choice.text, {
                    fontFamily: 'KyoboHandwriting2023wsa',
                    fontSize: '24px', // 폰트 크기
                    fill: '#000', // 기본 텍스트 색상
                    backgroundColor: '#fff',
                    padding: { x: 20, y: 10 }, // 패딩
                    fixedWidth: 250 // 버튼 너비
                }).setInteractive();

                // 스타일 적용
                if (choice.style) {
                    button.setStyle(choice.style);
                }

                button.on('pointerover', () => {
                    document.body.style.cursor = 'pointer'; // 마우스를 올렸을 때 커서 모양 변경
                });

                button.on('pointerout', () => {
                    document.body.style.cursor = 'default'; // 마우스가 버튼에서 벗어났을 때 커서 모양 원래대로
                });

                button.on('pointerdown', () => {
                    console.log(choice.text + ' 선택됨');
                    dialogueBox.setVisible(true); // 선택 후 텍스트 박스 다시 보이기
                    if (choice.response) {
                        dialogueText.setText(choice.response); // 선택에 따른 텍스트 출력
                    }
                    isChoicesVisible = false; // 선택 후 다시 텍스트를 보여줄 수 있게 함
                    // 선택지 버튼들을 제거
                    choices.forEach((choice, idx) => {
                        this.children.getByName(`choiceButton${idx}`).destroy();
                    });
                    document.body.style.cursor = 'default'; // 선택 후 커서 모양 원래대로

                    // nextTexts 처리 추가
                    if (choice.nextTexts) {
                        currentTexts = choice.nextTexts;
                        currentIndex = 0;
                        gamePhase = 'nextTexts';
                        dialogueText.setText(currentTexts[currentIndex]);
                        currentIndex++;

                        // nextTexts가 완료된 후 action 수행
                        const checkNextTextsComplete = () => {
                            if (currentIndex >= currentTexts.length) {
                                if (choice.action) {
                                    choice.action();
                                }
                            } else {
                                setTimeout(checkNextTextsComplete, 100); // 0.1초 후 다시 확인
                            }
                        };
                        checkNextTextsComplete();
                    }

                    // 새로운 선택지 표시
                    if (choice.newChoices) {
                        this.time.delayedCall(500, () => {
                            showNewChoices(choice.newChoices);
                        });
                    }
                }).setName(`choiceButton${index}`);
            });
        };

        // 선택지 안의 선택지에 대한 함수
        const showNewChoices = (newChoices) => {
            isChoicesVisible = true;
            gamePhase = 'newChoices';
            newChoices.forEach((choice, index) => {
                const buttonY = 400 + index * 60; // 버튼 Y 위치 조정
                const button = this.add.text(config.width - 420, buttonY, choice.text, {
                    fontFamily: 'KyoboHandwriting2023wsa',
                    fontSize: '24px', // 폰트 크기
                    fill: '#000', // 기본 텍스트 색상
                    backgroundColor: '#fff',
                    padding: { x: 20, y: 10 }, // 패딩
                    fixedWidth: 250 // 버튼 너비
                }).setInteractive();

                // 스타일 적용
                if (choice.style) {
                    button.setStyle(choice.style);
                }

                button.on('pointerover', () => {
                    document.body.style.cursor = 'pointer'; // 마우스를 올렸을 때 커서 모양 변경
                });

                button.on('pointerout', () => {
                    document.body.style.cursor = 'default'; // 마우스가 버튼에서 벗어났을 때 커서 모양 원래대로
                });

                button.on('pointerdown', () => {
                    console.log(choice.text + ' 선택됨');
                    dialogueBox.setVisible(true); // 선택 후 텍스트 박스 다시 보이기
                    if (choice.response) {
                        dialogueText.setText(choice.response); // 선택에 따른 텍스트 출력
                    }
                    isChoicesVisible = false; // 선택 후 다시 텍스트를 보여줄 수 있게 함
                    // 선택지 버튼들을 제거
                    newChoices.forEach((choice, idx) => {
                        this.children.getByName(`newChoiceButton${idx}`).destroy();
                    });
                    document.body.style.cursor = 'default'; // 선택 후 커서 모양 원래대로

                    // nextTexts 처리 추가
                    if (choice.nextTexts) {
                        currentTexts = choice.nextTexts;
                        currentIndex = 0;
                        gamePhase = 'nextTexts';
                        dialogueText.setText(currentTexts[currentIndex]);
                        currentIndex++;

                        // 이미지 표시
                        if (choice.imageKey) {
                            showItemImage(choice.imageKey);
                        }

                        // nextTexts가 완료된 후 action 수행
                        const checkNextTextsComplete = () => {
                            if (currentIndex >= currentTexts.length) {
                                if (choice.action) {
                                    choice.action();
                                }
                            } else {
                                setTimeout(checkNextTextsComplete, 100); // 0.1초 후 다시 확인
                            }
                        };
                        checkNextTextsComplete();
                    }
                }).setName(`newChoiceButton${index}`);
            });
        };





        let isDebounced = false;
        const debounceTime = 500; // 디바운스 시간(ms)

        // 텍스트와 배경을 관리하는 로직
        // 다음 텍스트가 끝난 후 선택지로 돌아가는 로직을 추가
        this.input.on('pointerdown', () => {
            if (isBlinking) return; // 눈 깜빡임 상태일 때 클릭 무시

            if (isDebounced) return; // 디바운스 상태일 때 클릭 무시
            isDebounced = true; // 디바운스 시작
            this.time.delayedCall(debounceTime, () => {
                isDebounced = false; // 디바운스 해제
            });

            if (isChoicesVisible) return; // 선택지가 보이는 동안에는 다른 입력 무시
            if (gamePhase === 'dialogue') {
                if (currentIndex < currentTexts.length) {
                    dialogueText.setText(currentTexts[currentIndex]);
                    currentIndex++;
                } else {
                    if (currentBackgroundIndex === 3 && currentTexts === texts4) { // texts4가 끝나면 background4에서 background3으로 돌아감
                        fadeOutCurrentBackground().on('complete', () => {
                            fadeInNextBackground(2); // background3을 페이드인
                        });
                    } else if (currentBackgroundIndex < backgrounds.length - 1) {
                        fadeOutCurrentBackground().on('complete', () => {
                            fadeInNextBackground(currentBackgroundIndex + 1);
                        });
                    } else if (currentBackgroundIndex === 2 && currentTexts === texts5) {
                        // texts5가 끝나면 선택지 표시, 반복 방지
                        showChoices();
                    }
                }
            } else if (gamePhase === 'nextTexts') {
                if (currentIndex < currentTexts.length) {
                    dialogueText.setText(currentTexts[currentIndex]);
                    if (currentTexts[currentIndex] === "[가위]를 획득했다.") {
                        showItemImage('scissors');
                        addItemToInventory('가위', "scissors");
                    }
                    if (currentTexts[currentIndex] === "[수상한 메모1]을 획득했다.") {
                        showItemImage('memo1');
                        addItemToInventory('수상한 메모1', "memo1");
                    }
                    if (currentTexts[currentIndex] === "[수상한 메모2]를 획득했다.") {
                        showItemImage('memo2');
                        addItemToInventory('수상한 메모2', "memo2");
                    }
                    if (currentTexts[currentIndex] === "[HDMI 케이블]을 획득했다.") {
                        showItemImage('cable');
                        addItemToInventory('HDMI 케이블', "cable");
                    }
                    currentIndex++;
                } else {
                    // nextTexts가 끝나면 선택지로 돌아감
                    dialogueText.setText('또 어디를 조사해볼까?'); // 텍스트 초기화
                    showChoices();
                }
            }
        });

        // 게임 시작 시 눈 깜빡임 효과 후 대사 시작
        blinkEffect();
    }

    function update() {
    }
</script>
</body>
</html>
