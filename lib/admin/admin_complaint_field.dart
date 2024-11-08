// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminComplaintField extends StatefulWidget {
  final bool isAdmin; // Flag to check if the user is admin

  const AdminComplaintField({this.isAdmin = true}); // Default user is admin

  @override
  _AdminComplaintFieldState createState() => _AdminComplaintFieldState();
}

class _AdminComplaintFieldState extends State<AdminComplaintField> {
  List<Map<String, String>> categories = [
    {'title': 'Education', 'image': 'assets/education.png'},
    {'title': 'Environmental', 'image': 'assets/environmental.png'},
    {'title': 'Healthcare', 'image': 'assets/healthcare.png'},
    {'title': 'Agricultural', 'image': 'assets/agricultural.png'},
    {'title': 'Electrical', 'image': 'assets/electrical.png'},
    {'title': 'Social', 'image': 'assets/social.png'},
  ];

  // Function to pick image from device
  Future<File?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // Function to add a new category
  void _addCategory(String title, String imagePath) {
    setState(() {
      categories.add({'title': title, 'image': imagePath});
    });
  }

  // Function to edit a category
  void _editCategory(int index, String newTitle, String? newImagePath) {
    setState(() {
      categories[index]['title'] = newTitle;
      if (newImagePath != null) {
        categories[index]['image'] = newImagePath;
      }
    });
  }

  // Function to delete a category
  void _deleteCategory(int index) {
    setState(() {
      categories.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153448),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView( // Wrapping content in SingleChildScrollView
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.mic),
                    border: InputBorder.none,
                    hintText: 'Search',
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            // Grid of complaint categories
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // Preventing GridView scrolling, as SingleChildScrollView is used
                shrinkWrap: true, // Ensures GridView takes up minimal vertical space
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 2.7 / 3,
                ),
                itemBuilder: (context, index) {
                  return _buildCategoryCard(
                    context,
                    categories[index]['title']!,
                    categories[index]['image']!,
                    index,
                  );
                },
              ),
            ),
            // Admin specific actions: Edit and Delete buttons
            if (widget.isAdmin)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      _showAddCategoryDialog(); // Add new category
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Helper function to build category card
  Widget _buildCategoryCard(BuildContext context, String title, String imagePath, int index) {
    return Card(
      color: const Color(0xFF3C5B6F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          if (title == 'Education') {
            // Example of handling a tap event
            // Navigate to the specific category details
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute the space evenly
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: imagePath.contains('assets/')
                        ? Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                          )
                        : Image.file(
                            File(imagePath),
                            fit: BoxFit.contain,
                          ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter, // Align to bottom center
                child: widget.isAdmin
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 14, 43, 63),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                              onPressed: () {
                                _showEditCategoryDialog(index); // Edit category
                              },
                            ),
                          ),
                          const SizedBox(width: 10), // Space between edit and delete buttons
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 14, 43, 63),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.delete, color: Color.fromARGB(255, 255, 255, 255), size: 16),
                              onPressed: () {
                                _deleteCategory(index); // Delete category
                              },
                            ),
                          ),
                        ],
                      )
                    : const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show dialog for adding a new category
  void _showAddCategoryDialog() {
    String newTitle = '';
    File? imageFile;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder( // Use StatefulBuilder to manage the state within the dialog
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Category'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Category Name'),
                      onChanged: (value) {
                        newTitle = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        imageFile = await _pickImage();
                        setState(() {}); // Update the UI with selected image
                      },
                      icon: const Icon(Icons.image),
                      label: Text(imageFile == null ? 'Pick Image' : 'Image Selected'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    String imagePath = imageFile != null ? imageFile!.path : 'assets/default.png';
                    _addCategory(newTitle, imagePath);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Show dialog for editing a category
  void _showEditCategoryDialog(int index) {
    TextEditingController controller = TextEditingController(text: categories[index]['title']!);
    File? imageFile;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder( // Use StatefulBuilder to manage the state within the dialog
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Category'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      decoration: const InputDecoration(labelText: 'Category Name'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        imageFile = await _pickImage();
                        setState(() {});
                      },
                      icon: const Icon(Icons.image),
                      label: Text(imageFile == null ? 'Change Image' : 'Image Selected'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    String? imagePath = imageFile?.path;
                    _editCategory(index, controller.text, imagePath);
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminComplaintField(isAdmin: true),
              ),
            );
          },
          child: const Text('Go to Complaint Categories'),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AdminDashboard(), // Start at the Admin Dashboard
    debugShowCheckedModeBanner: false,
  ));
}
