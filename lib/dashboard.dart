import 'package:flutter/material.dart';
import 'complaint_field_screen.dart';
import 'profile_screen.dart'; // Import the StudentProfileScreen
import 'package:village_voice/notification_screen.dart';// Import the NotificationScreen
import 'package:village_voice/event_schedule_screen.dart';// Import the NotificationScreen
import 'package:village_voice/gallery_screen.dart';// Import the NotificationScreen
import 'package:village_voice/emergency_list_screen.dart';// Import the NotificationScreen
import 'health_tips_screen.dart'; // Import the StudentProfileScreen

class Dashboard extends StatelessWidget {
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
            // Container for profile image and welcome text
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF3C5B6F), // Background color for the container
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentProfileScreen(), // Navigate to StudentProfileScreen
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/woman.png'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30), // Space after profile pic and text
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
                  EventScheduleScreen(), // No navigation
                ),
                _buildDashboardItem(
                  context,
                  'assets/complaint.png',
                  'Complaint Box',
                  ComplaintFieldScreen(), // Navigate to ComplaintFieldScreen
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
                  GalleryScreen(), // No navigation
                ),
                _buildDashboardItem(
                  context,
                  'assets/weather update.png',
                  'Weather',
                  null, // No navigation
                ),
                _buildDashboardItem(
                  context,
                  'assets/health tips.png',
                  'Health Tips',
                  HealthTipsScreen(), // No navigation
                ),
                _buildDashboardItem(
                  context,
                  'assets/emergency book.png',
                  'Emergency List',
                  EmergencyListScreen(), // No navigation
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
            padding: const EdgeInsets.all(7), // Increased padding for a bigger box
            decoration: BoxDecoration(
              color: const Color(0xFF3C5B6F), // Updated box background color
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
              width: 60,  // Increased image size to fit bigger box
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14, // Slightly increased font size
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color remains white
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
    home: Dashboard(),
    debugShowCheckedModeBanner: false,
  ));
}
