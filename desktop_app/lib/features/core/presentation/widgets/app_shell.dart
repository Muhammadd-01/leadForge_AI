import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current location to determine selected index
    final String location = GoRouterState.of(context).uri.toString();
    
    int selectedIndex = 0;
    if (location.startsWith('/dashboard')) selectedIndex = 0;
    if (location.startsWith('/businesses')) selectedIndex = 1;
    if (location.startsWith('/pipeline')) selectedIndex = 2;
    if (location.startsWith('/settings')) selectedIndex = 3;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              switch (index) {
                case 0:
                  context.go('/dashboard');
                  break;
                case 1:
                  context.go('/businesses');
                  break;
                case 2:
                  context.go('/pipeline');
                  break;
                case 3:
                  context.go('/settings');
                  break;
              }
            },
            extended: MediaQuery.of(context).size.width >= 800,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.business_outlined),
                selectedIcon: Icon(Icons.business),
                label: Text('Businesses'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.view_kanban_outlined),
                selectedIcon: Icon(Icons.view_kanban),
                label: Text('Pipeline'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Color(0xFF334155)),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
