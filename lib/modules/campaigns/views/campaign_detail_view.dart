import 'package:carousel_slider/carousel_slider.dart';
import 'package:flock_flutter/common/widgets/app_carousel.dart';
import 'package:flock_flutter/common/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/campaign_detail_model.dart';
import '../repositories/campaign_repository.dart';
import '../viewmodels/campaign_detail_viewmodel.dart';
import '../widgets/payment_bottom_sheet.dart';

class CampaignDetailView extends StatelessWidget {
  final int campaignId;
  const CampaignDetailView({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CampaignDetailViewModel(
        repository: context.read<CampaignRepository>(),
        campaignId: campaignId,
      ),
      child: Consumer<CampaignDetailViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(leading: const BackButton()),
            body: viewModel.isLoading || viewModel.campaignDetails == null
                ? const Center(child: CircularProgressIndicator())
                : _buildContent(context, viewModel),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showPaymentSheet(context),
              label: const Text('Fund It!'),
              icon: const Iconify(Ri.hand_heart_line),
            ),
            // ✨ ADDED: Location for the FAB
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            // ✨ UPDATED: The BottomAppBar now contains other actions
            bottomNavigationBar: _buildBottomAppBar(context),
          );
        },
      ),
    );
  }

  void _showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (_) => const PaymentBottomSheet(),
    );
  }

  Widget _buildContent(
    BuildContext context,
    CampaignDetailViewModel viewModel,
  ) {
    final details = viewModel.campaignDetails!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Media Carousel
          AppCarousel<String>(
            items: details.mediaUrls,
            options: CarouselOptions(height: 250, viewportFraction: 1.0),
            itemBuilder: (context, url) =>
                Image.network(url, fit: BoxFit.cover, width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVendorSection(context, details),
                const Divider(height: 32),
                _buildInteractionBar(context, details),
                const SizedBox(height: 24),
                Text(
                  details.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Campaign ends on ${DateFormat('d MMMM yyyy').format(details.campaignEndDate)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Goal: ₹${details.totalFundAmount.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Text(details.description),
                const SizedBox(height: 24),
                Text(
                  'Products in this Campaign',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          // Associated Products
          ...details.associatedProducts.map((product) {
            return ProductCard(product: product, mode: CardMode.horizontal);
          }),
          const SizedBox(height: 60), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildVendorSection(
    BuildContext context,
    CampaignDetailModel details,
  ) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(details.vendorAvatarUrl),
          radius: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                details.vendorName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                details.vendorDetails,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        OutlinedButton(onPressed: () {}, child: const Text('Follow')),
      ],
    );
  }

  Widget _buildInteractionBar(
    BuildContext context,
    CampaignDetailModel details,
  ) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color themeColor = isDarkMode
        ? Theme.of(context).primaryColor
        : Color(0xFF232122);

    final progress = (details.pledgeCount / details.pledgeGoal).clamp(0.0, 1.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${details.pledgeCount} pledged',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 200,
              height: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(value: progress),
              ),
            ),
          ],
        ),
        IconButton(
          icon: Iconify(Ri.share_forward_line, color: themeColor),
          onPressed: () {
            // TODO: Implement share functionality
          },
        ),
      ],
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color themeColor = isDarkMode
        ? Theme.of(context).primaryColor
        : Color(0xFF232122);

    return BottomAppBar(
      notchMargin: 8.0,
      child: Row(
        // The main axis alignment is start, so icons are on the left.
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Iconify(Ri.share_line, color: themeColor),
            onPressed: () {
              // TODO: Implement general share functionality
            },
          ),
        ],
      ),
    );
  }
}
