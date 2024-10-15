import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image picker package

class AdminEmergencyList extends StatefulWidget {
  final bool isAdmin; // Flag to check if the user is an admin

  const AdminEmergencyList({Key? key, this.isAdmin = true}) : super(key: key);

  @override
  _AdminEmergencyListState createState() => _AdminEmergencyListState();
}

class _AdminEmergencyListState extends State<AdminEmergencyList> {
  // List of emergency contacts (editable for admin)
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

  final ImagePicker _picker = ImagePicker();
  
  Future<void> _pickImage(int index) async {
    // Let admin pick an image from gallery or take a new photo
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        emergencyContacts[index]['icon'] = pickedFile.path; // Update the contact icon
      });
    }
  }

  // Add a new contact
  void _addContact() {
    setState(() {
      emergencyContacts.add({
        'icon': 'assets/default.png',
        'name': 'New Contact',
        'number': '0000',
      });
    });
  }

  // Edit contact details
  void _editContact(int index, String newName, String newNumber) {
    setState(() {
      emergencyContacts[index]['name'] = newName;
      emergencyContacts[index]['number'] = newNumber;
    });
  }

  // Delete a contact
  void _deleteContact(int index) {
    setState(() {
      emergencyContacts.removeAt(index);
    });
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
        actions: widget.isAdmin
            ? [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addContact, // Add new contact
                ),
              ]
            : null,
      ),
      body: Container(
        color: const Color(0xFF153448), // Background color
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Space after title
            Expanded(
              child: ListView.builder(
                itemCount: emergencyContacts.length,
                itemBuilder: (context, index) {
                  final contact = emergencyContacts[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15), // Spacing between boxes
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10), // Padding inside each box
                      leading: GestureDetector(
                        onTap: () {
                          if (widget.isAdmin) {
                            _pickImage(index); // Pick image if admin
                          }
                        },
                        child: Image.asset(
                          contact['icon'],
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: widget.isAdmin
                          ? TextFormField(
                              initialValue: contact['name'],
                              onFieldSubmitted: (newValue) {
                                _editContact(index, newValue, contact['number']);
                              },
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Text(
                              contact['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      subtitle: widget.isAdmin
                          ? TextFormField(
                              initialValue: contact['number'],
                              onFieldSubmitted: (newValue) {
                                _editContact(index, contact['name'], newValue);
                              },
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              '📞 ${contact['number']}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                      trailing: widget.isAdmin
                          ? IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteContact(index); // Delete contact if admin
                              },
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const AdminEmergencyList(isAdmin: true), // Pass true if admin
    debugShowCheckedModeBanner: false,
  ));
}
