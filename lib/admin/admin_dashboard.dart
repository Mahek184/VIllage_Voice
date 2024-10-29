import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:village_voice/admin/admin_complaint_field.dart';
import 'package:village_voice/admin/admin_profile_screen.dart';
import 'package:village_voice/notification_screen.dart';
import 'package:village_voice/admin/admin_event_schedule.dart';
import 'package:village_voice/gallery_screen.dart';
import 'package:village_voice/admin/admin_emergency_list_screen.dart';
import 'package:village_voice/admin/admin_health_tips_screen.dart';
import 'dart:io';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final CollectionReference _dashboardItems =
      FirebaseFirestore.instance.collection('dashboard_items');

  bool _isEditingMode = false; // Track if in editing mode
  bool _isDeleteMode = false; // Track if in delete mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153448),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        elevation: 0,
        toolbarHeight: 0, // Hide AppBar for a cleaner look
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
                      child: CircleAvatar(
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
                  icon: const Icon(Icons.delete,
                      color: Color(0xFF3C5B6F)), // Icon color set to 0xFF3C5B6F
                  label: const SizedBox.shrink(), // Remove label
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Change background color to white
                    padding: const EdgeInsets.all(
                        10), // Adjust padding to minimize space
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
                  icon: const Icon(Icons.edit,
                      color: Color(0xFF3C5B6F)), // Icon color set to 0xFF3C5B6F
                  label: const SizedBox.shrink(), // Remove label
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Change background color to white
                    padding: const EdgeInsets.all(
                        10), // Adjust padding to minimize space
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons
                // Add item button
                IconButton(
                  onPressed: () => _showAddItemDialog(context),
                  icon: const Icon(Icons.add_circle,
                      color: Colors.white, size: 60), // White icon color
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
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main item content
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
                  width: 50, // Standardize icon size
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
          // Conditional minus icon for delete mode
          if (_isDeleteMode)
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                onTap: () {
                  _deleteItem(itemId); // Delete the item
                },
                child: const Icon(Icons.remove_circle,
                    color: Colors.red, size: 20),
              ),
            ),
          // Conditional minus icon for editing mode
          if (_isEditingMode)
            Positioned(
              right: 8,
              top: 8,
              child: const Icon(Icons.edit, color: Colors.white, size: 20),
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

  void _editItem(String itemId, String newLabel, BuildContext context) {
    if (newLabel.isNotEmpty) {
      _dashboardItems.doc(itemId).update({
        'label': newLabel,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item updated to "$newLabel"!')),
      );
    }
  }

  void _deleteItem(String itemId) {
    _dashboardItems.doc(itemId).delete(); // Delete the item from Firestore
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item deleted!')),
    );
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

  void _addItem(String label, String iconPath, BuildContext context) {
    if (label.isNotEmpty && iconPath.isNotEmpty) {
      _dashboardItems.add({
        'label': label,
        'iconPath': iconPath,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item "$label" added!')),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminDashboard(),
  ));
}
