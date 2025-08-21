// lib/marketplace/views/marketplace_home_view.dart

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flock_flutter/common/widgets/app_carousel.dart';
import 'package:flock_flutter/modules/marketplace/models/brand_model.dart';
import 'package:flock_flutter/modules/search/viewmodels/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconify_flutter/icons/ri.dart';

import '../../../common/models/header_action.dart';
import '../../../common/models/product_model.dart';
import '../../../common/viewmodels/category_viewmodel.dart';
import '../../../common/viewmodels/navigation_viewmodel.dart';
import '../../../common/widgets/category_list.dart';
import '../../../common/widgets/home_header.dart';
import '../../../common/widgets/product_card.dart';
import '../../search/views/search_page.dart';
import '../models/marketplace_feed_model.dart';
import '../repositories/marketplace_repository.dart';
import '../viewmodels/marketplace_viewmodel.dart';
import '../widgets/brand_card.dart';
import '../widgets/campaign_promo_card.dart';
import '../widgets/marketplace_section.dart';

class MarketplaceHomeView extends StatelessWidget {
  final String? category;

  MarketplaceHomeView({super.key, this.category});

  final List<HeaderAction> headerActions = [
    HeaderAction(icon: Ri.search_2_line, actionName: 'search'),
    HeaderAction(icon: Ri.shopping_cart_line, actionName: 'cart'),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MarketplaceViewModel(
        repository: context.read<MarketplaceRepository>(),
        category: category,
      ),
      child: Consumer<MarketplaceViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: HomeHeader(
              // Conditionally show back button if it's a category page
              showBackButton: category != null,
              actions: headerActions,
              onActionPressed: (actionName) {
                if (actionName == 'search') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider.value(
                        value: context.read<SearchViewModel>(),
                        child: const SearchPage(),
                      ),
                    ),
                  );
                }
              },
            ),
            body: _buildBody(context, viewModel),
          );
        },
      ),
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
      itemCount: viewModel.feedItems.length,
      itemBuilder: (context, index) {
        final section = viewModel.feedItems[index];

        if (section is CarouselSection) {
          return Column(
            children: [
              AppCarousel<ProductModel>(
                items: section.products,
                itemBuilder: (context, product) {
                  return ProductCard(product: product, width: CardWidth.full);
                },
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 7),
                ),
              ),
              if (category == null) _buildCategoryOptions(context, viewModel),
            ],
          );
        } else if (section is CategoryProductSection) {
          return MarketplaceSection<ProductModel>(
            title: section.title,
            items: section.products,
            listHeight: 300,
            onSeeMore: () => debugPrint("See more products"),
            itemBuilder: (product) => ProductCard(
              product: product,
              width: CardWidth
                  .compressed, // Explicitly using the default full width
            ),
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

  _buildCategoryOptions(BuildContext context, MarketplaceViewModel viewModel) {
    return Column(
      children: [
        CampaignPromoCard(
          count: viewModel.activeCampaignsCount,
          headline: 'Campaigns',
          onTap: () {
            context.read<NavigationViewModel>().changeTab(1);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CategoryList(
            onCategorySelected: (categoryId) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiProvider(
                    providers: [
                      // Provide the existing instances of repositories and viewmodels
                      // that the new page and its children will need.
                      Provider.value(
                        value: context.read<MarketplaceRepository>(),
                      ),
                      ChangeNotifierProvider.value(
                        value: context.read<SearchViewModel>(),
                      ),
                      ChangeNotifierProvider.value(
                        value: context.read<NavigationViewModel>(),
                      ),
                      ChangeNotifierProvider.value(
                        value: context.read<CategoryViewModel>(),
                      ),
                    ],
                    // The new MarketplaceHomeView will create its own MarketplaceViewModel,
                    // but it needs the repository provided above to do so.
                    child: MarketplaceHomeView(category: categoryId),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
