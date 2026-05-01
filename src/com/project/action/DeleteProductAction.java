package com.project.action;

import com.project.dao.ProductDAO;
import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteProductAction extends Action {

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

        ProductDAO dao = new ProductDAO();
        dao.deleteProduct(id);

        request.setAttribute("products", dao.getAllProducts());
        return mapping.findForward("success");
    }
}