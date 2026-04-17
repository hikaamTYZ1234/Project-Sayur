import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_provider.dart';

// ============================================================
//  DATA
// ============================================================
// Warna hijau khusus disesuaikan dengan gambar onboarding "Sayur"
const Color _sayurGreen = Color(0xFF3BA660);

class _ComponentItem {
  final String name;
  const _ComponentItem(this.name);
}

final List<_ComponentItem> _components = [
  const _ComponentItem('Accordion'),
  const _ComponentItem('Action Sheet'),
  const _ComponentItem('Appbar'),
  const _ComponentItem('Autocomplete'),
  const _ComponentItem('Badge'),
  const _ComponentItem('Buttons'),
  const _ComponentItem('Calendar / Date Picker'),
  const _ComponentItem('Cards'),
  const _ComponentItem('Cards Expandable'),
  const _ComponentItem('Checkbox'),
  const _ComponentItem('Chips / Tags'),
  const _ComponentItem('Color Picker'),
  const _ComponentItem('Contacts List'),
  const _ComponentItem('Content Block'),
  const _ComponentItem('Data Table'),
  const _ComponentItem('Dialog'),
  const _ComponentItem('Elevation'),
  const _ComponentItem('FAB'),
  const _ComponentItem('FAB Morph'),
  const _ComponentItem('Form Storage'),
  const _ComponentItem('Gauge'),
  const _ComponentItem('Grid / Layout Grid'),
  const _ComponentItem('Icons'),
  const _ComponentItem('Infinite Scroll'),
  const _ComponentItem('Inputs'),
  const _ComponentItem('Lazy Load'),
  const _ComponentItem('List View'),
  const _ComponentItem('List Index'),
  const _ComponentItem('Login Screen'),
  const _ComponentItem('Menu'),
  const _ComponentItem('Messages'),
  const _ComponentItem('Navbar'),
  const _ComponentItem('Notifications'),
  const _ComponentItem('Panel / Side Panels'),
  const _ComponentItem('Photo Browser'),
  const _ComponentItem('Picker'),
  const _ComponentItem('Popover'),
  const _ComponentItem('Popup'),
  const _ComponentItem('Preloader'),
  const _ComponentItem('Progress Bar'),
  const _ComponentItem('Pull To Refresh'),
  const _ComponentItem('Radio'),
  const _ComponentItem('Range Slider'),
  const _ComponentItem('Searchbar'),
  const _ComponentItem('Searchbar Expandable'),
  const _ComponentItem('Sheet Modal'),
  const _ComponentItem('Skeleton (Ghost) Layouts'),
  const _ComponentItem('Smart Select'),
  const _ComponentItem('Sortable List'),
  const _ComponentItem('Stepper'),
  const _ComponentItem('Subnavbar'),
  const _ComponentItem('Swipeout (Swipe To Delete)'),
  const _ComponentItem('Swiper Slider'),
  const _ComponentItem('Tabs'),
  const _ComponentItem('Text Editor'),
  const _ComponentItem('Timeline'),
  const _ComponentItem('Toast'),
  const _ComponentItem('Toggle'),
  const _ComponentItem('Toolbar & Tabbar'),
  const _ComponentItem('Tooltip'),
  const _ComponentItem('Treeview'),
  const _ComponentItem('Virtual List'),
  const _ComponentItem('vi - Mobile Video SSP'),
];

// ============================================================
//  ELEMENTS SCREEN (list)
// ============================================================
class ElementsScreen extends StatefulWidget {
  const ElementsScreen({super.key});

  @override
  State<ElementsScreen> createState() => _ElementsScreenState();
}

