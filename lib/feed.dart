// --- Feed Page (Extracted from HomePage) ---
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flock_flutter/models/carousel_item.dart';
import 'package:flock_flutter/models/feed_item.dart';
import 'package:flock_flutter/shared/components/filter_panel.dart';
import 'package:flock_flutter/shared/widgets/carousel_item_card.dart';
import 'package:flutter/material.dart';

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
        _applyFilters();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            title: _buildSearchField(),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.black),
                onPressed: _showFilterPanel,
              ),
            ],
            floating: true,
            pinned: true,
            snap: true,
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(child: _buildCarousel()),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              child: Container(
                color: Colors.white,
                child: _buildCategoryList(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildFeedCard(index);
              },
              childCount: 10, // Example number of feed items
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    final List<CarouselItem> carouselItems = [
      CarouselItem(
        title: 'Project Alpha',
        description: 'A revolutionary new way to\nmanage your daily tasks.',
        imageUrl: 'https://placehold.co/300x300/png',
        backgroundColor: Colors.amber,
      ),
      CarouselItem(
        title: 'Creative Hub',
        description:
            'Connect with artists and creators\nfrom around the world.',
        imageUrl: 'https://placehold.co/300x300/png',
        backgroundColor: Colors.lightBlue.shade200,
      ),
      CarouselItem(
        title: 'Eco-Friendly Tech',
        description: 'Sustainable gadgets that help\nprotect our planet.',
        imageUrl: 'https://placehold.co/300x300/png',
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
        // Map over your data to create a list of CarouselItemCard widgets
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

  Widget _buildCategoryList() {
    final categories = [
      {'icon': Icons.lightbulb_outline, 'name': 'Tech'},
      {'icon': Icons.brush, 'name': 'Art'},
      {'icon': Icons.music_note, 'name': 'Music'},
      {'icon': Icons.movie_creation_outlined, 'name': 'Film'},
      {'icon': Icons.games_outlined, 'name': 'Games'},
      {'icon': Icons.book_outlined, 'name': 'Books'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    categories[index]['icon'] as IconData,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Text(categories[index]['name'] as String),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedCard(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image/Video placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Title and Description
          Text(
            'Project Feed Title $index',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'A short, compelling description of the project goes here to attract backers and supporters.',
          ),
          const SizedBox(height: 16),
          // Pledge Meter
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pledge Count: 1,234 / 2,000'),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: 0.6, // Example progress
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInteractionButton(
                icon: Icons.favorite_border,
                label: '123',
                onPressed: () {},
              ),
              _buildInteractionButton(
                icon: Icons.comment_outlined,
                label: '321',
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.black54),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black54, size: 20),
      label: Text(label, style: const TextStyle(color: Colors.black54)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

// Delegate for SliverPersistentHeader to make the category list sticky
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 100.0;
  @override
  double get maxExtent => 100.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
