package com.library.servlet;

import com.library.dao.BookDao;
import com.library.model.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * 搜索图书Servlet
 */
@WebServlet("/search")
public class SearchBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String keyword = request.getParameter("keyword");

        BookDao bookDao = new BookDao();
        List<Book> books;
        if (keyword == null || keyword.trim().isEmpty()) {
            books = bookDao.findAll();
        } else {
            books = bookDao.search(keyword.trim());
        }
        request.setAttribute("books", books);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
    }
}