class _ElementsScreenState extends State<ElementsScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<_ComponentItem> _filteredComponents = [];

  @override
  void initState() {
    super.initState();
    _filteredComponents = _components;
  }

  void _filterComponents(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredComponents = _components;
      } else {
        _filteredComponents = _components
            .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    final Color bg = isDark ? AppColors.backgroundDark : AppColors.surfaceLight;
    final Color cardBg = isDark
        ? AppColors.surfaceDark
        : AppColors.backgroundLight;
    final Color textPrimary = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color dividerColor = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;
    final Color chevronColor = isDark
        ? const Color(0xFF5A5A5E)
        : const Color(0xFFC7C7CC);

    // Menggunakan warna hijau khusus Sayur
    final Color primaryGreen = _sayurGreen;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(textPrimary),
            if (!_isSearching)
              _buildAboutTile(cardBg, textPrimary, chevronColor, primaryGreen),
            if (!_isSearching) _buildSectionHeader('Components', primaryGreen),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _filteredComponents.isEmpty
                    ? Center(
                        child: Text(
                          'No components found',
                          style: TextStyle(color: textPrimary),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: _filteredComponents.length,
                        separatorBuilder: (_, i) => Divider(
                          color: dividerColor,
                          height: 1,
                          indent: 54,
                          endIndent: 0,
                        ),
                        itemBuilder: (_, i) => _buildComponentTile(
                          _filteredComponents[i],
                          textPrimary,
                          chevronColor,
                          primaryGreen,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(Color textPrimary) {
    if (_isSearching) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                  _filteredComponents = _components;
                });
              },
              child: Icon(Icons.arrow_back, color: textPrimary, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: _filterComponents,
                autofocus: true,
                style: TextStyle(color: textPrimary, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: textPrimary.withOpacity(0.5)),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _filterComponents('');
              },
              child: Icon(Icons.close, color: textPrimary, size: 24),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.arrow_back, color: textPrimary, size: 26),
          ),
          Text(
            'Framework7',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _isSearching = true),
            child: Icon(Icons.search, color: textPrimary, size: 26),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTile(
    Color cardBg,
    Color textPrimary,
    Color chevronColor,
    Color primaryGreen,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        leading: _buildGreenIcon(Icons.info_outline, primaryGreen),
        title: Text(
          'About Framework7',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 15, color: textPrimary),
        ),
        trailing: Icon(Icons.chevron_right, color: chevronColor, size: 20),
        onTap: () => _navigate('About Framework7'),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color primaryGreen) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryGreen,
        ),
      ),
    );
  }

  Widget _buildComponentTile(
    _ComponentItem item,
    Color textPrimary,
    Color chevronColor,
    Color primaryGreen,
  ) {
    bool isVi = item.name == 'vi - Mobile Video SSP';
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      leading: isVi
          ? _buildYellowIcon()
          : _buildGreenIcon(Icons.touch_app, primaryGreen), // Ikon seragam
      title: Text(
        item.name,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15, color: textPrimary),
      ),
      trailing: Icon(Icons.chevron_right, color: chevronColor, size: 20),
      onTap: () => _navigate(item.name),
    );
  }

  Widget _buildGreenIcon(IconData icon, Color primaryGreen) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  Widget _buildYellowIcon() {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.circle,
      ),
      child: const Text(
        'vi',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  void _navigate(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ComponentDetailScreen(componentName: name),
      ),
    );
  }
}

// ============================================================
//  COMPONENT DETAIL SCREEN
// ============================================================
class ComponentDetailScreen extends StatelessWidget {
  final String componentName;

  const ComponentDetailScreen({super.key, required this.componentName});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    final Color bg = isDark ? AppColors.backgroundDark : AppColors.surfaceLight;
    final Color cardBg = isDark
        ? AppColors.surfaceDark
        : AppColors.backgroundLight;
    final Color textPrimary = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color textSecondary = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final Color dividerColor = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;

