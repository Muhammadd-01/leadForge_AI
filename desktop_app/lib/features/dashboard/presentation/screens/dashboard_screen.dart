import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide some haptic feedback when loading the dashboard
    HapticFeedback.lightImpact();
    
    return Scaffold(
      backgroundColor: Colors.transparent, // Handled by AppShell
      appBar: AppBar(
        title: Text('Overview', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              HapticFeedback.selectionClick();
            },
          ).animate().fadeIn().scale(),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppTheme.accentColor, AppTheme.primaryColor],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentColor.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const CircleAvatar(
              backgroundColor: AppTheme.surfaceColor,
              child: Text('AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ).animate().fadeIn(delay: 200.ms).scale(),
          const SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, Agency',
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ).animate().slideY(begin: 0.2, end: 0).fadeIn(),
            const SizedBox(height: 8),
            Text(
              'Your automated outreach engine is running.',
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
            ).animate().slideY(begin: 0.2, end: 0).fadeIn(delay: 100.ms),
            const SizedBox(height: 32),
            
            // Stats Row - Wrap for mobile responsiveness
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildStatCard(context, 'Total Leads', '1,248', Icons.people_outline, AppTheme.accentColor, 200.ms),
                _buildStatCard(context, 'Active Campaigns', '12', Icons.campaign_outlined, AppTheme.secondaryAccent, 300.ms),
                _buildStatCard(context, 'Conversion Rate', '8.4%', Icons.trending_up, Colors.orangeAccent, 400.ms),
                _buildStatCard(context, 'Meetings Booked', '42', Icons.event_available, Colors.purpleAccent, 500.ms),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Glowing Pipeline Overview & Activity
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildGlowingPipeline(context),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: _buildActivityFeed(context),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildGlowingPipeline(context),
                      const SizedBox(height: 24),
                      _buildActivityFeed(context),
                      const SizedBox(height: 100), // padding for bottom nav
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color iconColor, Duration delay) {
    // Determine card width based on screen size (min 150, flex to fill)
    final width = MediaQuery.of(context).size.width > 800 
        ? (MediaQuery.of(context).size.width - 48 - (16 * 3)) / 4 
        : (MediaQuery.of(context).size.width - 48 - 16) / 2;

    return Container(
      width: width,
      padding: const EdgeInsets.all(24.0),
      decoration: AppTheme.glassDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title, 
                  style: GoogleFonts.outfit(color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            value, 
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay).slideY(begin: 0.1, end: 0, curve: Curves.easeOut);
  }

  Widget _buildGlowingPipeline(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: AppTheme.glassDecoration.copyWith(
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.hub, color: AppTheme.accentColor),
              const SizedBox(width: 12),
              Text(
                'AI Sales Pipeline',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Shimmering Pipeline stages
          _buildPipelineStage('Leads Generated', 1248, 1.0, AppTheme.accentColor),
          const SizedBox(height: 16),
          _buildPipelineStage('Contacted via AI', 840, 0.7, AppTheme.primaryColor),
          const SizedBox(height: 16),
          _buildPipelineStage('Responses Received', 156, 0.3, Colors.orangeAccent),
          const SizedBox(height: 16),
          _buildPipelineStage('Meetings Booked', 42, 0.15, AppTheme.secondaryAccent),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildPipelineStage(String label, int value, double fill, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.outfit(color: AppTheme.textSecondary, fontWeight: FontWeight.w500)),
            Text(value.toString(), style: GoogleFonts.outfit(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 12,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: constraints.maxWidth * fill,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.3)),
              ),
            );
          }
        ),
      ],
    );
  }

  Widget _buildActivityFeed(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: AppTheme.glassDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bolt, color: Colors.amberAccent),
              const SizedBox(width: 12),
              Text(
                'Live Agent Activity',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildActivityItem('AI scraped 150 new Plumbers in NY', '2 mins ago', Icons.search, AppTheme.accentColor),
          _buildActivityItem('Email campaign "Q3 Outreach" sent', '15 mins ago', Icons.send, AppTheme.primaryColor),
          _buildActivityItem('John Doe replied to WhatsApp', '1 hour ago', Icons.chat, AppTheme.secondaryAccent),
          _buildActivityItem('Meeting booked with TechCorp', '2 hours ago', Icons.event, Colors.purpleAccent),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildActivityItem(String text, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: GoogleFonts.outfit(color: AppTheme.textPrimary, fontSize: 14)),
                const SizedBox(height: 4),
                Text(time, style: GoogleFonts.outfit(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
