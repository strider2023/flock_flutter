// data/repositories/product_repository.dart

import '../../../common/models/product_model.dart';

class SearchRepository {
  final String authToken;

  SearchRepository({required this.authToken});

  // --- DUMMY DATA (Simulates a database or API) ---
  final List<ProductModel> _allProducts = [
    ProductModel(
      itemName: 'Nike Air Force 1',
      vendorName: 'Nike',
      category: 'Lifestyle Sneakers',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec2c27ff?auto=format&fit=crop&w=800&q=60',
      purchasePrice: 8195.00,
      rating: 4.8,
      ratingCount: 1250,
      discountPercentage: 15,
      actualPrice: 9641.00,
    ),
    ProductModel(
      itemName: 'Levi\'s 501 Jeans',
      vendorName: 'Levis',
      category: 'Clothes',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=60',
      purchasePrice: 29990.00,
      rating: 4.9,
      ratingCount: 890,
    ),
  ];

  final List<String> _lastSearched = [
    'Nike Air Max',
    'Adidas Ultraboost',
    'Puma Sneakers',
    'Leather Jacket',
    'Denim Jeans',
    'Smart Watch',
    'Wireless Headphones',
    'Laptop Bag',
    'Sunglasses',
    'Running Shoes',
  ];

  final List<String> _trendingItems = [
    'Oversized T-Shirts',
    'Cargo Pants',
    'Crossbody Bags',
    'Retro Sunglasses',
    'Chunky Sneakers',
  ];

  // --- PUBLIC METHODS ---

  Future<List<String>> getLastSearched() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    ); // Simulate network delay
    return _lastSearched;
  }

  Future<List<String>> getTrendingItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _trendingItems;
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network search
    if (query.isEmpty) return [];

    return _allProducts
        .where(
          (product) =>
              product.itemName.toLowerCase().contains(query.toLowerCase()) ||
              product.vendorName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<List<String>> getSearchSuggestions(String query) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    ); // Simulate API latency
    if (query.isEmpty) return [];

    return _allProducts
        .where(
          (product) =>
              product.itemName.toLowerCase().contains(query.toLowerCase()),
        )
        .map((product) => product.itemName)
        .toList();
  }
}
