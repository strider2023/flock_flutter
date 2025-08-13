// lib/widgets/brand_card.dart

import 'package:flock_flutter/models/brand_model.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  final BrandModel brand;

  const BrandCard({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                brand.imageUrl,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                brand.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
