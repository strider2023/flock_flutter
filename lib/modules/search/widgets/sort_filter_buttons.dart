import 'package:flutter/material.dart';

class SortFilterButtons extends StatelessWidget {
  const SortFilterButtons({super.key});

  void _showActionSheet(BuildContext context, bool isFilter) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(isFilter ? 'Filter Options' : 'Sort Options'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Text(
            'Your ${isFilter ? "filtering" : "sorting"} UI goes here!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
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
