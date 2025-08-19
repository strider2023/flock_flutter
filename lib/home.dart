import 'package:flock_flutter/modules/campaigns/views/campaign_home_view.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';

import 'modules/favorites/views/favorites_view.dart';
import 'modules/marketplace/views/marketplace_home_view.dart';
import 'modules/profile/views/profile_view.dart';
import 'modules/search/views/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CampaignHomeView(),
    SearchPage(),
    MarketplaceHomeView(),
    FavoritesView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body now directly shows the selected page from the list.
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      // The BottomNavigationBar is now a standard Material widget.
      bottomNavigationBar: BottomNavigationBar(
        // The list of items for the navigation bar.
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Iconify(Ri.home_7_line),
            activeIcon: Iconify(Ri.home_7_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Iconify(Ri.search_2_line),
            activeIcon: Iconify(Ri.search_2_fill),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Iconify(Ri.shopping_bag_2_line),
            activeIcon: Iconify(Ri.shopping_bag_2_fill),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Iconify(Ri.heart_3_line),
            activeIcon: Iconify(Ri.heart_3_fill),
            label: 'Liked',
          ),
          BottomNavigationBarItem(
            icon: Iconify(Ri.user_6_line),
            activeIcon: Iconify(Ri.user_6_fill),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // --- Theming for the Navigation Bar ---
        // Sets the type to fixed for consistent background color.
        type: BottomNavigationBarType.fixed,
        // Uses the primary color from your theme for the selected item.
        selectedItemColor: Theme.of(context).primaryColor,
        // Uses a muted grey for unselected items.
        unselectedItemColor: Colors.grey.shade600,
        // Hides the labels for a cleaner look.
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // Removes the top border for a seamless look with the content.
        elevation: 0,
      ),
    );
  }
}