    // Menggunakan warna hijau khusus Sayur
    final Color primaryGreen = _sayurGreen;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context, textPrimary),
            Expanded(
              child: _buildContent(
                bg,
                cardBg,
                textPrimary,
                textSecondary,
                dividerColor,
                primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Color textPrimary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: textPrimary, size: 26),
          ),
          const SizedBox(width: 16),
          Text(
            componentName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    Color bg,
    Color cardBg,
    Color textPrimary,
    Color textSecondary,
    Color divider,
    Color primaryGreen,
  ) {
    switch (componentName) {
      case 'Accordion':
        return _AccordionDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'Action Sheet':
        return _ActionSheetDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Buttons':
        return _ButtonsDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Cards':
        return _CardsDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Checkbox':
        return _CheckboxDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'Chips / Tags':
        return _ChipsDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Data Table':
        return _DataTableDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'Dialog':
        return _DialogDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'FAB':
        return _FabDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Gauge':
        return _GaugeDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Inputs':
        return _InputsDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'List View':
        return _ListViewDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'Messages':
        return _MessagesDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Notifications':
        return _NotificationsDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'Progress Bar':
        return _ProgressBarDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Radio':
        return _RadioDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'Range Slider':
        return _RangeSliderDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Searchbar':
        return _SearchbarDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'Stepper':
        return _StepperDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'Swiper Slider':
        return _SwiperDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Tabs':
        return _TabsDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      case 'Toggle':
        return _ToggleDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          divider: divider,
          primaryGreen: primaryGreen,
        );
      case 'Timeline':
        return _TimelineDemo(
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
      default:
        return _GenericDemo(
          componentName: componentName,
          bg: bg,
          cardBg: cardBg,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          primaryGreen: primaryGreen,
        );
    }
  }
}

// ============================================================
//  DEMO WIDGETS (Full Version, Themed)
// ============================================================

// ── Accordion ────────────────────────────────────────────────
class _AccordionDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, textSecondary, divider, primaryGreen;
  const _AccordionDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.primaryGreen,
  });
  @override
  State<_AccordionDemo> createState() => _AccordionDemoState();
}

class _AccordionDemoState extends State<_AccordionDemo> {
  final List<bool> _expanded = [false, false, false];
  final List<bool> _expandedOpp = [false, false, false];
  final List<String> _items = ['Lorem Ipsum', 'Nested List', 'Integer semper'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'List View Accordion',
              style: TextStyle(
                color: widget.primaryGreen,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: widget.cardBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: List.generate(_items.length, (i) {
                return Column(
                  children: [
                    ListTile(
                      leading: AnimatedRotation(
                        turns: _expanded[i] ? -0.25 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.chevron_right,
                          color: widget.textSecondary,
                        ),
                      ),
                      title: Text(
                        _items[i],
                        textAlign: TextAlign.right,
                        style: TextStyle(color: widget.textPrimary),
                      ),
                      onTap: () => setState(() => _expanded[i] = !_expanded[i]),
                    ),
                    if (_expanded[i])
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Text(
                          'This is dummy content for ${_items[i]}. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: TextStyle(
                            color: widget.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    if (i < _items.length - 1)
                      Divider(height: 1, color: widget.divider, indent: 16),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Opposite Side',
              style: TextStyle(
                color: widget.primaryGreen,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: widget.cardBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: List.generate(_items.length, (i) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        _items[i],
                        style: TextStyle(color: widget.textPrimary),
                      ),
                      trailing: AnimatedRotation(
                        turns: _expandedOpp[i] ? 0.25 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.chevron_right,
                          color: widget.textSecondary,
                        ),
                      ),
                      onTap: () =>
                          setState(() => _expandedOpp[i] = !_expandedOpp[i]),
                    ),
                    if (_expandedOpp[i])
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Text(
                          'Opposite side content for ${_items[i]}.',
                          style: TextStyle(
                            color: widget.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    if (i < _items.length - 1)
                      Divider(height: 1, color: widget.divider, indent: 16),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Action Sheet ─────────────────────────────────────────────
class _ActionSheetDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _ActionSheetDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Action Sheet Demo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: cardBg,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _sheetItem(context, Icons.share, 'Share', textPrimary),
                      _sheetItem(context, Icons.edit, 'Edit', textPrimary),
                      _sheetItem(context, Icons.delete, 'Delete', Colors.red),
                      const Divider(),
                      _sheetItem(context, Icons.close, 'Cancel', textSecondary),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
              child: const Text(
                'Open Action Sheet',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetItem(
    BuildContext ctx,
    IconData icon,
    String label,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color)),
      onTap: () => Navigator.pop(ctx),
    );
  }
}

// ── Buttons ──────────────────────────────────────────────────
class _ButtonsDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _ButtonsDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Filled Buttons', textSecondary),
          const SizedBox(height: 8),
          _btn('Green Button', primaryGreen, Colors.white),
          const SizedBox(height: 8),
          _btn('Dark Button', const Color(0xFF333333), Colors.white),
          const SizedBox(height: 20),
          _label('Outline Buttons', textSecondary),
          const SizedBox(height: 8),
          _outlineBtn('Outline Green', primaryGreen),
          const SizedBox(height: 8),
          _outlineBtn('Outline Red', Colors.red),
          const SizedBox(height: 20),
          _label('Round Buttons', textSecondary),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _roundBtn('Round', primaryGreen, Colors.white)),
              const SizedBox(width: 12),
              Expanded(
                child: _roundBtn(
                  'Outline',
                  Colors.transparent,
                  primaryGreen,
                  border: primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _label('Disabled Buttons', textSecondary),
          const SizedBox(height: 8),
          _btn('Disabled', Colors.grey.shade400, Colors.white),
        ],
      ),
    );
  }

  Widget _label(String t, Color c) => Text(
    t,
    style: TextStyle(color: c, fontSize: 13, fontWeight: FontWeight.w600),
  );

  Widget _btn(String label, Color bg, Color fg) => SizedBox(
    width: double.infinity,
    height: 46,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      child: Text(label, style: TextStyle(color: fg)),
    ),
  );

