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
      appBar: AppBar(title: Text('Flock'), automaticallyImplyLeading: false),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 30),
          _buildProfileOption(
            context,
            icon: Ri.user_location_fill,
            title: 'My Addresses',
          ),
          _buildProfileOption(
            context,
            icon: Ri.shopping_cart_2_line,
            title: 'Order History',
          ),
          _buildProfileOption(
            context,
            icon: Ri.secure_payment_fill,
            title: 'Manage Payments',
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => _logout(context),
            child: const Text('Log Out'),
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
            const Column(
              // Center the text content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Jane Doe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
      leading: Iconify(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
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
