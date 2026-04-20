import 'package:flutter/material.dart';
import '../../main_menu/screens/main_menu_drawer.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme_provider.dart';
import '../../../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Warna hijau utama yang disesuaikan dari desain
  final Color primaryGreen = const Color(0xFF2E8B57); 

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final iconColor = isDark ? AppColors.iconDark : AppColors.iconLight;

    return Scaffold(
      backgroundColor: bgColor,
      drawer: const MainMenuDrawer(activeIndex: 0),
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: iconColor, size: 28),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }
        ),
        title: Text(
          'Home',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Stack(
                children: [
                  Icon(Icons.notifications_none, color: primaryGreen, size: 30),
                  Positioned(
                    top: 2,
                    right: 4,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade500,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Bagian Search Bar
            _buildSearchBar(context, isDark),
            const SizedBox(height: 30),
            // Bagian Ingredients
            _buildSectionHeader(context, 'Ingredients', isDark),
            const SizedBox(height: 16),
            _buildIngredientsGrid(context, isDark),
            const SizedBox(height: 30),
            // Bagian Promo Banners
            _buildPromoBanners(context, isDark),
            const SizedBox(height: 30),
            // Bagian Top Rated Menus
            _buildSectionHeader(context, 'Top Rated Menus', isDark),
            const SizedBox(height: 16),
            _buildTopRatedMenus(context, isDark),
            const SizedBox(height: 40), // Jarak di paling bawah
          ],
        ),
      ),
    );
  }

  // Widget Search Bar
  Widget _buildSearchBar(BuildContext context, bool isDark) {
    final bgColor = isDark ? AppColors.surfaceVariantDark : const Color(0xFFF6F6F6);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          style: TextStyle(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
          decoration: InputDecoration(
            hintText: 'Find food here...',
            hintStyle: TextStyle(color: isDark ? AppColors.textSecondaryDark : Colors.grey, fontSize: 15),
            prefixIcon: Icon(Icons.search, color: isDark ? AppColors.textSecondaryDark : Colors.grey, size: 24),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  // Widget Header untuk List (Title + Arrow Icon)
  Widget _buildSectionHeader(BuildContext context, String title, bool isDark) {
    final textColor = isDark ? AppColors.textPrimaryDark : Colors.black87;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryGreen, width: 1.5),
            ),
            child: Icon(Icons.arrow_forward_ios, size: 12, color: primaryGreen),
          ),
        ],
      ),
    );
  }

  // Widget Grid View untuk List Ingredient (berisi emoji sebagai representasi)
  Widget _buildIngredientsGrid(BuildContext context, bool isDark) {
    // Data dummy bahan (menggunakan emoji untuk purwarupa cepat)
    final List<Map<String, String>> ingredients = [
      {'name': 'Carrot', 'icon': '🥕'},
      {'name': 'Tomato', 'icon': '🍅'},
      {'name': 'Coconut', 'icon': '🥥'},
      {'name': 'Grapes', 'icon': '🍇'},
      {'name': 'Aubergine', 'icon': '🍆'},
      {'name': 'Banana', 'icon': '🍌'},
      {'name': 'Strawberry', 'icon': '🍓'},
      {'name': 'Corn', 'icon': '🌽'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ingredients.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,     // 4 item per baris
          childAspectRatio: 0.8, // Rasio tinggi kotak
          crossAxisSpacing: 12,  // Jarak antar kolom
          mainAxisSpacing: 16,   // Jarak antar baris
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
            borderRadius: BorderRadius.circular(16),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? AppColors.dividerDark : Colors.grey.shade100, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.black26 : Colors.grey.shade100,
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      ingredients[index]['icon']!,
                      style: const TextStyle(fontSize: 34),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ingredients[index]['name']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textSecondaryDark : Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget untuk List Horizontal Promo Banners
  Widget _buildPromoBanners(BuildContext context, bool isDark) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/food-detail');
            },
            child: Container(
              width: 310,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                    // Placeholder gambar promo sehat dari Unsplash
                    'https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&q=80&w=600',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      isDark ? AppColors.backgroundDark.withOpacity(0.9) : Colors.white.withOpacity(0.95),
                      isDark ? AppColors.backgroundDark.withOpacity(0.0) : Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : Colors.black87,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(text: 'Fresh Inside,\n'),
                          TextSpan(
                            text: 'Healthy Outside',
                            style: TextStyle(color: primaryGreen),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget untuk List Horizontal Menu Teratas
  Widget _buildTopRatedMenus(BuildContext context, bool isDark) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/food-detail');
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    index % 2 == 0
                        ? 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&q=80&w=400'
                        : 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&q=80&w=400',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
