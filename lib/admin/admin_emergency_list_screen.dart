// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminEmergencyListScreen extends StatefulWidget {
  const AdminEmergencyListScreen({Key? key}) : super(key: key);

  @override
  _AdminEmergencyListScreenState createState() => _AdminEmergencyListScreenState();
}

class _AdminEmergencyListScreenState extends State<AdminEmergencyListScreen> {
  // List of emergency contacts
  List<Map<String, dynamic>> emergencyContacts = [
    {
      'icon': 'assets/ambulance.png',
      'name': 'Ambulance',
      'number': '108',
    },
    {
      'icon': 'assets/police.png',
      'name': 'Police Control Room',
      'number': '100',
    },
    {
      'icon': 'assets/help.png',
      'name': 'Woman Helpline',
      'number': '1091',
    },
    {
      'icon': 'assets/bridge.png',
      'name': 'Fire Brigade',
      'number': '101',
    },
  ];

  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF153448),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Emergency Contact',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Container(
        color: const Color(0xFF153448),
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: emergencyContacts.length,
                    itemBuilder: (context, index) {
                      final contact = emergencyContacts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3C5B6F),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              leading: _selectedImage != null
                                  ? Image.file(
                                      _selectedImage!,
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      contact['icon'],
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                              title: Text(
                                contact['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                '📞 ${contact['number']}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  _editEmergencyContact(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      _deleteEmergencyContact();
                    },
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    backgroundColor: const Color(0xFF6EABC6),
                    onPressed: () {
                      _showAddEmergencyContactDialog();
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show the dialog for adding a new emergency contact
  void _showAddEmergencyContactDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController numberController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Emergency Contact"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: numberController,
                  decoration: const InputDecoration(labelText: "Number"),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _pickImage,
                  child: const Text('Choose Photo from Gallery'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                _addEmergencyContact(
                  titleController.text,
                  numberController.text,
                  _selectedImage?.path ?? 'assets/phone.png', // default if no image selected
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to add a new emergency contact
  void _addEmergencyContact(String title, String number, String icon) {
    setState(() {
      emergencyContacts.add({
        'icon': icon,
        'name': title,
        'number': number,
      });
    });
  }

  // Method to delete the last emergency contact
  void _deleteEmergencyContact() {
    setState(() {
      if (emergencyContacts.isNotEmpty) {
        emergencyContacts.removeLast();
      }
    });
  }

  // Method to edit an emergency contact
  void _editEmergencyContact(int index) {
    TextEditingController titleController = TextEditingController(text: emergencyContacts[index]['name']);
    TextEditingController numberController = TextEditingController(text: emergencyContacts[index]['number']);
    TextEditingController iconController = TextEditingController(text: emergencyContacts[index]['icon']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Emergency Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: "Number"),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: iconController,
                decoration: const InputDecoration(labelText: "Icon Path"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  emergencyContacts[index]['name'] = titleController.text;
                  emergencyContacts[index]['number'] = numberController.text;
                  emergencyContacts[index]['icon'] = iconController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AdminEmergencyListScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
