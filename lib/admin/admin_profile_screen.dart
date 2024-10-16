import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<AdminProfileScreen> {
  bool isEditing = false;

  // Initial profile data
  String name = 'user Name';
  String email = 'user@example.com';
  String dob = '01/01/2000';
  String contactNo = '9876543210';
  String gender = 'Male';
  String selectedLanguage = 'English'; // Default language

  // Image-related variables
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Controllers to manage text field inputs
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController dobController;
  late TextEditingController contactController;
  late TextEditingController genderController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with current data
    nameController = TextEditingController(text: name);
    emailController = TextEditingController(text: email);
    dobController = TextEditingController(text: dob);
    contactController = TextEditingController(text: contactNo);
    genderController = TextEditingController(text: gender);
  }

  @override
  void dispose() {
    // Dispose controllers when not needed
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    contactController.dispose();
    genderController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF153448), // Set to the specified background color
        title: const Text('Admin Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF153448), // Set page background color
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Profile Picture Section
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(Icons.person, size: 60, color: Colors.white)
                      : null,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _showImageSourceActionSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3C5B6F), // Updated button color
                    side: const BorderSide(color: Color(0xFF6EABC6)),
                  ),
                  child: const Text(
                    'Change Profile Picture',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Personal Details Section
                buildDetailsRow('Name', nameController),
                buildDetailsRow('Email', emailController),
                buildDetailsRow('Date Of Birth', dobController),
                buildDetailsRow('Gender', genderController),

                // Languages section
                const SizedBox(height: 20),
                buildLanguageDropdown(),

                const SizedBox(height: 40),

                // Edit/Save Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isEditing) {
                        // Save the updated data
                        name = nameController.text;
                        email = emailController.text;
                        dob = dobController.text;
                        contactNo = contactController.text;
                        gender = genderController.text;
                      }
                      isEditing = !isEditing; // Toggle the editing state
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3C5B6F), // Updated button color
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    isEditing ? 'Save' : 'Edit Profile',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper widget to build section titles
  Widget buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white, // Set text color to white for contrast
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  // Helper widget to build details rows (one field per row)
  Widget buildDetailsRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 8), // Space between label and TextField
          TextField(
            controller: controller,
            readOnly: !isEditing,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF6EABC6), // Updated border color
                ),
              ),
              border: const OutlineInputBorder(),
              fillColor: const Color(0xFF153448),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  // Build a dropdown for selecting language
  Widget buildLanguageDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Languages',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8), // Space between label and dropdown
          DropdownButtonFormField<String>(
            value: selectedLanguage,
            items: ['English', 'Hindi', 'Gujarati'].map((String language) {
              return DropdownMenuItem<String>(
                value: language,
                child: Text(language),
              );
            }).toList(),
            onChanged: isEditing ? (String? newValue) {
              setState(() {
                selectedLanguage = newValue!;
              });
            } : null, // Disable dropdown if not editing
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF6EABC6), // Updated border color
                ),
              ),
              border: const OutlineInputBorder(),
              fillColor: const Color(0xFF153448),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
