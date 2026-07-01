import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          const CircleAvatar(
            backgroundColor: Color(0xFF6366F1),
            child: Text('AI', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, Freelancer',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Here is what is happening with your leads today.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            // Stats Row
            Row(
              children: [
                Expanded(child: _buildStatCard(context, 'Total Leads', '1,248', Icons.people_outline, Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, 'Active Deals', '42', Icons.monetization_on_outlined, Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, 'Tasks Pending', '12', Icons.check_circle_outline, Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, 'Win Rate', '68%', Icons.trending_up, Colors.purple)),
              ],
            ),
            const SizedBox(height: 32),
            // Recent Activity & AI Insights
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildSectionCard(
                    context, 
                    'Recent Leads', 
                    const Center(child: Text('Lead List goes here')),
                    minHeight: 400,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: _buildSectionCard(
                    context, 
                    'AI Insights', 
                    const Center(child: Text('AI recommendations go here')),
                    minHeight: 400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color iconColor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                Icon(icon, color: iconColor, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            Text(value, style: Theme.of(context).textTheme.displaySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, String title, Widget content, {double minHeight = 200}) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        constraints: BoxConstraints(minHeight: minHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
