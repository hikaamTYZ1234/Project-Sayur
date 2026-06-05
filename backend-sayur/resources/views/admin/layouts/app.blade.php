<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Sayur Healthy</title>
    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-green: #2E7D32;
            --sidebar-bg: #1B3A1F;
            --bg-light: #F8F9FA;
        }
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            display: flex;
            min-height: 100vh;
            margin: 0;
        }
        /* Sidebar */
        .sidebar {
            width: 260px;
            background-color: var(--sidebar-bg);
            color: white;
            transition: all 0.3s;
            position: fixed;
            height: 100%;
            z-index: 1000;
        }
        .sidebar-header {
            padding: 1.5rem;
            font-size: 1.25rem;
            font-weight: 700;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .nav-link {
            color: rgba(255,255,255,0.7);
            padding: 0.8rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.2s;
        }
        .nav-link:hover, .nav-link.active {
            color: white;
            background-color: rgba(255,255,255,0.1);
        }
        .nav-link i {
            width: 20px;
            text-align: center;
        }
        /* Main Content */
        .main-content {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 2rem;
        }
        /* Dashboard Cards */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }
        .btn-success {
            background-color: var(--primary-green);
            border: none;
        }
        .btn-success:hover {
            background-color: #246527;
        }
        /* Custom Header */
        .content-header {
            margin-bottom: 2rem;
        }
        .content-header h2 {
            font-weight: 700;
            color: #1a1a1a;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            🥬 Sayur Admin
        </div>
        <div class="mt-3">
            <a href="/admin/products" class="nav-link {{ Request::is('admin/products*') ? 'active' : '' }}">
                <i class="fas fa-carrot"></i> Produk
            </a>
            <a href="/admin/categories" class="nav-link {{ Request::is('admin/categories*') ? 'active' : '' }}">
                <i class="fas fa-tags"></i> Kategori
            </a>
            <a href="/admin/orders" class="nav-link {{ Request::is('admin/orders*') ? 'active' : '' }}">
                <i class="fas fa-shopping-cart"></i> Orders
            </a>
            <hr class="mx-3 opacity-25">
            <a href="{{ url('/') }}" class="nav-link">
                <i class="fas fa-external-link-alt"></i> Lihat Toko
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        @if(session('success'))
            <div class="alert alert-success alert-dismissible fade show card" role="alert">
                <i class="fas fa-check-circle me-2"></i> {{ session('success') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        @endif

        @yield('content')
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>