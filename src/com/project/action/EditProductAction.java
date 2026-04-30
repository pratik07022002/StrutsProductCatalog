package com.project.action;

import javax.servlet.http.*;
import org.apache.struts.action.*;
import java.util.List;

import com.project.model.Product;

public class EditProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {

        HttpSession session = request.getSession();
        List<Product> list = (List<Product>) session.getAttribute("products");

        if (list != null) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);

                for (Product p : list) {
                    if (p.getId() == id) {
                        request.setAttribute("product", p);
                        break;
                    }
                }
            }
        }

        return mapping.findForward("success");
    }
}