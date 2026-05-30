@extends('admin.layouts.app')

@section('content')
<h4>Tambah Kategori</h4>
<form action="{{ route('admin.categories.store') }}" method="POST">
    @csrf
    <div class="mb-3">
        <label>Nama Kategori</label>
        <input type="text" name="name" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Gambar (URL opsional)</label>
        <input type="text" name="image" class="form-control">
    </div>
    <button type="submit" class="btn btn-success">Simpan</button>
    <a href="{{ route('admin.categories.index') }}" class="btn btn-secondary">Batal</a>
</form>
@endsection