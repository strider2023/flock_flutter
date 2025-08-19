import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AppCarousel<T> extends StatefulWidget {
  /// The list of items of a generic type `T` to display.
  final List<T> items;

  /// A function that takes an item of type `T` and returns a widget to display.
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// Configuration options for the carousel's behavior and appearance.
  final CarouselOptions options;

  /// Whether to display the dot indicators below the carousel. Defaults to true.
  final bool showIndicators;

  const AppCarousel({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.options,
    this.showIndicators = true,
  });

  @override
  State<AppCarousel<T>> createState() => _AppCarouselState<T>();
}

class _AppCarouselState<T> extends State<AppCarousel<T>> {
  // State variable to track the current carousel page for the indicators
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    // Return an empty box if there are no items to prevent errors.
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            // Use the provided itemBuilder to build the specific card widget.
            return widget.itemBuilder(context, widget.items[itemIndex]);
          },
          // Use the provided options, but override onPageChanged to update the local state.
          options: widget.options.copyWith(
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
              // Also call the original onPageChanged if it was provided.
              widget.options.onPageChanged?.call(index, reason);
            },
          ),
        ),

        // Conditionally build the dot indicators.
        if (widget.showIndicators)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 4.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).primaryColor).withOpacity(
                    _current == entry.key ? 0.9 : 0.4,
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
