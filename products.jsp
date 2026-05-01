<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.project.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="theme-color" content="#07111f">
    <title>Product List</title>

    <style>
        :root{
            --bg1:#06101d;
            --bg2:#0b1530;
            --panel:rgba(10, 18, 34, 0.78);
            --panel-border:rgba(148,163,184,.16);
            --text:#edf3ff;
            --muted:#9fb0cb;
            --primary:#5b8cff;
            --primary-2:#2dd4bf;
            --danger:#ff6b6b;
            --success:#22c55e;
            --shadow:0 24px 60px rgba(0,0,0,.32);
            --radius:24px;
        }

        *{box-sizing:border-box}

        html,body{
            margin:0;
            min-height:100%;
            background:
                radial-gradient(circle at top left, rgba(91,140,255,.16), transparent 28%),
                radial-gradient(circle at bottom right, rgba(45,212,191,.12), transparent 24%),
                linear-gradient(160deg, var(--bg1), var(--bg2));
            color:var(--text);
            font-family: Arial, Helvetica, sans-serif;
            overflow-x:hidden;
        }

        .page{
            min-height:100vh;
            padding:18px;
            display:flex;
            justify-content:center;
            align-items:flex-start;
        }

        .shell{
            width:min(1180px,100%);
            background:linear-gradient(180deg, rgba(13,20,38,.92), rgba(8,15,30,.92));
            border:1px solid var(--panel-border);
            border-radius:var(--radius);
            box-shadow:var(--shadow);
            backdrop-filter:blur(18px);
            overflow:hidden;
            animation:fadeUp .35s ease;
        }

        @keyframes fadeUp{
            from{opacity:0; transform:translateY(14px)}
            to{opacity:1; transform:translateY(0)}
        }

        .topbar{
            padding:18px 20px 16px;
            background:linear-gradient(135deg, rgba(91,140,255,.18), rgba(45,212,191,.12));
            border-bottom:1px solid rgba(255,255,255,.08);
        }

        .hero{
            display:flex;
            justify-content:space-between;
            align-items:flex-end;
            gap:14px;
            flex-wrap:wrap;
        }

        .hero h1{
            margin:0;
            font-size:clamp(24px, 3vw, 36px);
            letter-spacing:-.03em;
            line-height:1.1;
        }

        .hero p{
            margin:7px 0 0;
            color:rgba(237,243,255,.72);
            font-size:14px;
            line-height:1.55;
            max-width:64ch;
        }

        .top-actions{
            display:flex;
            gap:10px;
            flex-wrap:wrap;
        }

        .btn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            min-height:42px;
            padding:10px 14px;
            border-radius:14px;
            border:1px solid transparent;
            text-decoration:none;
            font-weight:800;
            font-size:13px;
            letter-spacing:.2px;
            cursor:pointer;
            transition:transform .16s ease, box-shadow .16s ease, background .16s ease, opacity .16s ease;
            user-select:none;
            white-space:nowrap;
        }

        .btn:active{transform:scale(.98)}
        .btn:hover{transform:translateY(-1px)}

        .btn-home{
            color:#eef4ff;
            background:rgba(255,255,255,.05);
            border-color:rgba(255,255,255,.10);
        }

        .btn-home:hover{background:rgba(255,255,255,.08)}

        .btn-add{
            color:#07111f;
            background:linear-gradient(135deg, #2dd4bf, #5b8cff);
            box-shadow:0 10px 24px rgba(91,140,255,.20);
        }

        .content{
            padding:16px 18px 18px;
        }

        .toolbar{
            display:grid;
            grid-template-columns:1.45fr .85fr;
            gap:10px;
            margin-bottom:12px;
        }

        .search-box input,
        .filter-box select{
            width:100%;
            min-height:44px;
            padding:11px 14px;
            border-radius:14px;
            border:1px solid rgba(255,255,255,.10);
            background:rgba(7,16,29,.72);
            color:var(--text);
            outline:none;
            font-size:14px;
            transition:border-color .16s ease, box-shadow .16s ease, background .16s ease;
        }

        .search-box input::placeholder{color:rgba(159,176,203,.70)}
        .search-box input:focus,
        .filter-box select:focus{
            border-color:rgba(91,140,255,.70);
            box-shadow:0 0 0 4px rgba(91,140,255,.15);
            background:rgba(7,16,29,.90);
        }

        .summary{
            display:flex;
            gap:8px;
            flex-wrap:wrap;
            margin:0 0 12px;
        }

        .chip{
            display:inline-flex;
            align-items:center;
            gap:8px;
            padding:9px 12px;
            border-radius:999px;
            background:rgba(255,255,255,.05);
            border:1px solid rgba(255,255,255,.08);
            color:#eef4ff;
            font-size:12px;
            font-weight:800;
            line-height:1;
        }

        .chip span{
            color:var(--muted);
            font-weight:700;
        }

        .list-head{
            display:grid;
            grid-template-columns:72px 1.2fr 150px 240px;
            gap:10px;
            align-items:center;
            padding:10px 14px;
            margin-bottom:8px;
            color:rgba(237,243,255,.78);
            font-size:12px;
            font-weight:800;
            text-transform:uppercase;
            letter-spacing:.7px;
            border-bottom:1px solid rgba(255,255,255,.08);
        }

        .list{
            border:1px solid rgba(255,255,255,.08);
            border-radius:18px;
            overflow:hidden;
            background:rgba(255,255,255,.03);
        }

        .item{
            display:grid;
            grid-template-columns:72px 1.2fr 150px 240px;
            gap:10px;
            align-items:center;
            padding:12px 14px;
            border-top:1px solid rgba(255,255,255,.08);
            transition:background .15s ease, transform .15s ease;
        }

        .item:first-child{border-top:none}
        .item:hover{background:rgba(91,140,255,.08)}

        .id-badge{
            width:56px;
            height:36px;
            border-radius:12px;
            display:flex;
            align-items:center;
            justify-content:center;
            background:rgba(255,255,255,.05);
            border:1px solid rgba(255,255,255,.08);
            color:#fff;
            font-weight:800;
            font-size:14px;
        }

        .name{
            font-size:15px;
            font-weight:800;
            color:#fff;
            line-height:1.25;
            word-break:break-word;
        }

        .price{
            display:inline-flex;
            justify-content:flex-start;
            align-items:center;
            gap:6px;
            font-size:14px;
            font-weight:800;
            color:#edf3ff;
            white-space:nowrap;
        }

        .price .sym{
            color:rgba(237,243,255,.9);
            font-size:15px;
        }

        .actions{
            display:flex;
            justify-content:flex-end;
            gap:8px;
            flex-wrap:wrap;
        }

        .btn-edit,
        .btn-delete{
            min-height:36px;
            padding:8px 12px;
            border-radius:12px;
            font-size:12px;
        }

        .btn-edit{
            color:#dce9ff;
            background:rgba(91,140,255,.16);
            border:1px solid rgba(91,140,255,.28);
        }

        .btn-edit:hover{background:rgba(91,140,255,.22)}

        .btn-delete{
            color:#ffd9d9;
            background:rgba(239,68,68,.12);
            border:1px solid rgba(239,68,68,.24);
        }

        .btn-delete:hover{background:rgba(239,68,68,.18)}

        .empty{
            padding:24px 14px;
            text-align:center;
            color:rgba(237,243,255,.72);
        }

        .empty strong{
            display:block;
            color:#fff;
            margin-bottom:6px;
            font-size:16px;
        }

        .footer{
            padding:12px 18px 16px;
            display:flex;
            justify-content:space-between;
            gap:10px;
            flex-wrap:wrap;
            border-top:1px solid rgba(255,255,255,.08);
            color:rgba(237,243,255,.68);
            font-size:12px;
        }

        /* modal */
        .modal-overlay{
            position:fixed;
            inset:0;
            display:flex;
            align-items:center;
            justify-content:center;
            padding:16px;
            background:rgba(2,6,23,.68);
            backdrop-filter:blur(10px);
            z-index:10000;
            opacity:0;
            visibility:hidden;
            pointer-events:none;
            transition:opacity .22s ease, visibility .22s ease;
        }

        .modal-overlay.show{
            opacity:1;
            visibility:visible;
            pointer-events:auto;
        }

        .modal{
            width:min(420px,100%);
            border-radius:22px;
            background:linear-gradient(180deg, rgba(17,24,39,.97), rgba(15,23,42,.97));
            border:1px solid rgba(255,255,255,.10);
            box-shadow:0 24px 70px rgba(0,0,0,.45);
            transform:translateY(18px) scale(.95);
            opacity:0;
            transition:transform .25s ease, opacity .25s ease;
            overflow:hidden;
        }

        .modal-overlay.show .modal{
            transform:translateY(0) scale(1);
            opacity:1;
        }

        .modal-overlay.closing{
            opacity:0;
        }

        .modal-overlay.closing .modal{
            transform:translateY(14px) scale(.95);
            opacity:0;
        }

        .modal-top{
            padding:18px 18px 10px;
            display:flex;
            align-items:center;
            gap:12px;
        }

        .warn{
            width:42px;
            height:42px;
            border-radius:14px;
            display:grid;
            place-items:center;
            background:rgba(239,68,68,.14);
            border:1px solid rgba(239,68,68,.24);
            color:#fecaca;
            font-size:20px;
            flex:0 0 auto;
        }

        .modal-top h3{
            margin:0;
            font-size:18px;
        }

        .modal-body{
            padding:0 18px 18px;
            color:rgba(237,243,255,.78);
            line-height:1.6;
            font-size:14px;
        }

        .modal-actions{
            display:flex;
            gap:10px;
            justify-content:flex-end;
            padding:0 18px 18px;
            flex-wrap:wrap;
        }

        .modal-btn{
            border:none;
            border-radius:12px;
            padding:10px 14px;
            font-weight:800;
            cursor:pointer;
            text-decoration:none;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            transition:transform .15s ease, opacity .15s ease;
        }

        .modal-btn:hover{transform:translateY(-1px)}
        .modal-cancel{background:rgba(255,255,255,.08); color:#eff6ff}
        .modal-confirm{background:linear-gradient(135deg,#ef4444,#f97316); color:#fff}

        /* toast */
        .toast{
            position:fixed;
            bottom:16px;
            right:16px;
            min-width:220px;
            max-width:min(92vw,360px);
            padding:12px 14px;
            border-radius:14px;
            background:rgba(15,23,42,.96);
            border:1px solid rgba(255,255,255,.10);
            box-shadow:0 16px 42px rgba(0,0,0,.30);
            color:#fff;
            opacity:0;
            transform:translateY(14px);
            pointer-events:none;
            transition:opacity .2s ease, transform .2s ease;
            z-index:12000;
        }

        .toast.show{opacity:1; transform:translateY(0)}
        .toast.success{border-color:rgba(34,197,94,.30)}
        .toast.error{border-color:rgba(239,68,68,.30)}
        .toast .t1{display:block; font-size:13px; font-weight:800; margin-bottom:3px}
        .toast .t2{display:block; font-size:12px; color:rgba(237,243,255,.75); line-height:1.45}

        .loader{
            position:fixed;
            inset:0;
            display:grid;
            place-items:center;
            background:rgba(7,16,29,.78);
            backdrop-filter:blur(10px);
            z-index:9999;
        }

        .spinner{
            width:52px;
            height:52px;
            border-radius:50%;
            border:5px solid rgba(255,255,255,.16);
            border-top-color:#7dd3fc;
            animation:spin 1s linear infinite;
        }

        @keyframes spin { to { transform:rotate(360deg) } }

        @media (max-width: 900px){
            .page{padding:14px}
            .hero{align-items:flex-start}
            .toolbar{grid-template-columns:1fr}
            .list-head, .item{
                grid-template-columns:62px 1fr 128px 188px;
            }
            .name{font-size:14px}
        }

        @media (max-width: 640px){
            .page{padding:10px}
            .shell{border-radius:20px}
            .topbar{padding:16px 16px 14px}
            .content{padding:14px 14px 16px}
            .hero h1{font-size:22px}
            .hero p{font-size:13px; margin-top:5px}
            .top-actions{width:100%}
            .top-actions .btn{flex:1 1 0; padding:10px 12px; font-size:12px}
            .summary{display:none}
            .list-head{
                display:grid;
                grid-template-columns:54px 1fr 98px 112px;
                padding:8px 10px;
                font-size:11px;
                letter-spacing:.5px;
            }
            .item{
                grid-template-columns:54px 1fr 98px 112px;
                padding:10px 10px;
                gap:8px;
            }
            .id-badge{width:46px; height:32px; border-radius:10px; font-size:12px}
            .price{font-size:13px}
            .btn-edit,.btn-delete{padding:7px 9px; min-height:32px; font-size:11px; border-radius:10px}
            .actions{justify-content:flex-end; gap:6px}
            .footer{padding:10px 14px 14px; justify-content:center; text-align:center}
            .toast{left:10px; right:10px; bottom:10px; min-width:0}
        }

        @media (max-width: 420px){
            .list-head, .item{
                grid-template-columns:46px 1fr 86px 92px;
                gap:6px;
            }
            .hero h1{font-size:21px}
            .hero p{font-size:12px}
            .btn{min-height:40px}
            .top-actions .btn{font-size:11px}
            .name{font-size:13px}
            .price{font-size:12px}
        }
    </style>
</head>
<body>
<div class="loader" id="loader"><div class="spinner"></div></div>

<div class="page">
    <div class="shell">
        <div class="topbar">
            <div class="hero">
                <div>
                    <h1>Product List</h1>
                    <p>Manage products in this Centralized Dashboard</p>
                </div>
                <div class="top-actions">
                    <a class="btn btn-home" href="index.jsp">Home</a>
                    <a class="btn btn-add" href="addProduct.jsp">Add Product</a>
                </div>
            </div>
        </div>

        <div class="content">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search product..." onkeyup="filterProducts()">
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

            <div class="summary">
                <div class="chip">Total <span id="totalCount">0</span></div>
                <div class="chip">Visible <span id="visibleCount">0</span></div>
                <div class="chip">Highest <span id="highestPrice">₹ 0</span></div>
                <div class="chip">Lowest <span id="lowestPrice">₹ 0</span></div>
            </div>

            <div class="list-head">
                <div>ID</div>
                <div>Product</div>
                <div>Price</div>
                <div style="text-align:right;">Actions</div>
            </div>

            <div class="list" id="productList">
                <div id="productTableBody">
                <%
                    ArrayList<Product> list = (ArrayList<Product>) request.getAttribute("products");
                    if (list != null && !list.isEmpty()) {
                        for (Product p : list) {
                %>
                    <div class="item" id="row-<%= p.getId() %>"
                         data-name="<%= p.getName().toLowerCase() %>"
                         data-price="<%= p.getPrice() %>">
                        <div class="id-badge" data-label="ID"><%= p.getId() %></div>
                        <div class="name" data-label="Product"><%= p.getName() %></div>
                        <div class="price" data-label="Price"><span class="sym">₹</span><span><%= p.getPrice() %></span></div>
                        <div class="actions" data-label="Actions">
                            <a class="btn btn-edit" href="editProduct.do?id=<%= p.getId() %>">Edit</a>
                            <a class="btn btn-delete" href="#" onclick="openDeleteModal('<%= p.getId() %>'); return false;">Delete</a>
                        </div>
                    </div>
                <%
                        }
                    } else {
                %>
                    <div id="emptyRow" class="empty">
                        <strong>No products available</strong>
                        Start by adding your first product.
                    </div>
                <%
                    }
                %>
                </div>
            </div>
        </div>

        <div class="footer">
            <div>Project designed by Pratik N Chakraborty</div>
            <div>Struts Product Catalog</div>
        </div>
    </div>
</div>

<div class="modal-overlay" id="deleteModal" aria-hidden="true">
    <div class="modal" role="dialog" aria-modal="true" aria-labelledby="deleteTitle">
        <div class="modal-top">
            <div class="warn">!</div>
            <div><h3 id="deleteTitle">Delete product?</h3></div>
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
    <span class="t1" id="toastTitle">Status</span>
    <span class="t2" id="toastText"></span>
</div>

<script>
    const deleteModal = document.getElementById('deleteModal');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    const toast = document.getElementById('toast');
    const toastTitle = document.getElementById('toastTitle');
    const toastText = document.getElementById('toastText');

    let toastTimer = null;

    function showToast(title, message, type) {
        toast.className = 'toast ' + (type || 'success');
        toastTitle.textContent = title;
        toastText.textContent = message || '';
        toast.classList.add('show');

        clearTimeout(toastTimer);
        toastTimer = setTimeout(() => toast.classList.remove('show'), 2400);
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
        setTimeout(() => deleteModal.classList.remove('show', 'closing'), 250);
    }

    async function deleteProduct(id) {
        try {
            const response = await fetch('deleteProduct.do?id=' + encodeURIComponent(id), {
                method: 'GET',
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            });

            if (!response.ok) throw new Error('Delete failed');

            const row = document.getElementById('row-' + id);
            if (row) {
                row.style.transition = 'opacity .22s ease, transform .22s ease';
                row.style.opacity = '0';
                row.style.transform = 'translateY(6px)';
                setTimeout(() => row.remove(), 220);
            }

            showToast('Deleted', 'Product removed successfully.', 'success');
            closeDeleteModal();
            updateStats();
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
        if (id) deleteProduct(id);
    });

    deleteModal.addEventListener('click', function (e) {
        if (e.target === deleteModal) closeDeleteModal();
    });

    window.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && deleteModal.classList.contains('show')) closeDeleteModal();
    });

    function filterProducts() {
        const query = document.getElementById('searchInput').value.toLowerCase().trim();
        const items = Array.from(document.querySelectorAll('#productTableBody .item'));
        let visible = 0;

        items.forEach(item => {
            const name = (item.dataset.name || '').toLowerCase();
            const match = name.includes(query);
            item.style.display = match ? '' : 'none';
            if (match) visible++;
        });

        const emptyRow = document.getElementById('emptyRow');
        if (emptyRow) emptyRow.style.display = visible === 0 ? '' : 'none';

        document.getElementById('visibleCount').textContent = visible;
    }

    function sortProducts() {
        const value = document.getElementById('sortSelect').value;
        const container = document.getElementById('productTableBody');
        const items = Array.from(container.querySelectorAll('.item'));

        const byName = (a, b, asc) => {
            const av = (a.dataset.name || '').toLowerCase();
            const bv = (b.dataset.name || '').toLowerCase();
            return asc ? av.localeCompare(bv) : bv.localeCompare(av);
        };

        const byPrice = (a, b, asc) => {
            const av = parseFloat(a.dataset.price || '0');
            const bv = parseFloat(b.dataset.price || '0');
            return asc ? av - bv : bv - av;
        };

        if (value === 'name-asc') items.sort((a,b) => byName(a,b,true));
        if (value === 'name-desc') items.sort((a,b) => byName(a,b,false));
        if (value === 'price-asc') items.sort((a,b) => byPrice(a,b,true));
        if (value === 'price-desc') items.sort((a,b) => byPrice(a,b,false));

        items.forEach(item => container.appendChild(item));
        filterProducts();
    }

    function updateStats() {
        const allItems = Array.from(document.querySelectorAll('#productTableBody .item'));
        const visibleItems = allItems.filter(item => item.style.display !== 'none');
        const prices = allItems.map(item => parseFloat(item.dataset.price || '0')).filter(n => !isNaN(n));

        document.getElementById('totalCount').textContent = allItems.length;
        document.getElementById('visibleCount').textContent = visibleItems.length;
        document.getElementById('highestPrice').textContent = '₹ ' + (prices.length ? Math.max(...prices).toFixed(2) : '0.00');
        document.getElementById('lowestPrice').textContent = '₹ ' + (prices.length ? Math.min(...prices).toFixed(2) : '0.00');
    }

    function checkEmptyState() {
        const items = Array.from(document.querySelectorAll('#productTableBody .item'));
        const visibleItems = items.filter(item => item.style.display !== 'none');
        const emptyRow = document.getElementById('emptyRow');

        if (visibleItems.length === 0) {
            if (emptyRow) emptyRow.style.display = '';
        } else if (emptyRow) {
            emptyRow.style.display = 'none';
        }
    }

    window.addEventListener('load', function () {
        const loader = document.getElementById('loader');
        loader.style.opacity = '0';
        loader.style.pointerEvents = 'none';
        loader.style.transition = 'opacity .3s ease';
        setTimeout(() => loader.remove(), 300);

        updateStats();
        filterProducts();
    });
</script>
</body>
</html>
