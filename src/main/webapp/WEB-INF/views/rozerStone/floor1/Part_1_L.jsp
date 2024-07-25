<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            height: 100vh;
            margin: 0;
            background-image: url("/static/images/rozer/integ/floor1_bg_dark.png");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .text_box { 
            position: absolute;
            bottom: 25%;
            color: black;
            z-index: 2;
            font-size: large;
            left: 38%;
            text-align: center;
        }
        .comment_area {
            position: absolute;
            bottom: 20%;
            width: 45%;
            left: 28%;
            z-index: 1;
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
        .bookshelf1 {
            z-index: 1;
            width: 13vw;
            height: 42vh;
            right: 54%;
            top: 24%;
         }
        .bookshelf2 {
            z-index: 1;
            width: 14vw;
            height: 36vh;
            right: 40%;
            top: 25%;
         }
        .bag {
            z-index: 2;
            width: 5vw;
            height: 6vh;
            right: 55%;
            top: 55%;
         }
        .statusBody {
            z-index: 2;
            width: 1.5vw;
            height: 5vh;
            right: 59%;
            top: 49%;
         }
        .papaer4 {
            z-index: 2;
            width: 5vw;
            height: 4vh;
            right: 47.7%;
            top: 56.3%;
         }
        .rib {
            z-index: 2;
            width: 2vw;
            height: 5vh;
            right: 42%;
            top: 51%;
         }
        .bloodBible {
            z-index: 2;
            width: 3vw;
            height: 4vh;
            right: 47%;
            top: 48%;
         }
        .bible {
            z-index: 2;
            width: 3vw;
            height: 4vh;
            right: 42.7%;
            top: 34.3%;
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
        .modal-content {
            background-color: #333;
            color: white;
            text-align: center;
            border: 2px solid red;
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.7);
        }
        .modal-body img {
            margin: 10px;
            cursor: pointer;
        }
        .btn-secondary {
            background-color: #666;
            border-color: #666;
        }
        .btn-secondary:hover {
            background-color: #999;
            border-color: #999;
        }
        .modal-header {
            border-bottom: none;
        }
        .modal-footer {
            border-top: none;
        }
        .modal-content {
            border-radius: 20px;
        }
        .modal-title {
            font-weight: bold;
            color: red;
        }
        .modal-body p {
            color: #ddd;
        }
    </style>
</head>
<body>
    <span>
        <div class="text_box" data-trigger>
            <span class="text"></span>
        </div>
        <div>
            <img src="/static/images/rozer/integ/Part_1_Left.png" class="middle bgimg">
            <img src="/static/images/rozer/integ/책장1.png" class="middle bookshelf1" onclick="deadByShelf()">
            <img src="/static/images/rozer/integ/책장2.png" class="middle bookshelf2" onclick="deadByShelf()">
            <img src="/static/images/rozer/integ/보따리.png" class="middle bag" data-bs-toggle="modal" data-bs-target="#bagModal">
            <img src="/static/images/rozer/integ/목잘린성모상몸통.png" class="middle statusBody" onclick="holymaria()">
            <img src="/static/images/rozer/integ/정체불명의 뼈.png" class="middle rib" id="trickybones" onclick="bones()">
            <img src="/static/images/rozer/integ/피묻은성경책.png" class="middle bloodBible" onclick="bible2()">
            <img src="/static/images/rozer/integ/성경책.png" class="middle bible" onclick="bible1()">
            <img src="/static/images/rozer/integ/종이4.png" class="middle papaer4" onclick="paper()">
            <img src="/static/images/rozer/integ/comment_area_bloody.png" class="comment_area" ondblclick="showBlackScreen()">
        </div>
        <!--링크 이동 수정-->
        <a href="Part_1_L.html" class="carousel-control-prev" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <!--링크 이동 수정-->
        <a href="Part_1_C.html" class="carousel-control-next" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
        <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
    </span>

    <!-- Modal -->
    <div class="modal fade" id="bagModal" tabindex="-1" aria-labelledby="bagModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bagModalLabel">보따리 내용물</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <img src="/static/images/rozer/integ/보따리에서나온열쇠.png" alt="열쇠" onclick="handleItemClick(this)">
                    <img src="/static/images/rozer/integ/화약통.png" alt="화약통" onclick="handleItemClick(this)">
                    <img src="/static/images/rozer/integ/쓸모없는옛날지폐.png" alt="지폐" onclick="handleItemClick(this)">
                    <img src="/static/images/rozer/integ/목잘린성모상머리.png" alt="성모상머리" onclick="handleItemClick(this)">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Black screen overlay -->
    <div class="black-screen" id="blackScreen"></div>

    <script>
        const initialContent = "좌측을 살펴보자..";
        const text = document.querySelector(".text");
        let i = 0;
        let typingInterval;
        let isHolyMariaPlayed = false;
    
        function startTyping() {
            typingInterval = setInterval(typing, 100);
        }
    
        function typing() {
            if (i < initialContent.length) {
                let txt = initialContent.charAt(i);
                text.innerHTML += txt;
                i++;
            } else {
                clearInterval(typingInterval);
            }
        }
    
        function resetMessage() {
            text.innerHTML = '';
            i = 0;
            startTyping();
        }
    
        function showInitialMessage() {
            resetMessage();
        }
    
        function showBlackScreen() {
            const blackScreen = document.getElementById('blackScreen');
            blackScreen.style.display = 'block';
            setTimeout(hideBlackScreen, 500);
        }
    
        function hideBlackScreen() {
            const blackScreen = document.getElementById('blackScreen');
            blackScreen.style.display = 'none';
        }
    
        function redirectToNaver() {
            window.location.href = "https://www.naver.com";
        }
    
        function getItem(imageSrc) {
            const audio = new Audio('/static/sounds/rozer/integ/아이템획득소리2.mp3');
            audio.play();
            let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
            if (inventory.length < 6) {
                inventory.push(imageSrc);
                localStorage.setItem('inventory', JSON.stringify(inventory));
                alert("아이템이 추가되었습니다.");
            } else {
                alert("인벤토리가 가득 찼습니다.");
            }
        }
    
        function handleItemClick(imgElement) {
            const imageSrc = imgElement.getAttribute('src').replace('image/', '');
            getItem(imageSrc);
            imgElement.style.display = 'none';
        }
    
        function deadByShelf() {
            /*링크 이동 수정*/
            window.location.href = "Dead_stampede.html";
            const bookshelf = document.querySelector('.bookshelf2');
            const rib = document.querySelector('.rib');
            const bloodBible = document.querySelector('.bloodBible');
            const bible = document.querySelector('.bible');
            const paper4 = document.querySelector('.paper4');
    
            bookshelf.style.transition = 'all 1s ease-in-out';
            rib.style.transition = 'all 1s ease';
            bloodBible.style.transition = 'all 1s ease-in';
            bible.style.transition = 'all 1s ease-out';
    
            bookshelf.addEventListener('transitionstart', () => {
                /*링크 이동 수정*/
                window.location.href = "Dead_stampede.html";
                bookshelf.style.zIndex = '3';
                paper4.style.transition = 'all 1s';
                paper4.style.zIndex = '1';
            });
        }
    
        function openbag() {
            var myModal = new bootstrap.Modal(document.getElementById('bagModal'));
            myModal.show();
        }
    
        function bible1() {
            const audio = new Audio('/static/sounds/rozer/integ/종이상호작용.mp3');
            audio.play();
            const currentMessage = "왜인지 모르겠지만 피가 묻어 있다. 어느 페이지는 찢겨져 있다.";
            text.innerHTML = currentMessage;
            i = 0;
        }
    
        function holymaria() {
            if (!isHolyMariaPlayed) {
                const audio = new Audio('/static/sounds/rozer/integ/짧은성가대.mp3');
                audio.play();
                isHolyMariaPlayed = true;
                const currentMessage = ".......!!!!!!!";
                text.innerHTML = currentMessage;
                showBlackScreen();
            }
        }
    
        function bible2() {
            const audio = new Audio('/static/sounds/rozer/integ/종이상호작용.mp3');
            audio.play();
            const parchment = document.createElement('img');
            parchment.src = "/static/images/rozer/floor1/양피지3.png";
            parchment.classList.add('middle');
            parchment.style.zIndex = 4;
            parchment.style.width = '30vw';
            parchment.style.height = 'auto';
            parchment.style.right = '35%';
            parchment.style.top = '3%';
            parchment.id = 'parchment';
            parchment.onclick = function () {
                document.body.removeChild(parchment);
            };
            document.body.appendChild(parchment);
        }

        function bones() {
            const modalContent = `
                <div class="modal-header">
                    <h5 class="modal-title" id="bonesModalLabel">이상한 뼈다... 갈비뼈인가?</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>들어올려본다 혹은 깨부숴본다를 선택해 주세요.</p>
                    <button class="btn btn-danger" onclick="handleChoice('들어올려본다')">들어올려본다</button>
                    <button class="btn btn-warning" onclick="handleChoice('깨부숴본다')">깨부숴본다</button>
                </div>
            `;
    
            const bonesModal = new bootstrap.Modal(document.getElementById('bonesModal'));
            bonesModal.show();
            document.getElementById('bonesModalContent').innerHTML = modalContent;
        }

        function handleChoice(choice) {
            if (choice === '들어올려본다') {
                /*링크 이동 수정*/
                window.location.href = "Dead_In_bones.html";
            } else if (choice === '깨부숴본다') {
                const audio = new Audio('/static/sounds/rozer/integ/떨어지는소리2.mp3');
                audio.play();
                const imageSrc = "/static/images/rozer/integ/보따리에서나온열쇠.png";
                getItem(imageSrc);
                document.getElementById('trickybones').style.display = 'none';
            }
        }

        function paper() {
            const parchment = document.createElement('img');
            parchment.src = "/static/images/rozer/floor1/양피지4.png";
            parchment.classList.add('middle');
            parchment.style.zIndex = 4;
            parchment.style.width = '30vw';
            parchment.style.height = 'auto';
            parchment.style.right = '35%';
            parchment.style.top = '3%';
            parchment.id = 'parchment';
            parchment.onclick = function () {
                document.body.removeChild(parchment);
            };
            document.body.appendChild(parchment);
        }
    
        function goToInventory() {
            /*링크 이동 수정*/
            window.location.href = "../integ/Inventory_temp.html";
        }
    
        startTyping();
    </script>
    
    <!-- Custom bones modal -->
    <div class="modal fade" id="bonesModal" tabindex="-1" aria-labelledby="bonesModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background-color: #222; color: white;">
                <div class="modal-body" id="bonesModalContent">
                    <button class="btn btn-danger" onclick="handleChoice('들어올려본다')">들어올려본다</button>
                    <button class="btn btn-warning" onclick="handleChoice('깨부숴본다')">깨부숴본다</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
