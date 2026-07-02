package com.library.servlet;

import com.library.dao.BookDao;
import com.library.dao.BorrowDao;
import com.library.model.Book;
import com.library.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 借书Servlet
 */
@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        BookDao bookDao = new BookDao();
        Book book = bookDao.findById(bookId);

        if (book == null || book.getAvailableCopies() <= 0) {
            request.getSession().setAttribute("msg", "该书库存不足，无法借阅！");
            response.sendRedirect("index");
            return;
        }

        BorrowDao borrowDao = new BorrowDao();
        if (borrowDao.hasBorrowed(user.getId(), bookId)) {
            request.getSession().setAttribute("msg", "您已经借阅过这本书且尚未归还！");
            response.sendRedirect("index");
            return;
        }

        // 借书：创建借阅记录 + 减少可用数量
        if (borrowDao.borrow(user.getId(), bookId)) {
            bookDao.decreaseAvailable(bookId);
            request.getSession().setAttribute("msg", "借阅成功！《" + book.getTitle() + "》，请在30天内归还。");
        } else {
            request.getSession().setAttribute("msg", "借阅失败，请重试！");
        }
        response.sendRedirect("index");
    }
}
