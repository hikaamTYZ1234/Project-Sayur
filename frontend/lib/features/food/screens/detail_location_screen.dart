import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../services/api_service.dart';

num _parseNum(dynamic value) {
  if (value is num) return value;
  if (value is String) {
    return num.tryParse(value.replaceAll(',', '').trim()) ?? 0;
  }
  return 0;
}

// ─────────────────────────────────────────────────────────────────
//  DETAILS SCREEN — menampilkan detail order real dari API
// ─────────────────────────────────────────────────────────────────
class DetailsScreen extends StatefulWidget {
  /// Data order dari API (Map dengan keys: id, status, total_price, items, ...)
  final Map<String, dynamic>? orderData;

  const DetailsScreen({super.key, this.orderData});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _itemsExpanded = true;

  List<dynamic> get _items =>
      (widget.orderData?['items'] as List<dynamic>?) ?? [];

  num get _grandTotal {
    final totalValue = widget.orderData?['total_price'];
    if (totalValue != null) {
      return _parseNum(totalValue);
    }
    // Hitung manual dari items kalau total_price kosong
    return _items.fold<double>(0.0, (sum, item) {
      final price = _parseNum(item['price']).toDouble();
      final qty = _parseNum(item['quantity']).toDouble();
      return sum + (price * qty);
    });
  }

  String get _status => widget.orderData?['status'] as String? ?? 'pending';
  String get _orderId => 'ORD-${widget.orderData?['id'] ?? '-'}';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(_orderId),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── MAP PLACEHOLDER ─────────────────────────────
            _MapPlaceholder(isDark: isDark),

            // ── KONTEN BAWAH MAP ─────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Info Kurir (statis) ─────────────────────────────
                  _CourierCard(isDark: isDark),

                  const SizedBox(height: 14),
                  Divider(
                    color: isDark
                        ? AppColors.dividerDark
                        : AppColors.dividerLight,
                    height: 1,
                  ),
                  const SizedBox(height: 14),

                  // ── Alamat + Status ─────────────────────────────────
                  _AddressRow(status: _status, isDark: isDark),

                  const SizedBox(height: 20),
                  Divider(
                    color: isDark
                        ? AppColors.dividerDark
                        : AppColors.dividerLight,
                    height: 1,
                  ),
                  const SizedBox(height: 16),

                  // ── Header Items ───────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_items.length} Items',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            setState(() => _itemsExpanded = !_itemsExpanded),
                        child: AnimatedRotation(
                          turns: _itemsExpanded ? 0 : -0.5,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark
                                    ? AppColors.primaryGreenLight
                                    : AppColors.primaryGreen,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: isDark
                                  ? AppColors.primaryGreenLight
                                  : AppColors.primaryGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ── List Item (collapsible) ────────────────
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 250),
                    crossFadeState: _itemsExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Column(
                      children: [
                        const SizedBox(height: 14),
                        if (_items.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Tidak ada item dalam order ini.',
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                            ),
                          )
                        else
                          ..._items.map(
                            (item) =>
                                _DetailItemCard(item: item, isDark: isDark),
                          ),
                      ],
                    ),
                    secondChild: const SizedBox.shrink(),
                  ),

                  const SizedBox(height: 8),
                  Divider(
                    color: isDark
                        ? AppColors.dividerDark
                        : AppColors.dividerLight,
                    height: 1,
                  ),
                  const SizedBox(height: 16),

                  // ── Grand Total ────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                      Text(
                        'Rp ${_grandTotal.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.priceGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Map dengan Zoom In/Out
// ─────────────────────────────────────────────────────────────────
class _MapPlaceholder extends StatefulWidget {
  final bool isDark;
  const _MapPlaceholder({required this.isDark});

  @override
  State<_MapPlaceholder> createState() => _MapPlaceholderState();
}

