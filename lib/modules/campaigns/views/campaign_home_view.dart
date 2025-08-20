// lib/feed/views/feed_home_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconify_flutter/icons/ri.dart';

import '../../../common/models/header_action.dart';
import '../../../common/widgets/app_carousel.dart';
import '../../../common/widgets/home_header.dart';
import '../models/carousel_item.dart';
import '../viewmodels/campaign_viewmodel.dart';
import '../widgets/carousel_item_card.dart';
import '../widgets/feed_item_card.dart';
import '../widgets/filter_panel.dart';

class CampaignHomeView extends StatelessWidget {
  const CampaignHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Read the ViewModel once for actions
    final feedViewModel = context.read<FeedViewModel>();

    final List<HeaderAction> headerActions = [
      HeaderAction(icon: Ri.filter_3_fill, actionName: 'filter'),
    ];

    return Scaffold(
      appBar: HomeHeader(
        actions: headerActions,
        onActionPressed: (actionName) {
          if (actionName == 'filter') {
            _showFilterPanel(context, feedViewModel);
          }
        },
      ),
      // Watch the ViewModel for state changes to rebuild the body
      body: Consumer<FeedViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return _buildFeedList(viewModel);
        },
      ),
    );
  }

  void _showFilterPanel(BuildContext context, FeedViewModel viewModel) async {
    final result = await showModalBottomSheet<Map<String, String?>>(
      context: context,
      builder: (_) => FilterPanel(
        initialCampaignFilter: viewModel.activeCampaignFilter,
        initialLikeSortOrder: viewModel.activeLikeSortOrder,
      ),
      isScrollControlled: true,
    );

    if (result != null) {
      viewModel.applyFilters(result);
    }
  }

  Widget _buildFeedList(FeedViewModel viewModel) {
    return ListView(
      children: [
        _buildCarousel(viewModel),
        ...viewModel.feedItems.map((item) => FeedCard(item: item)),
      ],
    );
  }

  Widget _buildCarousel(FeedViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: AppCarousel<CarouselItem>(
        items: viewModel.carouselItems,
        itemBuilder: (context, item) {
          return CarouselItemCard(item: item);
        },
        options: CarouselOptions(
          height: 180.0,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
        ),
      ),
    );
  }
}
