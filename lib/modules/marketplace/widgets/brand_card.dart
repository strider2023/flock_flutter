import 'package:flock_flutter/modules/marketplace/models/brand_model.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  final BrandModel brand;

  const BrandCard({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    // The root widget is now a Column to match the avatar styling.
    // The outer Card and SizedBox have been removed for a flatter look.
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // The Image is replaced with a CircleAvatar for the circular avatar style.
        CircleAvatar(
          radius: 42,
          // A fallback background color for while the image loads.
          backgroundColor: Colors.green.shade800,
          // The brand's image is now the background of the avatar.
          backgroundImage: NetworkImage(brand.imageUrl),
        ),
        const SizedBox(height: 8),
        // The Text widget is placed in a SizedBox to control its width
        // and prevent long names from breaking the layout.
        SizedBox(
          width: 75, // Keeps the text width constrained under the avatar
          child: Text(
            brand.name,
            textAlign: TextAlign.center,
            maxLines: 2, // Allow for slightly longer brand names
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
