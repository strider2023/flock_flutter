// lib/widgets/marketplace_section.dart

import 'package:flutter/material.dart';
import 'section_header.dart';

class MarketplaceSection<T> extends StatelessWidget {
  /// The title displayed in the section header.
  final String title;

  /// The list of items of a generic type `T`.
  final List<T> items;

  /// The function that builds the specific card widget for each item.
  final Widget Function(T item) itemBuilder;

  /// The fixed height of the horizontal list view.
  final double listHeight;

  /// The callback function for the "See More" action.
  final VoidCallback onSeeMore;

  /// The optional background color for the entire section.
  final Color? backgroundColor;

  const MarketplaceSection({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.listHeight,
    required this.onSeeMore,
    this.backgroundColor, // Added optional parameter
  });

  @override
  Widget build(BuildContext context) {
    // The Column is now wrapped in a Container to apply the background color.
    return Container(
      // Use the provided color, or default to transparent if it's null.
      color: backgroundColor ?? Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, onSeeMore: onSeeMore),
          SizedBox(
            height: listHeight,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: itemBuilder(item),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
