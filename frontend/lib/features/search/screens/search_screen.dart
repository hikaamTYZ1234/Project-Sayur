import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../services/api_service.dart';
import '../../../routes/app_routes.dart';
import '../../../main.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with RouteAware {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isListView = true;
  List<dynamic> _results = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _fetchProducts(search: _searchQuery.isEmpty ? null : _searchQuery);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query == _searchQuery) return;
    setState(() => _searchQuery = query);
    _fetchProducts(search: query.isEmpty ? null : query);
  }

  Future<void> _fetchProducts({String? search}) async {
    setState(() => _isLoading = true);
    try {
      final data = await ApiService.getProducts(search: search);
      if (mounted) setState(() => _results = data);
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<dynamic> get _filteredResults => _results;

  Color _primaryColor(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  // ── Fallback widget kalau gambar gagal load ───────────────────
  Widget _imageFallback(bool isDark) {
    return Container(
      color: isDark
          ? AppColors.surfaceVariantDark
          : AppColors.surfaceVariantLight,
      child: Center(
        child: Icon(
          Icons.fastfood_outlined,
          size: 40,
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        title: Text(
          'Search',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.swap_vert,
              color: Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),
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
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _fetchProducts(
                search: _searchQuery.isEmpty ? null : _searchQuery,
              ),
              child: _buildSearchResults(context),
            ),
          ),
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
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
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
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  // ─── Filter Row ───────────────────────────────────────────────
  Widget _buildFilterRow(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = _primaryColor(context);
    final inactiveColor = isDark
        ? AppColors.iconInactiveDark
        : AppColors.iconInactiveLight;

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
                child: Icon(
                  Icons.menu,
                  color: _isListView ? primaryColor : inactiveColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => setState(() => _isListView = false),
                child: Icon(
                  Icons.grid_view,
                  color: !_isListView ? primaryColor : inactiveColor,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Hasil Pencarian ──────────────────────────────────────────
  Widget _buildSearchResults(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final results = _filteredResults;
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            const SizedBox(height: 16),
            Text(
              'No food found',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }
    return _isListView
        ? _buildListView(context, results)
        : _buildGridView(context, results);
  }

  // ─── List View ────────────────────────────────────────────────
  Widget _buildListView(BuildContext context, List<dynamic> results) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = _primaryColor(context);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index] as Map<String, dynamic>;
        final imageUrl = (item['image_url'] as String?)?.isNotEmpty == true
            ? item['image_url'] as String
            : (item['image'] as String? ?? '');
        final price = item['price'];
        final rating = item['rating'];
        final category = item['category'] as Map<String, dynamic>?;
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final routeName = Uri(
              path: AppRoutes.foodDetail,
              queryParameters: {'id': '${item['id']}'},
            ).toString();
            Navigator.pushNamed(
              context,
              routeName,
              arguments: {
                'id': item['id'],
                'title': item['name'] ?? '',
                'ingredients': category?['name'] ?? '',
                'price': '\$$price',
                'image': imageUrl,
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _imageFallback(isDark),
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
                          )
                        : _imageFallback(isDark),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        category?['name'] ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            '\$$price',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '$rating',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
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
  Widget _buildGridView(BuildContext context, List<dynamic> results) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDark ? AppColors.dividerDark : AppColors.dividerLight;
    final primaryColor = _primaryColor(context);

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index] as Map<String, dynamic>;
        final imageUrl = (item['image_url'] as String?)?.isNotEmpty == true
            ? item['image_url'] as String
            : (item['image'] as String? ?? '');
        final price = item['price'];
        final rating = item['rating'];
        final category = item['category'] as Map<String, dynamic>?;
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final routeName = Uri(
              path: AppRoutes.foodDetail,
              queryParameters: {'id': '${item['id']}'},
            ).toString();
            Navigator.pushNamed(
              context,
              routeName,
              arguments: {
                'id': item['id'],
                'title': item['name'] ?? '',
                'ingredients': category?['name'] ?? '',
                'price': '\$$price',
                'image': imageUrl,
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) =>
                                _imageFallback(isDark),
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
                          )
                        : _imageFallback(isDark),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] ?? '',
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$$price',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: primaryColor),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppColors.accent,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$rating',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
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
