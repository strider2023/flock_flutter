import 'package:flock_flutter/modules/feed/feed.dart';
import 'package:flock_flutter/modules/marketplace/marketplace.dart';
import 'package:flock_flutter/modules/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    PlaceholderWidget(text: 'Search'),
    MarketplaceHome(),
    PlaceholderWidget(text: 'Liked'),
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

  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green.shade800,
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
          _buildNavItem(Ri.heart_3_fill, 3),
          _buildNavItem(Ri.menu_fill, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(String icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: _selectedIndex == index
            ? Color(0xFFF4FDDF)
            : Colors.green.shade800,
        child: Iconify(
          icon,
          color: _selectedIndex == index
              ? Colors.green.shade800
              : Color(0xFFF4FDDF),
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text;
  const PlaceholderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text), automaticallyImplyLeading: false),
      body: Center(
        child: Text(text, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
