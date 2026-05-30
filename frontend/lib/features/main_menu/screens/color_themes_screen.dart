import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_provider.dart';

// ─────────────────────────────────────────────────────────────────
//  DATA WARNA
// ─────────────────────────────────────────────────────────────────
class _ColorOption {
  final String label;
  final Color color;
  const _ColorOption({required this.label, required this.color});
}

const List<_ColorOption> _colorOptions = [
  _ColorOption(label: 'Red', color: Color(0xFFE53935)),
  _ColorOption(label: 'Green', color: Color(0xFF2E7D32)),
  _ColorOption(label: 'Blue', color: Color(0xFF1565C0)),
  _ColorOption(label: 'Pink', color: Color(0xFFAD1457)),
  _ColorOption(label: 'Yellow', color: Color(0xFF827717)),
  _ColorOption(label: 'Orange', color: Color(0xFFE65100)),
  _ColorOption(label: 'Purple', color: Color(0xFF6A1B9A)),
  _ColorOption(label: 'Deeppurple', color: Color(0xFF4527A0)),
  _ColorOption(label: 'Lightblue', color: Color(0xFF0277BD)),
  _ColorOption(label: 'Teal', color: Color(0xFF00695C)),
  _ColorOption(label: 'Lime', color: Color(0xFF558B2F)),
  _ColorOption(label: 'Amber', color: Color(0xFFFF8F00)),
];

// ─────────────────────────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────────────────────────
class ColorThemesScreen extends StatefulWidget {
  const ColorThemesScreen({super.key});

  @override
  State<ColorThemesScreen> createState() => _ColorThemesScreenState();
}

class _ColorThemesScreenState extends State<ColorThemesScreen> {
  int _selectedColorIndex = 1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = context.watch<ThemeProvider>();

    // 🔥 warna aktif (lokal saja)
    final selectedColor = _colorOptions[_selectedColorIndex].color;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Themes'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(text: 'Layout Themes', isDark: isDark),
            const SizedBox(height: 12),

            // 🔥 CARD 1
            _SectionCard(
              isDark: isDark,
              accentColor: selectedColor,
              child: Row(
                children: [
                  Expanded(
                    child: _LayoutThemeTile(
                      isDarkTile: false,
                      isSelected: !themeProvider.isDarkMode,
                      accentColor: selectedColor,
                      onTap: () =>
                          themeProvider.setTheme(ThemeMode.light),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _LayoutThemeTile(
                      isDarkTile: true,
                      isSelected: themeProvider.isDarkMode,
                      accentColor: selectedColor,
                      onTap: () =>
                          themeProvider.setTheme(ThemeMode.dark),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _SectionTitle(text: 'Default Color Themes', isDark: isDark),
            const SizedBox(height: 12),

            // 🔥 CARD 2
            _SectionCard(
              isDark: isDark,
              accentColor: selectedColor,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.6,
                ),
                itemCount: _colorOptions.length,
                itemBuilder: (_, i) {
                  final opt = _colorOptions[i];
                  final isSelected = i == _selectedColorIndex;
                  return _ColorChip(
                    option: opt,
                    isSelected: isSelected,
                    onTap: () =>
                        setState(() => _selectedColorIndex = i),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            _SectionTitle(text: 'Preview', isDark: isDark),
            const SizedBox(height: 12),

            // 🔥 CARD 3
            _SectionCard(
              isDark: isDark,
              accentColor: selectedColor,
              child: _ColorPreview(
                color: selectedColor,
                label: _colorOptions[_selectedColorIndex].label,
                isDark: isDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  SECTION TITLE
// ─────────────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String text;
  final bool isDark;

  const _SectionTitle({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.greenAccent : Colors.green,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  SECTION CARD (🔥 ADA BORDER DINAMIS)
// ─────────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final bool isDark;
  final Widget child;
  final Color accentColor;

  const _SectionCard({
    required this.isDark,
    required this.child,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),

        // 🔥 BORDER IKUT WARNA PILIHAN
        border: Border.all(
          color: accentColor.withOpacity(0.6),
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  TILE LIGHT/DARK (TANPA BORDER)
// ─────────────────────────────────────────────────────────────────
class _LayoutThemeTile extends StatelessWidget {
  final bool isDarkTile;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;

  const _LayoutThemeTile({
    required this.isDarkTile,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 70,
        decoration: BoxDecoration(
          color: isDarkTile ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),

          // 🔥 pakai shadow, bukan border
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accentColor.withOpacity(0.5),
                    blurRadius: 10,
                  )
                ]
              : [],
        ),
        child: Stack(
          children: [
            if (isSelected)
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(Icons.check,
                      size: 12, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  COLOR CHIP
// ─────────────────────────────────────────────────────────────────
class _ColorChip extends StatelessWidget {
  final _ColorOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorChip({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: option.color,
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? Border.all(color: Colors.white, width: 2)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          option.label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  PREVIEW
// ─────────────────────────────────────────────────────────────────
class _ColorPreview extends StatelessWidget {
  final Color color;
  final String label;
  final bool isDark;

  const _ColorPreview({
    required this.color,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 12),
        Text(label),
      ],
    );
  }
}