// lib/profile/views/profile_view.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import '../../../common/models/header_action.dart';
import '../../../common/widgets/home_header.dart';
import '../../favorites/viewmodels/favorites_viewmodel.dart';
import '../../favorites/views/favorites_view.dart';
import '../models/user_model.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use context.watch to listen for state changes for building UI
    final viewModel = context.watch<ProfileViewModel>();

    final List<HeaderAction> headerActions = [
      HeaderAction(icon: Ri.logout_circle_line, actionName: 'logout'),
    ];

    return Scaffold(
      appBar: HomeHeader(
        actions: headerActions,
        onActionPressed: (actionName) {
          if (actionName == 'logout') {
            context.read<ProfileViewModel>().logout();
          }
        },
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildProfileBody(context, viewModel.user),
    );
  }

  Widget _buildProfileBody(BuildContext context, UserModel? user) {
    if (user == null) {
      return const Center(child: Text('Could not load profile.'));
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      children: [
        _buildProfileHeader(context, user),
        const SizedBox(height: 30),
        _buildProfileOption(
          context,
          icon: Ri.user_settings_line,
          title: 'My Profile',
          onTap: () {},
        ),
        _buildProfileOption(
          context,
          icon: Ri.user_location_line,
          title: 'My Addresses',
          onTap: () {},
        ),
        _buildProfileOption(
          context,
          icon: Ri.shopping_cart_2_line,
          title: 'Manage Orders',
          onTap: () {},
        ),
        // ✨ CHANGED: "Manage Payments" is now "Favorites"
        _buildProfileOption(
          context,
          icon: Ri.heart_3_line, // Use a consistent icon
          title: 'Favorites',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                  value: context.read<FavoritesViewModel>(),
                  child: const FavoritesView(),
                ),
              ),
            );
          },
        ),
        _buildProfileOption(
          context,
          icon: Ri.chat_smile_2_line,
          title: 'Support',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserModel user) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).primaryColor,
              child: Iconify(Ri.user_6_fill, size: 50),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  user.name,
                  style: GoogleFonts.tinos(
                    fontSize: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(user.phone, style: const TextStyle()),
                Text(user.email, style: const TextStyle()),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color themeColor = isDarkMode
        ? Theme.of(context).primaryColor
        : Color(0xFF232122);

    return ListTile(
      leading: Iconify(icon, color: themeColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap, // Use the passed callback
    );
  }
}
