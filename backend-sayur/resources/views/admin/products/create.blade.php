@extends('admin.layouts.app')

@section('content')
<div class="content-header">
    <h2>Tambah Produk Baru</h2>
    <p class="text-muted">Lengkapi formulir di bawah untuk menambahkan item baru ke toko Anda.</p>
</div>

<div class="row">
    <div class="col-lg-8">
        <div class="card p-4 shadow-sm">
            <form action="{{ route('admin.products.store') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label fw-bold">Nama Produk</label>
                        <input type="text" name="name" class="form-control px-3 py-2 @error('name') is-invalid @enderror" value="{{ old('name') }}" placeholder="Contoh: Wortel Organik" required>
                        @error('name')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Kategori</label>
                        <select name="category_id" class="form-select px-3 py-2" required>
                            <option value="" disabled selected>Pilih Kategori</option>
                            @foreach($categories as $cat)
                                <option value="{{ $cat->id }}">{{ $cat->name }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Harga (Rp)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">Rp</span>
                            <input type="number" name="price" class="form-control px-3 py-2 border-start-0" placeholder="0" required>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Stok Awal</label>
                        <input type="number" name="stock" class="form-control px-3 py-2" placeholder="0" required>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-bold">Deskripsi</label>
                        <textarea name="description" class="form-control px-3 py-2" rows="4" placeholder="Berikan deskripsi singkat mengenai produk ini..."></textarea>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-bold">Foto Produk</label>
                        <div class="border rounded-3 p-3 bg-light">
                            <input type="file" name="image" class="form-control">
                            <small class="text-muted mt-2 d-block">Format: JPG, PNG, atau WEBP. Maks 2MB.</small>
                        </div>
                    </div>

                    <div class="col-md-12 mt-4">
                        <hr>
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-success px-4 py-2 fw-bold">
                                <i class="fas fa-save me-2"></i> Simpan Produk
                            </button>
                            <a href="{{ route('admin.products.index') }}" class="btn btn-light px-4 py-2 border fw-bold">
                                Batal
                            </a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <div class="col-lg-4">
        <div class="card p-4 border-0 bg-success-subtle text-success h-100">
            <h5><i class="fas fa-lightbulb me-2"></i> Tips Penambahan</h5>
            <ul class="small mt-3 ps-3">
                <li class="mb-2">Gunakan nama produk yang jelas dan deskriptif.</li>
                <li class="mb-2">Pastikan harga sudah kompetitif dengan pasar.</li>
                <li class="mb-2">Gunakan foto asli dengan pencahayaan baik (Rasio 1:1 disarankan).</li>
                <li>Deskripsi yang mendetail meningkatkan kepercayaan pembeli.</li>
            </ul>
        </div>
    </div>
</div>
@endsection