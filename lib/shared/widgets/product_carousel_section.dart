// lib/widgets/product_carousel_section.dart

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flock_flutter/models/marketplace_feed_model.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';

class ProductCarouselSection extends StatefulWidget {
  // Assuming your section model is named CarouselSection
  final CarouselSection section;

  const ProductCarouselSection({super.key, required this.section});

  @override
  State<ProductCarouselSection> createState() =>
      _ProductCarouselWithIndicatorState();
}

class _ProductCarouselWithIndicatorState extends State<ProductCarouselSection> {
  // State variable to track the current carousel page
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.section.products.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
                // We pass the product for the current index to the ProductCard.
                return ProductCard(product: widget.section.products[itemIndex]);
              },
          options: CarouselOptions(
            // The height of the carousel.
            height: 320,

            // A smaller fraction ensures side items are clearly visible.
            viewportFraction: 0.8,

            // This callback updates our state when the page changes.
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },

            // Makes the center page larger (zoomed in).
            enlargeCenterPage: true,

            // Other settings remain the same for a good user experience.
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),

        // This Row builds the dot indicators.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.section.products.asMap().entries.map((entry) {
            return GestureDetector(
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 4.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // The color changes based on the current page index.
                  color: (Colors.black).withOpacity(
                    _current == entry.key ? 0.9 : 0.4,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
