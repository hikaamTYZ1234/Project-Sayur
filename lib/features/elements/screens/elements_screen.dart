import 'package:flutter/material.dart';

// ============================================================
//  DATA
// ============================================================
const _kGreen = Color(0xFF2ECC71);
const _kGreenDark = Color(0xFF27AE60);

class _ComponentItem {
  final String name;
  const _ComponentItem(this.name);
}

final List<_ComponentItem> _components = [
  _ComponentItem('Accordion'),
  _ComponentItem('Action Sheet'),
  _ComponentItem('Appbar'),
  _ComponentItem('Autocomplete'),
  _ComponentItem('Badge'),
  _ComponentItem('Buttons'),
  _ComponentItem('Calendar / Date Picker'),
  _ComponentItem('Cards'),
  _ComponentItem('Cards Expandable'),
  _ComponentItem('Checkbox'),
  _ComponentItem('Chips / Tags'),
  _ComponentItem('Color Picker'),
  _ComponentItem('Contacts List'),
  _ComponentItem('Content Block'),
  _ComponentItem('Data Table'),
  _ComponentItem('Dialog'),
  _ComponentItem('Elevation'),
  _ComponentItem('FAB'),
  _ComponentItem('FAB Morph'),
  _ComponentItem('Form Storage'),
  _ComponentItem('Gauge'),
  _ComponentItem('Grid / Layout Grid'),
  _ComponentItem('Icons'),
  _ComponentItem('Infinite Scroll'),
  _ComponentItem('Inputs'),
  _ComponentItem('Lazy Load'),
  _ComponentItem('List View'),
  _ComponentItem('List Index'),
  _ComponentItem('Login Screen'),
  _ComponentItem('Menu'),
  _ComponentItem('Messages'),
  _ComponentItem('Navbar'),
  _ComponentItem('Notifications'),
  _ComponentItem('Panel / Side Panels'),
  _ComponentItem('Photo Browser'),
  _ComponentItem('Picker'),
  _ComponentItem('Popover'),
  _ComponentItem('Popup'),
  _ComponentItem('Preloader'),
  _ComponentItem('Progress Bar'),
  _ComponentItem('Pull To Refresh'),
  _ComponentItem('Radio'),
  _ComponentItem('Range Slider'),
  _ComponentItem('Searchbar'),
  _ComponentItem('Searchbar Expandable'),
  _ComponentItem('Sheet Modal'),
  _ComponentItem('Skeleton (Ghost) Layouts'),
  _ComponentItem('Smart Select'),
  _ComponentItem('Sortable List'),
  _ComponentItem('Stepper'),
  _ComponentItem('Subnavbar'),
  _ComponentItem('Swipeout (Swipe To Delete)'),
  _ComponentItem('Swiper Slider'),
  _ComponentItem('Tabs'),
  _ComponentItem('Text Editor'),
  _ComponentItem('Timeline'),
  _ComponentItem('Toast'),
  _ComponentItem('Toggle'),
  _ComponentItem('Toolbar & Tabbar'),
  _ComponentItem('Tooltip'),
  _ComponentItem('Treeview'),
  _ComponentItem('Virtual List'),
  _ComponentItem('vi - Mobile Video SSP'),
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
  bool _isDarkMode = false;

  Color get _bg =>
      _isDarkMode ? const Color(0xFF121212) : const Color(0xFFF2F2F7);
  Color get _cardBg => _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
  Color get _textPrimary =>
      _isDarkMode ? Colors.white : const Color(0xFF1A1A1A);
  Color get _textSecondary =>
      _isDarkMode ? const Color(0xFF9E9E9E) : const Color(0xFF8E8E93);
  Color get _divider =>
      _isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFE5E5EA);
  Color get _chevron =>
      _isDarkMode ? const Color(0xFF5A5A5E) : const Color(0xFFC7C7CC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildAboutTile(),
            _buildSectionHeader('Components'),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _components.length,
                  separatorBuilder: (_, i) => Divider(
                    color: _divider,
                    height: 1,
                    indent: 16,
                    endIndent: 0,
                  ),
                  itemBuilder: (_, i) => _buildComponentTile(_components[i]),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.search, color: _textPrimary, size: 24),
          ),
          const Spacer(),
          Text(
            'Framework7',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _isDarkMode = !_isDarkMode),
                child: Icon(
                  _isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  color: _textPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: _textPrimary, size: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTile() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        leading: Icon(Icons.chevron_left, color: _chevron, size: 20),
        title: Text(
          'About Framework7',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15, color: _textPrimary),
        ),
        trailing: _buildGreenIcon(Icons.info_outline),
        onTap: () => _navigate('About Framework7'),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 12, bottom: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _kGreen,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComponentTile(_ComponentItem item) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      leading: Icon(Icons.chevron_left, color: _chevron, size: 20),
      title: Text(
        item.name,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 15, color: _textPrimary),
      ),
      trailing: _buildGreenIcon(Icons.code),
      onTap: () => _navigate(item.name),
    );
  }

  Widget _buildGreenIcon(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: _kGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  void _navigate(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ComponentDetailScreen(componentName: name, isDarkMode: _isDarkMode),
      ),
    );
  }
}

