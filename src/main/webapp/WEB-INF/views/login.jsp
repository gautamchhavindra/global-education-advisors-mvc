<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Global Education Advisors</title>
    <style>
        body { font-family: sans-serif; background: #0f172a; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-card { background: white; padding: 40px; border-radius: 8px; width: 340px; box-shadow: 0 4px 12px rgba(0,0,0,0.3); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px;}
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { width: 100%; padding: 12px; background: #1a51c9; color: white; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; }
        .error { color: red; margin-bottom: 15px; font-size: 14px; }
    </style>
</head>
<body>
    <div class="login-card">
        <h2 style="margin-top:0; color:#0b1a30;">Advisor Login</h2>
        <c:if test="${not empty errorMessage}"><div class="error">${errorMessage}</div></c:if>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group"><label>Email Address</label><input type="email" name="emailAddress" required></div>
            <div class="form-group"><label>Password</label><input type="password" name="password" required></div>
            <button type="submit" class="btn">Login</button>
        </form>
    </div>
</body>
</html>