package com.library.servlet;

import com.library.dao.BookDao;
import com.library.dao.BorrowDao;
import com.library.model.BorrowRecord;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 还书Servlet
 */
@WebServlet("/return")
public class ReturnServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        int recordId = Integer.parseInt(request.getParameter("recordId"));

        BorrowDao borrowDao = new BorrowDao();
        BorrowRecord record = borrowDao.findById(recordId);

        if (record == null || !"borrowed".equals(record.getStatus())) {
            request.getSession().setAttribute("msg", "还书失败：记录不存在或已归还！");
            response.sendRedirect("myBorrows");
            return;
        }

        // 还书：更新借阅记录 + 增加可用数量
        if (borrowDao.returnBook(recordId)) {
            BookDao bookDao = new BookDao();
            bookDao.increaseAvailable(record.getBookId());
            request.getSession().setAttribute("msg", "还书成功！《" + record.getBookTitle() + "》");
        } else {
            request.getSession().setAttribute("msg", "还书失败，请重试！");
        }
        response.sendRedirect("myBorrows");
    }
}
