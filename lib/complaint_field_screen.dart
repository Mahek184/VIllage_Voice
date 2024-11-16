import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edu_rule_screen.dart'; // Import the edu_rule_screen (as an example screen for Education)

class ComplaintFieldScreen extends StatelessWidget {
  final CollectionReference _complaintRef =
      FirebaseFirestore.instance.collection('complaint');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153448),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Complaint Categories', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 3 / 3,
                children: [
                  _buildCategoryCard(context, 'Education', 'assets/education.png', 'education'),
                  _buildCategoryCard(context, 'Healthcare', 'assets/healthcare.png', 'healthcare'),
                  _buildCategoryCard(context, 'Environmental', 'assets/environmental.png', 'environmental'),
                  _buildCategoryCard(context, 'Agricultural', 'assets/agricultural.png', 'agricultural'),
                  _buildCategoryCard(context, 'Electrical', 'assets/electrical.png', 'electrical'),
                  _buildCategoryCard(context, 'Social', 'assets/social.png', 'social'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated helper function to include context for navigation
  Widget _buildCategoryCard(BuildContext context, String title, String imagePath, String categoryType) {
    return Card(
      color: Color(0xFF3C5B6F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to complaints of the selected category type
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComplaintListScreen(category: categoryType),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 50,
                fit: BoxFit.contain,
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
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComplaintListScreen extends StatelessWidget {
  final String category;

  // Constructor to receive the category
  ComplaintListScreen({required this.category});

  final CollectionReference _complaintRef =
      FirebaseFirestore.instance.collection('complaint');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153448),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('$category Complaints', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _complaintRef
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No complaints found for this category."));
          }

          final complaintDocs = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: complaintDocs.length,
              itemBuilder: (context, index) {
                var complaint = complaintDocs[index];
                String title = complaint['title']; // Fetch 'title'
                String description = complaint['description']; // Assuming 'description' exists
                String imagePath = complaint['imagePath']; // Fetch 'imagePath'

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  leading: Image.network(imagePath, width: 50),
                  title: Text(title, style: TextStyle(color: Colors.white)),
                  subtitle: Text(description, style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Handle complaint item tap
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selected complaint: $title')),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ComplaintFieldScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