  Widget _outlineBtn(String label, Color color) => SizedBox(
    width: double.infinity,
    height: 46,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      child: Text(label, style: TextStyle(color: color)),
    ),
  );

  Widget _roundBtn(String label, Color bg, Color fg, {Color? border}) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          side: border != null ? BorderSide(color: border) : BorderSide.none,
          shape: const StadiumBorder(),
        ),
        onPressed: () {},
        child: Text(label, style: TextStyle(color: fg)),
      );
}

// ── Cards ────────────────────────────────────────────────────
class _CardsDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _CardsDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCard(
            'Simple Card',
            'This is a simple card with some dummy text content inside it.',
          ),
          const SizedBox(height: 16),
          _buildCard(
            'Card with Header & Footer',
            'Card content goes here. It can contain text, images or any widget.',
            header: 'Card Header',
            footer: 'Card Footer',
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Color Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Cards can have any background color.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    String title,
    String body, {
    String? header,
    String? footer,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                header,
                style: TextStyle(color: textSecondary, fontSize: 12),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  body,
                  style: TextStyle(color: textSecondary, fontSize: 14),
                ),
              ],
            ),
          ),
          if (footer != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                footer,
                style: TextStyle(color: textSecondary, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Checkbox ─────────────────────────────────────────────────
class _CheckboxDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, divider, primaryGreen;
  const _CheckboxDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
    required this.primaryGreen,
  });
  @override
  State<_CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> {
  final List<bool> _checked = [true, false, true, false];
  final List<String> _labels = ['Books', 'Movies', 'Food', 'Sports'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: widget.cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: List.generate(
            _labels.length,
            (i) => Column(
              children: [
                CheckboxListTile(
                  value: _checked[i],
                  onChanged: (v) => setState(() => _checked[i] = v!),
                  title: Text(
                    _labels[i],
                    style: TextStyle(color: widget.textPrimary),
                  ),
                  activeColor: widget.primaryGreen,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                if (i < _labels.length - 1)
                  Divider(height: 1, color: widget.divider, indent: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Chips ────────────────────────────────────────────────────
class _ChipsDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _ChipsDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    final chips = [
      'Design',
      'Flutter',
      'Mobile',
      'UI/UX',
      'Dart',
      'Framework7',
      'Components',
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chips / Tags',
            style: TextStyle(
              color: textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips
                .map(
                  (c) => Chip(
                    label: Text(c, style: const TextStyle(color: Colors.white)),
                    backgroundColor: primaryGreen,
                    deleteIcon: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                    onDeleted: () {},
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          Text(
            'Outline Chips',
            style: TextStyle(
              color: textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips
                .map(
                  (c) => Chip(
                    label: Text(c, style: TextStyle(color: primaryGreen)),
                    backgroundColor: Colors.transparent,
                    shape: StadiumBorder(side: BorderSide(color: primaryGreen)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ── Data Table ───────────────────────────────────────────────
class _DataTableDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, divider, primaryGreen;
  const _DataTableDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingTextStyle: TextStyle(
              color: primaryGreen,
              fontWeight: FontWeight.bold,
            ),
            dataTextStyle: TextStyle(color: textPrimary),
            dividerThickness: 1,
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Position')),
              DataColumn(label: Text('Age')),
            ],
            rows: [
              _row('Alice', 'Designer', '28'),
              _row('Bob', 'Developer', '32'),
              _row('Carol', 'Manager', '35'),
              _row('Dave', 'QA Engineer', '26'),
              _row('Eve', 'DevOps', '30'),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _row(String name, String pos, String age) => DataRow(
    cells: [DataCell(Text(name)), DataCell(Text(pos)), DataCell(Text(age))],
  );
}

// ── Dialog ───────────────────────────────────────────────────
class _DialogDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _DialogDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dialogBtn(
              context,
              'Alert Dialog',
              () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: cardBg,
                  title: Text(
                    'Alert',
                    style: TextStyle(
                      color: textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    'This is an alert dialog example.',
                    style: TextStyle(color: textSecondary),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK', style: TextStyle(color: primaryGreen)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _dialogBtn(
              context,
              'Confirm Dialog',
              () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: cardBg,
                  title: Text(
                    'Confirm',
                    style: TextStyle(
                      color: textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    'Are you sure you want to continue?',
                    style: TextStyle(color: textSecondary),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: textSecondary),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK', style: TextStyle(color: primaryGreen)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogBtn(BuildContext ctx, String label, VoidCallback onTap) =>
      SizedBox(
        width: double.infinity,
        height: 46,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: Text(label, style: const TextStyle(color: Colors.white)),
        ),
      );
}

// ── FAB ──────────────────────────────────────────────────────
class _FabDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _FabDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            'Scroll content area',
            style: TextStyle(color: textSecondary),
          ),
        ),
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton(
            backgroundColor: primaryGreen,
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          child: FloatingActionButton.extended(
            backgroundColor: primaryGreen,
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text('Create', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

// ── Gauge ────────────────────────────────────────────────────
class _GaugeDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _GaugeDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });
  @override
  State<_GaugeDemo> createState() => _GaugeDemoState();
}

class _GaugeDemoState extends State<_GaugeDemo> {
  double _value = 0.67;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              height: 180,
              child: CustomPaint(
                painter: _GaugePainter(_value, widget.primaryGreen),
                child: Center(
                  child: Text(
                    '${(_value * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: widget.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Slider(
              value: _value,
              onChanged: (v) => setState(() => _value = v),
              activeColor: widget.primaryGreen,
              inactiveColor: widget.primaryGreen.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double value;
  final Color color;
  _GaugePainter(this.value, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final bgPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708,
      value * 6.2832,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter old) => old.value != value;
}

// ── Inputs ───────────────────────────────────────────────────
class _InputsDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, divider, primaryGreen;
  const _InputsDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    final style = InputDecoration(
      filled: true,
      fillColor: cardBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: textSecondary),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryGreen),
      ),
    );
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: style.copyWith(
              hintText: 'Name',
              prefixIcon: Icon(Icons.person_outline, color: textSecondary),
            ),
            style: TextStyle(color: textPrimary),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: style.copyWith(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email_outlined, color: textSecondary),
            ),
            style: TextStyle(color: textPrimary),
          ),
          const SizedBox(height: 12),
          TextField(
            obscureText: true,
            decoration: style.copyWith(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock_outline, color: textSecondary),
            ),
            style: TextStyle(color: textPrimary),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 3,
            decoration: style.copyWith(hintText: 'Message / Textarea'),
            style: TextStyle(color: textPrimary),
          ),
        ],
      ),
    );
  }
}

// ── List View ────────────────────────────────────────────────
class _ListViewDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, divider, primaryGreen;
  const _ListViewDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      'Item One',
      'Item Two',
      'Item Three',
      'Item Four',
      'Item Five',
    ];
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            Divider(height: 1, color: divider, indent: 16),
        itemBuilder: (_, i) => ListTile(
          leading: CircleAvatar(
            backgroundColor: primaryGreen.withOpacity(0.15),
            child: Text('${i + 1}', style: TextStyle(color: primaryGreen)),
          ),
          title: Text(items[i], style: TextStyle(color: textPrimary)),
          subtitle: Text(
            'Subtitle for ${items[i]}',
            style: TextStyle(color: textSecondary, fontSize: 12),
          ),
          trailing: Icon(Icons.chevron_right, color: textSecondary),
        ),
      ),
    );
  }
}

// ── Messages ─────────────────────────────────────────────────
class _MessagesDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _MessagesDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    final msgs = [
      {'text': 'Hello! How are you?', 'me': false},
      {'text': 'I am fine, thanks! And you?', 'me': true},
      {'text': 'Doing great! What are you working on?', 'me': false},
      {'text': 'Building a Flutter app with Framework7 style.', 'me': true},
      {'text': 'That sounds awesome!', 'me': false},
    ];
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: msgs.length,
            itemBuilder: (_, i) {
              final isMe = msgs[i]['me'] as bool;
              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? primaryGreen : cardBg,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isMe ? 16 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 16),
                    ),
                  ),
                  child: Text(
                    msgs[i]['text'] as String,
                    style: TextStyle(color: isMe ? Colors.white : textPrimary),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message…',
                    hintStyle: TextStyle(color: textSecondary),
                    filled: true,
                    fillColor: cardBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  style: TextStyle(color: textPrimary),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: primaryGreen,
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Notifications ────────────────────────────────────────────
class _NotificationsDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, divider, primaryGreen;
  const _NotificationsDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'Apply Success',
        'body': 'You applied for UI Designer at Queenify.',
        'time': '10h ago',
        'unread': true,
      },
      {
        'title': 'Interview Calls',
        'body': 'Congratulations! You have interview calls.',
        'time': '9h ago',
        'unread': true,
      },
      {
        'title': 'Complete your profile',
        'body': 'Please verify your profile to continue.',
        'time': '4h ago',
        'unread': false,
      },
    ];
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      separatorBuilder: (_, __) => Divider(height: 1, color: divider),
      itemBuilder: (_, i) {
        final item = items[i];
        final unread = item['unread'] as bool;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (unread) ...[
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
              ] else
                const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['body'] as String,
                      style: TextStyle(color: textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['time'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: textPrimary,
                          ),
                        ),
                        Text(
                          'Mark as read',
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryGreen,
                            fontWeight: FontWeight.w600,
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
      },
    );
  }
}

