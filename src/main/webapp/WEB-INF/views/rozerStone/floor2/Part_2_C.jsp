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
        .lever {
            position: absolute;
            z-index: 1;
            width: 1.5vw;
            height: 14vh;
            right: 56.3%;
            top: 40%;
            rotate: -50deg;
            transform-origin: bottom center;
            transition: transform 0.5s ease;
         }
        .leverBody {
            position: absolute;
            z-index: 2;
            width: 10vw;
            height: 10vh;
            right: 52%;
            top: 48%;
        }
        .tortureTable {
            position: absolute;
            z-index: 3;
            width: 18vw;
            height: 15vh;
            right: 37%;
            top: 46%;
        }
        .skelC1{
            z-index: 4;
            position: absolute;
            width: 6vw;
            height: 13vh;
            right: 42.5%;
            top: 41%;
            transform: scaleX(-1);
            rotate: 80deg;
        }
        .skelC2{
            z-index: 4;
            position: absolute;
            width: 7vw;
            height: 9vh;
            right: 46%;
            top: 46%;
            transform: scaleX(-1);
            rotate: 190deg;
        }
        .skelC3{
            z-index: 4;
            position: absolute;
            width: 2vw;
            height: 8vh;
            right: 48%;
            top: 45%;
            transform: scaleX(-1);
            rotate: 190deg;
        }
        .skelC4{
            z-index: 4;
            position: absolute;
            width: 7vw;
            height: 10vh;
            right: 42%;
            top: 44%;
            transform: scaleX(-1);
            rotate: 150deg;
        }
        .skelC5{
            z-index: 4;
            position: absolute;
            width: 7vw;
            height: 12vh;
            right: 43%;
            top: 42%;
            transform: scaleX(-1);
            rotate: 190deg;
        }
        .croatoan1{
            z-index: 4;
            position: absolute;
            width: 5vw;
            height: 3vh;
            right: 44%;
            top: 44%;
            rotate: -36deg;
        }
        .croatoan2{
            z-index: 4;
            position: absolute;
            width: 3vw;
            height: 1vh;
            right: 38%;
            top: 38%;
            rotate: 66deg;
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
    </style>
</head>
<body>
    <span>
        <div class="text_box" data-trigger>
            <span class="text"></span>
        </div>
        <div>
            <img src="/static/images/rozer/integ/Part_2_C.png" class="middle bgimg">
            <img src="/static/images/rozer/integ/고문대.png" class="tortureTable" onclick="enjoyTorture()">
            <img src="/static/images/rozer/integ/레버.png" class="lever" onclick="iskingtrue()">
            <img src="/static/images/rozer/integ/레버받침대.png" class="leverBody">
            <img src="/static/images/rozer/integ/해골C1.png" class="skelC1">
            <img src="/static/images/rozer/integ/해골C2.png" class="skelC2">
            <img src="/static/images/rozer/integ/해골C3.png" class="skelC3">
            <img src="/static/images/rozer/integ/해골C4.png" class="skelC4">
            <img src="/static/images/rozer/integ/해골C5.png" class="skelC5">
            <img src="/static/images/rozer/integ/CROATOAN1.png" class="croatoan1">
            <img src="/static/images/rozer/integ/CROATOAN2.png" class="croatoan2">
            <img src="/static/images/rozer/integ/comment_area_bloody.png" class="comment_area" onclick="redirectToNaver()">
            <!-- <img src="comment_area_bloody2.png" class="comment_area" onclick="redirectToNaver()"> -->
        </div>
        <a href="/lightToLeft.do" class="carousel-control-prev" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
<%--        링크이동만들기--%>
        <a href="/lightToRight.do" class="carousel-control-next" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
        <button class="inventory_button" onclick="goToInventory()">인벤토리</button>
    </div>
    </span>
    <script>
        const content = "정면이다";
        const text = document.querySelector(".text");
        let i = 0;

        function typing(){
            if (i < content.length) {
                let txt = content.charAt(i);
                text.innerHTML += txt;
                i++;
            }
        }
        setInterval(typing, 100);
        
        function getItem(imageSrc) {
            const audio = new Audio('/static/sounds/rozer/integ/아이템획득소리2.mp3');
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

        function iskingtrue() {
            let inventory = JSON.parse(localStorage.getItem('inventory')) || []; // Get inventory from localStorage

            // Check if '검정킹.png' exists in the inventory
            // 확인하기 검정킹*******************************************잘되나*************************
            const index = inventory.indexOf('/static/images/rozer/integ/검정킹.png');
            if (index !== -1) {
                inventory.splice(index, 1); // Remove '검정킹.png' from the inventory
                localStorage.setItem('inventory', JSON.stringify(inventory)); // Update inventory in localStorage
                movelever(); // Call movelever() function
            } else {
                alert("꿈쩍도 하지 않는다..."); // Display alert if '검정킹.png' is not found
            }
        }


        function movelever() {
            alert("레버를 움직입니다.");
            // 레버 돌아가는소리 추가하기
            // 비명소리 추가하기
            const lever = document.querySelector('.lever');
            lever.style.transform = 'rotate(70deg)';
            lever.style.transition = 'transform 2s ease';
            
            if(enjoytorture == 1){
                window.location.href = "/blindCenter.do";
            } // 링크이동만들기
            else{
                alert('고문대가 움직입니다');
                const skel1 = document.querySelector('.skelC1');
                const skel2 = document.querySelector('.skelC2');
                const skel3 = document.querySelector('.skelC3');
                const skel4 = document.querySelector('.skelC4');
                const skel5 = document.querySelector('.skelC5');

                skel1.style.transform = 'translateY(5000px)';
                skel1.style.transition = 'transform 0.7s linear';
                
                skel2.style.transform = 'translateX(4000px)';
                skel2.style.transition = 'transform 1s linear';
                
                skel3.style.transform = 'translateY(-80px)';
                skel3.style.transition = 'transform 0.2s linear';
                
                skel4.style.transform = 'translateY(600px)';
                skel4.style.transition = 'transform 0.2s linear';
                
                skel5.style.transform = 'translateY(-800px)';
                skel5.style.transition = 'transform 0.6s linear';
                setTimeout(() => {
                    skel.style.transform = 'translateY(0)';
                    skel.style.transition = 'transform 1s ease';
                }, 250);
            }
            setTimeout(() => {
                    lever.style.transform = 'rotate(0deg)';
                }, 1000);
                
            const nextButton = document.querySelector('.carousel-control-next');
            nextButton.style.display = 'none';

            const prevIcon = document.querySelector('.carousel-control-prev-icon');
            prevIcon.parentElement.href = '/toLeftUNLOCK0.do';
        } // 링크이동만들기

        var enjoytorture = 0;
        function enjoyTorture() {
            if(enjoytorture == 0){
                alert("고문대에 올라갔습니다.");
                // 해골이 나를 덮쳤다 -> 천장화면으로 전환??
                enjoytorture = 1;
            }
            else {
                alert('고문대에서 내려갑니다');
                enjoytorture = 0;
            }
        }

        function playmusic() {
            alert("음악을 재생합니다.");
        }

        function goToInventory() {
            window.location.href = "/inventory.do";
        }// 링크이동만들기
    </script>
</body>
</html>
