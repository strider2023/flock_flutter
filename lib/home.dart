import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// --- Home Page ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // --- Top App Bar with Search and Icons ---
          SliverAppBar(
            backgroundColor: Colors.white,
            title: _buildSearchField(),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
            floating: true, // App bar floats over the content
            pinned: true, // App bar stays visible
            snap: true, // App bar snaps into view
          ),
          // --- Carousel Section ---
          SliverToBoxAdapter(child: _buildCarousel()),
          // --- Sticky Category Header ---
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              child: Container(
                color: Colors.white,
                child: _buildCategoryList(),
              ),
            ),
          ),
          // --- Main Feed Content ---
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
      // --- Floating Bottom Navigation Bar ---
      bottomNavigationBar: _buildBottomNavBar(),
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
        items: [1, 2, 3].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // Text content on the left
                    const Positioned(
                      left: 20,
                      top: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Project Title',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Two liner description about the\nawesome new project.',
                            style: TextStyle(color: Colors.black87),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: null,
                            child: Text('View Project'),
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
                          'https://placehold.co/300x300/png',
                          fit: BoxFit.contain, // Placeholder image
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.image,
                                size: 100,
                                color: Colors.black26,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
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
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.home, 0),
          _buildNavItem(Icons.category, 1),
          _buildNavItem(Icons.favorite, 2),
          _buildNavItem(Icons.person, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: _selectedIndex == index ? Colors.white : Colors.black,
        child: Icon(
          icon,
          color: _selectedIndex == index ? Colors.black : Colors.white,
        ),
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
