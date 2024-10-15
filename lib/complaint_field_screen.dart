import 'package:flutter/material.dart';
import 'edu_rule_screen.dart'; // Import the edu_rule_screen

class ComplaintFieldScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153448),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
                  _buildCategoryCard(context, 'Education', 'assets/education.png'), // Pass context here
                  _buildCategoryCard(context, 'Environmental', 'assets/environmental.png'),
                  _buildCategoryCard(context, 'Healthcare', 'assets/healthcare.png'),
                  _buildCategoryCard(context, 'Agricultural', 'assets/agricultural.png'),
                  _buildCategoryCard(context, 'Electrical', 'assets/electrical.png'),
                  _buildCategoryCard(context, 'Social', 'assets/social.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated helper function to include context for navigation
  Widget _buildCategoryCard(BuildContext context, String title, String imagePath) {
    return Card(
      color: Color(0xFF3C5B6F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          if (title == 'Education') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EduRuleScreen()), // Navigate to EduRuleScreen
            );
          } else {
            // Handle other category taps
          }
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

void main() {
  runApp(MaterialApp(
    home: ComplaintFieldScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
