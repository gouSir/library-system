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
 * 管理员图书管理Servlet
 */
@WebServlet("/admin/books")
public class AdminBookServlet extends HttpServlet {

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

        String action = request.getParameter("action");
        BookDao bookDao = new BookDao();

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = bookDao.findById(id);
            request.setAttribute("editBook", book);
        }

        List<Book> books = bookDao.findAll();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/jsp/admin-books.jsp").forward(request, response);
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

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        BookDao bookDao = new BookDao();

        if ("add".equals(action)) {
            Book book = new Book();
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setIsbn(request.getParameter("isbn"));
            book.setCategory(request.getParameter("category"));
            book.setPublisher(request.getParameter("publisher"));
            book.setPublishYear(Integer.parseInt(request.getParameter("publishYear")));
            book.setTotalCopies(Integer.parseInt(request.getParameter("totalCopies")));
            book.setDescription(request.getParameter("description"));

            if (bookDao.add(book)) {
                session.setAttribute("msg", "图书添加成功！");
            } else {
                session.setAttribute("msg", "添加失败！");
            }
        } else if ("update".equals(action)) {
            Book book = new Book();
            book.setId(Integer.parseInt(request.getParameter("id")));
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setIsbn(request.getParameter("isbn"));
            book.setCategory(request.getParameter("category"));
            book.setPublisher(request.getParameter("publisher"));
            book.setPublishYear(Integer.parseInt(request.getParameter("publishYear")));
            book.setTotalCopies(Integer.parseInt(request.getParameter("totalCopies")));
            book.setDescription(request.getParameter("description"));

            if (bookDao.update(book)) {
                session.setAttribute("msg", "图书更新成功！");
            } else {
                session.setAttribute("msg", "更新失败！");
            }
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (bookDao.delete(id)) {
                session.setAttribute("msg", "图书删除成功！");
            } else {
                session.setAttribute("msg", "删除失败！");
            }
        }

        response.sendRedirect("books");
    }
}
