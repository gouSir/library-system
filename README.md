# 图书馆借还系统 — JavaWeb期末作业

## 项目说明
基于 Java Servlet + JSP + MySQL 的图书借阅归还管理系统。

## 技术栈
- **后端**：Java 8+, Servlet 4.0, JSP, JDBC
- **前端**：JSP, CSS, JSTL
- **数据库**：MySQL 8.0
- **构建**：Maven (war)

## 项目结构
```
library/
├── pom.xml                    # Maven配置
├── sql/init.sql               # 数据库初始化脚本
├── src/main/java/com/library/
│   ├── model/                 # 实体类
│   │   ├── User.java
│   │   ├── Book.java
│   │   └── BorrowRecord.java
│   ├── dao/                   # 数据访问层
│   │   ├── UserDao.java
│   │   ├── BookDao.java
│   │   └── BorrowDao.java
│   ├── util/DBUtil.java       # 数据库连接工具
│   └── servlet/               # Servlet控制器
│       ├── LoginServlet.java
│       ├── RegisterServlet.java
│       ├── LogoutServlet.java
│       ├── IndexServlet.java
│       ├── SearchBookServlet.java
│       ├── BorrowServlet.java
│       ├── ReturnServlet.java
│       ├── MyBorrowsServlet.java
│       ├── AdminBookServlet.java
│       └── AdminBorrowsServlet.java
└── src/main/webapp/
    ├── WEB-INF/web.xml
    ├── css/style.css
    └── jsp/
        ├── login.jsp          # 登录页
        ├── register.jsp       # 注册页
        ├── index.jsp          # 读者首页（图书列表）
        ├── my-borrows.jsp     # 我的借阅
        ├── admin-books.jsp    # 管理图书
        └── admin-borrows.jsp  # 管理借阅
```

## 运行步骤

### 🚀 一键启动（不需要配置 Tomcat！）
双击 `run.bat` 或在终端执行：
```bash
mvn jetty:run
```
等待控制台出现 `Started Jetty Server` 字样后，浏览器访问：
**http://localhost:8080/library/login**

> 按 `Ctrl+C` 停止服务器。

### 数据库（已初始化）
数据库 `mobile` 已初始化完成，MySQL 密码为 `root`。

如需重新初始化：
```bash
mysql -u root -proot --default-character-set=utf8mb4 < sql/init.sql
```

### 功能列表
| 功能 | 读者 | 管理员 |
|------|------|--------|
| 注册/登录 | ✓ | ✓ |
| 浏览图书列表 | ✓ | ✓ |
| 搜索图书 | ✓ | ✓ |
| 借阅图书 | ✓ | - |
| 归还图书 | ✓ | ✓ |
| 查看借阅记录 | ✓ | ✓ |
| 添加/编辑/删除图书 | - | ✓ |
| 管理所有借阅 | - | ✓ |

### 测试账号
| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | admin123 |
| 读者 | reader | reader123 |
| 读者 | lisi | 123456 |
| 读者 | wangwu | 123456 |
