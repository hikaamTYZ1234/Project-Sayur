@extends('admin.layouts.app')

@section('content')
<div class="content-header">
    <h2>Edit Kategori</h2>
    <p class="text-muted">Perbarui nama atau gambar ikon kategori Anda.</p>
</div>

<div class="row">
    <div class="col-lg-6">
        <div class="card p-4 shadow-sm">
            <form action="{{ route('admin.categories.update', $category->id) }}" method="POST">
                @csrf @method('PUT')
                <div class="mb-3">
                    <label class="form-label fw-bold">Nama Kategori</label>
                    <input type="text" name="name" class="form-control px-3 py-2" value="{{ $category->name }}" required>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold">Gambar Kategori (URL opsional)</label>
                    <input type="text" name="image" class="form-control px-3 py-2" value="{{ $category->image }}" placeholder="http://...">
                    @if($category->image)
                        <div class="mt-2">
                            <span class="small text-muted d-block mb-1">Preview Saat Ini:</span>
                            <img src="{{ $category->image }}" alt="Preview" class="rounded border" style="width: 50px; height: 50px; object-fit: cover;">
                        </div>
                    @endif
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-success px-4 py-2 fw-bold">
                        <i class="fas fa-save me-2"></i> Perbarui Kategori
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