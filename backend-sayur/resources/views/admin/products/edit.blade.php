@extends('admin.layouts.app')

@section('content')
<div class="content-header">
    <h2>Edit Produk</h2>
    <p class="text-muted">Perbarui informasi produk dan stok Anda di sini.</p>
</div>

<div class="row">
    <div class="col-lg-8">
        <div class="card p-4 shadow-sm">
            <form action="{{ route('admin.products.update', $product->id) }}" method="POST" enctype="multipart/form-data">
                @csrf @method('PUT')
                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label fw-bold">Nama Produk</label>
                        <input type="text" name="name" class="form-control px-3 py-2 @error('name') is-invalid @enderror" value="{{ old('name', $product->name) }}" required>
                        @error('name')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Kategori</label>
                        <select name="category_id" class="form-select px-3 py-2" required>
                            @foreach($categories as $cat)
                                <option value="{{ $cat->id }}" {{ $product->category_id == $cat->id ? 'selected' : '' }}>
                                    {{ $cat->name }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Harga (Rp)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">Rp</span>
                            <input type="number" name="price" class="form-control px-3 py-2 border-start-0" value="{{ $product->price }}" required>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Stok</label>
                        <input type="number" name="stock" class="form-control px-3 py-2" value="{{ $product->stock }}" required>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-bold">Deskripsi</label>
                        <textarea name="description" class="form-control px-3 py-2" rows="4">{{ $product->description }}</textarea>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-bold">Gambar Produk</label>
                        <div class="border rounded-3 p-3 bg-light d-flex align-items-center gap-3">
                            @if($product->image_url)
                                <img src="{{ $product->image_url }}" alt="Preview" class="rounded-2 border" style="width: 80px; height: 80px; object-fit: cover;">
                            @endif
                            <div class="flex-grow-1">
                                <input type="file" name="image" class="form-control">
                                <small class="text-muted mt-1 d-block">Biarkan kosong jika tidak ingin mengubah gambar.</small>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12 mt-4">
                        <hr>
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-success px-4 py-2 fw-bold">
                                <i class="fas fa-save me-2"></i> Perbarui Produk
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
        <div class="card p-4 border-0 bg-light h-100 shadow-sm">
            <h5>Info Produk</h5>
            <div class="mt-3">
                <p class="mb-1 small text-muted">Ditambahkan pada:</p>
                <p class="fw-bold">{{ $product->created_at->format('d M Y, H:i') }}</p>
                
                <p class="mb-1 small text-muted mt-3">Terakhir diupdate:</p>
                <p class="fw-bold">{{ $product->updated_at->format('d M Y, H:i') }}</p>

                <p class="mb-1 small text-muted mt-3">Status Produk:</p>
                @if($product->stock > 0)
                    <span class="badge bg-success">Tersedia</span>
                @else
                    <span class="badge bg-danger">Habis</span>
                @endif
            </div>
        </div>
    </div>
</div>
@endsection