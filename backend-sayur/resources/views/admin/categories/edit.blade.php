@extends('admin.layouts.app')

@section('content')
<h4>Edit Kategori</h4>
<form action="{{ route('admin.categories.update', $category->id) }}" method="POST">
    @csrf @method('PUT')
    <div class="mb-3">
        <label>Nama Kategori</label>
        <input type="text" name="name" class="form-control" value="{{ $category->name }}" required>
    </div>
    <div class="mb-3">
        <label>Gambar (URL opsional)</label>
        <input type="text" name="image" class="form-control" value="{{ $category->image }}">
    </div>
    <button type="submit" class="btn btn-success">Update</button>
    <a href="{{ route('admin.categories.index') }}" class="btn btn-secondary">Batal</a>
</form>
@endsection