// data/repositories/product_repository.dart

import '../models/product.dart';

class SearchRepository {
  final String authToken;

  SearchRepository({required this.authToken});

  // --- DUMMY DATA (Simulates a database or API) ---
  final List<Product> _allProducts = [
    Product(
      name: 'Nike Air Force 1',
      type: 'Sneakers',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=60',
    ),
    Product(
      name: 'Adidas Stan Smith',
      type: 'Sneakers',
      imageUrl:
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?auto=format&fit=crop&w=800&q=60',
    ),
    Product(
      name: 'Levi\'s 501',
      type: 'Jeans',
      imageUrl:
          'https://images.unsplash.com/photo-1602293589914-9e5c54a36e45?auto=format&fit=crop&w=800&q=60',
    ),
    Product(
      name: 'Ray-Ban Aviator',
      type: 'Sunglasses',
      imageUrl:
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&w=800&q=60',
    ),
    Product(
      name: 'Apple Watch SE',
      type: 'Smart Watch',
      imageUrl:
          'https://images.unsplash.com/photo-1579586337278-35d18b068f3d?auto=format&fit=crop&w=800&q=60',
    ),
    Product(
      name: 'Sony WH-1000XM5',
      type: 'Headphones',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=60',
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

  Future<List<Product>> searchProducts(String query) async {
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network search
    if (query.isEmpty) return [];

    return _allProducts
        .where(
          (product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.type.toLowerCase().contains(query.toLowerCase()),
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
          (product) => product.name.toLowerCase().contains(query.toLowerCase()),
        )
        .map((product) => product.name)
        .toList();
  }
}