// ── Progress Bar ─────────────────────────────────────────────
class _ProgressBarDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _ProgressBarDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });
  @override
  State<_ProgressBarDemo> createState() => _ProgressBarDemoState();
}

class _ProgressBarDemoState extends State<_ProgressBarDemo> {
  double _p1 = 0.44, _p2 = 0.7, _p3 = 0.2;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _bar('Progress 44%', _p1, widget.primaryGreen),
          const SizedBox(height: 24),
          _bar('Progress 70%', _p2, Colors.blue),
          const SizedBox(height: 24),
          _bar('Progress 20%', _p3, Colors.orange),
          const SizedBox(height: 24),
          Text(
            'Determinate',
            style: TextStyle(
              color: widget.primaryGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            color: widget.primaryGreen,
            backgroundColor: widget.primaryGreen.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  Widget _bar(String label, double v, Color color) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: widget.textPrimary, fontSize: 13),
          ),
          Text(
            '${(v * 100).toInt()}%',
            style: TextStyle(
              color: widget.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(
          value: v,
          minHeight: 8,
          color: color,
          backgroundColor: color.withOpacity(0.15),
        ),
      ),
    ],
  );
}

// ── Radio ────────────────────────────────────────────────────
class _RadioDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, divider, primaryGreen;
  const _RadioDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
    required this.primaryGreen,
  });
  @override
  State<_RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<_RadioDemo> {
  int _selected = 0;
  final List<String> _options = [
    'Option One',
    'Option Two',
    'Option Three',
    'Option Four',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(
          _options.length,
          (i) => Column(
            children: [
              RadioListTile<int>(
                value: i,
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v!),
                title: Text(
                  _options[i],
                  style: TextStyle(color: widget.textPrimary),
                ),
                activeColor: widget.primaryGreen,
              ),
              if (i < _options.length - 1)
                Divider(height: 1, color: widget.divider, indent: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Range Slider ─────────────────────────────────────────────
class _RangeSliderDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _RangeSliderDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });
  @override
  State<_RangeSliderDemo> createState() => _RangeSliderDemoState();
}

class _RangeSliderDemoState extends State<_RangeSliderDemo> {
  RangeValues _range = const RangeValues(20, 80);
  double _single = 0.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Single Slider',
            style: TextStyle(
              color: widget.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Slider(
            value: _single,
            onChanged: (v) => setState(() => _single = v),
            activeColor: widget.primaryGreen,
            inactiveColor: widget.primaryGreen.withOpacity(0.2),
          ),
          Text(
            '${(_single * 100).toInt()}',
            style: TextStyle(color: widget.textPrimary),
          ),
          const SizedBox(height: 24),
          Text(
            'Range Slider',
            style: TextStyle(
              color: widget.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          RangeSlider(
            values: _range,
            min: 0,
            max: 100,
            onChanged: (v) => setState(() => _range = v),
            activeColor: widget.primaryGreen,
            inactiveColor: widget.primaryGreen.withOpacity(0.2),
          ),
          Text(
            '${_range.start.toInt()} – ${_range.end.toInt()}',
            style: TextStyle(color: widget.textPrimary),
          ),
        ],
      ),
    );
  }
}

// ── Searchbar ────────────────────────────────────────────────
class _SearchbarDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, divider, primaryGreen;
  const _SearchbarDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
    required this.primaryGreen,
  });
  @override
  State<_SearchbarDemo> createState() => _SearchbarDemoState();
}

