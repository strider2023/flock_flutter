// --- Profile Page ---
import 'package:flock_flutter/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // Navigate back to WelcomePage and remove all routes behind
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flock'),
        actions: [
          IconButton(
            icon: Iconify(Ri.logout_circle_line, color: Colors.green.shade800),
            onPressed: () => _logout(context),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          _buildProfileHeader(context),
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
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to profile details page
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        // Changed Row to a Column for vertical layout
        child: Column(
          // Center the items horizontally
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              child: Iconify(Ri.user_6_fill, size: 50, color: Colors.black),
            ),
            // Changed to vertical spacing
            const SizedBox(height: 20),
            // Removed the Expanded widget, no longer needed in a Column
            Column(
              // Center the text content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Jane Doe',
                  style: TextStyle(
                    fontFamily: 'FlockFont',
                    fontSize: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.fontSize,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text('+1 234 567 890', style: TextStyle(color: Colors.black54)),
                Text(
                  'jane.doe@example.com',
                  style: TextStyle(color: Colors.black54),
                ),
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
        // TODO: Navigate to the respective page
      },
    );
  }
}
