import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flock_flutter/models/carousel_item.dart';
import 'package:flock_flutter/models/feed_item.dart';
import 'package:flock_flutter/shared/components/filter_panel.dart';
import 'package:flock_flutter/shared/components/carousel_item_card.dart';
import 'package:flock_flutter/shared/components/feed_item_card.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<FeedItem> _allFeedItems = [];
  List<FeedItem> _filteredFeedItems = [];

  String? _activeCampaignFilter;
  String? _activeLikeSortOrder;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // _fetchAndSetFeed();
  }

  // Future<void> _fetchAndSetFeed() async {
  //   setState(() => _isLoading = true);
  //   final items = await _apiService.getFeedData(context);
  //   setState(() {
  //     _allFeedItems = items;
  //     _applyFilters();
  //     _isLoading = false;
  //   });
  // }

  void _applyFilters() {
    // List<FeedItem> items = List.from(_allFeedItems);

    // // Campaign Filtering (client-side example)
    // if (_activeCampaignFilter != null) {
    //   if (_activeCampaignFilter == 'New Launches') {
    //     items.retainWhere((item) => DateTime.now().difference(item.launchDate).inDays <= 7);
    //   } else if (_activeCampaignFilter == 'Closing Soon') {
    //     items.retainWhere((item) => (item.pledgeGoal - item.pledgeCount) < 100 && item.pledgeCount < item.pledgeGoal);
    //   } else if (_activeCampaignFilter == 'Expiring Soon') {
    //      // This is just an example, you'd have an expiry date in a real model
    //     items.retainWhere((item) => item.id % 3 == 0);
    //   }
    // }

    // // Like Sorting
    // if (_activeLikeSortOrder != null) {
    //   if (_activeLikeSortOrder == 'high-low') {
    //     items.sort((a, b) => b.likeCount.compareTo(a.likeCount));
    //   } else if (_activeLikeSortOrder == 'low-high') {
    //     items.sort((a, b) => a.likeCount.compareTo(b.likeCount));
    //   }
    // }

    // setState(() {
    //   _filteredFeedItems = items;
    // });
  }

  void _showFilterPanel() async {
    final result = await showModalBottomSheet<Map<String, String?>>(
      context: context,
      builder: (context) => FilterPanel(
        initialCampaignFilter: _activeCampaignFilter,
        initialLikeSortOrder: _activeLikeSortOrder,
      ),
      isScrollControlled: true,
    );

    if (result != null) {
      setState(() {
        _activeCampaignFilter = result['campaign'];
        _activeLikeSortOrder = result['sort'];
        // _applyFilters();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title of the app.
        title: const Text('Flock'),

        // Actions for notifications and filtering.
        actions: [
          IconButton(
            icon: Iconify(Ri.notification_2_fill, color: Colors.green.shade800),
            onPressed: () {
              // TODO: Handle notifications tap
            },
          ),
          IconButton(
            icon: Iconify(Ri.filter_3_fill, color: Colors.green.shade800),
            onPressed: _showFilterPanel,
          ),
        ],

        // Ensures the app bar does not show a back button.
        automaticallyImplyLeading: false,

        // Creates a clean, flat look consistent with the original design.
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        // The children of the list view are displayed sequentially.
        children: [
          // The carousel is now the first item in the list.
          _buildCarousel(),

          // This generates the list of 10 feed cards using a collection-for loop.
          ...List.generate(10, (index) => _buildFeedCard(index)),

          // Adds the desired extra space at the very end of the list.
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  // The _buildSearchField method has been removed as it's no longer needed.

  Widget _buildCarousel() {
    final List<CarouselItem> carouselItems = [
      CarouselItem(
        title: 'Project Alpha',
        description: 'A revolutionary new way to\nmanage your daily tasks.',
        imageUrl:
            'https://static.vecteezy.com/system/resources/thumbnails/034/630/930/small_2x/elegant-decorative-vases-and-planters-with-succulents-and-other-plants-on-transparent-background-interior-accessories-cut-out-home-decor-front-view-ai-generated-png.png',
        backgroundColor: Colors.amber,
      ),
      CarouselItem(
        title: 'Creative Hub',
        description:
            'Connect with artists and creators\nfrom around the world.',
        imageUrl:
            'https://images.squarespace-cdn.com/content/v1/64370d26da28bc38144ca6e4/1682645870375-GUGT050JBKU3S7JL9G99/5.png',
        backgroundColor: Colors.lightBlue.shade200,
      ),
      CarouselItem(
        title: 'Eco-Friendly Tech',
        description: 'Sustainable gadgets that help\nprotect our planet.',
        imageUrl:
            'https://images.squarespace-cdn.com/content/v1/64370d26da28bc38144ca6e4/1682645870375-GUGT050JBKU3S7JL9G99/5.png',
        backgroundColor: Colors.teal.shade200,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 180.0,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
        ),
        items: carouselItems.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return CarouselItemCard(item: item);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeedCard(int index) {
    final FeedItem feedItem = FeedItem(
      id: index,
      imageUrls: [
        'https://images.squarespace-cdn.com/content/v1/64370d26da28bc38144ca6e4/1682645870375-GUGT050JBKU3S7JL9G99/5.png',
      ],
      title: 'Default Title',
      description: 'Default Description',
      likeCount: 10 + Random().nextInt((500 + 1) - 10),
      pledgeCount: 100 + Random().nextInt((999 + 1) - 100),
      pledgeGoal: 1000,
      commentCount: 10 + Random().nextInt((500 + 1) - 10),
      vendorName: 'Arindam Nath',
      vendorAvatarUrl: '',
      campaignEndDate: DateTime.now().add(Duration(days: 15)),
      postedDate: DateTime.now().subtract(Duration(days: 2)),
    );
    return FeedCard(item: feedItem);
  }
}
