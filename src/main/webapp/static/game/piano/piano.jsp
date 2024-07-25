<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Playable Piano JavaScript | CodingStella</title>
    <link rel="stylesheet" href="piano.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="/static/game/piano/piano.js" defer></script>
    <style>
      #back-button {
        position: absolute;
        bottom: 200px;
        left: 50%;
        transform: translateX(-50%);
        padding: 10px 20px;
        background-color: rgb(49, 48, 48);
        color: #c4a05a;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 1rem;
        font-family: "Homemade Apple", 'yleeMortalHeartImmortalMemory', cursive;
      }
    </style>
    
  </head>
  <body>
    <div class="wrapper">
      <header>
        <h2>deaD faCE</h2>
      </header>
      <ul class="piano-keys">
        <li class="key white" data-key="a" id="c" onclick="pianoClick(this);"><span></span></li>
        <li class="key black" data-key="w"><span></span></li>
        <li class="key white" data-key="s" id="d" onclick="pianoClick(this);"><span></span></li>
        <li class="key black" data-key="e"><span></span></li>
        <li class="key white" data-key="d" id="e" onclick="pianoClick(this);"><span></span></li>
        <li class="key white" data-key="f" id="f" onclick="pianoClick(this);"><span></span></li>
        <li class="key black" data-key="t"><span></span></li>
        <li class="key white" data-key="g"><span></span></li>
        <li class="key black" data-key="y"><span></span></li>
        <li class="key white" data-key="h" id="a" onclick="pianoClick(this);"><span></span></li>
        <li class="key black" data-key="u"><span></span></li>
        <li class="key white" data-key="j"><span></span></li>
        <li class="key white" data-key="k" id="c2" onclick="pianoClick(this);"><span></span></li>
        <li class="key black" data-key="o"><span></span></li>
        <li class="key white" data-key="l" id="d2" onclick="pianoClick(this);"><span></span></li>
        <li class="key black" data-key="p"><span></span></li>
        <li class="key white" data-key=";" id="e2" onclick="pianoClick(this);"><span></span></li>
      </ul>
    </div>
    <button id="back-button">Back</button>
    <script>
      // 상자 열쇠 false
      let clearBox = false;

      // 클릭값 받을 객체
      let clickCounts = {
        c: { count: 0, order: 0 },
        d: { count: 0, order: 0 },
        e: { count: 0, order: 0 },
        f: { count: 0, order: 0 },
        a: { count: 0, order: 0 },
        c2: { count: 0, order: 0 },
        d2: { count: 0, order: 0 },
        e2: { count: 0, order: 0 }
      };

      let clickOrder = 0; // 클릭 순서 변수

      // 클릭값 받기 
      function pianoClick(ele) {
        clickCounts[ele.id].count = clickCounts[ele.id].count + 1;
        clickCounts[ele.id].order = ++clickOrder; // 클릭 순서 기록
        console.log(clickCounts);
        console.log(clickOrder);

        // 연주 순서가 맞아야 true 반환
        // 연주 순서가 맞은 뒤엔 아무거나 눌러도 true 반환함
        // 연주 순서가 맞지 않는다면 새로고침 해줘야함.
        if(clickCounts.d.order === 1 && 
        clickCounts.e.order === 2 && clickCounts.f.order === 5 && 
        clickCounts.a.order === 6 && clickCounts.c2.order === 7 && 
        clickCounts.d2.order === 4 && clickCounts.e2.order === 8 ) {
          clearBox = true; // clearBox 변수 직접 수정
        }

        //-------//
        // 클리어 //
        //-------//
        if(clearBox) {
          console.log(clearBox); // 여기에 단서 있는 화면으로 바꾸는 기능ㄱ
          
          // 인벤토리에 깨진액자 추가
          let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
          const itemExists = inventory.includes('/static/images/theHostel/useritem/쟁미.png');
          if (!itemExists) {
              inventory.push('/static/images/theHostel/useritem/쟁미.png');
              localStorage.setItem('inventory', JSON.stringify(inventory));
          }

          // 메시지 표시 후 페이지 이동
          setTimeout(function() {
              alert('장미를 얻었습니다.');
              window.location.href = '/theHostel/right-wall.do'; // 돌아갈 페이지로 이동
          }, 500);
        }
        

        //-------------------------------------//
        // 틀렸으니까 다시 해보라고 알려주는 알람 //
        //-------------------------------------//
        if(!clearBox && clickOrder > 9) {
          console.log('"아무래도 이게 아닌 것 같아.."');
        }
      }

      //---------------------------------------------------------------------//
      // deaD faCE 대문자는 옥타브 위를 뜻함.                                  //
      // 상행으로 연주되게 힌트 줘야할 것 같음. <= 유저 눈치껏하기로 ~            //
      // 4. 오른쪽벽 화면에서 피아노를 클릭하면 이 이벤트가 실행되게 구현 해야 됌. //
      //---------------------------------------------------------------------//


      // 'Back' 버튼 클릭 이벤트 처리
      document.getElementById('back-button').addEventListener('click', function() {
        window.location.href = '/theHostel/right-wall.do'; // 돌아갈 페이지로 이동
      });

    </script>
  </body>
</html>
