@extends('admin.layouts.app')

@section('content')
<div class="content-header">
    <h2>Daftar Pesanan</h2>
    <p class="text-muted">Pantau dan kelola pesanan masuk dari pelanggan Anda.</p>
</div>

<div class="card p-4">
    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th class="ps-3 text-uppercase small fw-bold text-secondary">ID Order</th>
                    <th class="text-uppercase small fw-bold text-secondary">Pelanggan</th>
                    <th class="text-uppercase small fw-bold text-secondary">Total Harga</th>
                    <th class="text-uppercase small fw-bold text-secondary">Status</th>
                    <th class="text-uppercase small fw-bold text-secondary">Tanggal</th>
                    <th class="text-end pe-3 text-uppercase small fw-bold text-secondary">Detail</th>
                </tr>
            </thead>
            <tbody>
                @forelse($orders as $order)
                <tr>
                    <td class="ps-3 fw-bold text-dark">
                        #ORD-{{ $order->id }}
                    </td>
                    <td>
                        <div class="d-flex align-items-center gap-2">
                            <i class="fas fa-user-circle text-secondary opacity-50"></i>
                            <span class="text-dark">{{ $order->user->name ?? 'Guest' }}</span>
                        </div>
                    </td>
                    <td>
                        <span class="fw-bold text-success">Rp {{ number_format($order->total_price, 0, ',', '.') }}</span>
                    </td>
                    <td>
                        @php
                            $statusClass = match($order->status) {
                                'pending' => 'bg-warning-subtle text-warning border-warning-subtle',
                                'processing' => 'bg-primary-subtle text-primary border-primary-subtle',
                                'done', 'completed' => 'bg-success-subtle text-success border-success-subtle',
                                'cancelled' => 'bg-danger-subtle text-danger border-danger-subtle',
                                default => 'bg-secondary-subtle text-secondary border-secondary-subtle'
                            };
                            $statusLabel = match($order->status) {
                                'pending' => 'Menunggu',
                                'processing' => 'Diproses',
                                'done', 'completed' => 'Selesai',
                                'cancelled' => 'Dibatalkan',
                                default => ucfirst($order->status)
                            };
                        @endphp
                        <span class="badge border {{ $statusClass }} px-3 py-2 rounded-pill">
                            {{ $statusLabel }}
                        </span>
                    </td>
                    <td class="text-muted">
                        {{ $order->created_at->format('d M Y, H:i') }}
                    </td>
                    <td class="text-end pe-3">
                        <a href="{{ route('admin.orders.show', $order->id) }}" class="btn btn-light btn-sm rounded-pill px-3 fw-bold">
                            Lihat <i class="fas fa-chevron-right ms-1 small"></i>
                        </a>
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="6" class="text-center py-5 text-muted">
                        <i class="fas fa-receipt fa-3x mb-3 opacity-25"></i>
                        <p>Belum ada pesanan masuk.</p>
                    </td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-4">
        {{ $orders->links() }}
    </div>
</div>
@endsection