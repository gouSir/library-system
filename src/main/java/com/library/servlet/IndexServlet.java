package com.library.servlet;

import com.library.dao.BookDao;
import com.library.model.Book;
import com.library.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * 首页Servlet
 */
@WebServlet("/index")
public class IndexServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        BookDao bookDao = new BookDao();
        List<Book> books = bookDao.findAll();
        request.setAttribute("books", books);

        if (user.isAdmin()) {
            response.sendRedirect("admin/books");
        } else {
            request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
        }
    }
}
