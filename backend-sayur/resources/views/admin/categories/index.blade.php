@extends('admin.layouts.app')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-3">
    <h4>Daftar Kategori</h4>
    <a href="{{ route('admin.categories.create') }}" class="btn btn-success">+ Tambah Kategori</a>
</div>

<table class="table table-bordered">
    <thead class="table-success">
        <tr>
            <th>#</th>
            <th>Nama</th>
            <th>Slug</th>
            <th>Jumlah Produk</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach($categories as $i => $category)
        <tr>
            <td>{{ $i + 1 }}</td>
            <td>{{ $category->name }}</td>
            <td>{{ $category->slug }}</td>
            <td>{{ $category->products_count }}</td>
            <td>
                <a href="{{ route('admin.categories.edit', $category->id) }}" class="btn btn-warning btn-sm">Edit</a>
                <form action="{{ route('admin.categories.destroy', $category->id) }}" method="POST" class="d-inline">
                    @csrf @method('DELETE')
                    <button class="btn btn-danger btn-sm" onclick="return confirm('Hapus kategori ini?')">Hapus</button>
                </form>
            </td>
        </tr>
        @endforeach
    </tbody>
</table>
@endsection