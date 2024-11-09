import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyListScreen extends StatelessWidget {
  // Function to dial a phone number
  Future<void> _dialNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not dial $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Contacts"),
        backgroundColor: Colors.blueGrey[700],
      ),
      backgroundColor: const Color(0xFF153448),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<QuerySnapshot>(
          future:
              FirebaseFirestore.instance.collection('emergency_contacts').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final emergencyContacts = snapshot.data!.docs;

            if (emergencyContacts.isEmpty) {
              return Center(
                child: Text(
                  'No emergency contacts available.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: emergencyContacts.length,
              itemBuilder: (context, index) {
                var contact = emergencyContacts[index];
                String name = contact['name'];
                String phone = contact['phone'];

                return Card(
                  color: const Color(0xFF3C5B6F),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        const SizedBox(height: 5),
                        Text(
                          'Phone: $phone',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.phone, color: Colors.white),
                      onPressed: () => _dialNumber(phone), // Trigger dial
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
