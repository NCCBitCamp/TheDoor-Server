<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="icon" type="image/x-icon" href="static/images/main/favicon.ico">
    <meta charset="UTF-8">
    <style>
        body {
            color: #fff;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-image: url("/static/images/main/stage.png");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .login-container {
            width: 300px;
            padding: 20px;
            border-radius: 5px;
            background-color: #272727;
        }
        .login-container h2 {
            text-align: center;
            color: #fff;
        }
        .login-container label, .login-container input {
            display: block;
            width: calc(100% - 20px);
            margin: 10px auto;
            color: #C3C3C3;
            font-size: small;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            padding: 10px;
            border: none;
            border-radius: 3px;
            background-color: #3E3E3E;
            color: #fff;
            box-sizing: border-box;
        }
        .login-container input[type="submit"] {
            font-weight: bold;
            background-color: #FBC70E;
            color: #000;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            width: calc(100% - 20px);
            margin-top: 20px;
        }
        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>LOGIN</h2>
    <form action="/member/login.do" method="post">
        <label for="user_id">Username</label>
        <input type="text" id="user_id" name="user_id" required>
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
        <input type="submit" value="Sign in" onclick="saveUsername();">
    </form>
    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
    </c:if>
</div>
<script>
    function saveUsername() {
        var username = document.getElementById('user_id').value;
        localStorage.setItem('username', username);
        console.log(username);
    }
</script>
</body>
</html>
