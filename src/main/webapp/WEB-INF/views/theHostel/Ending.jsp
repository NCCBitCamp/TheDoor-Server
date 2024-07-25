<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>엔딩 장면</title>
    <script src="/static/js/theHostel/timer.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="/static/css/theHostel/01_the_hostel.css">
    <link rel="icon" href="/static/images/theHostel/favicon.ico" type="image/x-icon">
    <style>
        body {
            background-color: black;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden; /* 화면 밖으로 텍스트가 넘어가지 않도록 설정 */
        }
        .scroll-container {
            height: 100%; /* 전체 화면 높이 설정 */
            overflow: hidden; /* 화면 밖으로 텍스트가 넘어가지 않도록 설정 */
            position: relative; /* 상대 위치 설정 */
            width: 100%;
        }
        .scroll-text {
            position: absolute; /* 절대 위치 설정 */
            bottom: -100%; /* 화면 아래쪽에서 시작 */
            animation: scroll-up 20s linear infinite; /* 20초 동안 linear 애니메이션 실행 */
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        @keyframes scroll-up {
            0% {
                bottom: -100%; /* 화면 아래쪽에서 시작 */
            }
            100% {
                bottom: 100%; /* 화면 위쪽으로 끝 */
            }
        }
        .ending-container {
            text-align: center;
            max-width: 800px;
            margin: auto;
        }
        .ending-container h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        .ending-container p {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
        .ending-container button {
            padding: 10px 20px;
            font-size: 1rem;
            cursor: pointer;
            background-color: #007BFF;
            border: none;
            color: white;
            border-radius: 5px;
            transition: background-color 0.3s;
            position:fixed;
            right: 10px;
            bottom:30px;
        }
        .ending-container button:hover {
            background-color: #0056b3;
        }


    </style>
</head>
<body>
    <div class="scroll-container">
        <div class="scroll-text">
            <div class="ending-container">
                <h1>호스텔의 숨겨진 진실</h1>
                <p>모티브는 바에 들어서자마자 바텐더에게로 다가갔다. 바텐더는 록시가 자주 주문하던 칵테일에 대해 설명하며, 그녀가 자주 앉던 자리와 그녀의 일상적인 행동에 대해 이야기해 주었다. 모티브는 바텐더의 설명을 듣고 칵테일을 만들어 록시의 남자친구에게 건넸다. 남자친구는 모티브에게 록시의 사진을 건네며, 그녀를 마지막으로 본 날을 떠올렸다.</p>
                <p>사진 속 록시의 미소는 비밀스러운 메시지를 품고 있는 듯했다. 이 사진은 모티브를 다음 단계로 이끌었다. 모티브는 사진 속 단서를 따라 서랍장을 열기 위해 복잡한 퍼즐을 풀어나갔다. 러시아워 보드게임을 해결한 후, 모티브는 서랍에서 두 번째 칵테일 레시피를 발견했다. 이 레시피는 록시가 즐겨 마시던 또 다른 칵테일의 비밀을 담고 있었다.</p>
                <p>퍼즐을 풀며 서랍장을 열어가는 과정에서 모티브는 점점 록시의 흔적을 추적해 나갔다. 피아노 악보에 적힌 다잉 메시지, 신문에 실린 월들 퍼즐, 라틴어와 그림이 연결된 비디오 클립, 무게를 맞추는 바구니 퍼즐 등 다양한 트릭과 퍼즐을 해결하면서, 그녀는 실종된 록시의 마지막 순간을 조금씩 이해하게 되었다.</p>
                <p>마침내 모티브는 봉투 안에서 작은 동전을 발견했다. 동전을 괴종시계 옆 상자에 올려놓자, 숨겨진 편지가 나타났다. 편지에는 록시의 고통과 슬픔, 그리고 그녀가 자살을 선택하게 된 이유가 담겨 있었다. 편지와 함께 발견된 록시와 남자친구의 사진은 그들이 사랑했지만, 결국 이별할 수밖에 없었던 이야기를 말해주었다.</p>
                <p>모티브는 사건의 진실을 밝혀내며, 록시의 슬픔과 고통을 이해하게 되었다. 그녀는 록시의 이야기를 통해 사랑과 상실, 그리고 인간의 연약함을 다시금 되새기게 되었다. 이 사건은 모티브에게 또 다른 교훈을 남기며, 그녀의 기억 속에 깊이 새겨졌다.</p>
                <button onclick="location.href='/theHostel/the-hostel.do'">다시 시작하기</button>
            </div>
        </div>
    </div>
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
