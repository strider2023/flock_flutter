import 'package:flutter/material.dart';

class SortFilterButtons extends StatelessWidget {
  const SortFilterButtons({super.key});

  void _showActionSheet(BuildContext context, bool isFilter) {
    showModalBottomSheet(
      context: context,
      // ✨ REMOVED: isScrollControlled: true, which forces the sheet to be fullscreen.
      // The sheet will now take the height of its content.
      builder: (_) {
        // ✨ REPLACED: The Scaffold is replaced with a more fitting layout.
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Takes minimum vertical space
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isFilter ? 'Filter Options' : 'Sort Options',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              // Example content for the bottom sheet
              ListTile(
                leading: const Icon(Icons.arrow_upward),
                title: const Text('Price: Low to High'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: const Icon(Icons.arrow_downward),
                title: const Text('Price: High to Low'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: const Icon(Icons.new_releases_outlined),
                title: const Text('Newest Arrivals'),
                onTap: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.sort),
              label: const Text('Sort'),
              onPressed: () => _showActionSheet(context, false),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.filter_list),
              label: const Text('Filter'),
              onPressed: () => _showActionSheet(context, true),
            ),
          ),
        ],
      ),
    );
  }
}
