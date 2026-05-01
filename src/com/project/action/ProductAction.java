package com.project.action;

import com.project.dao.ProductDAO;
import com.project.model.Product;
import org.apache.struts.action.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        return mapping.findForward("success");
    }
}