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

  static final List<Widget> _widgetOptions = <Widget>[
    const CampaignHomeView(),
    const SearchPage(),
    MarketplaceHomeView(),
    const FavoritesView(),
    const ProfileView(),
  ];

  List<NavigationDestination> _getNavDestinations(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color unselectedColor = isDarkMode ? Colors.white : Color(0xFF232122);
    final Color selectedColor = isDarkMode
        ? Color(0xFF232122)
        : Color(0xFF232122);

    return [
      NavigationDestination(
        icon: Iconify(Ri.home_7_line, color: unselectedColor),
        selectedIcon: Iconify(Ri.home_7_fill, color: selectedColor),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Iconify(Ri.search_2_line, color: unselectedColor),
        selectedIcon: Iconify(Ri.search_2_fill, color: selectedColor),
        label: 'Search',
      ),
      NavigationDestination(
        icon: Iconify(Ri.shopping_bag_2_line, color: unselectedColor),
        selectedIcon: Iconify(Ri.shopping_bag_2_fill, color: selectedColor),
        label: 'Market',
      ),
      NavigationDestination(
        icon: Iconify(Ri.heart_3_line, color: unselectedColor),
        selectedIcon: Iconify(Ri.heart_3_fill, color: selectedColor),
        label: 'Liked',
      ),
      NavigationDestination(
        icon: Iconify(Ri.user_6_line, color: unselectedColor),
        selectedIcon: Iconify(Ri.user_6_fill, color: selectedColor),
        label: 'Profile',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: NavigationBar(
        destinations: _getNavDestinations(context),
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        indicatorColor: Theme.of(context).primaryColor,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
    );
  }
}
