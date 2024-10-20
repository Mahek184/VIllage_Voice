import 'package:flutter/material.dart';
import 'package:village_voice/admin/admin_complaint_field.dart';
import 'package:village_voice/admin/admin_profile_screen.dart';
import 'package:village_voice/notification_screen.dart'; // Import the NotificationScreen
import 'package:village_voice/admin/admin_event_schedule.dart'; // Import the EventScheduleScreen
import 'package:village_voice/gallery_screen.dart'; // Import the GalleryScreen
import 'package:village_voice/admin/admin_emergency_list_screen.dart'; // Import the EmergencyListScreen
import 'package:village_voice/admin/admin_health_tips_screen.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153448), // Page background color
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Row with profile image and welcome text inside a container
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFF3C5B6F), // Background color for the container
                borderRadius: BorderRadius.circular(20), // Rounded corners for the container
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminProfileScreen()), // Navigate to StudentProfileScreen
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/woman.png'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Welcome Admin",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30), // Space after profile pic and text

            // Dashboard grid items
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 22,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildDashboardItem(
                  context,
                  'assets/calendar.png',
                  'Event Schedule',
                  AdminEventSchedule(), // Navigate to EventScheduleScreen
                ),
                _buildDashboardItem(
                  context,
                  'assets/complaint.png',
                  'Complaint Box',
                  AdminComplaintField(), // Navigate to ComplaintFieldScreen
                ),
                _buildDashboardItem(
                  context,
                  'assets/announcement.png',
                  'Announcement',
                  NotificationScreen(), // Navigate to NotificationScreen
                ),
                _buildDashboardItem(
                  context,
                  'assets/gallery.png',
                  'Gallery',
                  GalleryScreen(), // Navigate to GalleryScreen
                ),
                _buildDashboardItem(
                  context,
                  'assets/weather update.png',
                  'Weather',
                  null, // No navigation for Weather
                ),
                _buildDashboardItem(
                  context,
                  'assets/health tips.png',
                  'Health Tips',
                  AdminHealthTipsScreen(), // Navigate to HealthTipsScreen
                ),
                _buildDashboardItem(
                  context,
                  'assets/emergency book.png',
                  'Emergency List',
                  AdminEmergencyListScreen(), // Navigate to EmergencyListScreen
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Modified to take the target screen as a parameter
  Widget _buildDashboardItem(BuildContext context, String imagePath, String label, Widget? targetPage) {
    return GestureDetector(
      onTap: () {
        if (targetPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(7), // Padding for the item box
            decoration: BoxDecoration(
              color: const Color(0xFF3C5B6F), // Box background color
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Image.asset(
              imagePath,
              width: 60,  // Icon size
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14, // Font size for label
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Main entry point for the app
void main() {
  runApp(MaterialApp(
    home: AdminDashboard(),
    debugShowCheckedModeBanner: false,
  ));
}
