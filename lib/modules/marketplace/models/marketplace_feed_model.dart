// lib/models/home_feed_model.dart

import '../../../common/models/product_model.dart';
import 'brand_model.dart';

// Abstract class that all section models will implement.
abstract class FeedSection {
  const FeedSection();
}

// Represents the main product carousel at the top.
class CarouselSection extends FeedSection {
  final List<ProductModel> products;
  const CarouselSection({required this.products});
}

// Represents a category section with a title and a list of products.
class CategoryProductSection extends FeedSection {
  final String title;
  final List<ProductModel> products;
  const CategoryProductSection({required this.title, required this.products});
}

// Represents a brand section with a title and a list of brands.
class BrandSection extends FeedSection {
  final String title;
  final List<BrandModel> brands;
  const BrandSection({required this.title, required this.brands});
}
