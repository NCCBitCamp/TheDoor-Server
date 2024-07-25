<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>5층</title>
    <script src="/static/js/bitCamp/timer.js"></script>
    <link rel="icon" href="/static/images/bitCamp/bitcamp_favicon.ico" type="image/x-icon">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    <button id="settings-button" onclick="openSettings()"><img src="/static/images/bitCamp/settings-icon.svg"
                                                               alt="Settings"></button>
</div>

<script>
    // console.log("롱메");
    document.addEventListener('DOMContentLoaded', function() {
        const elapsedTime = localStorage.getItem('elapsedTime');
        const msg = prompt(`클리어타임: \${localStorage.getItem('elapsedTime')}초\n
                    랭킹에 남길 메시지를 입력해주세요.`)
        const username = localStorage.getItem('username');
        const now = new Date();
        console.log(`\${now.getFullYear()}\${now.getMonth() + 1 > 10 ? now.getMonth() + 1 : "0" + (now.getMonth() + 1)}\${now.getDate() > 10 ? now.getDate() : "0" + now.getDate()}T\${now.getHours() > 10 ? now.getHours() : "0" + now.getHours()}:\${now.getMinutes() > 10 ? now.getMinutes() : "0" + now.getMinutes()}:\${now.getSeconds() > 10 ? now.getSeconds() : "0" + now.getSeconds()}`);
        $.ajax({
            url: '/main/ranking',
            type: 'POST',
            data: {
                rank_id: username,
                playdate: `\${now.getFullYear()}-\${now.getMonth() + 1 >= 10 ? now.getMonth() + 1 : "0" + (now.getMonth() + 1)}-\${now.getDate() >= 10 ? now.getDate() : "0" + now.getDate()}T\${now.getHours() >= 10 ? now.getHours() : "0" + now.getHours()}:\${now.getMinutes() >= 10 ? now.getMinutes() : "0" + now.getMinutes()}:\${now.getSeconds() >= 10 ? now.getSeconds() : "0" + now.getSeconds()}`,
                playtime: elapsedTime,
                gametype: 'bitCamp',
                comment: msg
            },
            success: function(data) {
                console.log(data);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('AJAX Error:', textStatus);
                console.error('Error Thrown:', errorThrown);
                console.error('Response Text:', jqXHR.responseText);
            }
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
        this.load.image('background1', '/static/images/bitCamp/5floorD.png');
        this.load.image('background2', '/static/images/bitCamp/end_door.png');
        this.load.image('background3', '/static/images/bitCamp/light.png');
        this.load.image('background4', '/static/images/bitCamp/morning.png');
        this.load.image('background5', '/static/images/bitCamp/dark.png');
        this.load.image('background6', '/static/images/bitCamp/5floorD.png');
        this.load.image('background7', '/static/images/bitCamp/end_together.png');
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
            this.add.image(config.width / 2, config.height / 2, 'background6').setDisplaySize(config.width, config.height).setAlpha(0),
            this.add.image(config.width / 2, config.height / 2, 'background7').setDisplaySize(config.width, config.height).setAlpha(0),
        ];

        dialogueBox = this.add.image(config.width / 2, 530, 'dialogueBox').setOrigin(0.5, 0);

        createInventory(this);  // 소지품 칸 초기화 호출

        // showItemDetails 함수를 바인딩
        this.showItemDetails = showItemDetails.bind(this);

        const texts1 = ["강사님: 엇 마침 오셨군요.", "(강사님에게 어떻게 된 일인지 묻는다)", "강사님: 가져다주신 힌트 덕에 \n드디어 여기서 나갈 방법을 찾았거든요.", "이 쪽으로 와보세요.", "(강사님이 502호실의 문 앞으로 향한다.)", "(문 자체는 평소 보던 강의실 문과 다를 바가 없었지만,\n이상하게 생긴 잠금장치가 여전히 그곳에 있었다)",
            "(분명 열쇠로 열리는 잠금장치일텐데...)", "(강사님이 잠금장치를 만지작거리자 비밀번호를 누르는 장치가 나왔고,\n강사님이 거기에 어떤 번호를 입력한다)", "(그러자 철컥 소리가 나면서 문이 열리고 거기선 강렬한 빛이 쏟아져나왔다)"
        ];
        const texts2 = ["강사님 이건 대체..?", "강사님: 일단 여기서 빠져나가고 생각하죠. 절 믿고 따라와주세요", "(강사님과 같이 문을 통과한다)", "(시야가 빛으로 메워지고 정신이 아득해진다)"];
        const texts3 = ["...", "... ... ... ..."];
        const texts4 = ["??: xx님! xx님!", "(정신을 차려보니 502호실이었고, 옆에서 강사님이 나를 깨우고 있었다.\n아침햇살이 창살을 통해 강렬하게 내리쬐고 있었다)", "강사님: 휴 다행이다. 무슨 일이 생긴 건 아닐까 걱정했네요.", "이렇게 늦게까지 공부하고 계셨던 거에요?", "금요일인데 너무 무리하지 마시고 그만 들어가서 쉬세요", "강사님의 말이 뭔가 이상하다.\n강사님께 학원에 갇혔던 일에 대해서 얘기해보자.", "강사님: 네? 그게 무슨.. 방금 전까지 담배 피다가 들어왔는데,\n혹시 무슨 몰래카메라 같은 건가요?",
            "내가 겪었던 일들이 설마 꿈이었던걸까?", "1층으로 가서 직접 확인해보자."
        ];
        const texts5 = ["(강사님과 함께 엘리베이터를 타고 1층으로 향한다)", "(엘리베이터도, 1층 입구도 아무 문제 없었고, 무사히 바깥으로 나가는데 성공한다)", "강사님: 아무 일 없죠?", "강사님: 잠시 잠드셨을 때 꿈이라도 꾸셨나봐요.", "강사님: 아무튼 늦었는데 조심히 들어가세요~", "강사님: 저도 이만 들어가보겠습니다",
            "넋이 빠진채 강사님의 얘기를 듣고 있던 나는\n주머니를 만지작거리다가 뭔가를 발견하고 강사님을 멈춰세운다.", "(강사님께 사진과 신문기사를 보여준다)"
        ];
        const texts6 = ["강사님: 이걸 어디서.. 이게 아직도 남아있었군요.", "(강사님께 진실에 대해 물어본다)", "강사님: ..사실 제가 여기 온 건 우연이 아니에요.", "강사님: 저는 제 의지로 여기로 들어왔죠.", "강사님: 이 건물에 늦게까지 남아있으면 끌려간다는 소문이 요새 돌고 있었잖아요?", "강사님: 생전 어떤 코딩 문제를 풀지 못한 게 미련으로 남아서,\n그 문제를 풀어줄 성실한 사람들을 끌고 간다는 소문..", "강사님: 그 소문을 듣자마자 생각했어요.", "강사님: 젊을 적 저와 같이 여기서 공부하던 친구 이야기가 말이죠.",
            "(그렇다면 설마..)", "강사님: 네 맞아요.", "강사님: 신문기사랑 사진에 있던 그 친구에요.", "강사님: 항상 이 학원에서 공부를 같이 하던 친구였는데,\n코딩을 너무 좋아하는 코딩 바보였죠.", "강사님: 밥도 항상 같이 먹고, 코딩 대회도 같이 나가고..", "강사님: 정말 좋은 친구였는데 건강이 너무 안좋아서 항상 일찍 조퇴하곤 했어요.", "강사님: 그러던 어느 날 병이 너무 악화된 나머지 수업을 듣다가 쓰러졌고..", "강사님: 전 그 뒤로 다신 그 친구를 볼 수 없었어요.", "(그런 일이..)", "강사님: 그 친구가 항상 풀고 싶어하던 정말 어려운 코딩문제가 있었거든요.",
            "강사님: 어떻게 해서든 답지를 보지 않고 풀고 싶다고 했던 문제였는데,", "강사님: 쓰러지기 전까지도 그 문제에 대해서 일장연설을 하곤 했죠.", "강사님: 그래서 이번에 소문을 듣고 반신반의하면서 이 건물에 남았고", "강사님: 이 곳에 끌려오고, 바뀐 건물을 보자마자 알았어요.", "강사님: 예전에 제가 수업을 받던 20년전의 건물이라는 걸 말이죠.", "강사님: 무엇보다 그 친구의 미련과 후회, 죄책감 같은 감정이", "강사님: 이 건물에 들어온 순간부터 전해져오는 게 느껴졌어요.", "강사님: 바로 노트북을 켜서 그 때 그 친구가 풀지 못했던 코딩 문제를 풀기 시작했고", "강사님: 그 답을 입력하니 문이 열렸던 거에요.",
            "(전혀 생각도 못한 답을 들으니 정신이 멍해진다)", "(강사님이 5층에서 꼼짝도 안하셨던 게 그것 때문이였구나)", "강사님: 저 말고 다른 사람도 끌려오게 될 줄은 몰랐는데..", "여태까지 제대로 말씀을 드리지 못해서 죄송합니다.", "강사님: 저 혼자 매듭지어야 하는 일이라고 생각했거든요.", "강사님: 그 친구가 어떤 상태인지도 모르고", "강사님: 전날 쓸데없는 일로 싸우기나 했던 한심한 제가 마무리해야..", "(강사님은 말문이 막히신 듯 이야기를 이어가지 못하신다)", "(강사님은 그 친구의 일에 죄책감을 느끼시고 계신 듯 하다)", "(하지만..)", "주인공: 강사님 탓이 아니에요", "강사님: ..네?", "주인공: 강사님이 마지막에 얘기하고 계셨던 분이 그 친구분이신거죠?", "주인공: CCTV를 통해서 봤어요.",
            "주인공: 전 자세한 사정은 모르지만", "주인공: 강사님을 탓하시는 것 같진 않던데, 무슨 대화 중이셨나요?", "강사님: …", "강사님: 자기 꿈이었던 강사가 되어줘서 고맙다고,", "강사님: 여기서 항상 제 강의를 들을 수 있어서 즐거웠다고 하더군요.", "(강사님은 추억에 잠기신 듯 수분 정도 그 자리에 서계신다)", "강사님: …감사합니다. xx님.", "강사님: 시간도 이렇게 됐는데, 아침식사라도 같이 하시러 가실래요?", "강사님: 그 친구가 좋아하던 국밥집이 있는데, 국물맛이 아주 좋거든요", "(공짜밥을 마다할 이유는 없어보인다)", "(이렇게 비트캠프 건물의 모든 진실은 밝혀졌고,\n강사님의 마음 속 응어리도 어느 정도 풀어진 듯하다)"
        ];
        const texts7 = ["(그렇게 강사님과 나는 어깨동무를 하고 아침식사를 하러 향한다)", "(20년 전 그 친구분과 가셨던 식당으로)", "[트루엔딩: 20년 전 그 때처럼]"];


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
            backgrounds[currentBackgroundIndex].setAlpha(0); // 배경 투명하게 초기화
            return this.tweens.add({
                targets: backgrounds[currentBackgroundIndex],
                alpha: 1,
                duration: 150,
                onComplete: () => {
                    // 배경에 맞는 대화 텍스트 할당
                    switch (currentBackgroundIndex) {
                        case 0:
                            currentTexts = texts1;
                            break;
                        case 1:
                            currentTexts = texts2;
                            break;
                        case 2:
                            currentTexts = texts3;
                            break;
                        case 3:
                            currentTexts = texts4;
                            break;
                        case 4:
                            currentTexts = texts5;
                            break;
                        case 5:
                            currentTexts = texts6;
                            break;
                        case 6:
                            currentTexts = texts7;
                            break;
                        default:
                            currentTexts = [];
                    }
                    currentIndex = 0;
                    dialogueText.setText(currentTexts[currentIndex]);
                }
            });
        };


        const startCredits = () => {
            const blackBackground = this.add.rectangle(config.width / 2, config.height / 2, config.width, config.height, 0x000000).setOrigin(0.5).setAlpha(1);
            const creditsText = [
                "개발: 김병주, 민수정",
                "스토리: 김병주",
                "아트: 민수정",
                "",
                "",
                "Thanks to",
                "고기천 강사님",
                "",
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
            if (isDebounced) return;
            isDebounced = true;
            this.time.delayedCall(debounceTime, () => {
                isDebounced = false;
            });

            if (isChoicesVisible) return;

            if (gamePhase === 'dialogue') {
                if (currentIndex < currentTexts.length) {
                    dialogueText.setText(currentTexts[currentIndex]);
                    currentIndex++;
                } else {
                    // 모든 텍스트가 출력된 후 다음 배경으로 전환
                    if (currentBackgroundIndex < backgrounds.length - 1) {
                        fadeOutCurrentBackground().on('complete', () => {
                            fadeInNextBackground(currentBackgroundIndex + 1);
                        });
                    } else if (currentBackgroundIndex === backgrounds.length - 1 && currentTexts === texts7 && currentIndex >= currentTexts.length) {
                        // 마지막 텍스트 및 배경에 도달한 경우
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
    });
</script>
</body>

</html>