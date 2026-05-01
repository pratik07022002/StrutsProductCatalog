package com.project.action;

import com.project.dao.ProductDAO;
import com.project.model.Product;
import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class ProductAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {

        ProductDAO dao = new ProductDAO();
        dao.seedDefaultProductsIfEmpty();

        List<Product> list = dao.getAllProducts();
        request.setAttribute("products", list);

        // ✅ Handle toast from session
        HttpSession session = request.getSession();

        request.setAttribute("toastTitle", session.getAttribute("toastTitle"));
        request.setAttribute("toastMessage", session.getAttribute("toastMessage"));
        request.setAttribute("toastType", session.getAttribute("toastType"));

        session.removeAttribute("toastTitle");
        session.removeAttribute("toastMessage");
        session.removeAttribute("toastType");

        // ✅ Forward to JSP (NOT redirect)
        return mapping.findForward("success");
    }
}