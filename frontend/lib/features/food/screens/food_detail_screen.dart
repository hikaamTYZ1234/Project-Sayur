import 'package:flutter/material.dart';
import '../../../services/api_service.dart';
import '../../../theme/app_colors.dart';
import 'detail_location_screen.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  late Future<Map<String, dynamic>?> _foodFuture;
  int _quantity = 1;
  bool _isOrdering = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _foodFuture = _loadFoodDetail();
  }

  Future<Map<String, dynamic>?> _loadFoodDetail() async {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      if (args.containsKey('name') && args.containsKey('image')) {
        return args;
      }
      final idValue = args['id'] ?? args['product_id'] ?? args['productId'];
      final id = int.tryParse('$idValue');
      if (id != null) {
        return ApiService.getProductDetail(id);
      }
      return args;
    }
    return null;
  }

  Future<void> _checkout(Map<String, dynamic> item) async {
    final token = await ApiService.getToken();
    if (token == null) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Login Diperlukan'),
          content: const Text('Silahkan login terlebih dahulu untuk melakukan pemesanan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() => _isOrdering = true);
    try {
      final idValue = item['id'] ?? item['product_id'];
      final productId = int.tryParse('$idValue');
      if (productId == null) throw 'ID produk tidak valid';

      final result = await ApiService.createOrder([
        {'product_id': productId, 'quantity': _quantity},
      ]);

      if (!mounted) return;
      // Ambil order yang baru dibuat dan navigasi ke DetailsScreen
      final Map<String, dynamic>? newOrder = result['order'] as Map<String, dynamic>?;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Order berhasil!'),
          backgroundColor: AppColors.primaryGreen,
        ),
      );

      await Navigator.pushNamed(context, '/orders');

      if (newOrder != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(orderData: newOrder),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuat order: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isOrdering = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<Map<String, dynamic>?>(
      future: _foodFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            backgroundColor: isDark
                ? AppColors.backgroundDark
                : AppColors.backgroundLight,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: isDark
                ? AppColors.backgroundDark
                : AppColors.backgroundLight,
            body: Center(
              child: Text(
                'Gagal memuat detail produk',
                style: TextStyle(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
          );
        }

        final item = snapshot.data;
        if (item == null || item.isEmpty) {
          return Scaffold(
            backgroundColor: isDark
                ? AppColors.backgroundDark
                : AppColors.backgroundLight,
            body: Center(
              child: Text(
                'Data produk tidak tersedia',
                style: TextStyle(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ),
          );
        }

        final String image =
            item['image_url'] as String? ??
            item['image'] as String? ??
            'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?auto=format&fit=crop&q=80&w=600';
        final String title =
            item['name'] as String? ??
            item['title'] as String? ??
            'Avocado Blend With Topping Egg';
        final String ingredients = item['category'] is Map<String, dynamic>
            ? (item['category'] as Map<String, dynamic>)['name'] as String? ??
                  'Bread, Avocado, Leaf'
            : item['ingredients'] as String? ?? 'Bread, Avocado, Leaf';
        final num? rawPrice = item['price'] is num ? item['price'] as num : null;
        final String priceDisplay = rawPrice != null
            ? 'Rp ${rawPrice.toStringAsFixed(0)}'
            : item['price'] as String? ?? 'Rp 0';
        final String description =
            item['description'] as String? ??
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.';

        // Hitung total harga
        final double totalPrice = ((rawPrice ?? 0) * _quantity).toDouble();

        return Scaffold(
          backgroundColor: isDark
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,

          body: Stack(
            children: [
              // ── 1. Gambar Background ─────────────────────────────
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.45,
                child: image.startsWith('http')
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: isDark
                              ? AppColors.surfaceVariantDark
                              : AppColors.surfaceVariantLight,
                          child: Icon(
                            Icons.fastfood_outlined,
                            size: 80,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      )
                    : Image.asset(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: isDark
                              ? AppColors.surfaceVariantDark
                              : AppColors.surfaceVariantLight,
                          child: const Icon(Icons.fastfood_outlined, size: 80),
                        ),
                      ),
              ),

              // ── 2. Gradient overlay AppBar ───────────────────────
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 120,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                ),
              ),

              // ── 3. White/Dark Container (Konten) ─────────────────
              Positioned(
                top: MediaQuery.of(context).size.height * 0.40,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.backgroundDark
                        : AppColors.backgroundLight,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 24,
                      right: 24,
                      bottom: 120, // ruang untuk tombol bawah
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Judul ──────────────────────────────────
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontSize: 24, height: 1.2),
                        ),
                        const SizedBox(height: 8),

                        // ── Bahan / Ingredients ────────────────────
                        Text(
                          ingredients,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: 15,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                        ),
                        const SizedBox(height: 16),

                        // ── Rating & Harga ─────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.star, color: Color(0xFFFF8C00), size: 20),
                                    Icon(Icons.star, color: Color(0xFFFF8C00), size: 20),
                                    Icon(Icons.star, color: Color(0xFFFF8C00), size: 20),
                                    Icon(Icons.star, color: Color(0xFFFF8C00), size: 20),
                                    Icon(Icons.star_half, color: Color(0xFFFF8C00), size: 20),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      '4.5',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '(128 reviews)',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontSize: 14,
                                        color: isDark
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondaryLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              priceDisplay,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.priceGreen,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        Divider(
                          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                          thickness: 1.5,
                        ),
                        const SizedBox(height: 24),

                        // ── Info Nutrisi ───────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _NutritionInfo(icon: Icons.whatshot, value: '160 g', unit: 'Protein', isDark: isDark),
                            _NutritionInfo(icon: Icons.opacity, value: '45 g', unit: 'Carbs', isDark: isDark),
                            _NutritionInfo(icon: Icons.bolt, value: 'A+', unit: 'Vitamin', isDark: isDark),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // ── Deskripsi ──────────────────────────────
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            height: 1.6,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // ── Quantity Selector ──────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _QtyButton(
                              icon: Icons.remove,
                              isDark: isDark,
                              enabled: _quantity > 1,
                              onTap: () => setState(() => _quantity--),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 28),
                              child: Text(
                                '$_quantity',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            _QtyButton(
                              icon: Icons.add,
                              isDark: isDark,
                              enabled: true,
                              onTap: () => setState(() => _quantity++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── 4. Tombol Cart (Floating ke /orders) ────────────────────────
              Positioned(
                top: MediaQuery.of(context).size.height * 0.40 - 30,
                right: 32,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/orders'),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.primaryGreenLight
                          : AppColors.primaryGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: (isDark
                                  ? AppColors.primaryGreenLight
                                  : AppColors.primaryGreen)
                              .withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),

              // ── 5. Custom AppBar Overlay ─────────────────────────
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                        ),
                        const Text(
                          'Details',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border, color: Colors.white, size: 28),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── 6. Tombol Checkout di Bawah ───────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Total Harga',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                ),
                              ),
                              Text(
                                'Rp ${totalPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.priceGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _isOrdering ? null : () => _checkout(item),
                            icon: _isOrdering
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : const Icon(Icons.shopping_bag_outlined, size: 20),
                            label: Text(
                              _isOrdering ? 'Memesan...' : 'Checkout',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Quantity Button
// ─────────────────────────────────────────────────────────────────
class _QtyButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final bool enabled;
  final VoidCallback onTap;

  const _QtyButton({
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
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: enabled
              ? (isDark ? AppColors.primaryGreenLight : AppColors.primaryGreen)
              : (isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight),
          shape: BoxShape.circle,
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.primaryGreen.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Icon(
          icon,
          size: 22,
          color: enabled ? Colors.white : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Nutrition Info
// ─────────────────────────────────────────────────────────────────
class _NutritionInfo extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;
  final bool isDark;

  const _NutritionInfo({
    required this.icon,
    required this.value,
    required this.unit,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent, size: 28),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
            ),
            Text(
              unit,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
