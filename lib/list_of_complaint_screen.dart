import 'package:flutter/material.dart';

class ListOfComplaintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153448),
      appBar: AppBar(
        title: Text('List of Complaints'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Complaint List Title
            Text(
              'List of Complaints',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            
            // Complaint cards list
            Expanded(
              child: ListView(
                children: [
                  _buildComplaintCard('Complaint 01', 'Broken Benches', 'assets/broken_benches.png'),
                  _buildComplaintCard('Complaint 02', 'Poor condition of roads', 'assets/roads.png'),
                  _buildComplaintCard('Complaint 03', 'Water Supply', 'assets/water_supply.png'),
                  _buildComplaintCard('Complaint 04', 'Electricity Problem', 'assets/electricity.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build each complaint card
  Widget _buildComplaintCard(String complaintTitle, String complaintSubtitle, String imagePath) {
    return Card(
      color: Color(0xFF1F2C34),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.asset(imagePath, fit: BoxFit.cover, width: 50, height: 50),
        title: Text(
          complaintTitle,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'Title: $complaintSubtitle',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
