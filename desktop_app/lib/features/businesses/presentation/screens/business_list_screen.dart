import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class BusinessListScreen extends StatelessWidget {
  const BusinessListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Handled by AppShell
      appBar: AppBar(
        title: const Text('CRM & Pipeline'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
            tooltip: 'Filter',
          ).animate().fadeIn().scale(),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Business'),
          ).animate().fadeIn(delay: 100.ms).scale(),
          const SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search businesses by name, industry, or location...',
                prefixIcon: Icon(Icons.search),
              ),
            ).animate().slideY(begin: -0.1, end: 0).fadeIn(),
            
            const SizedBox(height: 24),
            
            Expanded(
              child: Container(
                decoration: AppTheme.glassDecoration,
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      headingTextStyle: GoogleFonts.outfit(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                      dataTextStyle: GoogleFonts.outfit(
                        color: AppTheme.textPrimary,
                      ),
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Industry')),
                        DataColumn(label: Text('Location')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Lead Score')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: [
                        _buildDummyRow(context, 'Acme Corp', 'Technology', 'San Francisco, CA', 'New Lead', 85, '1', 100),
                        _buildDummyRow(context, 'Globex Inc.', 'Manufacturing', 'New York, NY', 'Qualified', 92, '2', 200),
                        _buildDummyRow(context, 'Soylent Corp', 'Food & Bev', 'Chicago, IL', 'Contacted', 65, '3', 300),
                        _buildDummyRow(context, 'Initech', 'Software', 'Austin, TX', 'Proposal Sent', 78, '4', 400),
                      ],
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05, end: 0),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDummyRow(BuildContext context, String name, String industry, String location, String status, int score, String id, int delayMs) {
    Color statusColor;
    switch (status) {
      case 'New Lead':
        statusColor = AppTheme.accentColor;
        break;
      case 'Qualified':
        statusColor = AppTheme.secondaryAccent;
        break;
      case 'Proposal Sent':
        statusColor = Colors.orangeAccent;
        break;
      default:
        statusColor = AppTheme.textSecondary;
    }

    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    name[0],
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ).animate(delay: delayMs.ms).fadeIn().slideX(begin: -0.1, end: 0),
          onTap: () => context.go('/businesses/$id'),
        ),
        DataCell(Text(industry).animate(delay: delayMs.ms).fadeIn()),
        DataCell(Text(location).animate(delay: delayMs.ms).fadeIn()),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withOpacity(0.5)),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ).animate(delay: delayMs.ms).fadeIn().scale(),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.psychology, 
                color: score > 80 ? Colors.redAccent : (score > 60 ? Colors.orangeAccent : Colors.grey),
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                score.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ).animate(delay: delayMs.ms).fadeIn()
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined, size: 20),
                onPressed: () => context.go('/businesses/$id'),
                tooltip: 'View Profile',
                color: AppTheme.accentColor,
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {},
                tooltip: 'Edit',
                color: AppTheme.textSecondary,
              ),
            ],
          ).animate(delay: delayMs.ms).fadeIn()
        ),
      ],
    );
  }
}
