import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.auto_awesome,
      'title': 'AI-Powered Leads',
      'description': 'Instantly discover high-quality business leads in your niche, automatically scored and categorized by local LLMs.',
      'color': AppTheme.accentColor,
    },
    {
      'icon': Icons.campaign,
      'title': 'Automated Outreach',
      'description': 'Launch cold email and WhatsApp campaigns directly from the app. Seamlessly convert your generated leads.',
      'color': AppTheme.secondaryAccent,
    },
    {
      'icon': Icons.rocket_launch,
      'title': 'Grow Your Agency',
      'description': 'Manage your entire pipeline in a single, high-performance workspace designed for top-tier freelancers.',
      'color': AppTheme.primaryColor,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          // Background subtle gradients
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _pages[_currentPage]['color'].withOpacity(0.15),
              ),
            ).animate(target: _currentPage.toDouble()).scaleXY(end: 1.2, duration: 1000.ms),
          ),
          
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(32),
                              decoration: AppTheme.glassDecoration.copyWith(
                                shape: BoxShape.circle,
                                borderRadius: null,
                                color: _pages[index]['color'].withOpacity(0.1),
                                border: Border.all(
                                  color: _pages[index]['color'].withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                _pages[index]['icon'],
                                size: 80,
                                color: _pages[index]['color'],
                              ),
                            )
                            .animate(delay: 200.ms)
                            .scaleXY(begin: 0.5, end: 1.0, curve: Curves.easeOutBack, duration: 800.ms)
                            .fadeIn(),
                            
                            const SizedBox(height: 60),
                            
                            Text(
                              _pages[index]['title'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            )
                            .animate(delay: 400.ms)
                            .slideY(begin: 0.2, end: 0, duration: 600.ms)
                            .fadeIn(),
                            
                            const SizedBox(height: 24),
                            
                            Text(
                              _pages[index]['description'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                color: AppTheme.textSecondary,
                                height: 1.5,
                              ),
                            )
                            .animate(delay: 600.ms)
                            .slideY(begin: 0.2, end: 0, duration: 600.ms)
                            .fadeIn(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                // Bottom Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Page Indicators
                      Row(
                        children: List.generate(
                          _pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 8),
                            height: 8,
                            width: _currentPage == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index 
                                ? _pages[_currentPage]['color'] 
                                : AppTheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      
                      // Next / Start Button
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _pages[_currentPage]['color'],
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white),
                          ],
                        ),
                      )
                      .animate(target: _currentPage == _pages.length - 1 ? 1 : 0)
                      .shimmer(duration: 2000.ms, curve: Curves.easeInOut),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
