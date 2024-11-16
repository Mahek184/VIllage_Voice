import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HealthTipsScreen extends StatelessWidget {
  const HealthTipsScreen({Key? key}) : super(key: key);

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
          'Health & Safety Tips',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false, // Title aligned next to the back button
      ),
      body: Container(
        color: const Color(0xFF153448), // Background color
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('health_tips').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final healthTips = snapshot.data!.docs;

            if (healthTips.isEmpty) {
              return const Center(
                child: Text(
                  'No health tips available.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: healthTips.length,
              itemBuilder: (context, index) {
                var tip = healthTips[index];
                String title = tip['title']; // Fetch the 'title' field
                String content = tip['content']; // Fetch the 'content' field

                return Column(
                  children: [
                    _buildHealthTipCard(title, content),
                    const SizedBox(height: 15), // Add gap between cards
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Helper method to build each health tip card
  Widget _buildHealthTipCard(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3C5B6F), // Card background color
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10), // Spacing between title and content
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5, // Line height for better readability
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HealthTipsScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
