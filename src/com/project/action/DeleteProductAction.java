package com.project.action;

import javax.servlet.http.*;
import org.apache.struts.action.*;
import java.util.Iterator;
import java.util.List;

import com.project.model.Product;

public class DeleteProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {

        HttpSession session = request.getSession();
        List<Product> list = (List<Product>) session.getAttribute("products");

        if (list != null) {
            int id = Integer.parseInt(request.getParameter("id"));

            Iterator<Product> iterator = list.iterator();
            while (iterator.hasNext()) {
                Product p = iterator.next();
                if (p.getId() == id) {
                    iterator.remove();
                    break;
                }
            }

            session.setAttribute("products", list);
            request.setAttribute("products", list);
        }

        return mapping.findForward("success");
    }
}