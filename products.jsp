<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.project.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>

    <style>
        :root{
            --bg1:#07111f;
            --bg2:#0f172a;
            --card:rgba(15, 23, 42, 0.72);
            --card-border:rgba(148, 163, 184, 0.18);
            --text:#e5eefc;
            --muted:#9fb0cb;
            --primary:#4f8cff;
            --primary-2:#2dd4bf;
            --success:#22c55e;
            --danger:#ef4444;
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
                radial-gradient(circle at top left, rgba(79,140,255,.20), transparent 28%),
                radial-gradient(circle at bottom right, rgba(45,212,191,.14), transparent 25%),
                linear-gradient(160deg, var(--bg1), var(--bg2));
        }

        .page {
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 28px;
        }

        .card {
            width: min(1280px, 100%);
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
            padding: 26px 30px;
            background: linear-gradient(135deg, rgba(79,140,255,.28), rgba(45,212,191,.18));
            border-bottom: 1px solid rgba(255,255,255,.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .title h1 {
            margin: 0;
            font-size: clamp(28px, 3vw, 42px);
            letter-spacing: -.03em;
        }

        .title p {
            margin: 8px 0 0;
            color: rgba(229,238,252,.78);
            line-height: 1.7;
        }

        .actions-top {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 18px;
            border-radius: 16px;
            text-decoration: none;
            font-weight: 800;
            letter-spacing: .2px;
            border: 1px solid transparent;
            transition: transform .18s ease, box-shadow .18s ease, background .18s ease, opacity .18s ease;
            cursor: pointer;
            font-size: 14px;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn:active {
            transform: translateY(0) scale(.98);
        }

        .btn-home {
            background: rgba(255,255,255,.06);
            border-color: rgba(255,255,255,.12);
            color: #eff6ff;
        }

        .btn-home:hover {
            background: rgba(255,255,255,.10);
        }

        .btn-add {
            background: linear-gradient(135deg, #22c55e, #2dd4bf);
            color: #07111f;
            box-shadow: 0 14px 30px rgba(34,197,94,.18);
        }

        .btn-add:hover {
            box-shadow: 0 18px 34px rgba(34,197,94,.24);
        }

        .content {
            padding: 28px;
        }

        .table-shell {
            overflow-x: auto;
            border-radius: 24px;
            border: 1px solid rgba(255,255,255,.10);
            background: rgba(255,255,255,.04);
            animation: fadeIn .35s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        th, td {
            padding: 16px 18px;
            text-align: center;
        }

        th {
            background: rgba(79,140,255,.16);
            color: #f8fbff;
            font-size: 14px;
            letter-spacing: .35px;
            text-transform: uppercase;
            border-bottom: 1px solid rgba(255,255,255,.10);
        }

        td {
            border-top: 1px solid rgba(255,255,255,.08);
            color: #e9f1ff;
            font-size: 15px;
        }

        tbody tr {
            transition: background .2s ease, transform .2s ease;
        }

        tbody tr:nth-child(even) td {
            background: rgba(255,255,255,.03);
        }

        tbody tr:hover td {
            background: rgba(79,140,255,.10);
        }

        .row-actions {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-edit, .btn-delete {
            padding: 10px 14px;
            border-radius: 14px;
            font-size: 13px;
        }

        .btn-edit {
            background: rgba(79,140,255,.16);
            color: #dce9ff;
            border: 1px solid rgba(79,140,255,.28);
        }

        .btn-edit:hover {
            background: rgba(79,140,255,.22);
        }

        .btn-delete {
            background: rgba(239,68,68,.14);
            color: #ffd7d7;
            border: 1px solid rgba(239,68,68,.25);
        }

        .btn-delete:hover {
            background: rgba(239,68,68,.20);
        }

        .empty {
            padding: 30px;
            color: rgba(229,238,252,.72);
            text-align: center;
        }

        .empty strong {
            display: block;
            margin-bottom: 8px;
            color: #fff;
            font-size: 18px;
        }

        .bottom-bar {
            display: flex;
            justify-content: center;
            padding: 20px 28px 28px;
        }

        .footer-card {
            width: 100%;
            display: flex;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
            color: rgba(229,238,252,.72);
            font-size: 13px;
            padding-top: 18px;
            border-top: 1px solid rgba(255,255,255,.08);
        }

        .loader {
            position: fixed;
            inset: 0;
            display: grid;
            place-items: center;
            background: rgba(7, 17, 31, .78);
            backdrop-filter: blur(10px);
            z-index: 9999;
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

        .modal-overlay {
            position: fixed;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background: rgba(2, 6, 23, .66);
            backdrop-filter: blur(10px);
            z-index: 10000;

            opacity: 0;
            visibility: hidden;
            pointer-events: none;
            transition: opacity .28s ease, visibility .28s ease;
        }

        .modal-overlay.show {
            opacity: 1;
            visibility: visible;
            pointer-events: auto;
        }

        .modal {
            width: min(460px, 100%);
            border-radius: 24px;
            background: linear-gradient(180deg, rgba(17,24,39,.96), rgba(15,23,42,.96));
            border: 1px solid rgba(255,255,255,.10);
            box-shadow: 0 30px 80px rgba(0,0,0,.45);

            transform: translateY(28px) scale(.92);
            opacity: 0;
            transition: transform .30s cubic-bezier(.2,.8,.2,1), opacity .30s ease;
            overflow: hidden;
        }

        .modal-overlay.show .modal {
            transform: translateY(0) scale(1);
            opacity: 1;
        }

        .modal-overlay.closing {
            opacity: 0;
        }

        .modal-overlay.closing .modal {
            transform: translateY(18px) scale(.92);
            opacity: 0;
        }

        .modal-head {
            padding: 22px 22px 12px;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .warn-icon {
            width: 48px;
            height: 48px;
            border-radius: 16px;
            display: grid;
            place-items: center;
            background: rgba(239,68,68,.14);
            border: 1px solid rgba(239,68,68,.22);
            color: #fecaca;
            font-size: 22px;
            flex: 0 0 auto;
        }

        .modal-head h3 {
            margin: 0;
            font-size: 20px;
        }

        .modal-body {
            padding: 0 22px 22px;
            color: rgba(229,238,252,.78);
            line-height: 1.7;
        }

        .modal-actions {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            padding: 0 22px 22px;
            flex-wrap: wrap;
        }

        .modal-btn {
            border: none;
            border-radius: 14px;
            padding: 12px 16px;
            font-weight: 800;
            cursor: pointer;
            transition: transform .18s ease, opacity .18s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .modal-btn:hover {
            transform: translateY(-1px);
        }

        .modal-cancel {
            background: rgba(255,255,255,.08);
            color: #eff6ff;
        }

        .modal-confirm {
            background: linear-gradient(135deg, #ef4444, #f97316);
            color: #fff;
        }

        @media (max-width: 768px) {
            .topbar {
                padding: 20px;
            }

            .content {
                padding: 20px;
            }

            .bottom-bar {
                padding: 16px 20px 20px;
            }

            .title h1 {
                font-size: 26px;
            }

            .title p {
                font-size: 14px;
            }

            .actions-top {
                width: 100%;
            }

            .actions-top .btn {
                flex: 1 1 0;
            }

            .row-actions {
                flex-direction: column;
                width: 100%;
            }

            .row-actions .btn {
                width: 100%;
            }

            .footer-card {
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

            th, td {
                padding: 14px 12px;
            }
        }
    </style>
</head>
<body>
<div class="loader" id="loader"><div class="spinner"></div></div>

<div class="page">
    <div class="card">
        <div class="topbar">
            <div class="title">
                <h1>Product List</h1>
                <p>Manage your product catalog with a clean and smooth interface.</p>
            </div>
            <div class="actions-top">
                <a class="btn btn-home" href="index.jsp">Home</a>
                <a class="btn btn-add" href="addProduct.jsp">Add Product</a>
            </div>
        </div>

        <div class="content">
            <div class="table-shell">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 12%;">ID</th>
                            <th style="width: 38%;">Name</th>
                            <th style="width: 20%;">Price</th>
                            <th style="width: 30%;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        ArrayList<Product> list = (ArrayList<Product>) request.getAttribute("products");
                        if (list != null && !list.isEmpty()) {
                            for (Product p : list) {
                    %>
                        <tr id="row-<%= p.getId() %>">
                            <td><%= p.getId() %></td>
                            <td><%= p.getName() %></td>
                            <td>&#8377; <%= p.getPrice() %></td>
                            <td>
                                <div class="row-actions">
                                    <a class="btn btn-edit" href="editProduct.do?id=<%= p.getId() %>">Edit</a>
                                    <a class="btn btn-delete" href="#" onclick="openDeleteModal('<%= p.getId() %>'); return false;">Delete</a>
                                </div>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="4" class="empty">
                                <strong>No products available</strong>
                                Start by adding your first product.
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="bottom-bar">
            <div class="footer-card">
                <div>Project designed by Pratik N Chakraborty</div>
                <div>Struts Product Catalog</div>
            </div>
        </div>
    </div>
</div>

<div class="modal-overlay" id="deleteModal" aria-hidden="true">
    <div class="modal" role="dialog" aria-modal="true" aria-labelledby="deleteTitle">
        <div class="modal-head">
            <div class="warn-icon">!</div>
            <div>
                <h3 id="deleteTitle">Delete product?</h3>
            </div>
        </div>
        <div class="modal-body">
            This action will remove the selected product from the catalog.
            The change will be applied immediately.
        </div>
        <div class="modal-actions">
            <button class="modal-btn modal-cancel" type="button" onclick="closeDeleteModal()">Cancel</button>
            <a class="modal-btn modal-confirm" id="confirmDeleteBtn" href="#">Delete</a>
        </div>
    </div>
</div>

<script>
    const deleteModal = document.getElementById('deleteModal');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

    function openDeleteModal(id) {
        confirmDeleteBtn.href = 'deleteProduct.do?id=' + encodeURIComponent(id);
        deleteModal.classList.remove('closing');
        deleteModal.classList.add('show');
        deleteModal.setAttribute('aria-hidden', 'false');
    }

    function closeDeleteModal() {
        deleteModal.classList.add('closing');
        deleteModal.setAttribute('aria-hidden', 'true');
        setTimeout(() => {
            deleteModal.classList.remove('show', 'closing');
        }, 300);
    }

    deleteModal.addEventListener('click', function (e) {
        if (e.target === deleteModal) {
            closeDeleteModal();
        }
    });

    window.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && deleteModal.classList.contains('show')) {
            closeDeleteModal();
        }
    });

    window.addEventListener('load', function () {
        const loader = document.getElementById('loader');
        loader.style.opacity = '0';
        loader.style.pointerEvents = 'none';
        loader.style.transition = 'opacity .35s ease';
        setTimeout(() => loader.remove(), 350);
    });
</script>
</body>
</html>