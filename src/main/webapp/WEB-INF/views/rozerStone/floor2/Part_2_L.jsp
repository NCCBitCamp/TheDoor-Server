<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
    <script src="/static/js/rozer/timer.js"></script>
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
            background-image: url("/static/images/rozer/integ/Part_2_bg.png");
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
        .pic {
            position: absolute;
            z-index: 5;
            width: 8vw;
            height: 21vh;
            right: 53.3%;
            top: 27%;
        }
        .rib {
            position: absolute;
            z-index: 1;
            width: 4vw;
            height: 7vh;
            right: 52%;
            top: 51%;
            transform: scaleX(-1);
        }
        .sekl1 {
            position: absolute;
            z-index: 1;
            width: 8vw;
            height: 14vh;
            right: 34%;
            top: 44%;
        }
        .bug {
            position: absolute;
            z-index: 1;
            width: 4vw;
            height: 5vh;
            right: 56%;
            top: 54%;
        }
        .hwaroblock {
            position: absolute;
            z-index: 2;
            width: 8vw;
            height: 15vh;
            right: 42%;
            top: 47%;
        }
        .chain {
            position: absolute;
            z-index: 1;
            width: 1vw;
            height: 4vh;
            right: 35%;
            top: 25%;
        }
        .sekl_Head {
            position: absolute;
            z-index: 1;
            width: 5vw;
            height: 7vh;
            right: 33%;
            top: 28%;
            rotate: 210deg;
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
        .red-overlay {
            display: none; /* 초기에는 오버레이를 숨깁니다. */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgb(51, 12, 12);
            opacity: 0;
            z-index: 4; /* 오버레이가 텍스트 박스, 버튼 위에 표시 */
            transition: opacity 4s ease-out; /* 4초 동안 천천히 나타나게 설정 */
        }
        .fade-in-red {
            display: block;
            opacity: 0.5; /* 붉은 오버레이의 불투명도 */
        }
    </style>
</head>
<body>
    <span>
        <div class="content">
            <div class="text_box" data-trigger>
                <span class="text"></span>
            </div>
            <div>
                <img src="/static/images/rozer/integ/Part_2_L.png" class="middle bgimg">
                <img src="/static/images/rozer/integ/초상화1-1.PNG" class="pic" onclick="showqueen()">
                <img src="/static/images/rozer/integ/해골8.png" class="rib" onclick="bonessound()">
                <img src="/static/images/rozer/integ/해골1.png" class="sekl1" onclick="bonessound()">
                <img src="/static/images/rozer/integ/벌레.png" class="bug" onclick="insect()">
                <img src="/static/images/rozer/integ/화로.png" class="hwaroblock" onclick="gethwaro()">
                <img src="/static/images/rozer/integ/쇠사슬4.png" class="chain" onclick="chainsound()">
                <img src="/static/images/rozer/integ/해골6.png" class="sekl_Head" onclick="bonessound()">
                <img src="/static/images/rozer/integ/comment_area_bloody2.png" class="comment_area" onclick="redirectToNaver()">
            </div>
            <a href="/lightToBack.do" class="carousel-control-prev" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </a>
<%--            위아래링크이동만들기--%>
            <a href="/lightToCenter.do" class="carousel-control-next" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </a>
            <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
        </div>
        <div class="red-overlay" id="redOverlay"></div>
    </span>
    <script>
        const content = "무슨 끔찍한 일이 일어난 것일까...?";
        const text = document.querySelector(".text");
        let i = 0;

        function typing(){
            if (i < content.length) {
                let txt = content.charAt(i);
                text.innerHTML += txt;
                i++;
            }
        }
        setInterval(typing, 50);

        // function redirectToNaver() {
        //     window.location.href = "Part_1_R.html";
        // }
        
        function getItem(imageSrc) {
            const audio = new Audio('/static/sounds/rozer/integ/아이템을획득.mp3');
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

        function showqueen() {
            const pic = document.querySelector('.pic');
            const redOverlay = document.getElementById('redOverlay');

            // 붉은 오버레이 표시
            redOverlay.style.display = 'block';
            redOverlay.classList.add('fade-in-red');

            setTimeout(() => {
                redOverlay.classList.remove('fade-in-red');
                setTimeout(() => {
                    redOverlay.style.display = 'none';
                }, 2000); // 페이드 아웃이 끝난 후 오버레이 숨기기
            }, 2000);

            // 초상화 클로즈업
            pic.style.transition = 'transform 2s';
            pic.style.transform = 'scale(4)';
            
            // 2초 후에 초상화 이미지 변경 및 애니메이션 시작
            setTimeout(() => {
                pic.src = '/static/images/rozer/integ/초상화2-1.PNG';
                changeImageSequence();
            }, 3000);
        }

        function changeImageSequence() {
            const pic = document.querySelector('.pic');
            const images = ['/static/images/rozer/integ/초상화3-1.PNG', '/static/images/rozer/integ/초상화4-1.PNG'];
            let index = 0;

            function toggleImages() {
                const audio1 = new Audio('/static/sounds/rozer/integ/여왕목소리2.mp3');
                audio1.play();
                setTimeout(() => {
                    pic.src = images[index % 2];
                    index++;
                    if (index < 100) {
                        toggleImages();
                    } else {
                        resetImage();
                    }
                }, 50);
            }

            toggleImages();
        }

        function resetImage() {
            const pic = document.querySelector('.pic');
            const redOverlay = document.getElementById('redOverlay');

            // 0.5초 후에 원래 이미지로 복원
            setTimeout(() => {
                pic.src = '/static/images/rozer/integ/초상화1-1.PNG';
                pic.style.transition = 'transform 2s';
                pic.style.transform = 'scale(1)';

                // 붉은 오버레이 숨기기
                redOverlay.classList.remove('fade-in-red');
                setTimeout(() => {
                    redOverlay.style.display = 'none';
                }, 4000); // 페이드 아웃이 끝난 후 오버레이 숨기기
            }, 500);
        }

        function gethwaro(){
            alert("무딘 칼을 얻었다...!");
            const audio = new Audio('/static/sounds/rozer/integ/치는소리6.mp3');
            audio.play();
            const imageSrc = "/static/images/rozer/integ/나무칼.png";
            getItem(imageSrc); // 이미지링크 확인하기*********************************************
            
            // 화로 이미지 클릭 비활성화
            const bornfire = document.querySelector('.hwaroblock');
            bornfire.onclick = null;
        }

        function insect(){
            window.location.href = "/ToDII.do";
        }//링크이동만들기

        let isbonesPlayed = false;
        let ischainPlayed = false;

        function bonessound(){
            if (!isbonesPlayed) {
                const audio = new Audio('/static/sounds/rozer/integ/치는소리5.mp3');
                audio.play();
                isbonesPlayed = true;
                const currentMessage = "생각했던 것보다 더욱 탁한 소리이다...";
                text.innerHTML = currentMessage;
            }
        }

        function chainsound(){
            if (!ischainPlayed) {
                const audio = new Audio('/static/sounds/rozer/integ/쇠사슬소리.mp3');
                audio.play();
                ischainPlayed = true;
                const currentMessage = "생각했던 것보다 정신사나운 소리이다...";
                text.innerHTML = currentMessage;
            }
        }

        function goToInventory() {
            window.location.href = "/inventory.do";
        }//링크이동만들기
    </script>
</body>
</html>
