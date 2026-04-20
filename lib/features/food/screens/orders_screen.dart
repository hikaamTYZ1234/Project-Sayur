import 'package:flutter/material.dart';
import '/../../theme/app_colors.dart';
import 'detail_location_screen.dart';
import '../../main_menu/screens/main_menu_drawer.dart';
// ─────────────────────────────────────────────────────────────────
//  MODEL
// ─────────────────────────────────────────────────────────────────
enum OrderStatus { onDelivery, done }

class OrderItem {
  final String id;
  final String name;
  final double price;
  final int qty;
  final String imageAsset;
  final OrderStatus status;

  const OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.imageAsset,
    required this.status,
  });

  double get total => price * qty;

  bool matchesSearch(String query) {
    final q = query.toLowerCase();
    return id.toLowerCase().contains(q) || name.toLowerCase().contains(q);
  }
}

// ─────────────────────────────────────────────────────────────────
//  DATA DUMMY
// ─────────────────────────────────────────────────────────────────
final List<OrderItem> _allOrders = [
  const OrderItem(
    id: 'ORD-001',
    name: 'Melted Omelette with Spicy Chilli',
    price: 5.8,
    qty: 2,
    imageAsset: 'assets/telur.png',
    status: OrderStatus.onDelivery,
  ),
  const OrderItem(
    id: 'ORD-002',
    name: 'Avocado Blend with Topping Egg',
    price: 8.6,
    qty: 1,
    imageAsset: 'assets/alpukat.png',
    status: OrderStatus.onDelivery,
  ),
  const OrderItem(
    id: 'ORD-003',
    name: 'Random Vegetables for Breakfast',
    price: 5.8,
    qty: 2,
    imageAsset: 'assets/sayuran.png',
    status: OrderStatus.onDelivery,
  ),
  const OrderItem(
    id: 'ORD-004',
    name: 'Grilled Salmon with Herbs',
    price: 12.5,
    qty: 1,
    imageAsset: 'assets/salmon.png',
    status: OrderStatus.done,
  ),
  const OrderItem(
    id: 'ORD-005',
    name: 'Fresh Fruit Bowl with Yogurt',
    price: 7.2,
    qty: 3,
    imageAsset: 'assets/buah.png',
    status: OrderStatus.done,
  ),
];

// ─────────────────────────────────────────────────────────────────
//  ORDERS SCREEN
// ─────────────────────────────────────────────────────────────────
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<OrderItem> get _filtered {
    List<OrderItem> list;
    switch (_selectedTab) {
      case 1:
        list = _allOrders
            .where((o) => o.status == OrderStatus.onDelivery)
            .toList();
        break;
      case 2:
        list = _allOrders.where((o) => o.status == OrderStatus.done).toList();
        break;
      default:
        list = List.from(_allOrders);
    }
    if (_searchQuery.isNotEmpty) {
      list = list.where((o) => o.matchesSearch(_searchQuery)).toList();
    }
    return list;
  }

  int _countTab(int tab) {
    if (tab == 1)
      return _allOrders
          .where((o) => o.status == OrderStatus.onDelivery)
          .length;
    if (tab == 2)
      return _allOrders.where((o) => o.status == OrderStatus.done).length;
    return _allOrders.length;
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

      body: Column(
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
            child: filtered.isEmpty
                ? _EmptyState(query: _searchQuery)
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) => _OrderCard(order: filtered[i]),
                  ),
          ),
        ],
      ),

      // ── Place Order Button → DetailsScreen ───────────────────
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 65),
            ),
            onPressed: filtered.isEmpty
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const DetailsScreen(),
                      ),
                    );
                  },
            child: const Text('PLACE ORDER', style: TextStyle(fontSize: 18)),
          ),
        ),
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
  final OrderItem order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              order.imageAsset,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceVariantDark
                      : AppColors.surfaceVariantLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.fastfood_outlined,
                  size: 34,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '\$${order.price.toStringAsFixed(1)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        '${order.qty}x',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      '\$${order.total.toStringAsFixed(1)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
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
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Empty State
// ─────────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final String query;
  const _EmptyState({required this.query});

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
        ],
      ),
    );
  }
}