<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Create Advisor Account</title>
            <style>
                body {
                    font-family: sans-serif;
                    margin: 0;
                    background: #f8fafc;
                }

                header {
                    background: #0b1a30;
                    color: white;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 15px 40px;
                }

                .nav-btn {
                    background: #1a51c9;
                    color: white;
                    padding: 8px 16px;
                    border-radius: 4px;
                    text-decoration: none;
                    font-size: 14px;
                }

                .container {
                    max-width: 500px;
                    margin: 40px auto;
                    background: white;
                    padding: 25px;
                    border-radius: 8px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                }

                .form-group {
                    margin-bottom: 15px;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 5px;
                    font-weight: bold;
                }

                .form-group input {
                    width: 100%;
                    padding: 10px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    box-sizing: border-box;
                }

                .btn {
                    background: #1a51c9;
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                    font-weight: bold;
                }

                .alert {
                    padding: 10px;
                    margin-bottom: 15px;
                    border-radius: 4px;
                }
            </style>
        </head>

        <body>
            <!-- Locate header inside create-user.jsp and replace with this: -->
            <header>
                <h2>Global Education Advisors Console</h2>
                <div>
                    <a href="${pageContext.request.contextPath}/users-list" class="nav-btn"
                        style="background: #0ea5e9;">View Advisors</a>
                    <a href="${pageContext.request.contextPath}/dashboard" class="nav-btn"
                        style="background: #64748b;">Back to Dashboard</a>
                </div>
            </header>
            <div class="container">
                <h3>Create New Advisor User Account</h3>
                <c:if test="${not empty successMessage}">
                    <div class="alert" style="background:#d1fae5; color:#065f46;">${successMessage}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert" style="background:#fee2e2; color:#991b1b;">${errorMessage}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/create-user" method="post">
                    <div class="form-group"><label>User Name</label><input type="text" name="userName" required></div>
                    <div class="form-group"><label>Email Address</label><input type="email" name="emailAddress"
                            required></div>
                    <div class="form-group"><label>Password</label><input type="password" name="password" required>
                    </div>
                    <button type="submit" class="btn">Register User</button>
                </form>
            </div>
        </body>

        </html>