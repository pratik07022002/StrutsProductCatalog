package com.project.action;

import javax.servlet.http.*;
import org.apache.struts.action.*;
import java.util.List;

import com.project.model.Product;

public class UpdateProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {

        HttpSession session = request.getSession();
        List<Product> list = (List<Product>) session.getAttribute("products");

        if (list != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");

            double price = 0;
            try {
                price = Double.parseDouble(request.getParameter("price"));
            } catch (Exception e) {
                price = 0;
            }

            for (Product p : list) {
                if (p.getId() == id) {
                    p.setName(name);
                    p.setPrice(price);
                    break;
                }
            }

            session.setAttribute("products", list);
            request.setAttribute("products", list);
        }

        return mapping.findForward("success");
    }
}