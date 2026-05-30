@extends('admin.layouts.app')

@section('content')
<h4>Daftar Orders</h4>

<table class="table table-bordered">
    <thead class="table-success">
        <tr>
            <th>#</th>
            <th>User</th>
            <th>Total</th>
            <th>Status</th>
            <th>Tanggal</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach($orders as $i => $order)
        <tr>
            <td>{{ $i + 1 }}</td>
            <td>{{ $order->user->name ?? '-' }}</td>
            <td>Rp {{ number_format($order->total_price, 0, ',', '.') }}</td>
            <td>
                <span class="badge 
                    {{ $order->status == 'done' ? 'bg-success' : 
                       ($order->status == 'on_delivery' ? 'bg-primary' : 
                       ($order->status == 'cancelled' ? 'bg-danger' : 'bg-warning')) }}">
                    {{ $order->status }}
                </span>
            </td>
            <td>{{ $order->created_at->format('d/m/Y H:i') }}</td>
            <td>
                <a href="{{ route('admin.orders.show', $order->id) }}" class="btn btn-info btn-sm">Detail</a>
            </td>
        </tr>
        @endforeach
    </tbody>
</table>
{{ $orders->links() }}
@endsection