// ============================================================
//  COMPONENT DETAIL SCREEN
// ============================================================
class ComponentDetailScreen extends StatefulWidget {
  final String componentName;
  final bool isDarkMode;

  const ComponentDetailScreen({
    super.key,
    required this.componentName,
    required this.isDarkMode,
  });

  @override
  State<ComponentDetailScreen> createState() => _ComponentDetailScreenState();
}

class _ComponentDetailScreenState extends State<ComponentDetailScreen> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  Color get _bg =>
      _isDarkMode ? const Color(0xFF121212) : const Color(0xFFF2F2F7);
  Color get _cardBg => _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
  Color get _textPrimary =>
      _isDarkMode ? Colors.white : const Color(0xFF1A1A1A);
  Color get _textSecondary =>
      _isDarkMode ? const Color(0xFF9E9E9E) : const Color(0xFF6B6B6B);
  Color get _divider =>
      _isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFE5E5EA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(
            widget.componentName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: _textPrimary, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (widget.componentName) {
      case 'Accordion':
        return _AccordionDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
          divider: _divider,
        );
      case 'Action Sheet':
        return _ActionSheetDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Buttons':
        return _ButtonsDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Cards':
        return _CardsDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Checkbox':
        return _CheckboxDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          divider: _divider,
        );
      case 'Chips / Tags':
        return _ChipsDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Data Table':
        return _DataTableDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
          divider: _divider,
        );
      case 'Dialog':
        return _DialogDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'FAB':
        return _FabDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Gauge':
        return _GaugeDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Inputs':
        return _InputsDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
          divider: _divider,
        );
      case 'List View':
        return _ListViewDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
          divider: _divider,
        );
      case 'Messages':
        return _MessagesDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Notifications':
        return _NotificationsDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
          divider: _divider,
        );
      case 'Progress Bar':
        return _ProgressBarDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Radio':
        return _RadioDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          divider: _divider,
        );
      case 'Range Slider':
        return _RangeSliderDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Searchbar':
        return _SearchbarDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          divider: _divider,
        );
      case 'Stepper':
        return _StepperDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          divider: _divider,
        );
      case 'Swiper Slider':
        return _SwiperDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Tabs':
        return _TabsDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      case 'Toggle':
        return _ToggleDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          divider: _divider,
        );
      case 'Timeline':
        return _TimelineDemo(
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
      default:
        return _GenericDemo(
          componentName: widget.componentName,
          isDarkMode: _isDarkMode,
          bg: _bg,
          cardBg: _cardBg,
          textPrimary: _textPrimary,
          textSecondary: _textSecondary,
        );
    }
  }
}

// ============================================================
//  DEMO WIDGETS
// ============================================================

