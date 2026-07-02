package com.library.servlet;

import com.library.dao.BorrowDao;
import com.library.model.BorrowRecord;
import com.library.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * 我的借阅记录Servlet
 */
@WebServlet("/myBorrows")
public class MyBorrowsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        BorrowDao borrowDao = new BorrowDao();
        List<BorrowRecord> records = borrowDao.findByUserId(user.getId());
        request.setAttribute("records", records);
        request.getRequestDispatcher("/jsp/my-borrows.jsp").forward(request, response);
    }
}
