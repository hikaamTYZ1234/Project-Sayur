import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart'; 

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ── Ambil data dari argument ────────────────────────────────
    final Map<String, dynamic>? item =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String image      = item?['image']       ?? 'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?auto=format&fit=crop&q=80&w=600';
    final String title      = item?['title']       ?? 'Avocado Blend With Topping Egg';
    final String ingredients = item?['ingredients'] ?? 'Bread, Avocado, Leaf';
    final String price      = item?['price']       ?? '\$5.7';

    return Scaffold(
      // ── Background ikut theme ──────────────────────────────────
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,

      body: Stack(
        children: [
          // ── 1. Gambar Background ─────────────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.network(
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
            ),
          ),

          // ── 2. Gradient overlay AppBar ───────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            height: 120,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end:   Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
            ),
          ),

          // ── 3. White/Dark Container (Konten) ─────────────────
          Positioned(
            top:    MediaQuery.of(context).size.height * 0.40,
            left:   0,
            right:  0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                // ✅ Warna container ikut theme
                color: isDark
                    ? AppColors.backgroundDark
                    : AppColors.backgroundLight,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 40, left: 24, right: 24, bottom: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Judul ──────────────────────────────────
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 24,
                        height:   1.2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ── Bahan / Ingredients ────────────────────
                    Text(
                      ingredients,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                            // Bintang
                            Row(
                              children: const [
                                Icon(Icons.star,      color: Color(0xFFFF8C00), size: 20),
                                Icon(Icons.star,      color: Color(0xFFFF8C00), size: 20),
                                Icon(Icons.star,      color: Color(0xFFFF8C00), size: 20),
                                Icon(Icons.star,      color: Color(0xFFFF8C00), size: 20),
                                Icon(Icons.star_half, color: Color(0xFFFF8C00), size: 20),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  '4.5',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 16,
                                  ),
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

                        // Harga — pakai priceGreen sesuai desain
                        Text(
                          price,
                          style: TextStyle(
                            fontSize:   28,
                            fontWeight: FontWeight.bold,
                            color:      AppColors.priceGreen,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Divider(
                      color: isDark
                          ? AppColors.dividerDark
                          : AppColors.dividerLight,
                      thickness: 1.5,
                    ),
                    const SizedBox(height: 24),

                    // ── Info Nutrisi ───────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _NutritionInfo(
                          icon:  Icons.whatshot,
                          value: '160 g',
                          unit:  'Protein',
                          isDark: isDark,
                        ),
                        _NutritionInfo(
                          icon:  Icons.opacity,
                          value: '45 g',
                          unit:  'Carbs',
                          isDark: isDark,
                        ),
                        _NutritionInfo(
                          icon:  Icons.bolt,
                          value: 'A+',
                          unit:  'Vitamin',
                          isDark: isDark,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // ── Deskripsi ──────────────────────────────
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        height:   1.6,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── 4. Tombol Cart (Floating) ────────────────────────
          Positioned(
            top:   MediaQuery.of(context).size.height * 0.40 - 30,
            right: 32,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/orders'),
              child: Container(
                width:  60,
                height: 60,
                decoration: BoxDecoration(
                  // ✅ Warna tombol ikut theme (hijau di light, hijau muda di dark)
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
                  size:  28,
                ),
              ),
            ),
          ),

          // ── 5. Custom AppBar Overlay ─────────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical:   8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Back
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size:  28,
                      ),
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                    ),

                    // Judul AppBar
                    const Text(
                      'Details',
                      style: TextStyle(
                        color:      Colors.white,
                        fontSize:   20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Tombol Bookmark
                    IconButton(
                      icon: const Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                        size:  28,
                      ),
                      onPressed: () {
                        // TODO: bookmark
                      },
                    ),
                  ],
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
//  WIDGET: Nutrition Info
// ─────────────────────────────────────────────────────────────────
class _NutritionInfo extends StatelessWidget {
  final IconData icon;
  final String   value;
  final String   unit;
  final bool     isDark;

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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              unit,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}