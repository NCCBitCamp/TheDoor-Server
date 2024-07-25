<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
    <link rel="icon" href="../favicon-16x16.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: black;
            display: flex;
            justify-content: center;
            align-items: flex-end;
            height: 100vh; /* 화면 전체 높이로 설정 */
            margin: 0;
            background-image: url("/static/images/rozer/integ/floor1_bg_dark.png");
            background-size: cover; /* 이미지를 화면에 꽉 차게 설정 */
            background-position: center; /* 이미지를 화면 중앙에 위치 */
            background-repeat: no-repeat; /* 이미지를 반복하지 않게 설정 */
        }
        .text_box { /*텍스트 디자인*/
            position: absolute;
            bottom: 25%; /* 텍스트가 이미지 위에 오도록 위치 조정 */
            color: black;
            z-index: 2; /* 텍스트를 이미지 위에 표시하기 위해 z-index 설정 */
            font-size: large;
            left: 38%;
            text-align: center;
        }
        .comment_area {
            position: absolute;
            bottom: 20%;
            width: 45%;
            left: 28%;
            z-index: 1; /* 이미지는 텍스트 아래로 배치 */
        }
        .middle{
            position: absolute;
            right: 32%;
            bottom: 35%;
            width: 35%;
        }
        .bgimg {
            z-index: 0;
            width: 672px;
        }
        img:hover{
            pointer-events: visiblePainted;
        }
        .shelf3 {
            position: absolute;
            z-index: 1;
            width: 14vw;
            height: 41vh;
            right: 34.5%;
            top: 25%;
        }
        .jewchest{
            position: absolute;
            z-index: 2;
            width: 4vw;
            height: 7vh;
            right: 41%;
            top: 41.5%;
        }
        .bigchest{
            position: absolute;
            z-index: 1;
            width: 12vw;
            height: 15vh;
            right: 52%;
            top: 45%;
        }
        .lock{
            position: absolute;
            z-index: 2;
            width: 3vw;
            height: 8vh;
            right: 57%;
            top: 50%;
        }
        .indian_doll{
            position: absolute;
            z-index: 2;
            width: 2vw;
            height: 5vh;
            right: 40%;
            top: 36.5%;
        }
        .bloody_cross{
            position: absolute;
            z-index: 1;
            width: 7vw;
            height: 15vh;
            right: 48%;
            top: 30%;
        }
        .inventory_button {
            position: absolute;
            bottom: 5%;
            right: 5%;
            z-index: 3;
            background-color: white;
            color: black;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
        .jewchestModal{
            position: absolute;
            align-items: center;
        }
    </style>
</head>
<body>
    <div>
        <div class="text_box" data-trigger>
            <span class="text"></span>
        </div>
        <div>
            <img src="/static/images/rozer/integ/Part_1_Right.png" class="middle bgimg">
            <img src="/static/images/rozer/integ/그림3.png" class="shelf3" onclick="handleShelf3Click()">
            <img src="/static/images/rozer/integ/보물함.png" class="jewchest" id="jewchest" onclick="getjewchest()">
            <img src="/static/images/rozer/integ/그상자.png" class="bigchest" onclick="getMessaggechest()">
            <img src="/static/images/rozer/integ/자물쇠.png" class="lock" onclick="getlock()">
            <img src="/static/images/rozer/integ/인디언인형.png" class="indian_doll" id="indian_doll" onclick="getindiandoll()">
            <img src="/static/images/rozer/integ/피묻은십자가표식.png" class="bloody_cross" onclick="playmusic()">
            
            <img src="/static/images/rozer/integ/comment_area_bloody.png" class="comment_area" onclick="resetMessage()">
        </div>
        <!--링크 이동 수정-->
        <a href="Part_1_C.html" class="carousel-control-prev" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
    </div>
    
    <!-- 모달 창 구조 -->
    <div class="modal fade" id="jewchestModal" tabindex="-1" aria-labelledby="jewchestModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background-color: darkslategray; color: white;">
                <div class="modal-body">
                    <p>매우 수상한 장신구가 나를 맞이하고 있다....</p>
                    <div class="btn-group">
                        <img src="/static/images/rozer/integ/장신구.png" class="btn btn-dark" id="modalItem" style="width: 45%; cursor: pointer; align-items: center;">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 으스스한 디자인의 모달 창 -->
    <div class="modal fade" id="spookyModal" tabindex="-1" aria-labelledby="spookyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background-color: darkslategray; color: white;">
                <div class="modal-header">
                    <h5 class="modal-title" id="spookyModalLabel">단발권총과 성냥갑을 발견했습니다....</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p></p>
                    <div class="btn-group">
                        <img src="/static/images/rozer/integ/단발권총.png" class="btn btn-dark" id="pistol" style="width: 45%; cursor: pointer;">
                        <img src="/static/images/rozer/integ/성냥갑.png" class="btn btn-dark" id="matchbox" style="width: 45%; cursor: pointer;">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="indianDollModal" tabindex="-1" aria-labelledby="indianDollModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="indianDollModalLabel"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>끔찍한 인형...</p>
                    <div class="btn-group">
                        <button type="button" class="btn btn-dark" onclick="handleChoice(1)">1. 흔들어본다</button>
                        <button type="button" class="btn btn-dark" onclick="handleChoice(2)">2. 불태워본다!</button>
                        <button type="button" class="btn btn-dark" onclick="handleChoice(3)">3. 그냥 놔둔다</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const initialContent = "우측이다.";
        const chestContent = "튼튼하게 생긴 상자 같다. 그런데... 어째서 안이 비어있는 것 같지?";
        const emptyContent = "열면 큰일이 날 것 같은데...";
        const text = document.querySelector(".text");
        let i = 0;
        let currentMessage = initialContent;
        let isInitialMessage = true;

        function typing(){
            if (i < currentMessage.length) {
                let txt = currentMessage.charAt(i);
                text.innerHTML += txt;
                i++;
                setTimeout(typing, 100);
            }
        }

        function resetMessage() {
            if (isInitialMessage) {
                currentMessage = emptyContent;
                isInitialMessage = false;
            } else {
                currentMessage = initialContent;
                isInitialMessage = true;
            }
            text.innerHTML = "";
            i = 0;
            typing();
        }

        function getItem(imageSrc) {
            const audio = new Audio('static/sounds/rozer/integ/아이템획득소리2.mp3');
            audio.play();
            let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
            if (inventory.length < 6) { // 인벤토리에 아이템이 6개 이하인 경우만 추가
                inventory.push(imageSrc);
                localStorage.setItem('inventory', JSON.stringify(inventory));
                alert("아이템이 추가되었습니다.");
            } else {
                alert("인벤토리가 가득 찼습니다.");
            }
        }

        function getMessaggeshelf3() {
            /*링크 이동 수정*/
            window.location.href = "Dead_stampede.html";
        }

        function getMessaggechest() {
            currentMessage = chestContent;
            text.innerHTML = "";
            i = 0;
            typing();
        }

        function playmusic() {
            alert("음악을 재생합니다.");
        }

        function getjewchest(){

            const jewchestModal = new bootstrap.Modal(document.getElementById('jewchestModal'));
            jewchestModal.show();
            

            document.getElementById('modalItem').onclick = function() {
                getItem('/static/images/rozer/integ/장신구.png');
                jewchestModal.hide();
                document.getElementById('jewchest').style.display = 'none';
            }
        }

        function getindiandoll() {
            const indianDollModal = new bootstrap.Modal(document.getElementById('indianDollModal'));
            indianDollModal.show();
        }

        function handleChoice(choice) {
            switch (choice) {
                case 1:
                    const audio = new Audio('static/sounds/rozer/integ/3층시체가를때나는소리.mp3');
                    audio.play();
                    currentMessage = "더 이상 흔들면 정말 큰일 날 것 같다";
                    text.innerHTML = "";
                    i = 0;
                    typing();
                    

                    document.querySelector('.comment_area').onclick = function() {
                        currentMessage = initialContent;
                        text.innerHTML = "";
                        i = 0;
                        typing();
                    };
                    break;
                case 2:

                    getItem('static/images/rozer/integ/보따리에서나온열쇠.png');
                    alert("무언가를 얻었습니다.");
                    break;
                case 3:

                    break;
                default:
                    alert("올바른 선택지를 입력하세요 (1, 2, 3)");
                    break;
            }
            
            const indianDollModal = new bootstrap.Modal(document.getElementById('indianDollModal'));
            indianDollModal.hide();
        }

        function getlock(){

            let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
            

            let hasKey = inventory.includes('static/images/rozer/integ/보따리에서나온열쇠.png');

            if (!hasKey) {

                currentMessage = "도저히 열 수가 없다...";
                text.innerHTML = "";
                i = 0;
                typing();
            } else {

                currentMessage = "열렸다........괜찮은건가....?";
                text.innerHTML = "";
                i = 0;
                typing();


                setTimeout(function() {
                    currentMessage = "일단 내려가 보자...";
                    text.innerHTML = "";
                    i = 0;
                    typing();


                    document.querySelector('.comment_area').onclick = function() {
                        // 링크 이동 수정
                        window.location.href = "../floor2/Part_2-Script1.html";
                    };
                }, 2000);


                document.getElementById('indian_doll').style.display = 'none';
            }
        }

        function goToInventory() {
            // 링크 이동 수정
            window.location.href = "../integ/Inventory_temp.html";
        }

        function handleShelf3Click() {
            const randomChoice = Math.random();
            if (randomChoice < 0.5) {
                getMessaggeshelf3();
            } else {
                const spookyModal = new bootstrap.Modal(document.getElementById('spookyModal'));
                spookyModal.show();

                document.getElementById('pistol').onclick = function() {
                    getItem('static/images/rozer/integ/단발권총.png');
                    document.getElementById('pistol').style.display = 'none';
                }

                document.getElementById('matchbox').onclick = function() {
                    getItem('static/images/rozer/integ/성냥갑.png');
                    document.getElementById('matchbox').style.display = 'none';
                }
            }
        }

        typing(); // 초기 메시지 타이핑 시작
    </script>
</body>
</html>
