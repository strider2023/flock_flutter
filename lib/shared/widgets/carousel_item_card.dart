import 'package:flock_flutter/models/carousel_item.dart';
import 'package:flutter/material.dart';

class CarouselItemCard extends StatelessWidget {
  final CarouselItem item;

  const CarouselItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: item.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Text content on the left
          Positioned(
            left: 20,
            top: 30,
            child: Column(
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    /* TODO: Implement navigation */
                  },
                  // Use a style that works on a colored background
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('View Project'),
                ),
              ],
            ),
          ),
          // Image on the right, blending into the background
          Positioned(
            right: -40,
            bottom: -20,
            child: SizedBox(
              height: 160,
              width: 160,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 100, color: Colors.black26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
