<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>RozerStone</title>
  <script src="/static/js/rozer/timer.js"></script>
  <link rel="icon" href="../favicon-16x16.png">
  <link rel="stylesheet" href="/static/css/rozer/chess.css">
  <script src="/static/js/rozer/chess.js"></script>
</head>
<body style="background-image: url('/static/images/rozer/integ/체스테이블.jpg');" onclick="flag()">
  <div>
    <table>
      <tr>
        <td class="white"><div class="black-rook" onclick="moveRook()"></div></td>
        <td class="black"><div class="black-knight" onclick="moveKnight()"></div></td>
        <td class="white"><div class="black-bishop" onclick="moveBishop()"></div></td>
        <td class="black"><div class="black-queen" onclick="moveQeen()"></div></td>
        <td class="white"><div class="black-back" onclick = "back()"></div></td>
        <td class="black"><div class="black-bishop" onclick="moveBishop()"></div></td>
        <td class="white"><div class="black-knight" onclick="moveKnight()"></div></td>
        <td class="black"><div class="black-rook" onclick="moveRook()"></div></td>
      </tr>
      <tr>
        <td class="black"><div class="black-pawn" onclick="movePawn(this)"data-row="1" data-col="0"></div></td>
        <td class="white"><div class="black-pawn" onclick="movePawn(this)"data-row="1" data-col="1"></div></td>
        <td class="black"><div class="black-pawn" onclick="movePawn(this)"data-row="1" data-col="2"></div></td>
        <td class="white"><div class="black-pawn" onclick="movePawn(this)"data-row="1" data-col="3"></div></td>
        <td class="black"><div class="black-pawn" onclick="movePawn(this)"data-row="1" data-col="4"></div></td>
        <td class="white"><div class="black-pawn" onclick="movePawn(this)"data-row="1" data-col="5"></div></td>
        <td class="black"><div class="black-pawn" onclick="movePawn(this)"data-row="1" data-col="6"></div></td>
        <td class="white"><div class="black-pawn" onclick="movePawn(this)"data-row="1" data-col="7"></div></td>
      </tr>
      <tr>
        <td class="white"></td>
        <td class="black"><div data-row="2" data-col="0"></div> </td>
        <td class="white"><div data-row="2" data-col="1"></div> </td>
        <td class="black"><div data-row="2" data-col="2"></div> </td>
        <td class="white"><div data-row="2" data-col="3"></div> </td>
        <td class="black"><div data-row="2" data-col="4"></div> </td>
        <td class="white"><div data-row="2" data-col="5"></div> </td>
        <td class="black"><div data-row="2" data-col="6"></div> </td>
      </tr>
      <tr>
        <td class="black"><div data-row="3" data-col="0"></div></td>
        <td class="white"><div data-row="3" data-col="1"></div></td>
        <td class="black"><div data-row="3" data-col="2"></div></td>
        <td class="white"><div data-row="3" data-col="3"></div></td>
        <td class="black"><div data-row="3" data-col="4"></div></td>
        <td class="white"><div data-row="3" data-col="5"></div></td>
        <td class="black"><div data-row="3" data-col="6"></div></td>
        <td class="white"><div data-row="3" data-col="7"></div></td>
      </tr>
      <tr>
        <td class="white"><div data-row="4" data-col="0"></div></td>
        <td class="black"><div data-row="4" data-col="1"></div></td>
        <td class="white"><div data-row="4" data-col="2"></div></td>
        <td class="black"><div data-row="4" data-col="3"></div></td>
        <td class="white"><div data-row="4" data-col="4"></div></td>
        <td class="black"><div data-row="4" data-col="5"></div></td>
        <td class="white"><div data-row="4" data-col="6"></div></td>
        <td class="black"><div data-row="4" data-col="7"></div></td>
      </tr>
      <tr>
        <td class="black"><div data-row="5" data-col="0"></div></td>
        <td class="white"><div data-row="5" data-col="1"></div></td>
        <td class="black"><div data-row="5" data-col="2"></div></td>
        <td class="white"><div data-row="5" data-col="3"></div></td>
        <td class="black"><div data-row="5" data-col="4"></div></td>
        <td class="white"><div data-row="5" data-col="5"></div></td>
        <td class="black"><div data-row="5" data-col="6"></div></td>
        <td class="white"><div data-row="5" data-col="7"></div></td>
      </tr>
      <tr>
        <td class="white"><div data-row="6" data-col="0"></div></td>
        <td class="black"><div data-row="6" data-col="1"></div></td>
        <td class="white"><div data-row="6" data-col="2"></div></td>
        <td class="black"><div data-row="6" data-col="3"></div></td>
        <td class="white"><div data-row="6" data-col="4"></div></td>
        <td class="black"><div data-row="6" data-col="5"></div></td>
        <td class="white"><div data-row="6" data-col="6"></div></td>
        <td class="black"><div data-row="6" data-col="7"></div></td>
      </tr>
      <tr>
        <td class="black"><div data-row="7" data-col="0"></div></td>
        <td class="white"><div data-row="7" data-col="1"></div></td>
        <td class="black"><div data-row="7" data-col="2"></div></td>
        <td class="white"><div data-row="7" data-col="3"></div></td>
        <td class="black"><div data-row="7" data-col="4"></div></td>
        <td class="white"><div data-row="7" data-col="5"></div></td>
        <td class="black"><div data-row="7" data-col="6"></div></td>
        <td class="white"><div data-row="7" data-col="7"></div></td>
      </tr>
    </table>
  </div>
  <audio id="bgaudio" autoplay></audio>

  <script>

    function back(){
      window.history.back();
    }

  </script>
</body>
</html>