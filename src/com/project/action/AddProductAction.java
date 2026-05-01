package com.project.action;

import com.project.dao.ProductDAO;
import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {

        String name = request.getParameter("name");
        double price = 0;

        try {
            price = Double.parseDouble(request.getParameter("price"));
        } catch (Exception e) {
            price = 0;
        }

        ProductDAO dao = new ProductDAO();
        dao.addProduct(name, price);

        request.setAttribute("products", dao.getAllProducts());
        return mapping.findForward("success");
    }
}