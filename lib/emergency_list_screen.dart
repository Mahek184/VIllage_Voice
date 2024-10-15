import 'package:flutter/material.dart';

class EmergencyListScreen extends StatelessWidget {
  const EmergencyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of emergency contacts
    final List<Map<String, dynamic>> emergencyContacts = [
      {
        'icon': 'assets/ambulance.png', // Make sure to add this icon in assets
        'name': 'Ambulance',
        'number': '108',
      },
      {
        'icon': 'assets/police.png', // Make sure to add this icon in assets
        'name': 'Police Control Room',
        'number': '100',
      },
      {
        'icon': 'assets/help.png', // Make sure to add this icon in assets
        'name': 'Woman Helpline',
        'number': '1091',
      },
      {
        'icon': 'assets/bridge.png', // Make sure to add this icon in assets
        'name': 'Fire Brigade',
        'number': '101',
      },
    ];

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
        centerTitle: false, // Aligns the title to the left (next to the back button)
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
                      leading: Image.asset(
                        contact['icon'], // Load icon
                        width: 35,  // Set the width to 35
                        height: 35, // Set the height to 35
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
  runApp(const MaterialApp(
    home: EmergencyListScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
