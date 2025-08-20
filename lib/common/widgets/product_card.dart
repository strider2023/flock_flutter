import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import '../models/product_model.dart';

// Enum for card width options, primarily for vertical cards.
enum CardWidth { full, compressed }

// ✨ ADDED: Enum to define the card's orientation.
enum CardMode { vertical, horizontal }

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final CardWidth width;
  // ✨ ADDED: New parameter to control the card's mode.
  final CardMode mode;

  const ProductCard({
    super.key,
    required this.product,
    this.width = CardWidth.full,
    this.mode = CardMode.vertical, // Default is vertical
  });

  @override
  Widget build(BuildContext context) {
    // Switch between layouts based on the mode.
    return switch (mode) {
      CardMode.horizontal => _buildHorizontalLayout(context),
      CardMode.vertical => _buildVerticalLayout(context),
    };
  }

  // --- VERTICAL LAYOUT ---
  Widget _buildVerticalLayout(BuildContext context) {
    double cardWidth;
    switch (width) {
      case CardWidth.compressed:
        cardWidth =
            MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width / 4);
        break;
      case CardWidth.full:
        cardWidth = MediaQuery.of(context).size.width - 20;
        break;
    }

    return SizedBox(
      width: cardWidth,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(height: 180),
                Flexible(child: _buildContent(context)),
              ],
            ),
            _buildDiscountTag(context),
          ],
        ),
      ),
    );
  }

  // --- HORIZONTAL LAYOUT ---
  Widget _buildHorizontalLayout(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: SizedBox(
        height: 140, // Fixed height for a list item
        child: Row(
          children: [
            SizedBox(width: 120, child: _buildImage(height: 140)),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
    );
  }

  // --- SHARED WIDGETS (Refactored for reuse) ---

  Widget _buildImage({required double height}) {
    return Image.network(
      product.imageUrl,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          Icon(Icons.error, size: height / 2),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            product.category,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.itemName,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: mode == CardMode.horizontal
                ? 2
                : 1, // Allow more lines in horizontal
            overflow: TextOverflow.ellipsis,
          ),
          _buildRating(context),
          _buildPrices(context),
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    return Row(
      children: [
        Iconify(Ri.star_fill, color: Theme.of(context).primaryColor, size: 16),
        const SizedBox(width: 4),
        Text(
          '${product.rating}',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Text(
          '(${product.ratingCount})',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildPrices(BuildContext context) {
    return Row(
      children: [
        Text(
          '₹ ${product.purchasePrice.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        if (product.actualPrice != null)
          Text(
            '₹ ${product.actualPrice!.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: Colors.red,
            ),
          ),
      ],
    );
  }

  Widget _buildDiscountTag(BuildContext context) {
    if (product.discountPercentage == null) return const SizedBox.shrink();
    return Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${product.discountPercentage?.toInt()}% OFF',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