class _MapPlaceholderState extends State<_MapPlaceholder> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;

  static const double _minScale = 1.0;
  static const double _maxScale = 4.0;
  static const double _zoomStep = 0.5;

  void _zoomIn() {
    setState(() {
      _scale = (_scale + _zoomStep).clamp(_minScale, _maxScale);
      _clampOffset();
    });
  }

  void _zoomOut() {
    setState(() {
      _scale = (_scale - _zoomStep).clamp(_minScale, _maxScale);
      if (_scale <= _minScale) _offset = Offset.zero;
      _clampOffset();
    });
  }

  void _clampOffset() {
    const mapHeight = 220.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final maxX = (screenWidth * (_scale - 1)) / 2;
    final maxY = (mapHeight * (_scale - 1)) / 2;
    _offset = Offset(
      _offset.dx.clamp(-maxX, maxX),
      _offset.dy.clamp(-maxY, maxY),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: ClipRect(
        child: Stack(
          children: [
            GestureDetector(
              onScaleStart: (details) {
                _previousScale = _scale;
                _previousOffset = _offset;
              },
              onScaleUpdate: (details) {
                setState(() {
                  _scale = (_previousScale * details.scale).clamp(
                    _minScale,
                    _maxScale,
                  );
                  if (_scale > _minScale) {
                    _offset = _previousOffset + details.focalPointDelta;
                  }
                  _clampOffset();
                });
              },
              onScaleEnd: (_) {
                if (_scale <= _minScale) setState(() => _offset = Offset.zero);
              },
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(_offset.dx, _offset.dy)
                  ..scale(_scale),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/map.png',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: double.infinity,
                    height: 220,
                    color: widget.isDark
                        ? const Color(0xFF2A3A2A)
                        : const Color(0xFFE8F5E9),
                    child: CustomPaint(
                      painter: _MapPainter(isDark: widget.isDark),
                      child: const Center(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 36,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? AppColors.surfaceDark
                      : AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Open in Maps',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: widget.isDark
                            ? AppColors.primaryGreenLight
                            : AppColors.primaryGreen,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.open_in_new,
                      size: 13,
                      color: widget.isDark
                          ? AppColors.primaryGreenLight
                          : AppColors.primaryGreen,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 16,
              child: Column(
                children: [
                  _ZoomButton(
                    icon: Icons.add,
                    isDark: widget.isDark,
                    enabled: _scale < _maxScale,
                    onTap: _zoomIn,
                  ),
                  const SizedBox(height: 4),
                  _ZoomButton(
                    icon: Icons.remove,
                    isDark: widget.isDark,
                    enabled: _scale > _minScale,
                    onTap: _zoomOut,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 52,
              bottom: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${(_scale * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Tombol Zoom
// ─────────────────────────────────────────────────────────────────
class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final bool enabled;
  final VoidCallback onTap;

  const _ZoomButton({
    required this.icon,
    required this.isDark,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 4),
          ],
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled
              ? (isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight)
              : (isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  Fallback painter
// ─────────────────────────────────────────────────────────────────
class _MapPainter extends CustomPainter {
  final bool isDark;
  _MapPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? const Color(0xFF3A4A3A) : const Color(0xFFFFFFFF)
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final paint2 = Paint()
      ..color = isDark ? const Color(0xFF3A4A3A) : const Color(0xFFFFFFFF)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.6, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.75, 0),
      Offset(size.width * 0.75, size.height),
      paint2,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.75),
      Offset(size.width, size.height * 0.75),
      paint2,
    );
  }

  @override
  bool shouldRepaint(_MapPainter old) => old.isDark != isDark;
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Courier Card (statis)
// ─────────────────────────────────────────────────────────────────
class _CourierCard extends StatelessWidget {
  final bool isDark;
  const _CourierCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: isDark
              ? AppColors.surfaceVariantDark
              : AppColors.surfaceVariantLight,
          child: Icon(
            Icons.delivery_dining_rounded,
            size: 28,
            color: isDark
                ? AppColors.primaryGreenLight
                : AppColors.primaryGreen,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kurir',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              Text(
                'Pengiriman Ekspres',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark
                    ? AppColors.primaryGreenLight
                    : AppColors.primaryGreen,
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.phone,
              size: 20,
              color: isDark
                  ? AppColors.primaryGreenLight
                  : AppColors.primaryGreen,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Address Row — menampilkan status order nyata
// ─────────────────────────────────────────────────────────────────
class _AddressRow extends StatelessWidget {
  final String status;
  final bool isDark;
  const _AddressRow({required this.status, required this.isDark});

  Color get _statusColor {
    if (status == 'done' || status == 'completed')
      return AppColors.primaryGreen;
    if (status == 'processing') return Colors.blue;
    return Colors.orange;
  }

  String get _statusLabel {
    switch (status) {
      case 'done':
      case 'completed':
        return 'Selesai';
      case 'processing':
        return 'Diproses';
      case 'pending':
      default:
        return 'Menunggu';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.location_on, color: AppColors.accent, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alamat Pengiriman',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
              Text(
                'Jl. Contoh No. 123',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _statusColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _statusLabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Detail Item Card — menggunakan data dari API
// ─────────────────────────────────────────────────────────────────
class _DetailItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isDark;
  const _DetailItemCard({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = item['product'] as Map<String, dynamic>? ?? {};
    final String name = product['name'] as String? ?? 'Produk';
    final num price = _parseNum(item['price']);
    final num qty = _parseNum(item['quantity']);
    final String imageUrl = ApiService.fixImageUrl(
      (product['image_url'] as String?)?.isNotEmpty == true
          ? product['image_url'] as String
          : (product['image'] as String? ?? ''),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Gambar produk ──────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 80,
              height: 80,
              child: imageUrl.isNotEmpty && imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, loadingProgress) =>
                          loadingProgress == null ? child : _placeholder(),
                      errorBuilder: (_, __, ___) => _placeholder(),
                    )
                  : _placeholder(),
            ),
          ),

          const SizedBox(width: 14),

          // ── Info ───────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 14,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$$price',
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '${qty}x',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      '\$${(price * qty).toStringAsFixed(1)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppColors.priceGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceVariantDark
            : AppColors.surfaceVariantLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.fastfood_outlined,
        size: 30,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      ),
    );
  }
}
