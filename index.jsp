<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Struts Product Catalog (Mini Project)</title>
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
            overflow-x: hidden;
        }

        .bg-grid {
            position: fixed;
            inset: 0;
            pointer-events: none;
            opacity: .18;
            background-image:
                linear-gradient(rgba(255,255,255,.08) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,.08) 1px, transparent 1px);
            background-size: 42px 42px;
            mask-image: radial-gradient(circle at center, black 40%, transparent 100%);
        }

        .page {
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 28px;
        }

        .panel {
            width: min(980px, 100%);
            background: var(--card);
            border: 1px solid var(--card-border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            backdrop-filter: blur(18px);
            overflow: hidden;
            padding: 38px;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 9px 14px;
            border-radius: 999px;
            background: rgba(79, 140, 255, .12);
            border: 1px solid rgba(79, 140, 255, .20);
            color: #cfe0ff;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: .2px;
        }

        h1 {
            margin: 18px 0 10px;
            font-size: clamp(34px, 4vw, 56px);
            line-height: 1.04;
            letter-spacing: -.03em;
        }

        .lead {
            margin: 0;
            max-width: 62ch;
            color: var(--muted);
            font-size: 16px;
            line-height: 1.8;
        }

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            margin-top: 28px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 14px 20px;
            border-radius: 16px;
            text-decoration: none;
            font-weight: 800;
            letter-spacing: .2px;
            transition: transform .18s ease, box-shadow .18s ease, background .18s ease;
            border: 1px solid transparent;
            user-select: none;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
            color: #07111f;
            background: linear-gradient(135deg, #7dd3fc, #4f8cff, #2dd4bf);
            box-shadow: 0 14px 30px rgba(79, 140, 255, .25);
        }

        .btn-secondary {
            color: #eff6ff;
            background: rgba(255,255,255,.06);
            border-color: rgba(255,255,255,.12);
        }

        .btn-secondary:hover {
            background: rgba(255,255,255,.10);
        }

        footer {
            margin-top: 34px;
            padding-top: 18px;
            border-top: 1px solid rgba(255,255,255,.08);
            display: flex;
            justify-content: space-between;
            gap: 14px;
            flex-wrap: wrap;
            color: rgba(229, 238, 252, .75);
            font-size: 13px;
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

        @media (max-width: 640px) {
            .panel {
                padding: 24px;
            }
        }
    </style>
</head>
<body>
<div class="bg-grid"></div>

<div class="loader" id="loader">
    <div class="spinner"></div>
</div>

<div class="page">
    <section class="panel">
        <span class="badge">Struts Product Catalog (Mini Project)</span>
        <h1>Product Catalog</h1>
        <p class="lead">
            A modern Struts MVC mini project built with Servlet, JSP, and connected database storage.
            Manage products with a clean interface and simple workflow.
        </p>

        <div class="actions">
            <a class="btn btn-primary" href="products.do">View Products</a>
            <a class="btn btn-secondary" href="addProduct.jsp">Add Product</a>
        </div>

        <footer>
            <div>Project Designed by Pratik Narayan Chakraborty</div>
            <div>&copy; April 2026</div>
        </footer>
    </section>
</div>

<script>
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