class _SearchbarDemoState extends State<_SearchbarDemo> {
  final _ctrl = TextEditingController();
  final _all = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
  ];
  List<String> _filtered = [];
  @override
  void initState() {
    super.initState();
    _filtered = List.from(_all);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _ctrl,
            onChanged: (v) => setState(
              () => _filtered = _all
                  .where((e) => e.toLowerCase().contains(v.toLowerCase()))
                  .toList(),
            ),
            decoration: InputDecoration(
              hintText: 'Search…',
              hintStyle: TextStyle(color: widget.textPrimary.withOpacity(0.4)),
              prefixIcon: Icon(Icons.search, color: widget.primaryGreen),
              filled: true,
              fillColor: widget.cardBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: widget.primaryGreen),
              ),
            ),
            style: TextStyle(color: widget.textPrimary),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.cardBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                itemCount: _filtered.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: widget.divider, indent: 16),
                itemBuilder: (_, i) => ListTile(
                  title: Text(
                    _filtered[i],
                    style: TextStyle(color: widget.textPrimary),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: widget.primaryGreen,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stepper ──────────────────────────────────────────────────
class _StepperDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, divider, primaryGreen;
  const _StepperDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
    required this.primaryGreen,
  });
  @override
  State<_StepperDemo> createState() => _StepperDemoState();
}

