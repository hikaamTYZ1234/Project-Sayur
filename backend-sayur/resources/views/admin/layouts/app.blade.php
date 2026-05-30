<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin App Sayur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-success px-4">
        <span class="navbar-brand fw-bold">🥬 Admin App Sayur</span>
        <div>
            <a href="/admin/products" class="btn btn-outline-light btn-sm me-2">Produk</a>
            <a href="/admin/categories" class="btn btn-outline-light btn-sm me-2">Kategori</a>
            <a href="/admin/orders" class="btn btn-outline-light btn-sm">Orders</a>
        </div>
    </nav>
    <div class="container mt-4">
        @if(session('success'))
            <div class="alert alert-success">{{ session('success') }}</div>
        @endif
        @yield('content')
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>