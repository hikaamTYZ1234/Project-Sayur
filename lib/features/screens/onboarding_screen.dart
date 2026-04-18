import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'Healthy Food, For Breakfast',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ),
    _OnboardingData(
      title: 'Start your healthy life now',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ),
    _OnboardingData(
      title: 'Tasty & Healthy Organic Food',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
  }

  Future<void> _navigateToRegister() async {
    await _completeOnboarding();
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.messages);
    }
  }

  Future<void> _navigateToLogin() async {
    await _completeOnboarding();
    if (mounted) {
     Navigator.pushReplacementNamed(context, AppRoutes.messages);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Menggunakan AppColors dari app_colors.dart
    const Color bgColor    = AppColors.primaryGreen;  
    const Color accentColor = AppColors.accent;        
    const Color onBgColor  = Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),

            // ── Logo ───────────────────────────────────────────────────
            const _SayurLogo(),

            const SizedBox(height: 6),

            Text(
              'Sayur',
              style: TextStyle(
                fontFamily: 'Cursive',
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: onBgColor,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Healthy Food Delivery',
              style: textTheme.bodyMedium?.copyWith(
                color: onBgColor.withOpacity(0.85),
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 20),

            // ── PageView ───────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) {
                  return _OnboardingSlide(
                    data: _pages[index],
                    onBgColor: onBgColor,
                    textTheme: textTheme,
                  );
                },
              ),
            ),

            // ── Dot Indicator ──────────────────────────────────────────
            _DotIndicator(
              count: _pages.length,
              current: _currentPage,
              activeColor: onBgColor,
              inactiveColor: onBgColor.withOpacity(0.4),
              onDotTap: _goToPage,
            ),

            const SizedBox(height: 20),

            // ── Buttons ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Sign Up 
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _navigateToRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      child: const Text('SIGN UP'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Login 
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      onPressed: _navigateToLogin,
                      style: TextButton.styleFrom(
                        backgroundColor: onBgColor.withOpacity(0.18),
                        foregroundColor: onBgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      child: const Text('LOGIN'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ==================== DATA MODEL ====================
class _OnboardingData {
  final String title;
  final String description;
  const _OnboardingData({
    required this.title,
    required this.description,
  });
}

// ==================== LOGO ====================
class _SayurLogo extends StatelessWidget {
  const _SayurLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/wortel_logo.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(
              Icons.eco_rounded,
              size: 44,
              color: AppColors.primaryGreen,
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== SLIDE ====================
class _OnboardingSlide extends StatelessWidget {
  final _OnboardingData data;
  final Color onBgColor;
  final TextTheme textTheme;
  const _OnboardingSlide({
    required this.data,
    required this.onBgColor,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(
              color: onBgColor,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: onBgColor.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== DOT INDICATOR ====================
class _DotIndicator extends StatelessWidget {
  final int count;
  final int current;
  final Color activeColor;
  final Color inactiveColor;
  final void Function(int) onDotTap;

  const _DotIndicator({
    required this.count,
    required this.current,
    required this.activeColor,
    required this.inactiveColor,
    required this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == current;
        return GestureDetector(
          onTap: () => onDotTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 20 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}