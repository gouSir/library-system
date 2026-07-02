package com.library.servlet;

import com.library.dao.BookDao;
import com.library.dao.BorrowDao;
import com.library.model.BorrowRecord;
import com.library.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * 管理员借阅管理Servlet
 */
@WebServlet("/admin/borrows")
public class AdminBorrowsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/index");
            return;
        }

        BorrowDao borrowDao = new BorrowDao();
        List<BorrowRecord> records = borrowDao.findAll();
        request.setAttribute("records", records);
        request.getRequestDispatcher("/jsp/admin-borrows.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/index");
            return;
        }

        String action = request.getParameter("action");
        if ("return".equals(action)) {
            int recordId = Integer.parseInt(request.getParameter("recordId"));
            BorrowDao borrowDao = new BorrowDao();
            BorrowRecord record = borrowDao.findById(recordId);

            if (record != null && "borrowed".equals(record.getStatus())) {
                if (borrowDao.returnBook(recordId)) {
                    BookDao bookDao = new BookDao();
                    bookDao.increaseAvailable(record.getBookId());
                    session.setAttribute("msg", "管理员还书成功！");
                } else {
                    session.setAttribute("msg", "还书失败！");
                }
            }
        }

        response.sendRedirect("borrows");
    }
}
