package com.project.action;

import com.project.dao.ProductDAO;
import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) throws Exception {

        String name = request.getParameter("name");

        double price = 0;
        try {
            price = Double.parseDouble(request.getParameter("price"));
        } catch (Exception e) {
            price = 0;
        }

        ProductDAO dao = new ProductDAO();
        dao.addProduct(name, price);

        HttpSession session = request.getSession();
        session.setAttribute("toastTitle", "Added");
        session.setAttribute("toastMessage", "Product added successfully.");
        session.setAttribute("toastType", "success");

        response.sendRedirect("products.do");
        return null;
    }
}