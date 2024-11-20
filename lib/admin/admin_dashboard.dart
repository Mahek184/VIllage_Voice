import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:village_voice/Screen/weather_home.dart';
import 'package:village_voice/admin/admin_announcement.dart';
import 'package:village_voice/admin/admin_complaint_field.dart';
import 'package:village_voice/admin/admin_emergency_list_screen.dart';
import 'package:village_voice/admin/admin_event_schedule.dart';
import 'package:village_voice/admin/admin_health_tips_screen.dart';
import 'package:village_voice/admin/admin_profile_screen.dart';
import 'package:village_voice/admin/admin_gallery.dart';
import 'package:village_voice/welcome_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final CollectionReference _dashboardItems =
      FirebaseFirestore.instance.collection('dashboard_items');
  bool _isEditingMode = false;
  bool _isDeleteMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153448),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        elevation: 0,
        toolbarHeight: 0, // Hide AppBar for a cleaner look
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Welcome Admin Section
              Container(
                height: 80,
                width: 360,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.only(
                    top: 16, bottom: 30), // Add bottom margin for spacing
                decoration: BoxDecoration(
                  color: const Color(0xFF3C5B6F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(  
                              builder: (context) => const AdminProfileScreen()),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/woman.png'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Welcome Admin",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              // Dashboard grid items
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _dashboardItems.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final dashboardItems = snapshot.data!.docs;

                      return GridView.builder(
                        itemCount: dashboardItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 columns
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          var item = dashboardItems[index];
                          var itemData = item.data() as Map<String, dynamic>;

                          return _buildDashboardItem(
                            context,
                            itemData['iconPath'] ?? 'assets/default_icon.png',
                            itemData['label'] ?? 'Unknown Label',
                            item.id,
                            itemData['label'], // Pass label for editing
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          // Logout icon positioned on the top right corner of the "Welcome Admin" container
          Positioned(
            top:
                30, // Position the logout icon near the top right of the "Welcome Admin" container
            right: 20, // Adjust the right margin as needed
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: _logout,
            ),
          ),

          // Edit, Delete, and Add buttons at the bottom right corner
          Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Minimize the row size
              children: [
                // Delete Button
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isDeleteMode = !_isDeleteMode; // Toggle delete mode
                    });
                  },
                  icon: const Icon(Icons.delete, color: Color(0xFF3C5B6F)),
                  label: const SizedBox.shrink(), // Remove label
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons
                // Edit Button
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isEditingMode = !_isEditingMode; // Toggle edit mode
                    });
                  },
                  icon: const Icon(Icons.edit, color: Color(0xFF3C5B6F)),
                  label: const SizedBox.shrink(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                  ),
                ),
                const SizedBox(width: 10),
                // Add item button
                IconButton(
                  onPressed: () => _showAddItemDialog(context),
                  icon: const Icon(Icons.add_circle,
                      color: Colors.white, size: 60),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(BuildContext context, String imagePath,
      String label, String itemId, String itemLabel) {
    return GestureDetector(
      onTap: () {
        if (_isEditingMode) {
          _showEditingOptions(context, itemId, itemLabel);
        } else {
          // Navigate to specific screens based on item label
          if (label == "Gallery") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminGallery()),
            );
          } else if (label == "Emergency List") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminEmergencyScreen()),
            );
          } else if (label == "Weather") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeatherHome()),
            );
          } else if (label == "Announcement") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminAnnouncementScreen()),
            );
          } else if (label == "Health Tips") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdminHealthTipsScreen()),
            );
          } else if (label == "Complaint Box") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminComplaintField()),
            );
          } else if (label == "Event Schedule") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminEventSchedule()),
            );
          }
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF3C5B6F),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 4, spreadRadius: 2)
                  ],
                ),
                child: Image.asset(
                  imagePath,
                  width: 50,
                  height: 60,
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
          if (_isDeleteMode)
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                onTap: () {
                  _deleteItem(itemId);
                },
                child: const Icon(Icons.remove_circle,
                    color: Colors.red, size: 20),
              ),
            ),
          if (_isEditingMode)
            const Positioned(
              right: 8,
              top: 8,
              child: Icon(Icons.edit, color: Colors.white, size: 20),
            ),
        ],
      ),
    );
  }

  void _showEditingOptions(
      BuildContext context, String itemId, String currentLabel) {
    final TextEditingController labelController =
        TextEditingController(text: currentLabel);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: TextField(
            controller: labelController,
            decoration: const InputDecoration(labelText: 'Label'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _editItem(itemId, labelController.text, context);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _editItem(String itemId, String newLabel, BuildContext context) async {
    if (newLabel.isNotEmpty) {
      try {
        // Update item for the admin
        await _dashboardItems.doc(itemId).update({
          'label': newLabel,
        });

        // Now, update all users' dashboard items
        var usersCollection = FirebaseFirestore.instance.collection('users');

        var usersSnapshot = await usersCollection.get();
        for (var userDoc in usersSnapshot.docs) {
          var userItems = List.from(userDoc['dashboard_items'] ?? []);

          for (var item in userItems) {
            if (item['itemId'] == itemId) {
              item['label'] = newLabel; // Update the label of the item
              break;
            }
          }

          // Update the user's document with the modified dashboard_items
          await usersCollection.doc(userDoc.id).update({
            'dashboard_items': userItems,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item updated to "$newLabel"!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating item: $e')),
        );
      }
    }
  }

  void _deleteItem(String itemId) async {
    try {
      // First, delete the item from the admin's dashboard
      await _dashboardItems.doc(itemId).delete();

      // Then, remove the item from all users' dashboard_items
      var usersCollection = FirebaseFirestore.instance.collection('users');

      var usersSnapshot = await usersCollection.get();
      for (var userDoc in usersSnapshot.docs) {
        var userItems = List.from(userDoc['dashboard_items'] ?? []);

        // Remove the item with the given itemId
        userItems.removeWhere((item) => item['itemId'] == itemId);

        // Update the user's dashboard_items field
        await usersCollection.doc(userDoc.id).update({
          'dashboard_items': userItems,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Item deleted from both admin and user dashboards!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $e')),
      );
    }
  }

  // Show add item dialog
  void _showAddItemDialog(BuildContext context) {
    final TextEditingController labelController = TextEditingController();
    final TextEditingController iconPathController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelController,
                decoration: const InputDecoration(labelText: 'Label'),
              ),
              TextField(
                controller: iconPathController,
                decoration: const InputDecoration(labelText: 'Icon Path'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addItem(
                    labelController.text, iconPathController.text, context);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }

  void _addItem(String label, String iconPath, BuildContext context) async {
    if (label.isNotEmpty && iconPath.isNotEmpty) {
      setState(() {});
      try {
        // Add item to the dashboard_items collection (Admin's view)
        var itemRef = await _dashboardItems.add({
          'label': label,
          'iconPath': iconPath,
        });

        // Assuming there's a 'users' collection where each user has a 'dashboard_items' field
        var usersCollection = FirebaseFirestore.instance.collection('users');

        // Fetch all users and update their dashboard_items field
        var usersSnapshot = await usersCollection.get();
        for (var userDoc in usersSnapshot.docs) {
          // Get the user's existing dashboard items (if any)
          var userItems = List.from(userDoc['dashboard_items'] ?? []);

          // Add the new item reference to their dashboard_items
          userItems.add({
            'itemId': itemRef.id, // Add the ID for the new item
            'label': label,
            'iconPath': iconPath,
          });

          // Update the user's document
          await usersCollection.doc(userDoc.id).update({
            'dashboard_items': userItems,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Item "$label" added to both admin and user dashboards!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding item: $e')),
        );
      } finally {
        setState(() {});
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both label and icon path!')),
      );
    }
  }
}
