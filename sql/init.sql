-- ============================================
-- 图书馆借还系统 - 数据库初始化脚本
-- 数据库名: mobile
-- ============================================

CREATE DATABASE IF NOT EXISTS mobile DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE mobile;

-- 禁用外键检查，避免删除时冲突
SET FOREIGN_KEY_CHECKS = 0;

-- 用户表
DROP TABLE IF EXISTS borrow_records;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    role ENUM('reader', 'admin') DEFAULT 'reader',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 图书表
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    category VARCHAR(50),
    publisher VARCHAR(100),
    publish_year INT,
    total_copies INT DEFAULT 1,
    available_copies INT DEFAULT 1,
    description TEXT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 借阅记录表
CREATE TABLE borrow_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('borrowed', 'returned', 'overdue') DEFAULT 'borrowed',
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- 初始数据
-- ============================================

-- 管理员账号: admin / admin123
-- 读者账号: reader / reader123
INSERT INTO users (username, password, real_name, phone, role) VALUES
('admin', 'admin123', '系统管理员', '13800000000', 'admin'),
('reader', 'reader123', '张三', '13900000001', 'reader'),
('lisi', '123456', '李四', '13900000002', 'reader'),
('wangwu', '123456', '王五', '13900000003', 'reader');

-- 示例图书
INSERT INTO books (title, author, isbn, category, publisher, publish_year, total_copies, available_copies, description) VALUES
('Java程序设计', '张三丰', '978-7-111-11111-1', '计算机', '清华大学出版社', 2020, 5, 5, 'Java入门到精通，全面讲解JavaSE核心知识'),
('MySQL数据库实战', '李四海', '978-7-111-22222-2', '计算机', '人民邮电出版社', 2019, 3, 3, 'MySQL从基础到高级，包含大量实战案例'),
('Spring框架揭秘', '王代码', '978-7-111-33333-3', '计算机', '电子工业出版社', 2021, 4, 4, '深入浅出讲解Spring框架原理与实践'),
('数据结构与算法', '陈算法', '978-7-111-44444-4', '计算机', '机械工业出版社', 2018, 3, 3, '经典数据结构和算法详解，面试必备'),
('计算机网络', '赵网络', '978-7-111-55555-5', '计算机', '清华大学出版社', 2020, 4, 4, '计算机网络原理与TCP/IP协议详解'),
('百年孤独', '加西亚·马尔克斯', '978-7-544-66666-6', '文学', '南海出版公司', 2017, 3, 3, '魔幻现实主义代表作，值得一读'),
('三体', '刘慈欣', '978-7-536-77777-7', '科幻', '重庆出版社', 2008, 5, 5, '中国科幻文学的里程碑之作'),
('活着', '余华', '978-7-539-88888-8', '文学', '作家出版社', 2012, 4, 4, '讲述了一个人一生的故事，感人至深'),
('高等数学（第七版）', '同济大学数学系', '978-7-040-39999-9', '数学', '高等教育出版社', 2014, 3, 3, '理工科必修课程，微积分经典教材'),
('线性代数', '同济大学数学系', '978-7-040-40000-0', '数学', '高等教育出版社', 2018, 3, 3, '矩阵理论与线性空间的基础教材');

-- 示例借阅记录
INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, return_date, status) VALUES
(2, 1, '2026-05-15', '2026-06-15', NULL, 'borrowed'),
(2, 6, '2026-05-20', '2026-06-20', NULL, 'borrowed'),
(3, 2, '2026-05-01', '2026-06-01', '2026-05-28', 'returned'),
(3, 7, '2026-05-10', '2026-06-10', NULL, 'borrowed');
