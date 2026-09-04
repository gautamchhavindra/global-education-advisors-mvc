<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Dashboard - Global Education Advisors</title>
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

                /* Search Bar Component Styling */
                .search-box-container {
                    margin: 20px 0;
                    display: flex;
                    gap: 10px;
                }

                .search-input {
                    padding: 10px;
                    font-size: 14px;
                    width: 300px;
                    border: 1px solid #cbd5e1;
                    border-radius: 4px;
                }

                .search-btn {
                    background: #0b1a30;
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    border-radius: 4px;
                    cursor: pointer;
                    font-weight: 600;
                }

                .clear-btn {
                    background: #64748b;
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    border-radius: 4px;
                    text-decoration: none;
                    font-size: 14px;
                    line-height: 20px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 10px;
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

                .timestamp {
                    font-size: 13px;
                    color: #64748b;
                }
            </style>
        </head>

        <body>
            <header>
                <h2>Global Education Advisors Console</h2>
                <div>

                    <div>
                        <span>Welcome, <strong>${user.userName}</strong></span>
                        <a href="${pageContext.request.contextPath}/users-list" class="nav-btn"
                            style="background: #0ea5e9;">View Advisors</a>
                        <a href="${pageContext.request.contextPath}/create-user" class="nav-btn">Create Advisor User</a>
                        <a href="${pageContext.request.contextPath}/logout" class="nav-btn"
                            style="background:#ef4444;">Logout</a>
                    </div>
            </header>
            <div class="container">
                <h3>Student Intake Leads Management</h3>

                <!-- Search Controls View Layout Component -->
                <form action="${pageContext.request.contextPath}/dashboard" method="get">
                    <div class="search-box-container">
                        <input type="text" name="search" class="search-input"
                            placeholder="Search by name, email, or country..." value="${currentSearch}">
                        <button type="submit" class="search-btn">Search Filter</button>
                        <c:if test="${not empty currentSearch}">
                            <a href="${pageContext.request.contextPath}/dashboard" class="clear-btn">Reset Grid</a>
                        </c:if>
                    </div>
                </form>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Email Address</th>
                            <th>Highest Qualification</th>
                            <th>Preferred Country</th>
                            <th>Phone Number</th>
                            <th>Date Received</th> <!-- New Column -->
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="lead" items="${leads}">
                            <tr>
                                <td>#${lead.id}</td>
                                <td><strong>${lead.fullName}</strong></td>
                                <td>${lead.emailAddress}</td>
                                <td>${lead.highestQualification}</td>
                                <td><span
                                        style="background: #e0f2fe; color: #0369a1; padding: 4px 8px; border-radius: 4px; font-weight:600;">${lead.preferredCountry}</span>
                                </td>
                                <td>${lead.phoneNumber}</td>
                                <td class="timestamp">${lead.createDate}</td> <!-- Displays create_date -->
                            </tr>
                        </c:forEach>
                        <c:if test="${empty leads}">
                            <tr>
                                <td colspan="7" style="text-align: center; color: #94a3b8; padding: 30px;">No match
                                    found tracking your specified search query context.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </body>

        </html>