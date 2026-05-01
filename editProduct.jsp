<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.Product"%>
<%
    Product product = (Product) request.getAttribute("product");
    boolean hasProduct = (product != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#0f172a">
    <title>Edit Product</title>

    <style>
        :root{
            --bg1:#07111f;
            --bg2:#0f172a;
            --card:rgba(15, 23, 42, 0.72);
            --card-border:rgba(148, 163, 184, 0.18);
            --text:#e5eefc;
            --muted:#9fb0cb;
            --primary:#4f8cff;
            --warning:#f59e0b;
            --shadow:0 24px 60px rgba(0,0,0,.32);
            --radius:28px;
        }

        * { box-sizing: border-box; }

        html, body {
            margin: 0;
            min-height: 100%;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            color: var(--text);
            background:
                radial-gradient(circle at top left, rgba(245,158,11,.16), transparent 28%),
                radial-gradient(circle at bottom right, rgba(79,140,255,.14), transparent 25%),
                linear-gradient(160deg, var(--bg1), var(--bg2));
        }

        .page {
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 28px;
        }

        .card {
            width: min(820px, 100%);
            background: var(--card);
            border: 1px solid var(--card-border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            backdrop-filter: blur(18px);
            overflow: hidden;
            animation: fadeUp .45s ease;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .topbar {
            padding: 28px 32px;
            background: linear-gradient(135deg, rgba(245,158,11,.22), rgba(79,140,255,.14));
            border-bottom: 1px solid rgba(255,255,255,.08);
        }

        .topbar h1 {
            margin: 0;
            font-size: clamp(28px, 3vw, 42px);
            letter-spacing: -.03em;
        }

        .topbar p {
            margin: 10px 0 0;
            color: rgba(229,238,252,.78);
            line-height: 1.7;
        }

        .content {
            padding: 30px 32px 24px;
        }

        .form-shell {
            padding: 22px;
            border-radius: 24px;
            background: rgba(255,255,255,.04);
            border: 1px solid rgba(255,255,255,.08);
        }

        .hint {
            margin: 0 0 20px;
            color: rgba(229,238,252,.72);
            font-size: 14px;
            line-height: 1.7;
        }

        .field {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 9px;
            font-size: 14px;
            color: rgba(229,238,252,.88);
            font-weight: 700;
        }

        input {
            width: 100%;
            padding: 14px 16px;
            border-radius: 16px;
            border: 1px solid rgba(255,255,255,.12);
            outline: none;
            background: rgba(7,17,31,.72);
            color: var(--text);
            font-size: 15px;
            transition: border-color .18s ease, box-shadow .18s ease, transform .18s ease, background .18s ease;
        }

        input::placeholder {
            color: rgba(159,176,203,.70);
        }

        input:focus {
            border-color: rgba(125,211,252,.8);
            box-shadow: 0 0 0 4px rgba(79,140,255,.16);
            background: rgba(7,17,31,.88);
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 13px 18px;
            border-radius: 16px;
            text-decoration: none;
            font-weight: 800;
            letter-spacing: .2px;
            border: 1px solid transparent;
            cursor: pointer;
            transition: transform .18s ease, box-shadow .18s ease, background .18s ease, opacity .18s ease;
            font-size: 14px;
            min-height: 48px;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn:active {
            transform: translateY(0) scale(.98);
        }

        .btn-save {
            background: linear-gradient(135deg, #f59e0b, #f97316);
            color: #07111f;
            box-shadow: 0 14px 30px rgba(245,158,11,.18);
        }

        .btn-save:hover {
            box-shadow: 0 18px 34px rgba(245,158,11,.24);
        }

        .btn-back {
            background: rgba(255,255,255,.06);
            border-color: rgba(255,255,255,.12);
            color: #eff6ff;
        }

        .btn-back:hover {
            background: rgba(255,255,255,.10);
        }

        .btn-list {
            background: rgba(79,140,255,.16);
            border-color: rgba(79,140,255,.24);
            color: #dce9ff;
        }

        .btn-list:hover {
            background: rgba(79,140,255,.22);
        }

        .notice {
            margin-top: 14px;
            color: rgba(229,238,252,.65);
            font-size: 13px;
            line-height: 1.6;
        }

        .error-box {
            padding: 22px;
            border-radius: 24px;
            background: rgba(239,68,68,.10);
            border: 1px solid rgba(239,68,68,.24);
            color: #ffd7d7;
        }

        .error-box h2 {
            margin: 0 0 8px;
            font-size: 22px;
        }

        .error-box p {
            margin: 0 0 16px;
            line-height: 1.7;
            color: rgba(255, 235, 235, .9);
        }

        footer {
            padding: 16px 32px 22px;
            border-top: 1px solid rgba(255,255,255,.08);
            color: rgba(229,238,252,.70);
            font-size: 13px;
            display: flex;
            justify-content: space-between;
            gap: 14px;
            flex-wrap: wrap;
        }

        .loader {
            position: fixed;
            inset: 0;
            display: grid;
            place-items: center;
            background: rgba(7, 17, 31, .78);
            backdrop-filter: blur(10px);
            z-index: 9999;
            opacity: 1;
            transition: opacity .35s ease;
        }

        .spinner {
            width: 54px;
            height: 54px;
            border-radius: 50%;
            border: 5px solid rgba(255,255,255,.16);
            border-top-color: #7dd3fc;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        @media (max-width: 768px) {
            .topbar, .content, footer {
                padding-left: 20px;
                padding-right: 20px;
            }

            .topbar h1 {
                font-size: 26px;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            footer {
                text-align: center;
                justify-content: center;
            }
        }

        @media (max-width: 640px) {
            .page {
                padding: 14px;
            }

            .card {
                border-radius: 22px;
            }

            .form-shell {
                padding: 18px;
            }
        }
    </style>
</head>
<body>
<div class="loader" id="loader"><div class="spinner"></div></div>

<div class="page">
    <div class="card">
        <div class="topbar">
            <h1>Edit Product</h1>
            <p>Update the product name and price, then save the changes.</p>
        </div>

        <div class="content">
            <div class="form-shell">
                <%
                    if (hasProduct) {
                %>
                    <p class="hint">
                        Edit the selected product below. The update will be saved in MySQL, so the latest data will appear for everyone after refresh.
                    </p>

                    <form action="updateProduct.do" method="post" onsubmit="showLoader()">
                        <input type="hidden" name="id" value="<%= product.getId() %>">

                        <div class="field">
                            <label for="name">Product Name</label>
                            <input
                                type="text"
                                id="name"
                                name="name"
                                value="<%= product.getName() %>"
                                maxlength="100"
                                autocomplete="off"
                                required
                            >
                        </div>

                        <div class="field">
                            <label for="price">Price</label>
                            <input
                                type="number"
                                id="price"
                                name="price"
                                value="<%= product.getPrice() %>"
                                min="0"
                                step="0.01"
                                inputmode="decimal"
                                required
                            >
                        </div>

                        <div class="actions">
                            <button class="btn btn-save" type="submit">Update Product</button>
                            <a class="btn btn-list" href="products.do">Back to List</a>
                            <a class="btn btn-back" href="index.jsp">Home</a>
                        </div>
                    </form>

                    <div class="notice">
                        Tip: use a valid numeric price. The browser will block invalid input before submitting.
                    </div>
                <%
                    } else {
                %>
                    <div class="error-box">
                        <h2>Product not found</h2>
                        <p>
                            The product you tried to edit is missing or invalid. Go back to the product list and choose a valid item.
                        </p>
                        <div class="actions">
                            <a class="btn btn-list" href="products.do">Back to List</a>
                            <a class="btn btn-back" href="index.jsp">Home</a>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>
        </div>

        <footer>
            <div>Project designed by Pratik N Chakraborty</div>
            <div>Struts Product Catalog</div>
        </footer>
    </div>
</div>

<script>
    function showLoader() {
        const loader = document.getElementById('loader');
        loader.style.display = 'grid';
        loader.style.opacity = '1';
    }

    window.addEventListener('load', function () {
        const loader = document.getElementById('loader');
        loader.style.opacity = '0';
        loader.style.pointerEvents = 'none';
        setTimeout(() => loader.remove(), 350);
    });
</script>
</body>
</html>