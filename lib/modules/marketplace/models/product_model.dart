// lib/models/product_model.dart

class ProductModel {
  final String imageUrl;
  final String vendorName;
  final String itemName;
  final double purchasePrice;
  final double? actualPrice; // Nullable for items not on discount
  final double? discountPercentage; // Nullable for the floating tag

  ProductModel({
    required this.imageUrl,
    required this.vendorName,
    required this.itemName,
    required this.purchasePrice,
    this.actualPrice,
    this.discountPercentage,
  });
}
