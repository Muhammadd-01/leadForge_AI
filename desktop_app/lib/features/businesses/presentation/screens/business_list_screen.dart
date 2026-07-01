import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BusinessListScreen extends StatelessWidget {
  const BusinessListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Businesses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
            tooltip: 'Filter',
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Business'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search businesses by name, industry, or location...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.surface.withOpacity(0.5),
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
                        _buildDummyRow(context, 'Acme Corp', 'Technology', 'San Francisco, CA', 'New Lead', 85, '1'),
                        _buildDummyRow(context, 'Globex Inc.', 'Manufacturing', 'New York, NY', 'Qualified', 92, '2'),
                        _buildDummyRow(context, 'Soylent Corp', 'Food & Bev', 'Chicago, IL', 'Contacted', 65, '3'),
                        _buildDummyRow(context, 'Initech', 'Software', 'Austin, TX', 'Proposal Sent', 78, '4'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDummyRow(BuildContext context, String name, String industry, String location, String status, int score, String id) {
    Color statusColor;
    switch (status) {
      case 'New Lead':
        statusColor = Colors.blue;
        break;
      case 'Qualified':
        statusColor = Colors.green;
        break;
      case 'Proposal Sent':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(
      cells: [
        DataCell(
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          onTap: () => context.go('/businesses/$id'),
        ),
        DataCell(Text(industry)),
        DataCell(Text(location)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withOpacity(0.5)),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_fire_department, 
                color: score > 80 ? Colors.red : (score > 60 ? Colors.orange : Colors.grey),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(score.toString()),
            ],
          )
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined, size: 20),
                onPressed: () => context.go('/businesses/$id'),
                tooltip: 'View Profile',
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {},
                tooltip: 'Edit',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
