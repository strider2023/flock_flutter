import 'package:flock_flutter/modules/campaigns/models/carousel_item.dart';
import 'package:flutter/material.dart';

class CarouselItemCard extends StatelessWidget {
  final CarouselItem item;

  const CarouselItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      // This clips the child widgets (the Row) to match the container's rounded corners.
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: item.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      // Use a Row for a clean two-column layout instead of a Stack.
      child: Row(
        children: [
          // ## Left Column: Text ##
          // Expanded makes this column take up exactly half the available space.
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              // FIX: Wrap the Column with a SingleChildScrollView.
              child: SingleChildScrollView(
                child: Column(
                  // Center the text vertically within the column.
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ## Right Column: Image ##
          // Expanded makes this column also take up exactly half the space.
          Expanded(
            flex: 1,
            child: Image.network(
              item.imageUrl,
              // BoxFit.cover scales the image to fill the entire column.
              fit: BoxFit.cover,
              // Ensures the image fills the height of the column.
              height: double.infinity,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.image, size: 60, color: Colors.black26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
