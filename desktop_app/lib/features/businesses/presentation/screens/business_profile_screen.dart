import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BusinessProfileScreen extends StatelessWidget {
  final String id;
  const BusinessProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/businesses'),
        ),
        title: const Text('Business Profile'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.auto_awesome),
            label: const Text('AI Audit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: Icon(Icons.business, size: 48, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Acme Corp', style: Theme.of(context).textTheme.displaySmall),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue.withOpacity(0.5)),
                            ),
                            child: const Text(
                              'New Lead',
                              style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Technology • San Francisco, CA', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildContactInfo(Icons.language, 'acmecorp.com'),
                          const SizedBox(width: 24),
                          _buildContactInfo(Icons.email, 'contact@acmecorp.com'),
                          const SizedBox(width: 24),
                          _buildContactInfo(Icons.phone, '+1 (555) 123-4567'),
                        ],
                      ),
                    ],
                  ),
                ),
                // Score Widget
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  child: Column(
                    children: [
                      const Text('Lead Score', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(Icons.local_fire_department, color: Colors.red, size: 32),
                          const SizedBox(width: 8),
                          Text('85', style: Theme.of(context).textTheme.displayMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Tabs Area
            DefaultTabController(
              length: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Overview'),
                      Tab(text: 'Contacts'),
                      Tab(text: 'Notes & Activity'),
                      Tab(text: 'AI Analysis'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 500, // Fixed height for demo
                    child: TabBarView(
                      children: [
                        _buildOverviewTab(context),
                        const Center(child: Text('Contacts List')),
                        const Center(child: Text('Notes Timeline')),
                        const Center(child: Text('AI Audit Results')),
                      ],
                    ),
                  ),
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
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
      ],
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  const Text(
                    'Acme Corp is a leading provider of innovative technology solutions. '
                    'They specialize in cloud infrastructure and enterprise software. '
                    'Recently expanded their operations to Europe.',
                    style: TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  Text('Tags', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: const Text('Enterprise'), backgroundColor: Colors.purple.withOpacity(0.1)),
                      Chip(label: const Text('Cloud'), backgroundColor: Colors.indigo.withOpacity(0.1)),
                      Chip(label: const Text('High Priority'), backgroundColor: Colors.red.withOpacity(0.1)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Google My Business', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 24),
                          const SizedBox(width: 8),
                          Text('4.8', style: Theme.of(context).textTheme.headlineMedium),
                          const Text(' (124 reviews)', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('View on Maps'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
