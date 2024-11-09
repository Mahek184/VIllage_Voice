import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:village_voice/complaint_field_screen.dart';
import 'package:village_voice/notification_screen.dart';
import 'package:village_voice/event_schedule_screen.dart';
import 'package:village_voice/gallery_screen.dart';
import 'package:village_voice/emergency_list_screen.dart';
import 'health_tips_screen.dart';

class Dashboard extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Open dialog for editing profile
  Future<void> _editProfile(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Debugging print statement to check if button works
                print('Name: ${_nameController.text}');
                print('Email: ${_emailController.text}');
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button on the Dashboard screen
        return Future.value(false); // Returning false prevents the back action
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF153448),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: null, // Ensure the back button is removed
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF3C5B6F),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Open the edit profile dialog on tap
                        _editProfile(context);
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/woman.png'),
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
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.language, color: Colors.white),
                      onPressed: () {
                        // Action for changing language
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('user dashboard items')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final dashboardItems = snapshot.data!.docs;

                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: dashboardItems.length,
                      itemBuilder: (context, index) {
                        var item = dashboardItems[index];
                        var data = item.data() as Map<String, dynamic>;

                        var imagePath = data.containsKey('imagePath')
                            ? data['imagePath']
                            : 'assets/weather update.png';
                        var title = data.containsKey('title')
                            ? data['title']
                            : 'Unknown';

                        return _buildDashboardItem(
                          context,
                          imagePath,
                          title,
                          _getScreenForItem(title),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getScreenForItem(String title) {
    switch (title) {
      case 'Event Schedule':
        return EventScheduleScreen();
      case 'Complaint Box':
        return ComplaintFieldScreen();
      case 'Announcement':
        return NotificationScreen();
      case 'Gallery':
        return GalleryScreen();
      case 'Health Tips':
        return HealthTipsScreen();
      case 'Emergency List':
        return EmergencyListScreen();
      default:
        return const Center(child: Text('Unknown Screen'));
    }
  }

  Widget _buildDashboardItem(
      BuildContext context, String imagePath, String label, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
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
