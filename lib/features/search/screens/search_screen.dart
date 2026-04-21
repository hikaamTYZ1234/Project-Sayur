import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isListView = true;

  // ── URL gambar diperbaiki — pakai yang stabil ─────────────────
  final List<Map<String, dynamic>> _allResults = [
    {
      'title': 'Avocado Blend with Topping Egg',
      'ingredients': 'Bread, Avocado, Leaf',
      'price': '\$5.8',
      'originalPrice': '\$9.9',
      'rating': '3.6',
      'image': 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=400&q=80',
    },
    {
      'title': 'Slices of Avocados at Original Bread',
      'ingredients': 'Bread, Avocado, Leaf',
      'price': '\$5.8',
      'originalPrice': '\$9.9',
      'rating': '3.6',
      'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80',
    },
    {
      'title': 'Green Avocados with Oats Bread',
      'ingredients': 'Bread, Avocado, Leaf',
      'price': '\$5.8',
      'originalPrice': '\$9.9',
      'rating': '3.6',
      'image': 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=400&q=80',
    },
    {
      'title': 'Basil Leaves and Avocado on Sliced Bread',
      'ingredients': 'Bread, Avocado, Leaf',
      'price': '\$5.8',
      'originalPrice': '\$9.9',
      'rating': '3.6',
      'image': 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=400&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredResults {
    if (_searchQuery.isEmpty) return _allResults;
    return _allResults.where((item) {
      final title       = item['title'].toString().toLowerCase();
      final ingredients = item['ingredients'].toString().toLowerCase();
      return title.contains(_searchQuery) || ingredients.contains(_searchQuery);
    }).toList();
  }

  Color _primaryColor(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  // ── Fallback widget kalau gambar gagal load ───────────────────
  Widget _imageFallback(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
      child: Center(
        child: Icon(
          Icons.fastfood_outlined,
          size: 40,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Search',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.swap_vert,
                color: Theme.of(context).colorScheme.onSurface, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildSearchBar(context),
          const SizedBox(height: 24),
          _buildFilterRow(context),
          const SizedBox(height: 16),
          Expanded(child: _buildSearchResults(context)),
        ],
      ),
    );
  }

  // ─── Search Bar ───────────────────────────────────────────────
  Widget _buildSearchBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceVariantDark
              : AppColors.surfaceVariantLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: _searchController,
          style: TextStyle(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            hintText: 'Find food here...',
            hintStyle: TextStyle(
              color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
              fontSize: 15,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
              size: 24,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.close,
                        size: 18,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight),
                    onPressed: () => _searchController.clear(),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  // ─── Filter Row ───────────────────────────────────────────────
  Widget _buildFilterRow(BuildContext context) {
    final isDark      = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = _primaryColor(context);
    final inactiveColor =
        isDark ? AppColors.iconInactiveDark : AppColors.iconInactiveLight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_filteredResults.length} Food found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _isListView = true),
                child: Icon(Icons.menu,
                    color: _isListView ? primaryColor : inactiveColor,
                    size: 28),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => setState(() => _isListView = false),
                child: Icon(Icons.grid_view,
                    color: !_isListView ? primaryColor : inactiveColor,
                    size: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Hasil Pencarian ──────────────────────────────────────────
  Widget _buildSearchResults(BuildContext context) {
    final results = _filteredResults;
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded,
                size: 64,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight),
            const SizedBox(height: 16),
            Text('No food found',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      );
    }
    return _isListView
        ? _buildListView(context, results)
        : _buildGridView(context, results);
  }

  // ─── List View ────────────────────────────────────────────────
  Widget _buildListView(
      BuildContext context, List<Map<String, dynamic>> results) {
    final isDark       = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = _primaryColor(context);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () =>
              Navigator.pushNamed(context, '/food-detail', arguments: item),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Gambar — fixed size, tidak overflow ────────
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width:  100,
                    height: 100,
                    child: Image.network(
                      item['image'],
                      width:  100,
                      height: 100,
                      fit:    BoxFit.cover,
                      // ✅ Fallback kalau gambar gagal load
                      errorBuilder: (_, __, ___) => _imageFallback(isDark),
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: isDark
                              ? AppColors.surfaceVariantDark
                              : AppColors.surfaceVariantLight,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isDark
                                  ? AppColors.primaryGreenLight
                                  : AppColors.primaryGreen,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // ── Info produk — Expanded agar tidak overflow ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['ingredients'],
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          // Harga diskon
                          Text(
                            item['price'],
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color:      primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize:   18,
                                ),
                          ),
                          const SizedBox(width: 8),
                          // Harga asli (coret)
                          Text(
                            item['originalPrice'],
                            style: TextStyle(
                              fontSize:   14,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const Spacer(),
                          // Badge rating
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.white, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  item['rating'],
                                  style: const TextStyle(
                                    color:      Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:   13,
                                  ),
                                ),
                              ],
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
      },
    );
  }

  // ─── Grid View ────────────────────────────────────────────────
  Widget _buildGridView(
      BuildContext context, List<Map<String, dynamic>> results) {
    final isDark       = Theme.of(context).brightness == Brightness.dark;
    final cardColor    = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor  = isDark ? AppColors.dividerDark : AppColors.dividerLight;
    final primaryColor = _primaryColor(context);

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:   2,
        crossAxisSpacing: 16,
        mainAxisSpacing:  16,
        childAspectRatio: 0.75,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () =>
              Navigator.pushNamed(context, '/food-detail', arguments: item),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border:       Border.all(color: borderColor),
              color:        cardColor,
              boxShadow: [
                BoxShadow(
                  color:       Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                  spreadRadius: 1,
                  blurRadius:  4,
                  offset:      const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Gambar grid — Expanded agar proporsional ────
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16)),
                    child: Image.network(
                      item['image'],
                      fit:   BoxFit.cover,
                      width: double.infinity,
                      // ✅ Fallback
                      errorBuilder: (_, __, ___) => _imageFallback(isDark),
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: isDark
                              ? AppColors.surfaceVariantDark
                              : AppColors.surfaceVariantLight,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isDark
                                  ? AppColors.primaryGreenLight
                                  : AppColors.primaryGreen,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['price'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: primaryColor),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: AppColors.accent, size: 14),
                              const SizedBox(width: 4),
                              Text(item['rating'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge),
                            ],
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
      },
    );
  }
}