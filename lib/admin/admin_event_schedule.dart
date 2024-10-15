import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminEventSchedule extends StatefulWidget {
  final bool isAdmin;

  AdminEventSchedule({Key? key, this.isAdmin = true}) : super(key: key);

  @override
  _AdminEventScheduleState createState() => _AdminEventScheduleState();
}

class _AdminEventScheduleState extends State<AdminEventSchedule> {
  List<Map<String, dynamic>> events = [
    {
      'title': 'INDEPENDENCE DAY - FLAG HOSTING',
      'date': '15 August',
      'description':
          'Independence Day is a special day that brings us all together to celebrate our nation’s freedom.',
      'image': 'assets/india.png'
    },
  ];

  // Function to pick image from device
  Future<File?> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // Function to add a new event
  void _addEvent(String title, String date, String description, File? image) {
    setState(() {
      events.add({
        'title': title,
        'date': date,
        'description': description,
        'image': image != null ? image.path : 'assets/default.png',
      });
    });
  }

  // Function to edit an event
  void _editEvent(int index, String title, String date, String description, File? image) {
    setState(() {
      events[index] = {
        'title': title,
        'date': date,
        'description': description,
        'image': image != null ? image.path : events[index]['image'],
      };
    });
  }

  // Function to delete an event
  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  // Function to delete all events
  void _deleteAllEvents() {
    setState(() {
      events.clear(); // Clears all events from the list
    });
  }

  // Show dialog for adding or editing an event
  void _showEventDialog({int? index}) {
    String title = '';
    String date = '';
    String description = '';
    File? imageFile;

    if (index != null) {
      title = events[index]['title'];
      date = events[index]['date'];
      description = events[index]['description'];
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Event' : 'Edit Event'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Event Title'),
                  onChanged: (value) => title = value,
                  controller: TextEditingController(text: title),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Event Date'),
                  onChanged: (value) => date = value,
                  controller: TextEditingController(text: date),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Event Description'),
                  onChanged: (value) => description = value,
                  controller: TextEditingController(text: description),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    imageFile = await _pickImage();
                    setState(() {}); // Update the UI with selected image
                  },
                  icon: Icon(Icons.image),
                  label: Text(imageFile == null ? 'Pick Image' : 'Image Selected'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (index == null) {
                  _addEvent(title, date, description, imageFile);
                } else {
                  _editEvent(index, title, date, description, imageFile);
                }
                Navigator.pop(context);
              },
              child: Text(index == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  // Widget to display FloatingActionButton conditionally
  Widget _adminButtons() {
    if (!widget.isAdmin) return Container(); // Return an empty container if not admin
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            _showEventDialog(); // Open add event dialog
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          onPressed: () {
            _deleteAllEvents(); // Clear all events
          },
          child: Icon(Icons.delete),
          backgroundColor: Colors.red,
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF153448),
        title: const Text(
          'Event Schedule',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFF153448), // Background color
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E4D60), // Card background color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display Image
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: events[index]['image'].contains('assets/')
                              ? Image.asset(
                                  events[index]['image'],
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(events[index]['image']),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        // Event Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                events[index]['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    events[index]['date'],
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                events[index]['description'],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Edit and Delete buttons for Admin
                        if (widget.isAdmin)
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  _showEventDialog(index: index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteEvent(index);
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _adminButtons(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminEventSchedule(isAdmin: true), // Set to true for admin mode
    debugShowCheckedModeBanner: false,
  ));
}
