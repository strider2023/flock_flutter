// lib/screens/home_screen.dart

import 'package:flock_flutter/models/marketplace_feed_model.dart';
import 'package:flock_flutter/shared/widgets/brand_card.dart';
import 'package:flock_flutter/shared/widgets/marketplace_section.dart';
import 'package:flock_flutter/shared/widgets/product_card.dart';
import 'package:flock_flutter/shared/widgets/product_carousel_section.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/brand_model.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';

class MarketplaceHome extends StatefulWidget {
  const MarketplaceHome({super.key});

  @override
  State<MarketplaceHome> createState() => _MarketplaceHomeState();
}

class _MarketplaceHomeState extends State<MarketplaceHome> {
  // This list would typically be fetched from a backend API.
  late final List<FeedSection> _feedItems;

  @override
  void initState() {
    super.initState();
    _loadFeedData();
  }

  // Simulate fetching data from a backend.
  void _loadFeedData() {
    // This data would come from an API call in a real app.
    _feedItems = [
      CarouselSection(products: _getMockProducts(5)),
      CategoryProductSection(
        title: "🔥 Trending Now",
        products: _getMockProducts(10, onSale: true),
      ),
      BrandSection(title: "Top Brands", brands: _getMockBrands(5)),
      CategoryProductSection(
        title: "New Arrivals",
        products: _getMockProducts(10),
      ),
      BrandSection(
        title: "Featured Brands",
        brands: _getMockBrands(5, offset: 5),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flock'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Iconify(Ri.search_2_line, color: Colors.green.shade800),
          ),
          IconButton(
            onPressed: () {},
            icon: Iconify(Ri.notification_3_line, color: Colors.green.shade800),
          ),
          IconButton(
            onPressed: () {},
            icon: Iconify(Ri.shopping_cart_line, color: Colors.green.shade800),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        // Add 1 to the item count for the SizedBox at the end.
        itemCount: _feedItems.length + 1,
        itemBuilder: (context, index) {
          // Check if it's the last item.
          if (index == _feedItems.length) {
            // If so, return the SizedBox to create space at the bottom.
            return const SizedBox(height: 100);
          }

          // Otherwise, build the list items as before.
          final section = _feedItems[index];

          // Build the widget based on the section type
          if (section is CarouselSection) {
            return ProductCarouselSection(section: section);
          } else if (section is CategoryProductSection) {
            return MarketplaceSection<ProductModel>(
              title: section.title,
              items: section.products,
              listHeight: 320,
              onSeeMore: () => print("See more products"),
              itemBuilder: (product) => ProductCard(product: product),
              backgroundColor: Colors.black12,
            );
          } else if (section is BrandSection) {
            return MarketplaceSection<BrandModel>(
              title: section.title,
              items: section.brands,
              listHeight: 120,
              onSeeMore: () => print("See more brands"),
              itemBuilder: (brand) => BrandCard(brand: brand),
            );
          }
          // Fallback for unknown section types
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // --- MOCK DATA GENERATION ---
  // In a real app, this would be your API service.

  List<ProductModel> _getMockProducts(
    int count, {
    bool onSale = false,
    int offset = 0,
  }) {
    return List.generate(count, (i) {
      final index = i + offset;
      final price = (19.99 + index * 5);
      return ProductModel(
        imageUrl: 'https://picsum.photos/id/${100 + index}/400/400',
        vendorName: 'Vendor ${index + 1}',
        itemName: 'Stylish Product Name ${index + 1}',
        purchasePrice: onSale ? (price * 0.8) : price,
        actualPrice: onSale ? price : null,
        discountPercentage: onSale ? 20 : null,
      );
    });
  }

  List<BrandModel> _getMockBrands(int count, {int offset = 0}) {
    return List.generate(count, (i) {
      final index = i + offset;
      return BrandModel(
        imageUrl: 'https://picsum.photos/id/${200 + index}/200/200',
        name: 'Brand ${index + 1}',
      );
    });
  }
}
