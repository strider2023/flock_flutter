// lib/common/models/product_model.dart

class ProductModel {
  final String imageUrl;
  final String vendorName;
  final String itemName;
  final String category; // ✨ ADDED
  final double purchasePrice;
  final double? actualPrice;
  final double? discountPercentage;
  final double rating; // ✨ ADDED
  final int ratingCount; // ✨ ADDED

  ProductModel({
    required this.imageUrl,
    required this.vendorName,
    required this.itemName,
    required this.category,
    required this.purchasePrice,
    this.actualPrice,
    this.discountPercentage,
    required this.rating,
    required this.ratingCount,
  });
}
