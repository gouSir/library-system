<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 图书馆借还系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h2>📚 图书馆借还系统</h2>
            <p class="subtitle">欢迎回来，请登录您的账号</p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg">${error}</div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="success-msg">${success}</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" name="username" placeholder="请输入用户名" required>
                </div>
                <div class="form-group">
                    <label>密码</label>
                    <input type="password" name="password" placeholder="请输入密码" required>
                </div>
                <button type="submit" class="btn-submit">登 录</button>
            </form>
            <div class="switch-link">
                还没有账号？<a href="${pageContext.request.contextPath}/register">立即注册</a>
            </div>
            <div style="margin-top:16px;padding:12px;background:#f5f5f5;border-radius:6px;font-size:12px;color:#888;">
                <strong>测试账号：</strong><br>
                管理员：admin / admin123<br>
                读者：reader / reader123
            </div>
        </div>
    </div>
</body>
</html>
