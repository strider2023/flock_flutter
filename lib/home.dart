import 'package:flock_flutter/feed.dart';
import 'package:flock_flutter/profile.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';

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
    PlaceholderWidget(text: 'Search'),
    PlaceholderWidget(text: 'Shop'),
    PlaceholderWidget(text: 'My Pledges'),
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
      // The body is now a Stack, which allows widgets to be layered.
      body: Stack(
        children: [
          // This is your main page content.
          Center(child: _widgetOptions.elementAt(_selectedIndex)),
          // The Align widget positions the navigation bar at the bottom of the Stack.
          Align(alignment: Alignment.bottomCenter, child: _buildBottomNavBar()),
        ],
      ),
      // The bottomNavigationBar property has been removed from the Scaffold.
    );
  }

  // This method remains unchanged.
  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Ri.home_7_fill, 0),
          _buildNavItem(Ri.search_2_fill, 1),
          _buildNavItem(Ri.shopping_bag_2_fill, 2),
          _buildNavItem(Ri.hand_coin_fill, 3),
          _buildNavItem(Ri.menu_fill, 4),
        ],
      ),
    );
  }

  // This method remains unchanged.
  Widget _buildNavItem(String icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: _selectedIndex == index
            ? Color(0xFFF4FDDF)
            : Colors.black,
        child: Iconify(
          icon,
          color: _selectedIndex == index ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

// --- Placeholder for other tabs ---
// This widget remains unchanged.
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
