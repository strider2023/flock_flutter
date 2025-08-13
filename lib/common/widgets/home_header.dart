// lib/widgets/home_header.dart
import 'package:flock_flutter/common/models/header_action.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<HeaderAction> actions;
  final void Function(String actionName) onActionPressed;

  const HomeHeader({
    super.key,
    this.title = 'Flock', // Default title
    required this.actions,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      // Dynamically build the actions from the list provided.
      actions: actions.map((action) {
        return IconButton(
          icon: Iconify(action.icon, color: Colors.green.shade800),
          onPressed: () {
            // Emit the action name when the icon is pressed.
            onActionPressed(action.actionName);
          },
        );
      }).toList(),
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0, // Set color for title and icons
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
