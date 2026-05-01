package com.project.action;

import com.project.dao.ProductDAO;
import com.project.model.Product;
import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditProductAction extends Action {

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
        Product product = dao.getProductById(id);

        request.setAttribute("product", product);
        request.setAttribute("editInfo", "Edit mode active. Update the fields and save the changes.");

        // ✅ forward to edit page (NOT redirect)
        return mapping.findForward("success");
    }
}