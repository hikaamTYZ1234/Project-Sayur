@extends('admin.layouts.app')

@section('content')
<h4>Detail Order #{{ $order->id }}</h4>
<div class="card mb-3">
    <div class="card-body">
        <p><strong>User:</strong> {{ $order->user->name ?? '-' }}</p>
        <p><strong>Email:</strong> {{ $order->user->email ?? '-' }}</p>
        <p><strong>Status:</strong> {{ $order->status }}</p>
        <p><strong>Total:</strong> Rp {{ number_format($order->total_price, 0, ',', '.') }}</p>
        <p><strong>Tanggal:</strong> {{ $order->created_at->format('d/m/Y H:i') }}</p>
    </div>
</div>

<h5>Item Pesanan</h5>
<table class="table table-bordered">
    <thead class="table-success">
        <tr>
            <th>Produk</th>
            <th>Harga</th>
            <th>Qty</th>
            <th>Subtotal</th>
        </tr>
    </thead>
    <tbody>
        @foreach($order->items as $item)
        <tr>
            <td>{{ $item->product->name ?? '-' }}</td>
            <td>Rp {{ number_format($item->price, 0, ',', '.') }}</td>
            <td>{{ $item->quantity }}</td>
            <td>Rp {{ number_format($item->price * $item->quantity, 0, ',', '.') }}</td>
        </tr>
        @endforeach
    </tbody>
</table>

<a href="{{ route('admin.orders.index') }}" class="btn btn-secondary">Kembali</a>
@endsection