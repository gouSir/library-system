<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图书列表 - 图书馆借还系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- 顶部导航 -->
    <nav class="navbar">
        <div class="brand">
            <span class="icon">📚</span> 图书馆借还系统
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index" class="active">图书列表</a>
            <a href="${pageContext.request.contextPath}/myBorrows">我的借阅</a>
            <span class="user-info">👤 ${sessionScope.user.realName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">退出登录</a>
        </div>
    </nav>

    <!-- 主内容 -->
    <div class="container">
        <div class="page-header">
            <h2>📖 图书列表</h2>
            <p>浏览图书馆藏书，搜索并借阅您感兴趣的图书</p>
        </div>

        <!-- 提示消息 -->
        <c:if test="${not empty sessionScope.msg}">
            <div class="toast-msg">${sessionScope.msg}</div>
            <c:remove var="msg" scope="session"/>
        </c:if>

        <!-- 搜索栏 -->
        <form class="search-bar" action="${pageContext.request.contextPath}/search" method="get">
            <input type="text" name="keyword" placeholder="搜索书名、作者、ISBN或分类..." value="${keyword}">
            <button type="submit">🔍 搜索</button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/index" class="btn btn-sm" style="padding:12px 16px;">清除</a>
            </c:if>
        </form>

        <!-- 图书卡片网格 -->
        <div class="book-grid">
            <c:forEach items="${books}" var="book">
                <div class="book-card">
                    <div class="book-title">📕 ${book.title}</div>
                    <div class="book-meta">
                        <span>✍ ${book.author}</span>
                        <span>📂 ${book.category}</span>
                    </div>
                    <div class="book-meta">
                        <span>🏢 ${book.publisher}</span>
                        <span>📅 ${book.publishYear}</span>
                    </div>
                    <c:if test="${not empty book.isbn}">
                        <div class="book-meta">ISBN: ${book.isbn}</div>
                    </c:if>
                    <div class="book-desc">${book.description}</div>
                    <div class="book-footer">
                        <div class="copies">
                            可借：
                            <c:choose>
                                <c:when test="${book.availableCopies > 0}">
                                    <span class="available">${book.availableCopies}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="unavailable">0</span>
                                </c:otherwise>
                            </c:choose>
                            / ${book.totalCopies}
                        </div>
                        <c:choose>
                            <c:when test="${book.availableCopies > 0}">
                                <a href="${pageContext.request.contextPath}/borrow?bookId=${book.id}"
                                   class="btn-borrow"
                                   onclick="return confirm('确定要借阅《${book.title}》吗？借阅期限为30天。')">
                                    借阅
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="btn-borrow disabled">暂无库存</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty books}">
            <div style="text-align:center;padding:60px;color:#999;">
                <p style="font-size:48px;">📭</p>
                <p style="font-size:18px;margin-top:12px;">没有找到相关图书</p>
            </div>
        </c:if>
    </div>

    <div class="footer">
        &copy; 2026 图书馆借还系统 · JavaWeb期末作业
    </div>
</body>
</html>
