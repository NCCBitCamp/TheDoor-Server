<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RozerStone</title>
    <script src="/static/js/rozer/timer.js"></script>
    <link rel="icon" href="../favicon-16x16.png">
    <style>
        body {
            background-color: black;
            display: flex;
            justify-content: center;
            align-items: flex-end;
            height: 100vh; /* 화면 전체 높이로 설정 */
            margin: 0;
        }
        .text_box { /*텍스트 디자인*/
            position: absolute;
            bottom: 25%; /* 텍스트가 이미지 위에 오도록 위치 조정 */
            color: black;
            z-index: 2; /* 텍스트를 이미지 위에 표시하기 위해 z-index 설정 */
            font-size: large;
        }
        .comment_area {
            position: absolute;
            bottom: 20%;
            width: 45%;
            z-index: 1; /* 이미지는 텍스트 아래로 배치 */
        }
        .middle{
            position: absolute;
            align-items: center;
            bottom: 35%;
            width: 35%;
        }
        img .middle{
            background: black;
            z-index: 2;
        }
    </style>
</head>
<body>
    <div class="text_box" data-trigger>
        <span class="text"></span>
    </div>
    <img class="middle" onclick="redirectToNaver()">
    <img class="comment_area" onclick="redirectTo2_C()">
    <script>
        const content = "아니... 어디까지 내려가는거야...?";
        const text = document.querySelector(".text");
        const comment_area = document.querySelector(".comment_area");
        let i = 0;

        function typing(){
            comment_area.src = "/static/images/rozer/integ/comment_area_bloody.png";
            if (i < content.length) {
                let txt = content.charAt(i);
                text.innerHTML += txt;
                i++;
            } else {
                setTimeout(() => {
                comment_area.src = "";
                }, 1000);
                // 2초후 2-C로 이동
                setTimeout(redirectTo2_C, 2000);
            }
        }
        setInterval(typing, 100);

        function redirectTo2_C() {
            window.location.href = "/darkToCenter.do"; // 링크이동만들기
        }
    </script>
</body>
</html>
