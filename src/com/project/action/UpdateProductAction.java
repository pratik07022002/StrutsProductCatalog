package com.project.action;

import com.project.dao.ProductDAO;
import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) throws Exception {

        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (Exception e) {
            id = 0;
        }

        String name = request.getParameter("name");

        double price = 0;
        try {
            price = Double.parseDouble(request.getParameter("price"));
        } catch (Exception e) {
            price = 0;
        }

        ProductDAO dao = new ProductDAO();
        dao.updateProduct(id, name, price);

        // ✅ store toast in session (survives redirect)
        HttpSession session = request.getSession();
        session.setAttribute("toastTitle", "Updated");
        session.setAttribute("toastMessage", "Product updated successfully.");
        session.setAttribute("toastType", "success");

        // ✅ redirect to avoid resubmission
        response.sendRedirect("products.do");
        return null;
    }
}