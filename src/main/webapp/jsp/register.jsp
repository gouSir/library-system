<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - 图书馆借还系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h2>📝 注册新账号</h2>
            <p class="subtitle">创建账号以借阅图书</p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg">${error}</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" name="username" placeholder="请设置用户名" required>
                </div>
                <div class="form-group">
                    <label>密码</label>
                    <input type="password" name="password" placeholder="请设置密码" required>
                </div>
                <div class="form-group">
                    <label>真实姓名</label>
                    <input type="text" name="realName" placeholder="请输入您的真实姓名" required>
                </div>
                <div class="form-group">
                    <label>手机号</label>
                    <input type="text" name="phone" placeholder="请输入手机号">
                </div>
                <button type="submit" class="btn-submit">注 册</button>
            </form>
            <div class="switch-link">
                已有账号？<a href="${pageContext.request.contextPath}/login">去登录</a>
            </div>
        </div>
    </div>
</body>
</html>
