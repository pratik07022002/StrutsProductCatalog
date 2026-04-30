package com.project.action;

import javax.servlet.http.*;
import org.apache.struts.action.*;
import java.util.ArrayList;
import java.util.List;

import com.project.model.Product;

public class AddProductAction extends Action {

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

        String name = request.getParameter("name");

        double price = 0;
        try {
            price = Double.parseDouble(request.getParameter("price"));
        } catch (Exception e) {
            price = 0;
        }

        Integer nextIdObj = (Integer) session.getAttribute("nextProductId");
        int nextId = (nextIdObj == null) ? (list.size() + 1) : nextIdObj;

        list.add(new Product(nextId, name, price));
        session.setAttribute("nextProductId", nextId + 1);
        session.setAttribute("products", list);

        request.setAttribute("products", list);
        return mapping.findForward("success");
    }
}