class _StepperDemoState extends State<_StepperDemo> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      onStepContinue: () => setState(() {
        if (_currentStep < 2) _currentStep++;
      }),
      onStepCancel: () => setState(() {
        if (_currentStep > 0) _currentStep--;
      }),
      connectorColor: WidgetStateProperty.all(widget.primaryGreen),
      steps: [
        Step(
          title: Text('Account', style: TextStyle(color: widget.textPrimary)),
          content: Text(
            'Enter your account details.',
            style: TextStyle(color: widget.textPrimary),
          ),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Profile', style: TextStyle(color: widget.textPrimary)),
          content: Text(
            'Fill in your profile information.',
            style: TextStyle(color: widget.textPrimary),
          ),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Confirm', style: TextStyle(color: widget.textPrimary)),
          content: Text(
            'Review and confirm your details.',
            style: TextStyle(color: widget.textPrimary),
          ),
          isActive: _currentStep >= 2,
        ),
      ],
    );
  }
}

// ── Swiper Slider ────────────────────────────────────────────
class _SwiperDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _SwiperDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });
  @override
  State<_SwiperDemo> createState() => _SwiperDemoState();
}

class _SwiperDemoState extends State<_SwiperDemo> {
  final PageController _ctrl = PageController();
  int _page = 0;
  late List<Color> _colors;
  final _labels = ['Slide 1', 'Slide 2', 'Slide 3', 'Slide 4', 'Slide 5'];

