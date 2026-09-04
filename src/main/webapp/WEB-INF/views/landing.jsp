<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Global Education Advisors</title>
    <style>
        :root { --primary-blue: #0b1a30; --accent-blue: #1a51c9; --orange-btn: #f5a623; --light-bg: #f8fafc; --text-dark: #1e293b; }
        body { font-family: sans-serif; margin: 0; background: var(--light-bg); color: var(--text-dark); }
        header { background: #fff; display: flex; justify-content: space-between; align-items: center; padding: 15px 50px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .logo { font-size: 22px; font-weight: bold; color: var(--primary-blue); text-decoration:none;}
        .nav-btn { background: var(--accent-blue); color: white; padding: 10px 22px; border-radius: 25px; text-decoration: none; font-weight: 600; }
        .hero-section { background: linear-gradient(135deg, #0e2447 0%, #15376c 100%); color: white; padding: 60px 50px; display: flex; justify-content: space-between; align-items: center; }
        .hero-text { width: 52%; }
        .hero-text h1 { font-size: 38px; }
        .hero-text h1 span { color: var(--orange-btn); }
        .form-card { background: white; border-radius: 12px; padding: 30px; width: 400px; box-shadow: 0 10px 25px rgba(0,0,0,0.2); }
        .form-group { margin-bottom: 14px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 5px; color: #475569; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box; }
        .submit-btn { width: 100%; background: var(--primary-blue); color: white; padding: 12px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; }
        .alert-success { background: #d1fae5; color: #065f46; padding: 12px; border-radius: 6px; margin-bottom: 15px; }
    </style>
</head>
<body>
    <header>
        <a href="#" class="logo">Global <span style="color:var(--accent-blue)">Education Advisors</span></a>
        <a href="${pageContext.request.contextPath}/login" class="nav-btn">Advisor Login</a>
    </header>
    <div class="hero-section">
        <div class="hero-text">
            <h1>Study Abroad with Trusted Study Abroad Experts in India – <br><span>UK, Ireland, New Zealand & Australia</span></h1>
            <p>Get comprehensive guidance for university admissions, profile evaluations, and swift global documentation execution pipelines.</p>
        </div>
        <div class="form-card">
            <h2 style="color:var(--primary-blue); margin-top:0;">Get Free Counselling</h2>
            <c:if test="${not empty successMessage}"><div class="alert-success">${successMessage}</div></c:if>
            <form action="${pageContext.request.contextPath}/submit-lead" method="post">
                <div class="form-group"><label>Full Name</label><input type="text" name="fullName" required></div>
                <div class="form-group"><label>Email Address</label><input type="email" name="emailAddress" required></div>
                <div class="form-group">
                    <label>Highest Qualification</label>
                    <select name="highestQualification" required>
                        <option value="">Select Qualification</option>
                        <option value="High School">High School (12th)</option>
                        <option value="Bachelors Degree">Bachelors Degree</option>
                        <option value="Masters Degree">Masters Degree</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Preferred Country</label>
                    <select name="preferredCountry" required>
                        <option value="">Country of Interest</option>
                        <option value="UK">United Kingdom</option>
                        <option value="Ireland">Ireland</option>
                        <option value="New Zealand">New Zealand</option>
                        <option value="Australia">Australia</option>
                    </select>
                </div>
                <div class="form-group"><label>Phone Number</label><input type="tel" name="phoneNumber" required></div>
                <button type="submit" class="submit-btn" style="background:var(--accent-blue);">Submit Details</button>
            </form>
        </div>
    </div>
</body>
</html>