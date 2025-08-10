import 'package:flock_flutter/feed.dart';
import 'package:flock_flutter/profile.dart';
import 'package:flutter/material.dart';

// --- Home Page ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages to be displayed by the bottom nav bar
  static const List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    PlaceholderWidget(text: 'Categories'),
    PlaceholderWidget(text: 'Favorites'),
    PlaceholderWidget(text: 'Cart'),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
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
          _buildNavItem(Icons.shopping_cart, 3),
          _buildNavItem(Icons.person, 4),
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

// --- Placeholder for other tabs ---
class PlaceholderWidget extends StatelessWidget {
  final String text;
  const PlaceholderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text)),
      body: Center(
        child: Text(text, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
