<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的借阅 - 图书馆借还系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="brand">
            <span class="icon">📚</span> 图书馆借还系统
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index">图书列表</a>
            <a href="${pageContext.request.contextPath}/myBorrows" class="active">我的借阅</a>
            <span class="user-info">👤 ${sessionScope.user.realName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">退出登录</a>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h2>📋 我的借阅记录</h2>
            <p>查看您的借阅历史和当前在借图书</p>
        </div>

        <c:if test="${not empty sessionScope.msg}">
            <div class="toast-msg">${sessionScope.msg}</div>
            <c:remove var="msg" scope="session"/>
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>图书名称</th>
                        <th>作者</th>
                        <th>借阅日期</th>
                        <th>应还日期</th>
                        <th>归还日期</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${records}" var="r" varStatus="s">
                        <tr>
                            <td>${s.index + 1}</td>
                            <td><strong>${r.bookTitle}</strong></td>
                            <td>${r.bookAuthor}</td>
                            <td>${r.borrowDate}</td>
                            <td>${r.dueDate}</td>
                            <td>${empty r.returnDate ? '-' : r.returnDate}</td>
                            <td>
                                <span class="status-badge status-${r.status}">${r.statusText}</span>
                            </td>
                            <td>
                                <c:if test="${r.status == 'borrowed'}">
                                    <a href="${pageContext.request.contextPath}/return?recordId=${r.id}"
                                       class="btn btn-success btn-sm"
                                       onclick="return confirm('确定要归还《${r.bookTitle}》吗？')">
                                        还书
                                    </a>
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
                <p style="font-size:18px;margin-top:12px;">您还没有借阅记录</p>
                <p style="margin-top:8px;"><a href="${pageContext.request.contextPath}/index">去借一本书吧 →</a></p>
            </div>
        </c:if>
    </div>

    <div class="footer">
        &copy; 2026 图书馆借还系统 · JavaWeb期末作业
    </div>
</body>
</html>
