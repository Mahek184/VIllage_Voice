import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:village_voice/announcement_screen.dart';
import 'package:village_voice/complaint_field_screen.dart';
import 'package:village_voice/emergency_list_screen.dart';
import 'package:village_voice/event_schedule_screen.dart';
import 'package:village_voice/gallery_screen.dart';
import 'package:village_voice/health_tips_screen.dart';

import 'package:village_voice/login_screen.dart';

class Dashboard extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _editProfile(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Handle profile update here
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent back navigation
      child: Scaffold(
        backgroundColor: const Color(0xFF153448),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.language, color: Colors.white),
              onPressed: () {}, // Language selection logic
            ),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () => _logout(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _buildProfileSection(context),
              const SizedBox(height: 30),
              Expanded(
                child: _buildDashboardGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3C5B6F),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _editProfile(context),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: const AssetImage('assets/woman.png'),
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            "Welcome",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildDashboardGrid() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('dashboard_items').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final dashboardItems = snapshot.data!.docs;
        if (dashboardItems.isEmpty) {
          return const Center(child: Text('No items available.'));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: dashboardItems.length,
          itemBuilder: (context, index) {
            final item = dashboardItems[index];
            final data = item.data() as Map<String, dynamic>;
            final iconPath = data['iconPath'] ?? 'assets/placeholder.png';
            final label = data['label'] ?? 'Unknown';
            final itemId = item.id;

            return _buildDashboardItem(
              context,
              iconPath,
              label,
              itemId,
              data['label'] ?? '',
            );
          },
        );
      },
    );
  }

  Widget _buildDashboardItem(BuildContext context, String imagePath,
      String label, String itemId, String itemLabel) {
    return GestureDetector(
      onTap: () {
        // Navigation logic for each dashboard item
        if (label == "Gallery") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GalleryScreen()),
          );
        } else if (label == "Emergency List") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmergencyListScreen()),
          );
        } else if (label == "Announcement") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnnouncementScreen()),
          );
        } else if (label == "Health Tips") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HealthTipsScreen()),
          );
        } else if (label == "Complaint Box") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComplaintFieldScreen()),
          );
        } else if (label == "Event Schedule") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventScheduleScreen()),
          );
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF3C5B6F),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Dashboard(),
    debugShowCheckedModeBanner: false,
  ));
}
