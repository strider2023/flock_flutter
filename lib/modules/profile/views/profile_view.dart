// lib/profile/views/profile_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import '../models/user_model.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use context.watch to listen for state changes for building UI
    final viewModel = context.watch<ProfileViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flock'),
        actions: [
          IconButton(
            icon: Iconify(Ri.logout_circle_line, color: Colors.green.shade800),
            // Use context.read for one-time actions like button presses
            onPressed: () => context.read<ProfileViewModel>().logout(),
          ),
        ],
        automaticallyImplyLeading: false,
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
        ),
        _buildProfileOption(
          context,
          icon: Ri.user_location_line,
          title: 'My Addresses',
        ),
        _buildProfileOption(
          context,
          icon: Ri.shopping_cart_2_line,
          title: 'Manage Orders',
        ),
        _buildProfileOption(
          context,
          icon: Ri.bank_card_2_line,
          title: 'Manage Payments',
        ),
        _buildProfileOption(
          context,
          icon: Ri.chat_smile_2_line,
          title: 'Support',
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserModel user) {
    return InkWell(
      onTap: () {
        /* TODO: Navigate */
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              child: Iconify(Ri.user_6_fill, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontFamily: 'FlockFont',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(user.phone, style: const TextStyle(color: Colors.black54)),
                Text(user.email, style: const TextStyle(color: Colors.black54)),
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
  }) {
    return ListTile(
      leading: Iconify(icon, color: Colors.green.shade800),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.green.shade800,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black54,
      ),
      onTap: () {
        /* TODO: Navigate */
      },
    );
  }
}
