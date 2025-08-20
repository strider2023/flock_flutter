import 'package:flock_flutter/modules/campaigns/views/campaign_home_view.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:provider/provider.dart';

import 'common/viewmodels/navigation_viewmodel.dart';
import 'modules/marketplace/views/marketplace_home_view.dart';
import 'modules/notifications/views/notification_view.dart';
import 'modules/profile/views/profile_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    MarketplaceHomeView(),
    CampaignHomeView(),
    NotificationView(),
    ProfileView(),
  ];

  List<NavigationDestination> _getNavDestinations(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color unselectedColor = isDarkMode ? Colors.white : Color(0xFF232122);
    final Color selectedColor = isDarkMode
        ? Color(0xFF232122)
        : Color(0xFFfbfbfb);

    return [
      NavigationDestination(
        icon: Iconify(Ri.shopping_bag_2_line, color: unselectedColor),
        selectedIcon: Iconify(Ri.shopping_bag_2_fill, color: selectedColor),
        label: 'Market',
      ),
      NavigationDestination(
        icon: Iconify(Ri.hand_heart_line, color: unselectedColor),
        selectedIcon: Iconify(Ri.hand_heart_fill, color: selectedColor),
        label: 'Fund It',
      ),
      NavigationDestination(
        icon: Iconify(Ri.notification_3_line, color: unselectedColor),
        selectedIcon: Iconify(Ri.notification_3_fill, color: selectedColor),
        label: 'Notifications',
      ),
      NavigationDestination(
        icon: Iconify(Ri.user_6_line, color: unselectedColor),
        selectedIcon: Iconify(Ri.user_6_fill, color: selectedColor),
        label: 'Profile',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final navViewModel = context.watch<NavigationViewModel>();

    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(navViewModel.selectedIndex)),
      bottomNavigationBar: NavigationBar(
        destinations: _getNavDestinations(context),
        selectedIndex: navViewModel.selectedIndex,
        onDestinationSelected: (index) =>
            context.read<NavigationViewModel>().changeTab(index),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
    );
  }
}