// ── Accordion ────────────────────────────────────────────────
class _AccordionDemo extends StatefulWidget {
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary, divider;
  const _AccordionDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
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
                color: _kGreen,
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
                          'This is dummy content for ${_items[i]}. '
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
                color: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _ActionSheetDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
                backgroundColor: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _ButtonsDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
          _btn('Green Button', _kGreen, Colors.white),
          const SizedBox(height: 8),
          _btn('Dark Button', const Color(0xFF333333), Colors.white),
          const SizedBox(height: 20),
          _label('Outline Buttons', textSecondary),
          const SizedBox(height: 8),
          _outlineBtn('Outline Green', _kGreen),
          const SizedBox(height: 8),
          _outlineBtn('Outline Red', Colors.red),
          const SizedBox(height: 20),
          _label('Round Buttons', textSecondary),
          const SizedBox(height: 8),
          Row(
            children: [
              _roundBtn('Round', _kGreen, Colors.white),
              const SizedBox(width: 12),
              _roundBtn(
                'Outline',
                Colors.transparent,
                _kGreen,
                border: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _CardsDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
              color: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, divider;
  const _CheckboxDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
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
                  activeColor: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _ChipsDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
                    backgroundColor: _kGreen,
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
                    label: Text(c, style: const TextStyle(color: _kGreen)),
                    backgroundColor: Colors.transparent,
                    shape: const StadiumBorder(
                      side: BorderSide(color: _kGreen),
                    ),
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary, divider;
  const _DataTableDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
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
              color: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _DialogDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
                      child: const Text('OK', style: TextStyle(color: _kGreen)),
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
                      child: const Text('OK', style: TextStyle(color: _kGreen)),
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
            backgroundColor: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _FabDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
            backgroundColor: _kGreen,
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          child: FloatingActionButton.extended(
            backgroundColor: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _GaugeDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
                painter: _GaugePainter(_value),
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
              activeColor: _kGreen,
              inactiveColor: _kGreen.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double value;
  _GaugePainter(this.value);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final bgPaint = Paint()
      ..color = _kGreen.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final fgPaint = Paint()
      ..color = _kGreen
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary, divider;
  const _InputsDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
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
        borderSide: const BorderSide(color: _kGreen),
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary, divider;
  const _ListViewDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
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
            backgroundColor: _kGreen.withOpacity(0.15),
            child: Text('${i + 1}', style: const TextStyle(color: _kGreen)),
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _MessagesDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
                    color: isMe ? _kGreen : cardBg,
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
                backgroundColor: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary, divider;
  const _NotificationsDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
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
                  decoration: const BoxDecoration(
                    color: _kGreen,
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
                        const Text(
                          'Mark as read',
                          style: TextStyle(
                            fontSize: 12,
                            color: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _ProgressBarDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
          _bar('Progress 44%', _p1, _kGreen),
          const SizedBox(height: 24),
          _bar('Progress 70%', _p2, Colors.blue),
          const SizedBox(height: 24),
          _bar('Progress 20%', _p3, Colors.orange),
          const SizedBox(height: 24),
          const Text(
            'Determinate',
            style: TextStyle(color: _kGreen, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
            color: _kGreen,
            backgroundColor: Color(0xFFE0F7EA),
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
            style: const TextStyle(color: _kGreen, fontWeight: FontWeight.bold),
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, divider;
  const _RadioDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
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
                activeColor: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _RangeSliderDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
            activeColor: _kGreen,
            inactiveColor: _kGreen.withOpacity(0.2),
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
            activeColor: _kGreen,
            inactiveColor: _kGreen.withOpacity(0.2),
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, divider;
  const _SearchbarDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
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
              prefixIcon: const Icon(Icons.search, color: _kGreen),
              filled: true,
              fillColor: widget.cardBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _kGreen),
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
                  trailing: const Icon(Icons.chevron_right, color: _kGreen),
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, divider;
  const _StepperDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
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
      connectorColor: MaterialStateProperty.all(_kGreen),
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _SwiperDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
  });
  @override
  State<_SwiperDemo> createState() => _SwiperDemoState();
}

class _SwiperDemoState extends State<_SwiperDemo> {
  final PageController _ctrl = PageController();
  int _page = 0;
  final _colors = [
    _kGreen,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];
  final _labels = ['Slide 1', 'Slide 2', 'Slide 3', 'Slide 4', 'Slide 5'];

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
                color: _page == i ? _kGreen : _kGreen.withOpacity(0.3),
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _TabsDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
          labelColor: _kGreen,
          unselectedLabelColor: widget.textSecondary,
          indicatorColor: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, divider;
  const _ToggleDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.divider,
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
                activeColor: _kGreen,
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _TimelineDemo({
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
                    decoration: const BoxDecoration(
                      color: _kGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (i < events.length - 1)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: _kGreen.withOpacity(0.3),
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
                        style: const TextStyle(color: _kGreen, fontSize: 12),
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
  final bool isDarkMode;
  final Color bg, cardBg, textPrimary, textSecondary;
  const _GenericDemo({
    required this.componentName,
    required this.isDarkMode,
    required this.bg,
    required this.cardBg,
    required this.textPrimary,
    required this.textSecondary,
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
                color: _kGreen.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.widgets_outlined,
                color: _kGreen,
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
              'This is a demo of the $componentName component.\n'
              'In a real implementation, the full interactive preview would be shown here.',
              style: TextStyle(color: textSecondary, fontSize: 14, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _kGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(200, 46),
              ),
              onPressed: () {},
              child: Text(
                'Try $componentName',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
