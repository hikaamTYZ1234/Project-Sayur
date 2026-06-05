import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import 'detail_location_screen.dart';
import '../../main_menu/screens/main_menu_drawer.dart';
import '../../../services/api_service.dart';
import '../../../main.dart';

// ─────────────────────────────────────────────────────────────────
//  ORDERS SCREEN
// ─────────────────────────────────────────────────────────────────
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with RouteAware {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<dynamic> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.trim());
    });
    _loadOrders();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoading = true);
    try {
      final orders = await ApiService.getMyOrders();
      if (mounted) setState(() => _orders = orders);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal memuat order: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _createSampleOrder() async {
    setState(() => _isLoading = true);
    try {
      final products = await ApiService.getProducts();
      if (products.isEmpty) {
        throw 'Tidak ada produk untuk dibuat order.';
      }

      final items = products.take(2).map((product) {
        return {'product_id': product['id'], 'quantity': 1};
      }).toList();

      final result = await ApiService.createOrder(items);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Order demo berhasil dibuat'),
          ),
        );
        await _loadOrders();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal membuat order demo: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<dynamic> get _filtered {
    List<dynamic> list;
    switch (_selectedTab) {
      case 1:
        list = _orders
            .where(
              (o) => o['status'] == 'pending' || o['status'] == 'processing',
            )
            .toList();
        break;
      case 2:
        list = _orders
            .where((o) => o['status'] == 'done' || o['status'] == 'completed')
            .toList();
        break;
      default:
        list = List.from(_orders);
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((o) {
        final id = o['id'].toString().toLowerCase();
        final items = o['items'] as List<dynamic>? ?? [];
        final hasMatch = items.any((item) {
          final name = (item['product']?['name'] ?? '')
              .toString()
              .toLowerCase();
          return name.contains(q);
        });
        return id.contains(q) || hasMatch;
      }).toList();
    }
    return list;
  }

  int _countTab(int tab) {
    if (tab == 1)
      return _orders
          .where((o) => o['status'] == 'pending' || o['status'] == 'processing')
          .length;
    if (tab == 2)
      return _orders
          .where((o) => o['status'] == 'done' || o['status'] == 'completed')
          .length;
    return _orders.length;
  }

  // ── Helper: satu garis hamburger ─────────────────────────────
  Widget _buildHamburgerLine(double width, Color color) {
    return Container(
      width: width,
      height: 2.5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final filtered = _filtered;

    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    return Scaffold(
      drawer: const MainMenuDrawer(activeIndex: 1),

      // ── AppBar ───────────────────────────────────────────────
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // ── Kiri: Hamburger menu ─────────────────────────────
        leading: Builder(
          builder: (context) {
            final canPop = Navigator.canPop(context);
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (canPop) {
                  Navigator.pop(context);
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: canPop
                    ? Icon(Icons.arrow_back, color: textColor)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHamburgerLine(24, textColor),
                          const SizedBox(height: 5),
                          _buildHamburgerLine(18, textColor),
                          const SizedBox(height: 5),
                          _buildHamburgerLine(24, textColor),
                        ],
                      ),
              ),
            );
          },
        ),

        // ── Tengah: Judul halaman ────────────────────────────
        title: Text(
          'Orders',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        centerTitle: true,

        // ── Kanan: Icon sort/filter (sesuai UI) ──────────────
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(
                Icons.swap_vert_rounded, // ↑↓ icon sesuai screenshot
                color: textColor,
                size: 26,
              ),
              onPressed: () {
                // TODO: aksi sort / filter
              },
            ),
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Search Bar ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: isDark
                            ? AppColors.textHintDark
                            : AppColors.textHintLight,
                        size: 22,
                      ),
                      hintText: 'Search Order ID or Product',
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 18,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                              onPressed: () => _searchController.clear(),
                            )
                          : null,
                    ),
                  ),
                ),

                // ── Tab Selector ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: _TabSelector(
                    tabs: const ['All', 'On Delivery', 'Done'],
                    counts: [_countTab(0), _countTab(1), _countTab(2)],
                    selectedIndex: _selectedTab,
                    onTap: (i) => setState(() => _selectedTab = i),
                  ),
                ),

                // ── Order List / Empty State ──────────────────────────
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _loadOrders,
                    child: filtered.isEmpty
                        ? _EmptyState(
                            query: _searchQuery,
                            onCreateSample: _createSampleOrder,
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                            itemCount: filtered.length,
                            itemBuilder: (_, i) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailsScreen(
                                        orderData: filtered[i] as Map<String, dynamic>),
                                  ),
                                );
                              },
                              child: _OrderCard(order: filtered[i]),
                            ),
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Tab Selector
// ─────────────────────────────────────────────────────────────────
class _TabSelector extends StatelessWidget {
  final List<String> tabs;
  final List<int> counts;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _TabSelector({
    required this.tabs,
    required this.counts,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceVariantDark
            : AppColors.surfaceVariantLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isSelected = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark
                            ? AppColors.surfaceDark
                            : AppColors.backgroundLight)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tabs[i],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isSelected
                            ? (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight)
                            : (isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryGreen
                            : (isDark
                                  ? AppColors.surfaceDark
                                  : AppColors.dividerLight),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${counts[i]}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Order Card
// ─────────────────────────────────────────────────────────────────
class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final items = order['items'] as List<dynamic>? ?? [];
    final totalPrice = order['total_price'];
    final status = order['status'] ?? '';
    final orderId = 'ORD-${order['id']}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID & status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: status == 'done' || status == 'completed'
                      ? AppColors.primaryGreen.withOpacity(0.15)
                      : Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: status == 'done' || status == 'completed'
                        ? AppColors.primaryGreen
                        : Colors.orange.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Items
          ...items.map((item) {
            final product = item['product'] as Map<String, dynamic>? ?? {};
            final imageUrl =
                (product['image_url'] as String?)?.isNotEmpty == true
                ? product['image_url'] as String
                : (product['image'] as String? ?? '');
            final qty = item['quantity'] ?? 1;
            final price = item['price'];
            final total = (price is num && qty is num) ? price * qty : 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 72,
                      height: 72,
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _placeholder(isDark),
                            )
                          : _placeholder(isDark),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'] ?? '',
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
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 13,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                '${qty}x',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Text(
                              '\$${total.toStringAsFixed(1)}',
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
          }),
          // Total
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total: \$$totalPrice',
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.priceGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget _placeholder(bool isDark) {
    return Container(
      color: isDark
          ? AppColors.surfaceVariantDark
          : AppColors.surfaceVariantLight,
      child: Icon(
        Icons.fastfood_outlined,
        size: 28,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Empty State
// ─────────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final String query;
  final VoidCallback? onCreateSample;
  const _EmptyState({required this.query, this.onCreateSample});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            query.isNotEmpty
                ? Icons.search_off_rounded
                : Icons.receipt_long_outlined,
            size: 68,
            color: color,
          ),
          const SizedBox(height: 16),
          Text(
            query.isNotEmpty
                ? 'Tidak ada hasil untuk\n"$query"'
                : 'Belum ada pesanan di sini',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(color: color),
          ),
          if (onCreateSample != null && query.isEmpty) ...[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onCreateSample,
              child: const Text('Buat order demo'),
            ),
          ],
        ],
      ),
    );
  }
}
