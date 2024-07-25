<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2024-07-25
  Time: 오전 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>7층</title>
    <script src="/static/js/bitCamp/timer.js"></script>
    <link rel="icon" href="/static/images/bitCamp/bitcamp_favicon.ico" type="image/x-icon">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.55.2/phaser.min.js"></script>
</head>
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
        display: none;
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
    /* 입력 상자 스타일 */
    #inputBox {
        position: absolute;
        bottom: 270px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 34px;
        font-family: 'KyoboHandwriting2023wsa';
        padding: 10px;
        border: 2px solid #8B4513; /* Dark brown border */
        border-radius: 5px;
        background-color: #F5DEB3; /* Light brown background */
        color: #8B4513; /* Dark brown text */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Add a shadow */
        display: none;
        width: 240px; /* 고정된 너비 */
        height: 50px; /* 고정된 높이 */
        box-sizing: border-box; /* 패딩과 테두리 포함 */
    }

    /* 버튼 스타일 */
    #submitButton {
        position: absolute;
        bottom: 269px;
        left: calc(50% + 160px);
        transform: translateX(-50%);
        font-size: 24px;
        font-family: 'KyoboHandwriting2023wsa';
        padding: 12px 30px;
        display: none;
        background-color: #8B4513; /* Dark brown background */
        color: white; /* White text */
        border: none; /* Remove borders */
        border-radius: 5px; /* Rounded corners */
        cursor: pointer; /* Pointer/hand icon */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Add a shadow */
        transition: all 0.3s ease; /* Animation for hover effect */
    }

    #submitButton:hover {
        background-color: #A0522D; /* Lighter brown background on hover */
    }

    #submitButton:active {
        background-color: #5C3317; /* Darker brown background on click */
        box-shadow: 0 2px #666; /* Smaller shadow */
        transform: translateX(-50%) translateY(4px); /* Move the button down */
    }

    @font-face {
        font-family: 'KyoboHandwriting2023wsa';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404-2@1.0/KyoboHandwriting2023wsa.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
    }

    @font-face {
        font-family: 'LABDigital';
        font-weight: normal;
        font-style: normal;
        src: url('https://cdn.jsdelivr.net/gh/webfontworld/fontlab/LABDigital.eot');
        src: url('https://cdn.jsdelivr.net/gh/webfontworld/fontlab/LABDigital.eot?#iefix') format('embedded-opentype'),
        url('https://cdn.jsdelivr.net/gh/webfontworld/fontlab/LABDigital.woff2') format('woff2'),
        url('https://cdn.jsdelivr.net/gh/webfontworld/fontlab/LABDigital.woff') format('woff'),
        url('https://cdn.jsdelivr.net/gh/webfontworld/fontlab/LABDigital.ttf') format("truetype");
        font-display: swap;
    }

    .digital-font {
        font-family: 'LABDigital', sans-serif;
    }

</style>
<body>
<div id="game-container">
    <button id="prev-button" class="nav-button" onclick="viewSection(-1)"><</button>
    <button id="next-button" class="nav-button" onclick="viewSection(1)">></button>
    <button id="back-button" class="nav-button" style="display:none;" onclick="goBack()">
        <img src="/static/images/bitCamp/back_button.svg" alt="Back">
    </button>
    <button id="settings-button" onclick="openSettings()"><img src="/static/images/bitCamp/settings-icon.svg" alt="Settings"></button>
</div>
<input type="text" id="inputBox" placeholder="번호를 입력하세요" style="display: none;" />
<button id="submitButton" style="display: none;">입력</button>

