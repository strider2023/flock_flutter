// lib/marketplace/views/marketplace_home_view.dart

import 'package:flock_flutter/modules/marketplace/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';

import '../models/marketplace_feed_model.dart';
import '../models/product_model.dart';
import '../viewmodels/marketplace_viewmodel.dart';
import '../widgets/brand_card.dart';
import '../widgets/marketplace_section.dart';
import '../widgets/product_card.dart';
import '../widgets/product_carousel_section.dart';

class MarketplaceHomeView extends StatelessWidget {
  const MarketplaceHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch for changes in the ViewModel
    final viewModel = context.watch<MarketplaceViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flock'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Iconify(Ri.search_2_line, color: Colors.green.shade800),
          ),
          IconButton(
            onPressed: () {},
            icon: Iconify(Ri.notification_3_line, color: Colors.green.shade800),
          ),
          IconButton(
            onPressed: () {},
            icon: Iconify(Ri.shopping_cart_line, color: Colors.green.shade800),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, MarketplaceViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.feedItems.isEmpty) {
      return const Center(child: Text('No items to display.'));
    }

    return ListView.builder(
      itemCount: viewModel.feedItems.length + 1,
      itemBuilder: (context, index) {
        if (index == viewModel.feedItems.length) {
          return const SizedBox(height: 100);
        }

        final section = viewModel.feedItems[index];

        if (section is CarouselSection) {
          return ProductCarouselSection(section: section);
        } else if (section is CategoryProductSection) {
          return MarketplaceSection<ProductModel>(
            title: section.title,
            items: section.products,
            listHeight: 320,
            onSeeMore: () => debugPrint("See more products"),
            itemBuilder: (product) => ProductCard(product: product),
            backgroundColor: Colors.black12,
          );
        } else if (section is BrandSection) {
          return MarketplaceSection<BrandModel>(
            title: section.title,
            items: section.brands,
            listHeight: 120,
            onSeeMore: () => debugPrint("See more brands"),
            itemBuilder: (brand) => BrandCard(brand: brand),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
