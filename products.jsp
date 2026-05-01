<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.project.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#0f172a">
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
            min-height: 46px;
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

        .toolbar {
            display: grid;
            grid-template-columns: 1.5fr .8fr;
            gap: 14px;
            margin-bottom: 18px;
        }

        .search-box input,
        .filter-box select {
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

        .search-box input::placeholder {
            color: rgba(159,176,203,.70);
        }

        .search-box input:focus,
        .filter-box select:focus {
            border-color: rgba(125,211,252,.8);
            box-shadow: 0 0 0 4px rgba(79,140,255,.16);
            background: rgba(7,17,31,.88);
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
            margin-bottom: 18px;
        }

        .stat-card {
            padding: 16px 18px;
            border-radius: 20px;
            background: rgba(255,255,255,.05);
            border: 1px solid rgba(255,255,255,.08);
        }

        .stat-label {
            display: block;
            color: var(--muted);
            font-size: 13px;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 20px;
            font-weight: 800;
            color: #fff;
        }

        .table-shell {
            overflow-x: auto;
            border-radius: 24px;
            border: 1px solid rgba(255,255,255,.10);
            background: rgba(255,255,255,.04);
            animation: fadeIn .35s ease;
            -webkit-overflow-scrolling: touch;
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

        .toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            min-width: 240px;
            max-width: min(92vw, 420px);
            padding: 14px 16px;
            border-radius: 16px;
            background: rgba(15, 23, 42, .96);
            border: 1px solid rgba(255,255,255,.10);
            color: #fff;
            box-shadow: 0 18px 50px rgba(0,0,0,.35);
            opacity: 0;
            transform: translateY(16px);
            pointer-events: none;
            transition: opacity .24s ease, transform .24s ease;
            z-index: 12000;
        }

        .toast.show {
            opacity: 1;
            transform: translateY(0);
        }

        .toast.success {
            border-color: rgba(34,197,94,.35);
        }

        .toast.error {
            border-color: rgba(239,68,68,.35);
        }

        .toast .toast-title {
            display: block;
            font-size: 14px;
            font-weight: 800;
            margin-bottom: 4px;
        }

        .toast .toast-text {
            display: block;
            font-size: 13px;
            color: rgba(229,238,252,.78);
            line-height: 1.5;
        }

        @media (max-width: 1024px) {
            .stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .toolbar {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .topbar {
                padding: 18px 18px 16px;
            }

            .content {
                padding: 16px;
            }

            .bottom-bar {
                padding: 14px 16px 18px;
            }

            .title h1 {
                font-size: 24px;
            }

            .title p {
                font-size: 13px;
                margin-top: 6px;
            }

            .actions-top {
                width: 100%;
            }

            .actions-top .btn {
                flex: 1 1 0;
                padding: 11px 14px;
            }

            .toolbar {
                gap: 10px;
                margin-bottom: 14px;
            }

            .search-box input,
            .filter-box select {
                padding: 12px 14px;
                font-size: 14px;
            }

            .stats {
                grid-template-columns: 1fr;
                gap: 10px;
                margin-bottom: 14px;
            }

            .stat-card {
                padding: 13px 14px;
                border-radius: 18px;
            }

            .stat-value {
                font-size: 18px;
            }

            .table-shell {
                border-radius: 20px;
            }

            .footer-card {
                text-align: center;
                justify-content: center;
            }

            .toast {
                left: 14px;
                right: 14px;
                bottom: 14px;
                min-width: 0;
            }
        }

        @media (max-width: 640px) {
            .page {
                padding: 12px;
            }

            .card {
                border-radius: 22px;
            }

            .topbar {
                gap: 12px;
            }

            .title {
                width: 100%;
            }

            .actions-top {
                gap: 8px;
            }

            .actions-top .btn {
                font-size: 13px;
            }

            .stats {
                display: none;
            }

            .table-shell {
                background: transparent;
                border: none;
                overflow: visible;
            }

            table {
                min-width: 0;
                width: 100%;
                border-collapse: separate;
                border-spacing: 0 12px;
            }

            thead {
                display: none;
            }

            tbody {
                display: block;
            }

            tbody tr {
                display: block;
                background: rgba(255,255,255,.05);
                border: 1px solid rgba(255,255,255,.08);
                border-radius: 18px;
                padding: 12px 12px 6px;
                margin-bottom: 12px;
                box-shadow: 0 10px 22px rgba(0,0,0,.18);
            }

            tbody tr:hover td {
                background: transparent;
            }

            tbody tr:nth-child(even) td {
                background: transparent;
            }

            td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 12px;
                border: none;
                border-top: 1px solid rgba(255,255,255,.08);
                padding: 12px 0;
                text-align: left;
                font-size: 14px;
                line-height: 1.45;
            }

            td:first-child {
                border-top: none;
                padding-top: 0;
            }

            td::before {
                content: attr(data-label);
                color: rgba(159,176,203,.92);
                font-size: 12px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: .5px;
                flex: 0 0 auto;
                margin-right: 10px;
            }

            td.actions-cell {
                display: block;
                padding-bottom: 2px;
            }

            td.actions-cell::before {
                display: block;
                margin: 0 0 10px;
            }

            .row-actions {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 10px;
                width: 100%;
            }

            .row-actions .btn {
                width: 100%;
                padding: 12px 10px;
            }

            .empty {
                display: block;
                text-align: center;
                padding: 20px 10px;
            }

            .empty strong {
                margin-bottom: 6px;
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
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search by product name..." onkeyup="filterProducts()">
                </div>
                <div class="filter-box">
                    <select id="sortSelect" onchange="sortProducts()">
                        <option value="default">Sort</option>
                        <option value="name-asc">Name A → Z</option>
                        <option value="name-desc">Name Z → A</option>
                        <option value="price-asc">Price Low → High</option>
                        <option value="price-desc">Price High → Low</option>
                    </select>
                </div>
            </div>

            <div class="stats">
                <div class="stat-card">
                    <span class="stat-label">Total Products</span>
                    <span class="stat-value" id="totalCount">0</span>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Visible Products</span>
                    <span class="stat-value" id="visibleCount">0</span>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Highest Price</span>
                    <span class="stat-value" id="highestPrice">₹ 0</span>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Lowest Price</span>
                    <span class="stat-value" id="lowestPrice">₹ 0</span>
                </div>
            </div>

            <div class="table-shell">
                <table id="productTable">
                    <thead>
                        <tr>
                            <th style="width: 12%;">ID</th>
                            <th style="width: 38%;">Name</th>
                            <th style="width: 20%;">Price</th>
                            <th style="width: 30%;">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="productTableBody">
                    <%
                        ArrayList<Product> list = (ArrayList<Product>) request.getAttribute("products");
                        if (list != null && !list.isEmpty()) {
                            for (Product p : list) {
                    %>
                        <tr id="row-<%= p.getId() %>"
                            data-name="<%= p.getName().toLowerCase() %>"
                            data-price="<%= p.getPrice() %>">
                            <td data-label="ID"><%= p.getId() %></td>
                            <td data-label="Name" class="product-name"><%= p.getName() %></td>
                            <td data-label="Price" class="product-price">&#8377; <%= p.getPrice() %></td>
                            <td data-label="Actions" class="actions-cell">
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
                        <tr id="emptyRow">
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

<div id="toast" class="toast" aria-live="polite" aria-atomic="true">
    <span class="toast-title" id="toastTitle">Status</span>
    <span class="toast-text" id="toastText"></span>
</div>

<script>
    const deleteModal = document.getElementById('deleteModal');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    const toast = document.getElementById('toast');
    const toastTitle = document.getElementById('toastTitle');
    const toastText = document.getElementById('toastText');

    let toastTimer = null;
    let currentSort = 'default';

    function showToast(title, message, type) {
        toast.className = 'toast ' + (type || 'success');
        toastTitle.textContent = title;
        toastText.textContent = message || '';
        toast.classList.add('show');

        clearTimeout(toastTimer);
        toastTimer = setTimeout(() => {
            toast.classList.remove('show');
        }, 2600);
    }

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

    async function deleteProduct(id) {
        try {
            const response = await fetch('deleteProduct.do?id=' + encodeURIComponent(id), {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            });

            if (!response.ok) {
                throw new Error('Delete failed');
            }

            const row = document.getElementById('row-' + id);
            if (row) {
                row.style.transition = 'opacity .25s ease, transform .25s ease';
                row.style.opacity = '0';
                row.style.transform = 'translateY(8px)';
                setTimeout(() => row.remove(), 260);
            }

            showToast('Deleted', 'Product removed successfully.', 'success');
            updateStats();
            closeDeleteModal();
            checkEmptyState();
        } catch (e) {
            showToast('Error', 'Could not delete the product.', 'error');
        }
    }

    confirmDeleteBtn.addEventListener('click', function (e) {
        e.preventDefault();
        const href = confirmDeleteBtn.getAttribute('href');
        const idMatch = href.match(/id=([^&]+)/);
        const id = idMatch ? decodeURIComponent(idMatch[1]) : null;
        if (id) {
            deleteProduct(id);
        }
    });

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

    function filterProducts() {
        const query = document.getElementById('searchInput').value.toLowerCase().trim();
        const rows = Array.from(document.querySelectorAll('#productTableBody tr'))
            .filter(r => r.id !== 'emptyRow');

        let visible = 0;

        rows.forEach(row => {
            const name = (row.dataset.name || '').toLowerCase();
            const match = name.includes(query);
            row.style.display = match ? '' : 'none';
            if (match) visible++;
        });

        const emptyRow = document.getElementById('emptyRow');
        if (emptyRow) {
            emptyRow.style.display = visible === 0 ? '' : 'none';
        }

        document.getElementById('visibleCount').textContent = visible;
    }

    function sortProducts() {
        currentSort = document.getElementById('sortSelect').value;

        const tbody = document.getElementById('productTableBody');
        const rows = Array.from(tbody.querySelectorAll('tr')).filter(r => r.id !== 'emptyRow');

        const compareByName = (a, b, asc) => {
            const av = (a.dataset.name || '').toLowerCase();
            const bv = (b.dataset.name || '').toLowerCase();
            return asc ? av.localeCompare(bv) : bv.localeCompare(av);
        };

        const compareByPrice = (a, b, asc) => {
            const av = parseFloat(a.dataset.price || '0');
            const bv = parseFloat(b.dataset.price || '0');
            return asc ? av - bv : bv - av;
        };

        if (currentSort === 'name-asc') rows.sort((a, b) => compareByName(a, b, true));
        if (currentSort === 'name-desc') rows.sort((a, b) => compareByName(a, b, false));
        if (currentSort === 'price-asc') rows.sort((a, b) => compareByPrice(a, b, true));
        if (currentSort === 'price-desc') rows.sort((a, b) => compareByPrice(a, b, false));

        rows.forEach(row => tbody.appendChild(row));
        filterProducts();
    }

    function updateStats() {
        const allRows = Array.from(document.querySelectorAll('#productTableBody tr'))
            .filter(r => r.id !== 'emptyRow' && r.style.display !== 'none');

        const allVisibleRows = Array.from(document.querySelectorAll('#productTableBody tr'))
            .filter(r => r.id !== 'emptyRow');

        const visibleCount = allRows.length;
        const totalCount = allVisibleRows.length;

        const prices = allVisibleRows
            .map(r => parseFloat(r.dataset.price || '0'))
            .filter(n => !isNaN(n));

        const highest = prices.length ? Math.max(...prices) : 0;
        const lowest = prices.length ? Math.min(...prices) : 0;

        document.getElementById('totalCount').textContent = totalCount;
        document.getElementById('visibleCount').textContent = visibleCount;
        document.getElementById('highestPrice').textContent = '₹ ' + highest.toFixed(2);
        document.getElementById('lowestPrice').textContent = '₹ ' + lowest.toFixed(2);
    }

    function checkEmptyState() {
        const rows = Array.from(document.querySelectorAll('#productTableBody tr'))
            .filter(r => r.id !== 'emptyRow' && r.style.display !== 'none');

        let emptyRow = document.getElementById('emptyRow');

        if (rows.length === 0) {
            if (!emptyRow) {
                const tbody = document.getElementById('productTableBody');
                emptyRow = document.createElement('tr');
                emptyRow.id = 'emptyRow';
                emptyRow.innerHTML = `
                    <td colspan="4" class="empty">
                        <strong>No products available</strong>
                        Start by adding your first product.
                    </td>
                `;
                tbody.appendChild(emptyRow);
            } else {
                emptyRow.style.display = '';
            }
        } else if (emptyRow) {
            emptyRow.style.display = 'none';
        }
    }

    window.addEventListener('load', function () {
        const loader = document.getElementById('loader');
        loader.style.opacity = '0';
        loader.style.pointerEvents = 'none';
        loader.style.transition = 'opacity .35s ease';
        setTimeout(() => loader.remove(), 350);

        updateStats();
        filterProducts();
    });
</script>
</body>
</html>