<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
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
            --danger:#f97316;
            --shadow:0 24px 60px rgba(0,0,0,.32);
            --radius:28px;
        }

        * { box-sizing: border-box; }

        html, body {
            margin: 0;
            min-height: 100%;
        }

        body {
            font-family: Inter, Arial, Helvetica, sans-serif;
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
            width: min(820px, 100%);
            background: var(--card);
            border: 1px solid var(--card-border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            backdrop-filter: blur(18px);
            overflow: hidden;
        }

        .topbar {
            padding: 28px 32px;
            background: linear-gradient(135deg, rgba(79,140,255,.26), rgba(45,212,191,.18));
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
            transition: border-color .18s ease, box-shadow .18s ease, transform .18s ease;
        }

        input::placeholder {
            color: rgba(159,176,203,.70);
        }

        input:focus {
            border-color: rgba(125,211,252,.8);
            box-shadow: 0 0 0 4px rgba(79,140,255,.16);
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
            transition: transform .18s ease, box-shadow .18s ease, background .18s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-save {
            background: linear-gradient(135deg, #22c55e, #2dd4bf);
            color: #07111f;
            box-shadow: 0 14px 30px rgba(34,197,94,.18);
        }

        .btn-back {
            background: rgba(255,255,255,.06);
            border-color: rgba(255,255,255,.12);
            color: #eff6ff;
        }

        .btn-back:hover {
            background: rgba(255,255,255,.10);
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
        }

        .spinner {
            width: 54px;
            height: 54px;
            border-radius: 50%;
            border: 5px solid rgba(255,255,255,.16);
            border-top-color: #7dd3fc;
            animation: spin 1s linear infinite;
        }

        @keyframes spin { to { transform: rotate(360deg); } }

        @media (max-width: 640px) {
            .topbar, .content, footer {
                padding-left: 20px;
                padding-right: 20px;
            }
        }
    </style>
</head>
<body>
<div class="loader" id="loader"><div class="spinner"></div></div>

<div class="page">
    <div class="card">
        <div class="topbar">
            <h1>Add Product</h1>
            <p>Enter a new product and keep the catalog growing.</p>
        </div>

        <div class="content">
            <div class="form-shell">
                <form action="addProduct.do" method="post" onsubmit="showLoader()">
                    <div class="field">
                        <label for="name">Product Name</label>
                        <input type="text" id="name" name="name" placeholder="Enter product name" required>
                    </div>

                    <div class="field">
                        <label for="price">Price</label>
                        <input type="text" id="price" name="price" placeholder="Enter price" required>
                    </div>

                    <div class="actions">
                        <button class="btn btn-save" type="submit">Add Product</button>
                        <a class="btn btn-back" href="index.jsp">Back to Home</a>
                    </div>
                </form>
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
        loader.style.transition = 'opacity .35s ease';
        setTimeout(() => loader.remove(), 350);
    });
</script>
</body>
</html>