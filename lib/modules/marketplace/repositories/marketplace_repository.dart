// lib/marketplace/data/repositories/marketplace_repository.dart

import '../models/brand_model.dart';
import '../models/marketplace_feed_model.dart';
import '../models/product_model.dart';

class MarketplaceRepository {
  final String authToken;

  MarketplaceRepository({required this.authToken});

  // Simulates fetching the entire marketplace feed from an API.
  Future<List<FeedSection>> getMarketplaceFeed() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real app, this would be an API call.
    // The data generation logic is moved here from the old widget.
    return [
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

  // --- MOCK DATA GENERATION (Kept private within the repository) ---

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
