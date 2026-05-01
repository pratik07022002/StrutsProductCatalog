package com.project.action;

import com.project.dao.ProductDAO;
import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {

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

        request.setAttribute("products", dao.getAllProducts());
        return mapping.findForward("success");
    }
}