<script>
    let config = {
        type: Phaser.AUTO,
        width: 1280,
        height: 720,
        parent: 'game-container',
        scene: {
            preload: preload,
            create: create,
            update: update // update 함수 추가
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
    let currentTexts = [];
    let currentLineIndex = 0;
    let clickableZones = []; // 클릭 가능한 영역을 저장할 배열
    let gameOver = false; // 게임 오버 상태 변수
    const texts1 = ["학원의 학생들과 강사님이 사용하는 사물함이다.", "강사님의 말씀대로라면 분명 이 중 한 곳에 2층 열쇠가 있을거다.", "몇 번 사물함을 조사해볼까?", "조사할 사물함의 번호를 입력해주세요.(101 ~ 303)"];
    const texts2 = ["식사시간에 자주 이용하던 전자레인지다.", "...", "?", "전자레인지 안 쪽에 유리병 하나가 있다.", "[수상한 유리병]을 획득했다.", "대체 누가 이런 곳에 둔걸까?"];
    const texts3_1 = ["깨끗이 정돈된 테이블이다.", "딱히 눈에 띄는 점은 없어보인다."];

    const texts3_2 = ["조금 더럽고 낡은 테이블이다.", "잘 보니 테이블 구석에 누군가 낙서를 해둔 게 보인다.", "\"301번 사물함 비번 개어렵다 ㄹㅇ\"", "\"디지털 숫자인 이유가 있을 것 같은데.. 숫자를 하나씩 옮겨본다던가?\"", "\"그것보다 숨겨진 사물함 얘긴 들어봤어?? 강의실 번호랑 같은 사물함이 섞여있다는 소문 말이야\"", "...", "이런저런 소문에 대한 얘기가 젹혀있다."];
    const texts3_3 = ["?", "7층에 이런 게시판이 있었던가?", "뭐라고 써있는지 살펴볼까?"];
    const texts4 = ["아직 2층 열쇠를 얻지 못했다. 좀 더 조사해보자."];
    const texts5 = ["엘리베이터는 아직도 작동할 기미가 보이지 않는다.", "언제쯤 여기서 빠져나갈 수 있을까.."];
    const textsExit = ["[2층 열쇠]를 사용했다.", "2층으로 이동합니다.", ""];
    const textsSelect = ["...정말 전자레인지에 유리병을 돌려도 될까?", "그런데 어느 전자레인지에 돌려야되지?", "전자레인지를 선택해주세요."];
    const textsFinished = ["더 이상 이 곳에서 볼 일은 없어보인다."];
    const textsMap = {
        "101": ["101번 사물함을 조사한다.", "...", "사물함은 텅텅 비어있다."],
        "102": ["102번 사물함을 조사한다.", "...", "몇 개의 책들이 들어있다.", "지금 필요한 물건은 아닌 것 같다."],
        "103": ["103번 사물함을 조사한다.", "...", "[수상한 쪽지]를 획득했다."],
        "201": ["201번 사물함을 조사한다.", "...", "사물함은 텅텅 비어있다."],
        "202": ["202번 사물함을 조사한다.", "...", "옷가지가 몇 개 있다.", "지금 필요한 물건은 아닌 것 같다."],
        "203": ["203번 사물함을 조사한다.", "...", "고장난 장비가 있습니다."],
        "301": ["301번 사물함을 조사한다.", "...", "옆에 송 강사님의 사물함이라는 포스트잇이 붙어있다.", "강사님 말씀대로라면 이 사물함 안에 내가 찾는 열쇠가 있을 거다.", "하지만 비밀번호로 잠겨있다.", "비밀번호를 알아내야 열 수 있을 것 같은데.. 혹시 주변에 뭔가 단서가 없는지 살펴보자."],
        "301_second": ["301번 사물함을 다시 조사한다.", "...", "여전히 비밀번호로 잠겨있다.", "포스트잇을 다시보니 작게 숫자들이 적혀있다.", "1159 -> 159 -> 169 -> 158 -> ????", "비밀번호에 대한 힌트일까?"],
        "correct_password": ["...", "비밀번호가 맞았다! 사물함이 열렸다.", "사물함 안에서 [2층 열쇠]를 획득했다!", "이제 비상구 계단을 통해서 2층으로 갈 수 있겠어"],
        "wrong_password": ["...", "비밀번호가 틀린 것 같다.", "바깥에서 단서를 더 찾아볼까?"],
        "302": ["302번 사물함을 조사한다.", "...", "사물함은 텅텅 비어있다."],
        "303": ["303번 사물함을 조사한다.", "...", "쓸모없는 서류들이 들어있다."],
        "502": ["그런 번호의 사물함은 존재하지 않는...", "어?", "잘 보니 있을 리가 없는 502번 사물함이 정 가운데에 있다.", "502번 사물함을 조사한다.", "...", "[옛날 신문기사]를 획득했다.", "대체 이게 어떻게 된 일이지.."],
        "default": ["그런 번호의 사물함은 존재하지 않는다. 다시 생각해보자."]
    };

    document.fonts.ready.then(function () {
        const font = new FontFace('LABDigital', 'url(https://cdn.jsdelivr.net/gh/webfontworld/fontlab/LABDigital.woff2)');
        font.load().then(function (loadedFont) {
            document.fonts.add(loadedFont);
        });
    });

    // 인벤토리 관련 변수 및 함수
    let inventory = [];
    let inventoryImages = []; // 소지품 이미지들을 저장할 배열
    let inventoryText, inventoryBag, modal, modalBackground, modalText;
    let modalItems = []; // 모달에 추가된 소지품 이미지들을 저장할 배열

    const createInventory = (scene) => {
        // 가방 이미지 추가
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
        modalBackground = scene.add.rectangle(scene.cameras.main.centerX, scene.cameras.main.centerY - 180, 800, 300, 0xFFFAFA).setAlpha(0).setInteractive().setScrollFactor(0);
        modalText = scene.add.text(scene.cameras.main.centerX, 60, '소지품', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '24px',
            fill: '#000000'
        }).setAlpha(0).setOrigin(0.5).setScrollFactor(0);
        modal = scene.add.container(0, 0, [modalBackground, modalText]).setAlpha(0);
    };

    // 소지품 칸에 아이템을 추가하는 함수
    const addItemToInventory = (item, imageKey) => {
        // 아이템이 이미 소지품에 있는지 확인
        if (!inventory.includes(item)) {
            inventory.push(item);
            inventoryImages.push({ key: imageKey, name: item }); // 소지품 이미지와 이름을 저장
            updateInventoryDisplay();

            // '수상한 쪽지'는 로컬 스토리지에 저장하지 않음
            if (item !== "수상한 쪽지" && (item === "옛날 신문기사" || item === "누군가의 옛날 사진")) {
                localStorage.setItem('inventory', JSON.stringify(inventory));
                localStorage.setItem('inventoryImages', JSON.stringify(inventoryImages));
            }
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

    const removeItemFromInventory = (item) => {
        const itemIndex = inventory.findIndex(existingItem => existingItem === item);
        if (itemIndex !== -1) {
            inventory.splice(itemIndex, 1);
            inventoryImages.splice(itemIndex, 1); // Remove from image array
            updateInventoryDisplay();

            // 특정 아이템을 로컬스토리지에서 제거
            if (item === "옛날 신문기사" || item === "누군가의 옛날 사진" || item === "2층 열쇠") {
                localStorage.setItem('inventory', JSON.stringify(inventory));
                localStorage.setItem('inventoryImages', JSON.stringify(inventoryImages));
            }
        }
    };

    const removeSpecificItemFromLocalStorage = (item) => {
        let storedInventory = JSON.parse(localStorage.getItem('inventory')) || [];
        let storedInventoryImages = JSON.parse(localStorage.getItem('inventoryImages')) || [];
        storedInventory = storedInventory.filter(existingItem => existingItem !== item);
        storedInventoryImages = storedInventoryImages.filter(imageObj => imageObj.name !== item);
        localStorage.setItem('inventory', JSON.stringify(storedInventory));
        localStorage.setItem('inventoryImages', JSON.stringify(storedInventoryImages));
    };




    // 아이템 세부 정보를 표시하는 함수
    const showItemDetails = (scene, itemKey) => {
        // 확대해서 보여줄 이미지를 설정
        let enlargedImageKey;
        let dialogTexts = null; // 대사 텍스트를 저장할 변수

        if (itemKey === 'photo') { // photo 클릭 시 보여줄 이미지 및 대사
            enlargedImageKey = 'photo_enlarge';
            dialogTexts = ["유리병을 폭발시켜 얻은 사진이다.", "사진에는 젊은 강사님과 누군가가 어깨동무를 하고 있다.", "굉장히 큰 대회에서 우승한 사진인 것 같은데.. 강사님과 같이 있는 이 사람은 누굴까?"];
        } else if (itemKey === 'letter') { // letter 클릭 시 보여줄 이미지
            enlargedImageKey = 'letterOpen';
            dialogTexts = ["곳곳이 지워져서 잘 알아볼 수 없는 쪽지다.", "자세힌 모르겠지만 전자레인지를 사용할 때는 조심해야할 것 같다."];
        } else if (itemKey === 'newspaper') {
            enlargedImageKey = 'newspaper_enlarge';
            dialogTexts = ["날짜를 보니 20년 전 신문기사인 듯 하다.", "전국 개발대회에서 1등했던 학생 2명... 불운한 사고... 한 명은 의식불명...", "과거에 있던 안타까운 사고에 대한 이야기인 것 같다.", "그런데 이런 게 왜 여기있는거지?"];
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

                    // 대사가 있을 경우 대사 출력
                    if (dialogTexts) {
                        showDialog(scene, dialogTexts);
                    }
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
            overlay.setAlpha(0.5); // Show overlay

            // 클릭 가능한 영역 비활성화
            disableClickableZones();

            // 소지품 이미지를 모달에 추가
            inventoryImages.forEach((imageObj, index) => {
                const itemImage = scene.add.image(scene.cameras.main.centerX - 300 + (index % 4) * 200, scene.cameras.main.centerY - 190 + Math.floor(index / 4) * 140, imageObj.key).setScale(0.3).setScrollFactor(0); // setScrollFactor(0) 추가;
                const itemText = scene.add.text(scene.cameras.main.centerX - 300 + (index % 4) * 200, scene.cameras.main.centerY - 100 + Math.floor(index / 4) * 140, imageObj.name, {
                    fontFamily: 'KyoboHandwriting2023wsa',
                    fontSize: '25px', // 폰트 크기 조절
                    fill: '#000000'
                }).setOrigin(0.5).setScrollFactor(0); // setScrollFactor(0) 추가;
                modal.add([itemImage, itemText]);
                modalItems.push(itemImage); // 추가된 소지품 이미지를 저장
                modalItems.push(itemText); // 추가된 소지품 텍스트를 저장

                // 메모 아이템에 대한 클릭 이벤트 추가
                if (imageObj.key === 'photo' || imageObj.key === 'letter' || imageObj.key === 'newspaper') {
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
            overlay.setAlpha(0); // Hide overlay

            // 모달에 추가된 소지품 이미지를 제거
            modalItems.forEach(item => item.destroy());
            modalItems = []; // 소지품 이미지 배열 초기화

            // 클릭 가능한 영역 다시 활성화
            enableClickableZones();
        }
    };

    // 대사 출력 함수
    function showDialog(scene, texts) {
        disableClickableZones(); // 클릭 가능한 영역 비활성화
        currentTexts = texts;
        currentTextIndex = 0;
        dialogBox.setVisible(true);
        dialogText.setVisible(true);

        // 첫 번째 텍스트 설정 시에도 폰트를 명확하게 설정
        if (currentTexts[currentTextIndex].includes("1159 -> 159 -> 169 -> 158 -> ????")) {
            dialogText.setFontFamily('LABDigital').setText(currentTexts[currentTextIndex]);
        } else {
            dialogText.setFontFamily('KyoboHandwriting2023wsa').setText(currentTexts[currentTextIndex]);
        }

        // back-button 비활성화
        document.getElementById('back-button').style.pointerEvents = 'none';

        if (texts === texts1 || texts === textsMap["301_second"]) {
            dialogBox.off('pointerdown');  // 이전 이벤트 리스너 제거
            dialogBox.on('pointerdown', function() {
                advanceDialogueWithInput(texts);
            });
        } else {
            dialogBox.off('pointerdown');  // 이전 이벤트 리스너 제거
            dialogBox.on('pointerdown', advanceDialogue);
        }
    }

    // 선택지 출력 함수
    function showChoicesDialog(scene, preChoiceTexts, choices) {
        disableClickableZones();
        let preChoiceIndex = 0;

        function showChoices() {
            dialogText.setText("전자레인지를 선택하세요.");
            dialogBox.off('pointerdown'); // 기존 클릭 이벤트 비활성화

            choices.forEach((choice, index) => {
                const buttonY = 430 + index * 60; // 버튼 Y 위치 조정
                const button = scene.add.text(config.width - 300, buttonY, choice.text, {
                    fontFamily: 'KyoboHandwriting2023wsa',
                    fontSize: '24px', // 폰트 크기
                    fill: '#000', // 기본 텍스트 색상
                    backgroundColor: '#fff',
                    padding: { x: 20, y: 10 }, // 패딩
                    fixedWidth: 250 // 버튼 너비
                }).setOrigin(0.5).setInteractive().setScrollFactor(0);

                button.on('pointerover', () => {
                    document.body.style.cursor = 'pointer'; // 마우스를 올렸을 때 커서 모양 변경
                });

                button.on('pointerout', () => {
                    document.body.style.cursor = 'default'; // 마우스가 버튼에서 벗어났을 때 커서 모양 원래대로
                });

                button.on('pointerdown', () => {
                    console.log(choice.text + ' 선택됨');
                    handleChoiceSelection(choice); // 선택지 예를 선택했는지 여부를 로컬스토리지에 저장하는 함수 호출
                    choices.forEach((choice, idx) => {
                        scene.children.getByName(`choiceButton${idx}`).destroy();
                    });
                    document.body.style.cursor = 'default'; // 선택 후 커서 모양 원래대로

                    if (choice.gameOver) {
                        showDialog(scene, choice.nextTexts, () => showGameOver(scene));
                    } else {
                        showDialog(scene, choice.nextTexts);
                    }
                }).setName(`choiceButton${index}`);
            });
        }

        function showPreChoiceDialog() {
            if (preChoiceIndex < preChoiceTexts.length) {
                dialogText.setText(preChoiceTexts[preChoiceIndex]);
                preChoiceIndex++;
            } else {
                showChoices();
            }
        }

        dialogBox.off('pointerdown'); // 기존 클릭 이벤트 비활성화
        dialogBox.on('pointerdown', showPreChoiceDialog);

        showPreChoiceDialog(); // 최초 호출
    }

    // 게시판 선택지 출력 함수
    const handleTexts3_3 = (scene) => {
        const choices = [
            { text: "예", nextTexts: ["게시판을 살펴본다.", "유?리병&*전#자레!!인지((4死4死4死4死))펑%펑%펑%펑^펑00 넣고 돌려", "뭔가 꺼림칙한 글씨체다.", "전자레인지에 유리병을 넣고 돌리라는 얘기 같은데.."] },
            { text: "아니오", nextTexts: ["게시판을 그냥 지나친다.", "다른 곳을 더 살펴봐야겠다."] }
        ];

        showChoicesDialog(scene, choices, "게시판을 살펴보시겠습니까?");
    };

    // 전자레인지 선택지 출력 함수
    const handleTextsSelect = (scene) => {
        const choices = [
            {
                text: "빨간 전자레인지",
                nextTexts: ["펑!!!!!!!!!!!!", "엄청난 폭발과 함께 사망하셨습니다. 굿바이", "폭사엔딩 -완-"],
                gameOver: true // 게임 오버 상태 플래그
            },
            {
                text: "흰색 전자레인지",
                nextTexts: ["펑!!!!!!!!!!!!", "...", "힌트를 제대로 보지 않은 플레이어는 끔찍한 결말을 맞이하고 말았다.", "폭사엔딩 -완-"],
                gameOver: true // 게임 오버 상태 플래그
            },
            {
                text: "검정 전자레인지",
                nextTexts: ["펑!!!!!!!!!!", "굉장한 폭음이 들렸지만, 전자레인지를 열어보니 유리병의 내용물만 온전히 남아있다.", "[누군가의 옛날 사진]을 획득했다."]
            },
            {
                text: "돌리지 않는다.",
                nextTexts: ["어떤 일이 벌어질지 모르니 일단 주위를 더 살펴보고 오자."]
            }
        ];

        const preChoiceTexts = [
            "게시판에서 본 대로라면 유리병을 전자레인지에 돌리라는데..",
            "정말 돌리는 게 맞는 걸까?",
            "...근데 돌린다면 어떤 전자레인지에 돌려야하지?"
        ];

        showPreChoiceDialog(scene, preChoiceTexts, choices);
    };

    // 선택지 이전 텍스트 출력 함수
    function showPreChoiceDialog(scene, preChoiceTexts, choices) {
        let preChoiceIndex = 0;
        dialogText.setText(preChoiceTexts[preChoiceIndex]);

        dialogBox.off('pointerdown'); // 기존 클릭 이벤트 비활성화
        dialogBox.on('pointerdown', () => {
            preChoiceIndex++;
            if (preChoiceIndex < preChoiceTexts.length) {
                dialogText.setText(preChoiceTexts[preChoiceIndex]);
            } else {
                showChoicesDialog(scene, choices, "전자레인지를 선택하세요.");
            }
        });
    }

    // 선택지 예를 선택했는지 여부를 로컬스토리지에 저장하는 코드
    function handleChoiceSelection(choice) {
        if (choice.text === "예") {
            console.log("Setting selectedYesForTexts3_3 to true");
            localStorage.setItem("selectedYesForTexts3_3", "true");
        } else if (choice.text === "아니오") {
            console.log("Setting selectedYesForTexts3_3 to false");
            localStorage.setItem("selectedYesForTexts3_3", "false");
        }
    }

    // 선택지 형식 함수
    function showChoicesDialog(scene, choices, promptText) {
        disableClickableZones();

        dialogText.setText(promptText);
        dialogBox.off('pointerdown');

        const numChoices = choices.length;

        let baseY, spacingY;

        if (numChoices === 2) {
            baseY = 460; // 버튼 Y 위치의 시작점
            spacingY = 70; // 버튼 간의 넓은 간격
        } else {
            baseY = 360; // 버튼 Y 위치의 시작점
            spacingY = 60; // 버튼 간의 기본 간격
        }

        choices.forEach((choice, index) => {
            const buttonY = baseY + index * spacingY;

            const button = scene.add.text(config.width - 300, buttonY, choice.text, {
                fontFamily: 'KyoboHandwriting2023wsa',
                fontSize: '24px',
                fill: '#000',
                backgroundColor: '#fff',
                padding: { x: 20, y: 10 },
                fixedWidth: 250
            }).setOrigin(0.5).setInteractive().setScrollFactor(0);

            button.on('pointerover', () => {
                document.body.style.cursor = 'pointer';
            });

            button.on('pointerout', () => {
                document.body.style.cursor = 'default';
            });

            button.on('pointerdown', () => {
                console.log(choice.text + ' 선택됨');
                handleChoiceSelection(choice);
                choices.forEach((choice, idx) => {
                    const choiceButton = scene.children.getByName(`choiceButton${idx}`);
                    if (choiceButton) {
                        choiceButton.destroy();
                    }
                });
                document.body.style.cursor = 'default';

                if (choice.text == "빨간 전자레인지" || choice.text == "흰색 전자레인지" || choice.text == "검정 전자레인지") { // "돌리지 않는다"를 제외한 선택지
                    scene.sound.play('explosionSound'); // 폭발 소리 재생
                }

                if (choice.gameOver) {
                    showDialog(scene, choice.nextTexts, () => showGameOver(scene));
                } else {
                    showDialog(scene, choice.nextTexts);
                }
            }).setName(`choiceButton${index}`);
        });
    }

    // 이미지 표시 함수
    const showItemImage = (imageKey) => {
        const scene = game.scene.scenes[0];
        const itemImage = scene.add.image(config.width / 2, config.height / 2, imageKey).setScale(0.5).setAlpha(0);

        scene.sound.play('itemSound'); // 아이템 획득 효과음

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

    // 아이템 획득 처리 함수
    const handleItemAcquisition = (text) => {
        if (text === "[수상한 유리병]을 획득했다.") {
            showItemImage('glass');
            addItemToInventory("수상한 유리병", "glass");
        } else if (text === "[수상한 쪽지]를 획득했다.") {
            showItemImage('letter');
            addItemToInventory("수상한 쪽지", "letter");
        } else if (text === "[옛날 신문기사]를 획득했다.") {
            showItemImage('newspaper');
            addItemToInventory("옛날 신문기사", "newspaper");
        } else if (text === "사물함 안에서 [2층 열쇠]를 획득했다!") {
            showItemImage('key');
            addItemToInventory("2층 열쇠", "key");
        } else if (text === "[누군가의 옛날 사진]을 획득했다.") {
            // '수상한 유리병' 제거
            const itemIndex = inventory.findIndex(existingItem => existingItem === "수상한 유리병");
            if (itemIndex !== -1) {
                inventory.splice(itemIndex, 1);
                inventoryImages.splice(itemIndex, 1); // 이미지 배열에서도 제거
                updateInventoryDisplay();
            }
            showItemImage('photo');
            addItemToInventory("누군가의 옛날 사진", "photo");
        }
    };


    // 대사 진행 함수
    function advanceDialogue() {
        currentTextIndex++;
        if (currentTextIndex < currentTexts.length) {
            if (currentTexts[currentTextIndex].includes("1159 -> 159 -> 169 -> 158 -> ????")) {
                dialogText.setFontFamily('LABDigital').setText(currentTexts[currentTextIndex]);
            } else {
                dialogText.setFontFamily('KyoboHandwriting2023wsa').setText(currentTexts[currentTextIndex]);
            }
            handleItemAcquisition(currentTexts[currentTextIndex]);
        } else {
            if (currentTexts.includes("엄청난 폭발과 함께 사망하셨습니다. 굿바이")) {
                dialogBox.off('pointerdown');
                dialogBox.setVisible(false);
                dialogText.setVisible(false);
                showGameOver(game.scene.scenes[0]);
            } else if (currentTexts.includes("힌트를 제대로 보지 않은 플레이어는 끔찍한 결말을 맞이하고 말았다.")) {
                dialogBox.off('pointerdown');
                dialogBox.setVisible(false);
                dialogText.setVisible(false);
                showGameOver(game.scene.scenes[0]);
            } else if (currentTexts === texts3_3) {
                dialogBox.off('pointerdown');
                handleTexts3_3(game.scene.scenes[0]); // texts3_3가 끝나면 handleTexts3_3 호출
            } else {
                dialogBox.setVisible(false);
                dialogText.setVisible(false);
                enableClickableZones(); // 클릭 가능한 영역 다시 활성화
                // back-button 활성화
                document.getElementById('back-button').style.pointerEvents = 'auto';
            }
        }
    }

    // texts1일 경우와 301_second에만 inputBox 나오도록 따로 함수 지정
    function advanceDialogueWithInput(texts) {
        currentTextIndex++;
        if (currentTextIndex < currentTexts.length) {
            if (currentTexts[currentTextIndex].includes("1159 -> 159 -> 169 -> 158 -> ????")) {
                dialogText.setFontFamily('LABDigital').setText(currentTexts[currentTextIndex]);
            } else {
                dialogText.setFontFamily('KyoboHandwriting2023wsa').setText(currentTexts[currentTextIndex]);
            }
        } else {
            if (texts === texts1) {
                dialogText.setText("조사할 사물함의 번호를 입력해주세요.(101 ~ 303)");
            } else if (texts === textsMap["301_second"]) {
                dialogText.setText("4자리 비밀번호를 입력해주세요.");
            }

            document.getElementById('inputBox').style.display = 'inline-block';
            document.getElementById('submitButton').style.display = 'inline-block';

            document.getElementById('submitButton').onclick = function() {
                const inputNumber = document.getElementById('inputBox').value;
                document.getElementById('inputBox').style.display = 'none';
                document.getElementById('submitButton').style.display = 'none';
                if (texts === texts1) {
                    handleInputNumber(inputNumber);
                } else if (texts === textsMap["301_second"]) {
                    handlePasswordInput(inputNumber);
                }

                // back-button 활성화
                document.getElementById('back-button').style.pointerEvents = 'auto';
            };
        }
    }

    const inputCounts = {};

    // 입력받은 사물함 번호에 따라서 처리 방식 지정 함수
    function handleInputNumber(inputNumber) {
        // 입력 횟수를 증가시키거나 초기화
        if (inputCounts[inputNumber] === undefined) {
            inputCounts[inputNumber] = 0;
        }
        inputCounts[inputNumber]++;

        // 301번 사물함의 경우 두 번째 이후 입력 시 다른 텍스트 반환
        if (inputNumber === "301" && inputCounts[inputNumber] >= 2) {
            currentTexts = textsMap["301_second"];
            currentTextIndex = 0;
            document.getElementById('back-button').style.pointerEvents = 'none'; // back-button 비활성화
            showDialog(game.scene.scenes[0], currentTexts); // showDialog 함수 호출
        } else {
            currentTexts = textsMap[inputNumber] || textsMap["default"];
            currentTextIndex = 0;
            dialogBox.setVisible(true);
            dialogText.setVisible(true);

            // 첫 번째 텍스트 설정 시에도 폰트를 명확하게 설정
            if (currentTexts[currentTextIndex].includes("1159 -> 159 -> 169 -> 158 -> ????")) {
                dialogText.setFontFamily('LABDigital').setText(currentTexts[currentTextIndex]);
            } else {
                dialogText.setFontFamily('KyoboHandwriting2023wsa').setText(currentTexts[currentTextIndex]);
            }

            // back-button 비활성화
            document.getElementById('back-button').style.pointerEvents = 'none';

            dialogBox.off('pointerdown');  // 이전 이벤트 리스너 제거
            dialogBox.on('pointerdown', function() {
                currentTextIndex++;
                if (currentTextIndex < currentTexts.length) {
                    if (currentTexts[currentTextIndex].includes("1159 -> 159 -> 169 -> 158 -> ????")) {
                        dialogText.setFontFamily('LABDigital').setText(currentTexts[currentTextIndex]);
                    } else {
                        dialogText.setFontFamily('KyoboHandwriting2023wsa').setText(currentTexts[currentTextIndex]);
                    }
                    handleItemAcquisition(currentTexts[currentTextIndex]);
                } else {
                    if (currentTexts === textsMap["301_second"]) {
                        document.getElementById('inputBox').style.display = 'inline-block';
                        document.getElementById('submitButton').style.display = 'inline-block';
                        dialogBox.setVisible(false);
                        dialogText.setVisible(false);
                    } else {
                        dialogBox.setVisible(false);
                        dialogText.setVisible(false);
                        enableClickableZones(); // 클릭 가능한 영역 다시 활성화
                        // back-button 활성화
                        document.getElementById('back-button').style.pointerEvents = 'auto';
                    }
                }
            });
        }
    }

    // 비밀번호 관련 함수
    function handlePasswordInput(inputNumber) {
        if (/^\d{4}$/.test(inputNumber)) {
            if (inputNumber === "1591") {
                currentTexts = textsMap["correct_password"];
            } else {
                currentTexts = textsMap["wrong_password"];
            }
        } else {
            currentTexts = ["4자리 숫자를 입력해주세요."];
        }

        currentTextIndex = 0;
        document.getElementById('inputBox').style.display = 'none';
        document.getElementById('submitButton').style.display = 'none';
        dialogText.setText(currentTexts[currentTextIndex]);

        dialogBox.off('pointerdown');
        dialogBox.on('pointerdown', function() {
            currentTextIndex++;
            if (currentTextIndex < currentTexts.length) {
                dialogText.setText(currentTexts[currentTextIndex]);
                handleItemAcquisition(currentTexts[currentTextIndex]);
            } else {
                dialogBox.setVisible(false);
                dialogText.setVisible(false);
                enableClickableZones();
            }
        });
    }

    // 클릭 가능한 영역을 비활성화 후 다시 활성화하는 함수(클릭영역과 dialogBox 영역 중복 회피)
    function disableClickableZones() {
        clickableZones.forEach(zone => zone.disableInteractive());
    }

    function enableClickableZones() {
        clickableZones.forEach(zone => zone.setInteractive());
    }

    // 공통 클릭 영역 생성 함수
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
        return zone;
    }

    // 공통 클릭 영역 제거 함수
    function clearClickableAreas() {
        clickableZones.forEach(zone => zone.destroy());
        clickableZones = [];
    }

    // 특정 클릭 가능한 영역을 제거하는 함수
    function clearSpecificClickableArea(zone) {
        zone.destroy();
        clickableZones = clickableZones.filter(z => z !== zone);
    }

    // 사물함 내부 영역 제거 함수
    function clearLockerArea() {
        clickableZones.forEach(zone => {
            if (zone) zone.destroy();
        });
        clickableZones = [];
    }

    // 클릭 가능한 영역을 생성하는 함수
    function createClickableAreas(scene) {
        // 사물함 클릭 영역
        createClickableZone(scene, 219.5, 280.5, 233, 259, () => {
            changeBackground(scene, 'locker'); // 배경 이미지 변경
            hideNavButtons(); // 좌우 버튼 숨기기
            showBackButton(); // 뒤로 가기 버튼 보이기
            createLockerClickableArea(scene); // 내부영역 생성
        });

        // 전자레인지 클릭 영역
        createClickableZone(scene, 573, 339.5, 236, 141, () => {
            if (currentSection === 1) {
                currentSection = 0;
                camera.scrollX = sectionWidth * currentSection;
            }
            changeBackground(scene, 'microwave'); // 배경 이미지 변경
            hideNavButtons(); // 좌우 버튼 숨기기
            showBackButton(); // 뒤로 가기 버튼 보이기
            createMicrowaveClickableArea(scene); // 내부영역 생성
        });

        // 테이블1 클릭 영역
        createClickableZone(scene, 936, 347.5, 292, 125, () => {
            showDialog(scene, texts3_1);
        });

        // 테이블2 클릭 영역
        createClickableZone(scene, 1294.5, 347.5, 293, 125, () => {
            showDialog(scene, texts3_2);
        });

        // 게시판 클릭 영역
        createClickableZone(scene, 1132, 154.5, 168, 113, () => {
            showDialog(scene, texts3_3);
        });

        // 비상계단문 클릭 영역
        createClickableZone(scene, 1591, 282.5, 130, 255, () => {
            if (inventory.includes("2층 열쇠")) {
                showDialog(scene, textsExit);

                // 대화가 끝난 후 floor2.html로 이동
                dialogBox.off('pointerdown'); // 이전 이벤트 리스너 제거
                dialogBox.on('pointerdown', function() {
                    currentTextIndex++;
                    if (currentTextIndex < currentTexts.length) {
                        dialogText.setText(currentTexts[currentTextIndex]);
                        handleItemAcquisition(currentTexts[currentTextIndex]);
                    } else {
                        dialogBox.setVisible(false);
                        dialogText.setVisible(false);
                        enableClickableZones();
                        removeItemFromInventory("2층 열쇠"); // Remove the key from inventory and local storage
                        removeSpecificItemFromLocalStorage("수상한 쪽지"); // Remove the suspicious note from local storage
                        window.location.href = "${pageContext.request.contextPath}/bitCamp/floor2.do"; // 페이지 리디렉션
                    }
                });

            } else {
                showDialog(scene, texts4);
            }
        });



        // 엘리베이터 클릭 영역
        createClickableZone(scene, 1944, 271.5, 346, 277, () => {
            showDialog(scene, texts5);
        });
    }

    // 사물함 내부 클릭 영역
    function createLockerClickableArea(scene) {
        const lockerZone = scene.add.zone(216, 147, 747, 567).setOrigin(0, 0).setInteractive();
        lockerZone.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        lockerZone.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });
        lockerZone.on('pointerdown', () => {
            showDialog(scene, texts1);
        });
        clickableZones.push(lockerZone); // 클릭 가능한 영역을 배열에 추가
    }

    // 전자레인지 내부 클릭 영역
    function createMicrowaveClickableArea(scene) {
        const microwaveZone = scene.add.zone(537.5, 462.5, 647, 209).setOrigin(0.5).setInteractive();
        microwaveZone.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });
        microwaveZone.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });
        microwaveZone.on('pointerdown', () => {
            const selectedYesForTexts3_3 = localStorage.getItem("selectedYesForTexts3_3") === "true";
            console.log("Selected Yes for texts3_3:", selectedYesForTexts3_3);
            console.log("Inventory includes suspicious bottle:", inventory.includes("수상한 유리병"));

            if (inventory.includes("수상한 유리병") && selectedYesForTexts3_3) {
                showDialog(scene, textsSelect);
                handleTextsSelect(scene); // 선택지를 출력하는 함수 호출
            } else if(inventory.includes("누군가의 옛날 사진")){
                showDialog(scene, textsFinished);
            } else {
                showDialog(scene, texts2);
            }
        });
        clickableZones.push(microwaveZone);
    }

    // 배경 이미지 변경 함수
    function changeBackground(scene, textureKey) {
        clearClickableAreas(); // 기존 클릭 가능한 영역 제거
        bgImage.setTexture(textureKey); // 배경 이미지 변경
        let scaleX = config.width / bgImage.width;
        let scaleY = config.height / bgImage.height;
        let scale = Math.max(scaleX, scaleY);
        bgImage.setScale(scale).setOrigin(0, 0);

        // 내부 클릭 영역 재생성
        if (textureKey === 'locker') {
            createLockerClickableArea(scene);
        } else if (textureKey === 'microwave') {
            createMicrowaveClickableArea(scene); // 화면 꽉 차게 스케일 조정
        }
    }

    // 좌우 버튼 숨기기 함수
    function hideNavButtons() {
        document.getElementById('prev-button').style.display = 'none';
        document.getElementById('next-button').style.display = 'none';
    }

    // 뒤로가기 버튼 표시 함수
    function showBackButton() {
        document.getElementById('back-button').style.display = 'block';
    }

    // 뒤로가기 버튼 기능 함수
    function goBack() {
        bgImage.setTexture('background'); // 원래 배경 이미지로 변경
        let scaleX = config.width / bgImage.width;
        let scaleY = config.height / bgImage.height;
        let scale = Math.max(scaleX, scaleY);
        bgImage.setScale(scale).setOrigin(0, 0); // 화면 꽉 차게 스케일 조정
        document.getElementById('back-button').style.display = 'none'; // 뒤로 가기 버튼 숨기기
        document.getElementById('prev-button').style.display = 'block'; // 좌우 버튼 다시 보이기
        document.getElementById('next-button').style.display = 'block';
        clearClickableAreas(); // 내부 클릭 영역 제거
        createClickableAreas(game.scene.scenes[0]); // 클릭 가능한 영역 다시 생성
        document.body.style.cursor = 'default'; // 커서를 기본값으로 되돌리기
    }

    function preload() {
        this.load.image('background', '/static/images/bitCamp/7floorBD.png');
        this.load.image('locker', '/static/images/bitCamp/floor7_locker.png');
        this.load.image('microwave', '/static/images/bitCamp/floor7_microwave.png');
        this.load.image('letter', '/static/images/bitCamp/letter.png');
        this.load.image('letterOpen', '/static/images/bitCamp/letterOpen.png');
        this.load.image('glass', '/static/images/bitCamp/glassBottle.png');
        this.load.image('photo', '/static/images/bitCamp/photo.png');
        this.load.image('photo_enlarge', '/static/images/bitCamp/photograph.png');
        this.load.image('newspaper', '/static/images/bitCamp/newspaper.png');
        this.load.image('newspaper_enlarge', '/static/images/bitCamp/newspaper_enlarge.png');
        this.load.image('key', '/static/images/bitCamp/key.png');
        this.load.image('dialogueBox', '/static/images/bitCamp/wallpaper-torn-paper-ripped-white-paper.png');
        this.load.image('bag', '/static/images/bitCamp/bag.svg');
        this.load.audio('bagSound', '/static/sounds/bitCamp/가방 여는 소리.wav');
        this.load.audio('itemSound', '/static/sounds/bitCamp/아이템 획득 소리.mp3');
        this.load.audio('explosionSound', '/static/sounds/bitCamp/폭발음.mp3');
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

        createClickableAreas(this);
    }

    function viewSection(direction) {
        if (dialogBox.visible) return;

        currentSection += direction;
        if (currentSection < 0) currentSection = 0;
        if (currentSection >= totalSections) currentSection = totalSections - 1;

        camera.scrollX = sectionWidth * currentSection;
        camera.scrollY = 0;
    }

    // 섹션에 따라서 카메라의 스크롤 위치 변경
    function update() {
        const cameraScrollX = camera.scrollX;

        dialogBox.setPosition(cameraScrollX + config.width / 2, 530);
        dialogText.setPosition(cameraScrollX + config.width / 2, config.height - 70);
    }

    // 게임 오버 화면 표시 함수
    function showGameOver(scene) {
        // 게임 오버 텍스트 추가
        const gameOverText = scene.add.text(config.width / 2, config.height / 2 - 50, '게임 오버', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '50px',
            fill: '#ff0000'
        }).setOrigin(0.5).setScrollFactor(0);

        // 다시 시작 버튼 추가
        const restartButton = scene.add.text(config.width / 2, config.height / 2 + 50, '다시 시작', {
            fontFamily: 'KyoboHandwriting2023wsa',
            fontSize: '30px',
            fill: '#ffffff',
            backgroundColor: '#000000',
            padding: { x: 20, y: 10 }
        }).setOrigin(0.5).setInteractive().setScrollFactor(0);

        restartButton.on('pointerover', () => {
            document.body.style.cursor = 'pointer';
        });

        restartButton.on('pointerout', () => {
            document.body.style.cursor = 'default';
        });

        restartButton.on('pointerdown', () => {
            location.reload(); // 페이지 새로고침하여 게임 다시 시작
        });
    }
</script>
</body>
</html>
