package com.project.action;

import javax.servlet.http.*;
import org.apache.struts.action.*;
import java.util.ArrayList;
import java.util.List;

import com.project.model.Product;

public class ProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {

        HttpSession session = request.getSession();

        List<Product> list = (List<Product>) session.getAttribute("products");

        if (list == null) {
            list = new ArrayList<>();

            list.add(new Product(1, "Laptop", 50000));
            list.add(new Product(2, "Mobile", 20000));
            list.add(new Product(3, "Headphones", 2000));

            session.setAttribute("products", list);
            session.setAttribute("nextProductId", 4);
        }

        request.setAttribute("products", list);
        return mapping.findForward("success");
    }
}