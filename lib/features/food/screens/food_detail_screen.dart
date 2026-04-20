import 'package:flutter/material.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  final Color primaryGreen = const Color(0xFF2E8B57);

  @override
  Widget build(BuildContext context) {
    // Ambil data item yang dikirim dari halaman sebelumnya
    final Map<String, dynamic>? item = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Fallback data jika tidak ada argument
    final String image = item?['image'] ?? 'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?auto=format&fit=crop&q=80&w=600';
    final String title = item?['title'] ?? 'Avocado Blend With Topping Egg';
    final String ingredients = item?['ingredients'] ?? 'Bread, Avocado, Leaf';
    final String price = item?['price'] ?? '\$5.7';
    // const rating = '4.5';
    // const reviews = '(128 reviews)';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Image Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          
          // 2. Gradient overlay agar teks appbar terbaca
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

          // 3. White Container (Content)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.40,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle / Ingredients
                    Text(
                      ingredients,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Rating & Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star, color: Color(0xFFFF8C00), size: 20),
                                const Icon(Icons.star, color: Color(0xFFFF8C00), size: 20),
                                const Icon(Icons.star, color: Color(0xFFFF8C00), size: 20),
                                const Icon(Icons.star, color: Color(0xFFFF8C00), size: 20),
                                const Icon(Icons.star_half, color: Color(0xFFFF8C00), size: 20),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '(128 reviews)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.grey.shade200, thickness: 1.5),
                    const SizedBox(height: 24),
                    // Nutrition Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutritionInfo(Icons.whatshot, '160 g', 'Protein'),
                        _buildNutritionInfo(Icons.opacity, '45 g', 'Carbs'), // Atau ikon lain yang mirip
                        _buildNutritionInfo(Icons.bolt, 'A+', 'Vitamin'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Description
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 4. Cart Floating Button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.40 - 30,
            right: 32,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/orders');
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: primaryGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryGreen.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),
              ),
            ),
          ),

          // 5. Custom App Bar Overlays
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border, color: Colors.white, size: 28),
                      onPressed: () {
                        // Bookmark action
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

  Widget _buildNutritionInfo(IconData icon, String value, String unit) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFF7E00), size: 28), // Ikon dan warna oranye
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              unit,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
