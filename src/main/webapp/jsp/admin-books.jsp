<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图书管理 - 后台管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="brand">
            <span class="icon">📚</span> 图书馆后台管理
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/books" class="active">图书管理</a>
            <a href="${pageContext.request.contextPath}/admin/borrows">借阅管理</a>
            <span class="user-info">👤 ${sessionScope.user.realName}（管理员）</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">退出登录</a>
        </div>
    </nav>

    <div class="container">
        <div class="page-header" style="display:flex;justify-content:space-between;align-items:center;">
            <div>
                <h2>📖 图书管理</h2>
                <p>添加、编辑和删除图书</p>
            </div>
            <button class="btn btn-primary" onclick="showAddModal()">＋ 添加图书</button>
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
                        <th>书名</th>
                        <th>作者</th>
                        <th>ISBN</th>
                        <th>分类</th>
                        <th>出版社</th>
                        <th>总量</th>
                        <th>可借</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${books}" var="book">
                        <tr>
                            <td>${book.id}</td>
                            <td><strong>${book.title}</strong></td>
                            <td>${book.author}</td>
                            <td>${book.isbn}</td>
                            <td>${book.category}</td>
                            <td>${book.publisher}</td>
                            <td>${book.totalCopies}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${book.availableCopies > 0}">
                                        <span style="color:#52c41a;font-weight:bold;">${book.availableCopies}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:#ff4d4f;">${book.availableCopies}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="btn-group">
                                    <a href="${pageContext.request.contextPath}/admin/books?action=edit&id=${book.id}"
                                       class="btn btn-warning btn-sm">编辑</a>
                                    <a href="javascript:void(0)"
                                       class="btn btn-danger btn-sm"
                                       onclick="confirmDelete(${book.id}, '${book.title}')">删除</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 添加/编辑图书模态框 -->
    <div class="modal-overlay" id="bookModal">
        <div class="modal-box">
            <h3 id="modalTitle">添加图书</h3>
            <form id="bookForm" action="${pageContext.request.contextPath}/admin/books" method="post">
                <input type="hidden" name="action" id="formAction" value="add">
                <input type="hidden" name="id" id="bookId" value="">
                <div class="form-group">
                    <label>书名 *</label>
                    <input type="text" name="title" id="title" required>
                </div>
                <div class="form-group">
                    <label>作者 *</label>
                    <input type="text" name="author" id="author" required>
                </div>
                <div class="form-group">
                    <label>ISBN</label>
                    <input type="text" name="isbn" id="isbn">
                </div>
                <div class="form-group">
                    <label>分类</label>
                    <input type="text" name="category" id="category" placeholder="如：计算机、文学、数学">
                </div>
                <div class="form-group">
                    <label>出版社</label>
                    <input type="text" name="publisher" id="publisher">
                </div>
                <div class="form-group">
                    <label>出版年份</label>
                    <input type="number" name="publishYear" id="publishYear" min="1900" max="2099">
                </div>
                <div class="form-group">
                    <label>馆藏数量 *</label>
                    <input type="number" name="totalCopies" id="totalCopies" min="1" value="1" required>
                </div>
                <div class="form-group">
                    <label>图书简介</label>
                    <textarea name="description" id="description" rows="3"></textarea>
                </div>
                <div class="btn-row">
                    <button type="button" class="btn" onclick="closeModal()">取消</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">
        &copy; 2026 图书馆借还系统 · JavaWeb期末作业
    </div>

    <script>
        function showAddModal() {
            document.getElementById('modalTitle').textContent = '添加图书';
            document.getElementById('formAction').value = 'add';
            document.getElementById('bookId').value = '';
            document.getElementById('title').value = '';
            document.getElementById('author').value = '';
            document.getElementById('isbn').value = '';
            document.getElementById('category').value = '';
            document.getElementById('publisher').value = '';
            document.getElementById('publishYear').value = '';
            document.getElementById('totalCopies').value = '1';
            document.getElementById('description').value = '';
            document.getElementById('bookModal').classList.add('show');
        }

        function closeModal() {
            document.getElementById('bookModal').classList.remove('show');
        }

        function confirmDelete(id, title) {
            if (confirm('确定要删除《' + title + '》吗？此操作不可恢复。')) {
                var form = document.createElement('form');
                form.method = 'post';
                form.action = '${pageContext.request.contextPath}/admin/books';
                form.innerHTML = '<input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="' + id + '">';
                document.body.appendChild(form);
                form.submit();
            }
        }

        // 编辑模式：如果页面带有 editBook，自动填充表单并打开弹窗
        <c:if test="${not empty editBook}">
            document.getElementById('modalTitle').textContent = '编辑图书';
            document.getElementById('formAction').value = 'update';
            document.getElementById('bookId').value = '${editBook.id}';
            document.getElementById('title').value = '${editBook.title}';
            document.getElementById('author').value = '${editBook.author}';
            document.getElementById('isbn').value = '${editBook.isbn}';
            document.getElementById('category').value = '${editBook.category}';
            document.getElementById('publisher').value = '${editBook.publisher}';
            document.getElementById('publishYear').value = '${editBook.publishYear}';
            document.getElementById('totalCopies').value = '${editBook.totalCopies}';
            document.getElementById('description').value = '${editBook.description}';
            document.getElementById('bookModal').classList.add('show');
        </c:if>

        // 点击遮罩关闭
        document.getElementById('bookModal').addEventListener('click', function(e) {
            if (e.target === this) closeModal();
        });
    </script>
</body>
</html>