  @override
  void initState() {
    super.initState();
    _colors = [
      widget.primaryGreen,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _ctrl,
            onPageChanged: (i) => setState(() => _page = i),
            itemCount: _colors.length,
            itemBuilder: (_, i) => Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _colors[i],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  _labels[i],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _colors.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _page == i ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _page == i
                    ? widget.primaryGreen
                    : widget.primaryGreen.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Tabs ─────────────────────────────────────────────────────
class _TabsDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _TabsDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });
  @override
  State<_TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<_TabsDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tc;
  @override
  void initState() {
    super.initState();
    _tc = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tc,
          labelColor: widget.primaryGreen,
          unselectedLabelColor: widget.textSecondary,
          indicatorColor: widget.primaryGreen,
          tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tc,
            children: [
              _tabContent('Content for Tab 1', widget.textPrimary),
              _tabContent('Content for Tab 2', widget.textPrimary),
              _tabContent('Content for Tab 3', widget.textPrimary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabContent(String text, Color color) => Center(
    child: Text(text, style: TextStyle(color: color, fontSize: 16)),
  );
}

// ── Toggle ───────────────────────────────────────────────────
class _ToggleDemo extends StatefulWidget {
  final Color bg, cardBg, textPrimary, divider, primaryGreen;
  const _ToggleDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
    required this.primaryGreen,
  });
  @override
  State<_ToggleDemo> createState() => _ToggleDemoState();
}

class _ToggleDemoState extends State<_ToggleDemo> {
  final List<bool> _vals = [true, false, true, false];
  final List<String> _labels = [
    'Wi-Fi',
    'Bluetooth',
    'Notifications',
    'Dark Mode',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(
          _labels.length,
          (i) => Column(
            children: [
              SwitchListTile(
                value: _vals[i],
                onChanged: (v) => setState(() => _vals[i] = v),
                title: Text(
                  _labels[i],
                  style: TextStyle(color: widget.textPrimary),
                ),
                activeColor: widget.primaryGreen,
              ),
              if (i < _labels.length - 1)
                Divider(height: 1, color: widget.divider, indent: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Timeline ─────────────────────────────────────────────────
class _TimelineDemo extends StatelessWidget {
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _TimelineDemo({
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': 'Order Placed',
        'time': '10:00 AM',
        'desc': 'Your order has been placed.',
      },
      {
        'title': 'Processing',
        'time': '10:30 AM',
        'desc': 'Order is being processed.',
      },
      {
        'title': 'Shipped',
        'time': '12:00 PM',
        'desc': 'Order shipped via courier.',
      },
      {
        'title': 'Out for Delivery',
        'time': '03:00 PM',
        'desc': 'Driver is on the way.',
      },
      {
        'title': 'Delivered',
        'time': '05:00 PM',
        'desc': 'Package delivered successfully.',
      },
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: events.length,
      itemBuilder: (_, i) {
        final e = events[i];
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: primaryGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (i < events.length - 1)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: primaryGreen.withOpacity(0.3),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ),
                      Text(
                        e['time']!,
                        style: TextStyle(color: primaryGreen, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        e['desc']!,
                        style: TextStyle(color: textSecondary, fontSize: 13),
                      ),
                    ],
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

// ── Generic Fallback ─────────────────────────────────────────
class _GenericDemo extends StatelessWidget {
  final String componentName;
  final Color bg, cardBg, textPrimary, textSecondary, primaryGreen;
  const _GenericDemo({
    required this.componentName,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: primaryGreen.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.widgets_outlined,
                color: primaryGreen,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              componentName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'This is a demo of the $componentName component.\nIn a real implementation, the full interactive preview would be shown here.',
              style: TextStyle(color: textSecondary, fontSize: 14, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(200, 46),
              ),
              onPressed: () {},
              child: const Text(
                'Try it out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
