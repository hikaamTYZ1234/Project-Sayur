@extends('admin.layouts.app')

@section('content')
<div class="content-header d-flex justify-content-between align-items-center">
    <div>
        <h2>Daftar Produk</h2>
        <p class="text-muted">Kelola koleksi sayuran dan buah-buahan segar Anda.</p>
    </div>
    <a href="{{ route('admin.products.create') }}" class="btn btn-success px-4 py-2 fw-bold">
        <i class="fas fa-plus me-2"></i> Tambah Produk
    </a>
</div>

<div class="card p-4">
    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th class="ps-3">Produk</th>
                    <th>Kategori</th>
                    <th>Harga</th>
                    <th>Stok</th>
                    <th>Rating</th>
                    <th class="text-end pe-3">Aksi</th>
                </tr>
            </thead>
            <tbody>
                @forelse($products as $product)
                <tr>
                    <td class="ps-3">
                        <div class="d-flex align-items-center gap-3">
                            <div class="rounded-3 border overflow-hidden" style="width: 50px; height: 50px;">
                                <img src="{{ $product->image_url ?? 'https://via.placeholder.com/50' }}" 
                                     alt="{{ $product->name }}" 
                                     class="w-100 h-100 object-fit-cover">
                            </div>
                            <span class="fw-semibold text-dark">{{ $product->name }}</span>
                        </div>
                    </td>
                    <td>
                        <span class="badge bg-light text-success border border-success-subtle">
                            {{ $product->category->name ?? 'Grup' }}
                        </span>
                    </td>
                    <td>
                        <span class="fw-bold text-dark">Rp {{ number_format($product->price, 0, ',', '.') }}</span>
                    </td>
                    <td>
                        @if($product->stock <= 5)
                            <span class="text-danger fw-bold"><i class="fas fa-exclamation-triangle me-1"></i> {{ $product->stock }}</span>
                        @else
                            <span class="text-muted">{{ $product->stock }} Item</span>
                        @endif
                    </td>
                    <td>
                        <div class="text-warning">
                            <i class="fas fa-star sm"></i>
                            <span class="text-dark fw-medium ms-1">{{ $product->rating }}</span>
                        </div>
                    </td>
                    <td class="text-end pe-3">
                        <div class="dropdown">
                            <button class="btn btn-light btn-sm rounded-circle" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                <li>
                                    <a class="dropdown-item py-2" href="{{ route('admin.products.edit', $product->id) }}">
                                        <i class="fas fa-edit me-2 text-warning"></i> Edit
                                    </a>
                                </li>
                                <li>
                                    <form action="{{ route('admin.products.destroy', $product->id) }}" method="POST" onsubmit="return confirm('Hapus produk ini?')">
                                        @csrf @method('DELETE')
                                        <button type="submit" class="dropdown-item py-2 text-danger">
                                            <i class="fas fa-trash me-2"></i> Hapus
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="6" class="text-center py-5 text-muted">
                        <i class="fas fa-box-open fa-3x mb-3 opacity-25"></i>
                        <p>Belum ada produk. Silakan tambah produk baru.</p>
                    </td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>
    
    <div class="mt-4">
        {{ $products->links() }}
    </div>
</div>
@endsection