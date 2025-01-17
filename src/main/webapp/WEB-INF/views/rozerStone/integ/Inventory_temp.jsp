<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게임 인벤토리</title>
    <link rel="icon" href="../favicon-16x16.png">
    <style>
        /* 기본적인 레이아웃과 스타일 설정 */
        body {
            background-color: black;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .inventoryImage {
            position: relative;
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .item {
            width: 50px;
            height: 50px;
            position: absolute;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        .back_button {
            position: absolute;
            bottom: 20%;
            right: 48%;
            width: 5%;
        }
        .box {
            position: absolute;
            width: 50px;
            height: 50px;
            background-color: rgba(255, 255, 255, 0.1); /* 박스를 구분하기 위한 반투명 배경 */
        }
    </style>
</head>
<body>
    <div class="inventory">
        <!-- 인벤토리 이미지를 감싸는 div 요소 -->
        <img src="/static/images/rozer/integ/inventory.png" class="inventoryImage">
        
        <!-- 아이템을 담을 박스 1 -->
        <div class="box" id="box1" style="left: 38%; top: 34%;"></div>
        
        <!-- 아이템을 담을 박스 2 -->
        <div class="box" id="box2" style="left: 51.6%; top: 34%;"></div>

        <!-- 아이템을 담을 박스 3 -->
        <div class="box" id="box3" style="left: 38%; top: 46%;"></div>

        <!-- 아이템을 담을 박스 4 -->
        <div class="box" id="box4" style="left: 51.6%; top: 46%;"></div>

        <!-- 아이템을 담을 박스 5 -->
        <div class="box" id="box5" style="left: 38%; top: 58%;"></div>

        <!-- 아이템을 담을 박스 6 -->
        <div class="box" id="box6" style="left: 51.6%; top: 58%;"></div>
    </div>
    
    <!-- 인벤토리에서 돌아가는 버튼 -->
    <div>
        <img src="/static/images/rozer/integ/Inventory_back.png" class="back_button" onclick="getBack()">
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            // 페이지가 로드될 때 실행되는 코드

            // 로컬 스토리지에서 인벤토리 데이터를 가져옴
            let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
            
            // 인벤토리 데이터를 순회하며 박스에 아이템 이미지를 추가
            inventory.forEach((item, index) => {
                if (index < 6) { // 박스가 6개인 경우에 대해서만 처리
                    const box = document.getElementById(`box${index + 1}`); // 박스 요소 선택
                    const img = document.createElement('img'); // 이미지 요소 생성
                    img.src = item; // 이미지 소스를 설정
                    img.className = 'item'; // CSS 클래스 설정
                    img.onclick = () => removeItem(index); // 클릭 시 아이템 제거 함수 호출
                    box.appendChild(img); // 박스에 이미지 요소 추가
                }
            });
        });


        // 인벤 돌아가기 버튼 선택
        const backButton = document.getElementById('backButton');

        // 마우스 클릭 이벤트 리스너 등록
        backButton.addEventListener('click', mouseclick);
        function getBack(){    
            // 뒤로 가기 기능 구현
            window.history.back();
        }
        // 아이템을 제거하는 함수
        function removeItem(index) {
            let inventory = JSON.parse(localStorage.getItem('inventory')) || []; // 로컬 스토리지에서 인벤토리 데이터를 가져옴
            inventory.splice(index, 1); // 지정된 인덱스의 아이템을 제거
            localStorage.setItem('inventory', JSON.stringify(inventory)); // 변경된 인벤토리 데이터를 로컬 스토리지에 저장
            location.reload(); // 페이지를 새로고침하여 변경사항을 반영
        }
    </script>
</body>
</html>
