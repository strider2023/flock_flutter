// --- Profile Page ---
import 'package:flock_flutter/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 30),
          _buildProfileOption(
            context,
            icon: Icons.location_on_outlined,
            title: 'Addresses',
          ),
          _buildProfileOption(
            context,
            icon: Icons.favorite_border,
            title: 'Pledges',
          ),
          _buildProfileOption(
            context,
            icon: Icons.history,
            title: 'Order History',
          ),
          _buildProfileOption(
            context,
            icon: Icons.payment,
            title: 'Manage Payments',
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => _logout(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black,
            ),
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
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    '+1 234 567 890',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    'jane.doe@example.com',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
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
