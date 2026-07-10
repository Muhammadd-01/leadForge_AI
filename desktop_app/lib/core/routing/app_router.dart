import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/core/presentation/widgets/app_shell.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/businesses/presentation/screens/business_list_screen.dart';
import '../../features/businesses/presentation/screens/business_profile_screen.dart';
import '../../features/core/presentation/widgets/placeholder_screen.dart';
import '../../features/core/presentation/screens/splash_screen.dart';
import '../../features/core/presentation/screens/onboarding_screen.dart';
import '../../features/leads/lead_generation_screen.dart';
import '../../features/campaigns/campaigns_screen.dart';
import '../../features/auth/presentation/screens/agency_registration_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const AgencyRegistrationScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/businesses',
            builder: (context, state) => const BusinessListScreen(),
          ),
          GoRoute(
            path: '/businesses/:id',
            builder: (context, state) => BusinessProfileScreen(id: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/pipeline',
            builder: (context, state) => const PlaceholderScreen(title: 'Pipeline'),
          ),
          GoRoute(
            path: '/leads',
            builder: (context, state) => const LeadGenerationScreen(),
          ),
          GoRoute(
            path: '/campaigns',
            builder: (context, state) => const CampaignsScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const PlaceholderScreen(title: 'Settings'),
          ),
        ],
      ),
    ],
  );
});
