<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>借阅管理 - 后台管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="brand">
            <span class="icon">📚</span> 图书馆后台管理
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/books">图书管理</a>
            <a href="${pageContext.request.contextPath}/admin/borrows" class="active">借阅管理</a>
            <span class="user-info">👤 ${sessionScope.user.realName}（管理员）</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">退出登录</a>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h2>📋 借阅管理</h2>
            <p>查看所有读者的借阅记录</p>
        </div>

        <c:if test="${not empty sessionScope.msg}">
            <div class="toast-msg">${sessionScope.msg}</div>
            <c:remove var="msg" scope="session"/>
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>读者</th>
                        <th>图书名称</th>
                        <th>作者</th>
                        <th>ISBN</th>
                        <th>借阅日期</th>
                        <th>应还日期</th>
                        <th>归还日期</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${records}" var="r">
                        <tr>
                            <td>${r.id}</td>
                            <td>
                                <strong>${r.realName}</strong>
                                <span style="color:#999;font-size:12px;">(${r.username})</span>
                            </td>
                            <td>${r.bookTitle}</td>
                            <td>${r.bookAuthor}</td>
                            <td style="font-size:12px;">${r.bookIsbn}</td>
                            <td>${r.borrowDate}</td>
                            <td>${r.dueDate}</td>
                            <td>${empty r.returnDate ? '-' : r.returnDate}</td>
                            <td>
                                <span class="status-badge status-${r.status}">${r.statusText}</span>
                            </td>
                            <td>
                                <c:if test="${r.status == 'borrowed'}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/borrows" style="display:inline;">
                                        <input type="hidden" name="action" value="return">
                                        <input type="hidden" name="recordId" value="${r.id}">
                                        <button type="submit" class="btn btn-success btn-sm"
                                                onclick="return confirm('确认帮读者归还《${r.bookTitle}》？')">
                                            确认归还
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${r.status != 'borrowed'}">
                                    <span style="color:#999;">-</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty records}">
            <div style="text-align:center;padding:60px;color:#999;">
                <p style="font-size:48px;">📭</p>
                <p style="font-size:18px;margin-top:12px;">暂无借阅记录</p>
            </div>
        </c:if>
    </div>

    <div class="footer">
        &copy; 2026 图书馆借还系统 · JavaWeb期末作业
    </div>
</body>
</html>
