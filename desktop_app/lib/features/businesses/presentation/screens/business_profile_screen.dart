import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class BusinessProfileScreen extends StatelessWidget {
  final String id;
  const BusinessProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Handled by AppShell
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/businesses'),
        ),
        title: Text('Business Profile', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.auto_awesome),
            label: const Text('AI Audit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryAccent,
              foregroundColor: Colors.white,
            ),
          ).animate().fadeIn().scale(),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.surfaceColor,
              foregroundColor: AppTheme.textPrimary,
              elevation: 0,
            ),
          ).animate().fadeIn(delay: 100.ms).scale(),
          const SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(32),
              decoration: AppTheme.glassDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.business, size: 48, color: AppTheme.primaryColor),
                    ),
                  ).animate().scaleXY(begin: 0.8, end: 1.0, duration: 500.ms, curve: Curves.easeOutBack),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Acme Corp', 
                              style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.accentColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppTheme.accentColor.withOpacity(0.5)),
                              ),
                              child: const Text(
                                'New Lead',
                                style: TextStyle(color: AppTheme.accentColor, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 2.seconds),
                          ],
                        ).animate().slideX(begin: 0.1, end: 0).fadeIn(duration: 400.ms),
                        const SizedBox(height: 8),
                        Text(
                          'Technology • San Francisco, CA', 
                          style: GoogleFonts.outfit(fontSize: 16, color: AppTheme.textSecondary)
                        ).animate().slideX(begin: 0.1, end: 0).fadeIn(delay: 100.ms),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            _buildContactInfo(Icons.language, 'acmecorp.com'),
                            const SizedBox(width: 32),
                            _buildContactInfo(Icons.email, 'contact@acmecorp.com'),
                            const SizedBox(width: 32),
                            _buildContactInfo(Icons.phone, '+1 (555) 123-4567'),
                          ],
                        ).animate().slideX(begin: 0.1, end: 0).fadeIn(delay: 200.ms),
                      ],
                    ),
                  ),
                  // Score Widget
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.surfaceVariant, AppTheme.surfaceColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      children: [
                        Text('Lead Score', style: GoogleFonts.outfit(color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(Icons.psychology, color: Colors.redAccent, size: 32)
                              .animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.2, duration: 1000.ms),
                            const SizedBox(width: 12),
                            Text(
                              '85', 
                              style: GoogleFonts.outfit(fontSize: 40, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().scaleXY(begin: 0.9, end: 1.0).fadeIn(delay: 300.ms),
                ],
              ),
            ).animate().slideY(begin: 0.1, end: 0).fadeIn(),
            const SizedBox(height: 48),
            // Tabs Area
            DefaultTabController(
              length: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: AppTheme.accentColor,
                    unselectedLabelColor: AppTheme.textSecondary,
                    indicatorColor: AppTheme.accentColor,
                    labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16),
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Contacts'),
                      Tab(text: 'Notes & Activity'),
                      Tab(text: 'AI Analysis'),
                    ],
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 600, // Fixed height for demo
                    child: TabBarView(
                      children: [
                        _buildOverviewTab(context),
                        const Center(child: Text('Contacts List')),
                        const Center(child: Text('Notes Timeline')),
                        const Center(child: Text('AI Audit Results')),
                      ],
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppTheme.accentColor),
        const SizedBox(width: 12),
        Text(
          text, 
          style: GoogleFonts.outfit(
            color: AppTheme.textPrimary,
            decoration: TextDecoration.underline,
            decorationColor: AppTheme.textSecondary,
          )
        ),
      ],
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(32.0),
            decoration: AppTheme.glassDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppTheme.primaryColor),
                    const SizedBox(width: 12),
                    Text('About Company', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Acme Corp is a leading provider of innovative technology solutions. '
                  'They specialize in cloud infrastructure and enterprise software. '
                  'Recently expanded their operations to Europe.',
                  style: GoogleFonts.outfit(height: 1.6, color: AppTheme.textSecondary, fontSize: 16),
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    const Icon(Icons.label_outline, color: AppTheme.secondaryAccent),
                    const SizedBox(width: 12),
                    Text('Tags & Classification', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  ],
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildChip('Enterprise', Colors.purpleAccent),
                    _buildChip('Cloud', Colors.indigoAccent),
                    _buildChip('High Priority', Colors.redAccent),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(32.0),
            decoration: AppTheme.glassDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_outline, color: Colors.amber),
                    const SizedBox(width: 12),
                    Text('Reputation', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 32),
                    const SizedBox(width: 12),
                    Text('4.8', style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Based on 124 Google Reviews', style: GoogleFonts.outfit(color: AppTheme.textSecondary)),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: AppTheme.surfaceColor,
                    foregroundColor: AppTheme.textPrimary,
                    elevation: 0,
                    side: BorderSide(color: AppTheme.surfaceVariant),
                  ),
                  child: const Text('View on Maps'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
