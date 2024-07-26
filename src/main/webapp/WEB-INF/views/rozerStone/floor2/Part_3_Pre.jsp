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
            background-image: url(/static/images/rozer/integ/귀신2.gif);
        }
        .centerTxt {
            color: darkred;
            text-align: center;
            font-size: 100px;
            line-height: 900px;
        }
    </style>
</head>
<body>
    <div class="centerTxt">    파트 3 에서 만나요    </div>
    <script>
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
                    gametype: 'theHostel',
                    comment: msg
                },
                success: function(data) {
                    console.log(data);
                    resetElapsedTime();
                    localStorage.removeItem(bgmCurrentTime);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX Error:', textStatus);
                    console.error('Error Thrown:', errorThrown);
                    console.error('Response Text:', jqXHR.responseText);
                }
            });
        });
    </script>
</body>
</html>