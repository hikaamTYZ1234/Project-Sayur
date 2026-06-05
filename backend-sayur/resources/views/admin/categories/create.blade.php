@extends('admin.layouts.app')

@section('content')
<div class="content-header">
    <h2>Tambah Kategori</h2>
    <p class="text-muted">Buat pengelompokan produk baru agar toko lebih terorganisir.</p>
</div>

<div class="row">
    <div class="col-lg-6">
        <div class="card p-4 shadow-sm">
            <form action="{{ route('admin.categories.store') }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label fw-bold">Nama Kategori</label>
                    <input type="text" name="name" class="form-control px-3 py-2" placeholder="Contoh: Sayuran Hijau" required>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold">Gambar Kategori (URL opsional)</label>
                    <input type="text" name="image" class="form-control px-3 py-2" placeholder="http://...">
                    <small class="text-muted mt-2 d-block">Gunakan link gambar untuk ikon kategori ini.</small>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-success px-4 py-2 fw-bold">
                        <i class="fas fa-save me-2"></i> Simpan Kategori
                    </button>
                    <a href="{{ route('admin.categories.index') }}" class="btn btn-light px-4 py-2 border fw-bold">
                        Batal
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection