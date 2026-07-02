package com.library.model;

/**
 * 借阅记录实体类
 */
public class BorrowRecord {
    private int id;
    private int userId;
    private int bookId;
    private String borrowDate;
    private String dueDate;
    private String returnDate;
    private String status;   // borrowed / returned / overdue

    // 关联查询字段
    private String username;
    private String realName;
    private String bookTitle;
    private String bookAuthor;
    private String bookIsbn;

    public BorrowRecord() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public String getBorrowDate() { return borrowDate; }
    public void setBorrowDate(String borrowDate) { this.borrowDate = borrowDate; }

    public String getDueDate() { return dueDate; }
    public void setDueDate(String dueDate) { this.dueDate = dueDate; }

    public String getReturnDate() { return returnDate; }
    public void setReturnDate(String returnDate) { this.returnDate = returnDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getRealName() { return realName; }
    public void setRealName(String realName) { this.realName = realName; }

    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }

    public String getBookAuthor() { return bookAuthor; }
    public void setBookAuthor(String bookAuthor) { this.bookAuthor = bookAuthor; }

    public String getBookIsbn() { return bookIsbn; }
    public void setBookIsbn(String bookIsbn) { this.bookIsbn = bookIsbn; }

    public String getStatusText() {
        if ("borrowed".equals(status)) return "借阅中";
        if ("returned".equals(status)) return "已归还";
        if ("overdue".equals(status)) return "已逾期";
        return "未知";
    }
}
