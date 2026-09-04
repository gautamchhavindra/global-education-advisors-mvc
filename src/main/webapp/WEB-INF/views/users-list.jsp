<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Advisor Management - Global Education Advisors</title>
            <style>
                body {
                    font-family: 'Segoe UI', sans-serif;
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
                    margin-left: 10px;
                }

                .container {
                    max-width: 1200px;
                    margin: 40px auto;
                    background: white;
                    padding: 25px;
                    border-radius: 8px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                }

                th,
                td {
                    padding: 12px;
                    text-align: left;
                    border-bottom: 1px solid #e2e8f0;
                }

                th {
                    background: #f1f5f9;
                    color: #0b1a30;
                }

                .badge-admin {
                    background: #fef3c7;
                    color: #d97706;
                    padding: 4px 8px;
                    border-radius: 4px;
                    font-size: 12px;
                    font-weight: bold;
                }
            </style>
        </head>

        <body>
            <header>
                <h2>Global Education Advisors Console</h2>
                <div>
                    <span>Welcome, <strong>${user.userName}</strong></span>
                    <a href="${pageContext.request.contextPath}/dashboard" class="nav-btn"
                        style="background:#64748b;">Leads Dashboard</a>
                    <a href="${pageContext.request.contextPath}/create-user" class="nav-btn">Create Advisor User</a>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-btn"
                        style="background:#ef4444;">Logout</a>
                </div>
            </header>
            <div class="container">
                <h3>Registered Internal Advisors (Users Table)</h3>
                <table>
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>User Name</th>
                            <th>Email Address (User ID)</th>
                            <th>Role Privilege</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>#${u.id}</td>
                                <td><strong>${u.userName}</strong></td>
                                <td>${u.emailAddress}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.emailAddress eq 'chhavindra.gautam@gmail.com'}">
                                            <span class="badge-admin" style="background:#dcfce7; color:#15803d;">Super
                                                User</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-admin">System Advisor</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>