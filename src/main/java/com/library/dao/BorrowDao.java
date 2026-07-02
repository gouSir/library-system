package com.library.dao;

import com.library.model.BorrowRecord;
import com.library.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 借阅记录数据访问层
 */
public class BorrowDao {

    /**
     * 借书 - 创建借阅记录
     */
    public boolean borrow(int userId, int bookId) {
        String sql = "INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, status) VALUES (?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), 'borrowed')";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, bookId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return false;
    }

    /**
     * 还书
     */
    public boolean returnBook(int recordId) {
        String sql = "UPDATE borrow_records SET return_date = CURDATE(), status = 'returned' WHERE id = ? AND status = 'borrowed'";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, recordId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return false;
    }

    /**
     * 获取指定用户的借阅记录
     */
    public List<BorrowRecord> findByUserId(int userId) {
        List<BorrowRecord> records = new ArrayList<>();
        String sql = "SELECT r.*, u.username, u.real_name, b.title AS book_title, " +
                     "b.author AS book_author, b.isbn AS book_isbn " +
                     "FROM borrow_records r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN books b ON r.book_id = b.id " +
                     "WHERE r.user_id = ? " +
                     "ORDER BY r.status ASC, r.borrow_date DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                records.add(extractRecord(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return records;
    }

    /**
     * 获取所有借阅记录（管理员）
     */
    public List<BorrowRecord> findAll() {
        List<BorrowRecord> records = new ArrayList<>();
        String sql = "SELECT r.*, u.username, u.real_name, b.title AS book_title, " +
                     "b.author AS book_author, b.isbn AS book_isbn " +
                     "FROM borrow_records r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN books b ON r.book_id = b.id " +
                     "ORDER BY r.status ASC, r.borrow_date DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                records.add(extractRecord(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return records;
    }

    /**
     * 根据ID查找借阅记录
     */
    public BorrowRecord findById(int id) {
        String sql = "SELECT r.*, u.username, u.real_name, b.title AS book_title, " +
                     "b.author AS book_author, b.isbn AS book_isbn " +
                     "FROM borrow_records r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN books b ON r.book_id = b.id " +
                     "WHERE r.id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractRecord(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return null;
    }

    /**
     * 检查用户是否已借阅某书且未归还
     */
    public boolean hasBorrowed(int userId, int bookId) {
        String sql = "SELECT COUNT(*) FROM borrow_records WHERE user_id = ? AND book_id = ? AND status = 'borrowed'";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, bookId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return false;
    }

    /**
     * 从ResultSet提取BorrowRecord对象
     */
    private BorrowRecord extractRecord(ResultSet rs) throws SQLException {
        BorrowRecord record = new BorrowRecord();
        record.setId(rs.getInt("id"));
        record.setUserId(rs.getInt("user_id"));
        record.setBookId(rs.getInt("book_id"));
        record.setBorrowDate(rs.getString("borrow_date"));
        record.setDueDate(rs.getString("due_date"));
        record.setReturnDate(rs.getString("return_date"));
        record.setStatus(rs.getString("status"));
        record.setUsername(rs.getString("username"));
        record.setRealName(rs.getString("real_name"));
        record.setBookTitle(rs.getString("book_title"));
        record.setBookAuthor(rs.getString("book_author"));
        record.setBookIsbn(rs.getString("book_isbn"));
        return record;
    }
}
