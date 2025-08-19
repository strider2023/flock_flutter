import 'package:flock_flutter/modules/marketplace/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // ✨ CHANGED: The root Container has been replaced with a Card.
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Card(
        // The margin is applied directly to the Card.
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        // The shape property is used to maintain the border radius.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // Ensures content inside the card respects the rounded corners.
        clipBehavior: Clip.antiAlias,
        // Elevation is set to 0 to remove any shadow as requested.
        elevation: 0,
        // The Card's child is the Stack that was previously inside the Container.
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Image.network(
                  product.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 120),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Vendor Name
                        Text(
                          product.vendorName,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Item Name
                        Text(
                          product.itemName,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Prices
                        Row(
                          children: [
                            Text(
                              '₹ ${product.purchasePrice.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            if (product.actualPrice != null)
                              Text(
                                '₹ ${product.actualPrice!.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.redAccent,
                                    ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Floating Discount Tag
            if (product.discountPercentage != null)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade800,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${product.discountPercentage?.toInt()}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
