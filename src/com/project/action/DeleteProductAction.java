package com.project.action;

import com.project.dao.ProductDAO;
import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteProductAction extends Action {

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

        ProductDAO dao = new ProductDAO();
        dao.deleteProduct(id);

        HttpSession session = request.getSession();
        session.setAttribute("toastTitle", "Deleted");
        session.setAttribute("toastMessage", "Product deleted successfully.");
        session.setAttribute("toastType", "success");

        response.sendRedirect("products.do");
        return null;
    }
}