<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>5층</title>
    <script src="/static/js/bitCamp/timer.js"></script>
    <link rel="icon" href="/static/images/bitCamp/bitcamp_favicon.ico" type="image/x-icon">
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
            inventoryImages.push({ key: imageKey, name: item }); // 소지품 이미지와 이름을 저장
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
        this.load.image('background1', '/static/images/bitCamp/end_door.png');
        this.load.image('background2', '/static/images/bitCamp/light.png');
        this.load.image('background3', '/static/images/bitCamp/morning.png');
        this.load.image('background4', '/static/images/bitCamp/dark.png');
        this.load.image('background5', '/static/images/bitCamp/end_alone.png');
        this.load.image('dialogueBox', '/static/images/bitCamp/wallpaper-torn-paper-ripped-white-paper.png');
        this.load.image('bag', '/static/images/bitCamp/bag.svg');
        this.load.image('teacher', '/static/images/bitCamp/teacher.png');
    }


    function create() {
        backgrounds = [
            this.add.image(config.width / 2, config.height / 2, 'background1').setDisplaySize(config.width, config.height),
            this.add.image(config.width / 2, config.height / 2, 'background2').setDisplaySize(config.width, config.height).setAlpha(0),
            this.add.image(config.width / 2, config.height / 2, 'background3').setDisplaySize(config.width, config.height).setAlpha(0),
            this.add.image(config.width / 2, config.height / 2, 'background4').setDisplaySize(config.width, config.height).setAlpha(0),
            this.add.image(config.width / 2, config.height / 2, 'background5').setDisplaySize(config.width, config.height).setAlpha(0),
        ];

        dialogueBox = this.add.image(config.width / 2, 530, 'dialogueBox').setOrigin(0.5, 0);

        createInventory(this);  // 소지품 칸 초기화 호출

        // showItemDetails 함수를 바인딩
        this.showItemDetails = showItemDetails.bind(this);

        const texts1 = ["빛...?","5층에 도착하니 502호의 강의실 문에서 희미한 빛이 흘러나오고 있었고", "강사님이 그 앞에 서계셨다.", "강사님: 엇 마침 오셨군요.", "(강사님에게 어떻게 된 일인지 묻는다)", "강사님: 아 그게.. 저도 어떻게 된 일인지 잘 모르겠는데", "강사님: 갑자기 문이 열리면서 보시는 것처럼 빛이 나오네요.", "강사님: 들어가봐야하나 고민하던 차에 마침 오신거라..", "강사님의 말투가 뭔가 어색하지만 1층 입구에서도 빠져나가지 못한 지금", "탈출로 이어질 가능성이 제일 높아보이는 이 문을 무시할 수는 없다.", "강사님께 한 번 들어가보자고 제안해보자",
            "강사님: 넵 그럼 같이 들어가보죠.", "강사님: 설마 무슨 일이 생기진 않겠지..", "(강사님과 같이 문을 통과한다)", "(시야가 빛으로 메워지고 정신이 아득해진다)"];
        const texts4 = ["...", "... ... ... ..."];
        const texts5 = ["??: xx님! xx님!", "(정신을 차려보니 502호실이었고, 옆에서 강사님이 나를 깨우고 있었다)", "강사님: 휴 다행이다.", "강사님: 무슨 일이 생긴 건 아닐까 걱정했네요.", "강사님: 이렇게 늦게까지 공부하고 계셨던 거에요?", "강사님: 금요일인데 너무 무리하지 마시고 그만 들어가서 쉬세요.",
            "강사님의 말이 뭔가 이상하다.", "강사님께 학원에 갇혔던 일에 대해서 얘기해보자.", "강사님: 네? 그게 무슨..", "강사님: 방금 전까지 사탕 빨다가 들어왔는데.. \n 혹시 무슨 몰래카메라 같은 건가요?", "내가 겪었던 일들이 설마 꿈이었던걸까?\n1층으로 가서 직접 확인해보자"
        ];
        const texts6 = ["(강사님과 함께 엘리베이터를 타고 1층으로 향한다)", "(엘리베이터도, 1층 입구도 아무 문제 없었고, 무사히 바깥으로 나가는데 성공한다)", "강사님: 아무 일 없죠?", "강사님: 잠시 잠드셨을 때 꿈이라도 꾸셨나봐요.", "강사님: 아무튼 늦었는데 조심히 들어가세요~", "강사님: 저도 이만 들어가보겠습니다",
            "나는 넋이 나간 상태로 강사님께 인사를 드리고\n5층으로 돌아가 짐을 싼 뒤 집에 돌아갈 준비를 했다.", "정말 전부 꿈이었던걸까? 그렇지만.."
        ];
        const texts7 = ["(꿈이라기에는 너무 생생했던 기억을 곱씹으며,\n나는 7층에서 폭발에 살짝 다쳤던 상처를 바라본다)", "갇혔던 게 사실이었다고 해도 무사히 돌아왔으면 그걸로 족한 게 아닐까?", "(나는 찝찝한 느낌을 털어버리고 휴대폰으로 x튜브를 켜서 평소보던 채널의 영상을 튼다.)", "어찌됐든 좋은 게 좋은 거 아니겠어?", "집에 가서 주말동안 푹 쉬어야지.", "[엔딩1: 좋은 게 좋은 거 아니겠어?]"];

        let currentIndex = 0;
        let currentTexts = texts1;

        dialogueText = this.add.text(config.width / 2, config.height - 70, '', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '35px',
            fill: '#000000'
        }).setOrigin(0.5).setAlign('center');

        const startDialogue = () => {
            dialogueText.setText(currentTexts[currentIndex]);
            currentIndex++;
        };

        // 이미지 표시 함수
        const showItemImage = (imageKey) => {
            const itemImage = this.add.image(config.width / 2, config.height / 2, imageKey).setScale(0.5).setAlpha(0);

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
                            case 0:
                                currentTexts = texts1;
                                break;
                            case 1:
                                currentTexts = texts4;
                                break;
                            case 2:
                                currentTexts = texts5;
                                break;
                            case 3:
                                currentTexts = texts6;
                                break;
                            case 4:
                                currentTexts = texts7;
                                break;
                            default:
                                currentTexts = [];
                        }
                        currentIndex = 0;
                        dialogueText.setText(currentTexts[currentIndex]);
                    }
                }
            });
        };

        const startCredits = () => {
            const blackBackground = this.add.rectangle(config.width / 2, config.height / 2, config.width, config.height, 0x000000).setOrigin(0.5).setAlpha(1);
            const creditsText = [
                "개발: 김병주, 민수정",
                "스토리: 김병주",
                "아트: 민수정",
                "BGM: 최수민",
                "",
                "AND YOU"
            ];

            const credits = this.add.text(config.width / 2, config.height, creditsText.join('\n'), {
                fontFamily: 'KyoboHandwriting2023wsa',
                fontSize: '40px',
                fill: '#FFFFFF',
                align: 'center'
            }).setOrigin(0.5).setAlign('center');

            this.tweens.add({
                targets: credits,
                y: -credits.height,
                duration: 10000,
                ease: 'Linear',
                onComplete: () => {
                    // 크레딧이 끝난 후 메인 화면으로 돌아가는 버튼 추가
                    const mainMenuButton = this.add.text(config.width / 2, config.height / 2, '메인 화면으로 돌아가기', {
                        fontFamily: 'KyoboHandwriting2023wsa',
                        fontSize: '35px',
                        fill: '#FFFFFF',
                        backgroundColor: '#000000',
                        padding: { x: 20, y: 10 },
                        borderRadius: 5
                    }).setOrigin(0.5).setInteractive();

                    mainMenuButton.on('pointerdown', () => {
                        window.location.href = '${pageContext.request.contextPath}/index.jsp';
                    });
                }
            });
        };

        let isDebounced = false;
        const debounceTime = 500; // 디바운스 시간(ms)

        // 텍스트와 배경을 관리하는 로직
        this.input.on('pointerdown', () => {

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
                    if (currentBackgroundIndex < backgrounds.length - 1) {
                        fadeOutCurrentBackground().on('complete', () => {
                            fadeInNextBackground(currentBackgroundIndex + 1);
                        });
                    } else if (currentTexts === texts7 && currentIndex >= currentTexts.length) {
                        // texts7이 끝나면 크레딧 시작
                        startCredits.call(this);
                    }
                }
            }
        });

        // 게임 시작 시 첫 대사 시작
        startDialogue();
    }



    function update() {
    }
</script>
</body>

</html>
