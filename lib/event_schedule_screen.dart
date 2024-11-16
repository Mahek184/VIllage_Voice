import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventScheduleScreen extends StatelessWidget {
  const EventScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF153448),
        title: const Text(
          'Event Schedule',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true, // Back button enabled
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFF153448), // Background color matching the image
        padding: const EdgeInsets.all(16), // Add padding around the content
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('event_schedule')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final events = snapshot.data?.docs ?? [];

            if (events.isEmpty) {
              return const Center(
                child: Text(
                  'No events available.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                var event = events[index];
                String title =
                    event['title'] ?? 'No Title'; // Fetch the 'title' field
                String date =
                    event['date'] ?? 'No Date'; // Fetch the 'date' field
                String description = event['description'] ??
                    'No Description'; // Fetch the 'description' field

                return EventCard(
                  title: title,
                  date: date,
                  description: description,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;

  const EventCard({
    Key? key,
    required this.title,
    required this.date,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E4D60), // Card background color
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 16), // Space between cards
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Details
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: Colors.white70,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: EventScheduleScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
