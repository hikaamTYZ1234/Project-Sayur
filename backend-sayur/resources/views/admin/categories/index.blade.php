@extends('admin.layouts.app')

@section('content')
<div class="content-header d-flex justify-content-between align-items-center">
    <div>
        <h2>Daftar Kategori</h2>
        <p class="text-muted">Kelola kategori produk untuk pengelompokan yang lebih baik.</p>
    </div>
    <a href="{{ route('admin.categories.create') }}" class="btn btn-success px-4 py-2 fw-bold">
        <i class="fas fa-plus me-2"></i> Tambah Kategori
    </a>
</div>

<div class="card p-4">
    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th class="ps-3 text-uppercase small fw-bold text-secondary">#</th>
                    <th class="text-uppercase small fw-bold text-secondary">Nama Kategori</th>
                    <th class="text-uppercase small fw-bold text-secondary">Slug</th>
                    <th class="text-uppercase small fw-bold text-secondary">Jumlah Produk</th>
                    <th class="text-end pe-3 text-uppercase small fw-bold text-secondary">Aksi</th>
                </tr>
            </thead>
            <tbody>
                @forelse($categories as $i => $category)
                <tr>
                    <td class="ps-3 text-muted">{{ $i + 1 }}</td>
                    <td>
                        <span class="fw-bold text-dark">{{ $category->name }}</span>
                    </td>
                    <td>
                        <code class="text-success bg-success-subtle px-2 py-1 rounded small">{{ $category->slug }}</code>
                    </td>
                    <td>
                        <div class="d-flex align-items-center gap-2">
                            <i class="fas fa-layer-group text-muted small"></i>
                            <span>{{ $category->products_count }} Produk</span>
                        </div>
                    </td>
                    <td class="text-end pe-3">
                        <div class="d-flex justify-content-end gap-2">
                            <a href="{{ route('admin.categories.edit', $category->id) }}" class="btn btn-warning btn-sm px-3 rounded-pill text-white fw-bold">
                                <i class="fas fa-edit me-1"></i> Edit
                            </a>
                            <form action="{{ route('admin.categories.destroy', $category->id) }}" method="POST" onsubmit="return confirm('Hapus kategori ini?')">
                                @csrf @method('DELETE')
                                <button type="submit" class="btn btn-outline-danger btn-sm px-3 rounded-pill fw-bold">
                                    <i class="fas fa-trash me-1"></i> Hapus
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="5" class="text-center py-5 text-muted">
                        <i class="fas fa-tags fa-3x mb-3 opacity-25"></i>
                        <p>Belum ada kategori. Silakan tambah kategori baru.</p>
                    </td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>
</div>
@endsection