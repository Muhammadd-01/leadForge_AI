import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../../../../core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    
    int selectedIndex = 0;
    if (location.startsWith('/dashboard')) selectedIndex = 0;
    if (location.startsWith('/businesses') || location.startsWith('/pipeline')) selectedIndex = 1;
    if (location.startsWith('/leads')) selectedIndex = 2;
    if (location.startsWith('/campaigns')) selectedIndex = 3;

    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: isDesktop ? null : _buildDrawer(context),
      body: Stack(
        children: [
          // Background Gradient effect
          Positioned(
            top: -150,
            right: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withOpacity(0.08),
                backgroundBlendMode: BlendMode.screen,
              ),
            ),
          ),
          
          Row(
            children: [
              if (isDesktop)
                NavigationRail(
                  backgroundColor: AppTheme.surfaceColor.withOpacity(0.5),
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (int index) => _navigate(context, index),
                  extended: MediaQuery.of(context).size.width >= 1000,
                  elevation: 0,
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: Text('Dashboard')),
                    NavigationRailDestination(icon: Icon(Icons.business_outlined), selectedIcon: Icon(Icons.business), label: Text('CRM')),
                    NavigationRailDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: Text('AI Leads')),
                    NavigationRailDestination(icon: Icon(Icons.campaign_outlined), selectedIcon: Icon(Icons.campaign), label: Text('Campaigns')),
                  ],
                  trailing: Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: () => context.go('/register'),
                        ),
                      ),
                    ),
                  ),
                ),
              
              if (isDesktop)
                Container(width: 1, color: AppTheme.surfaceVariant),
                
              Expanded(
                child: SafeArea(
                  bottom: false, // leave space for bottom nav
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
          
          // Floating Bottom Nav Bar for Mobile
          if (!isDesktop)
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: _buildFloatingNavBar(context, selectedIndex),
            ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.surfaceColor,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.2),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              child: Icon(Icons.apartment, color: Colors.white, size: 32),
            ),
            accountName: Text('My Agency', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
            accountEmail: const Text('admin@agency.com'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Agency Settings'),
            onTap: () {
              Navigator.pop(context); // close drawer
              context.go('/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Sign Out', style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              context.go('/register');
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar(BuildContext context, int selectedIndex) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 65,
          decoration: AppTheme.glassDecoration.copyWith(
            borderRadius: BorderRadius.circular(30),
            color: AppTheme.surfaceColor.withOpacity(0.7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(context, Icons.dashboard_outlined, Icons.dashboard, 0, selectedIndex),
              _buildNavItem(context, Icons.business_outlined, Icons.business, 1, selectedIndex),
              _buildNavItem(context, Icons.auto_awesome_outlined, Icons.auto_awesome, 2, selectedIndex, isProminent: true),
              _buildNavItem(context, Icons.campaign_outlined, Icons.campaign, 3, selectedIndex),
            ],
          ),
        ),
      ),
    ).animate().slideY(begin: 1, end: 0, duration: 500.ms, curve: Curves.easeOutBack);
  }

  Widget _buildNavItem(BuildContext context, IconData icon, IconData activeIcon, int index, int selectedIndex, {bool isProminent = false}) {
    final isSelected = index == selectedIndex;
    
    return GestureDetector(
      onTap: () => _navigate(context, index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: isProminent 
          ? const EdgeInsets.all(12) 
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isProminent
          ? BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.accentColor.withOpacity(isSelected ? 1.0 : 0.8),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentColor.withOpacity(0.4),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ]
            )
          : BoxDecoration(
              color: isSelected ? AppTheme.primaryColor.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
        child: Icon(
          isSelected ? activeIcon : icon,
          color: isProminent 
            ? AppTheme.backgroundColor 
            : (isSelected ? AppTheme.primaryColor : AppTheme.textSecondary),
          size: isProminent ? 28 : 24,
        ),
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/businesses');
        break;
      case 2:
        context.go('/leads');
        break;
      case 3:
        context.go('/campaigns');
        break;
    }
  }
}
