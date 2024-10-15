import 'package:flutter/material.dart';

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
        child: ListView(
          children: [
            _buildHealthTipCard(
              "1. Fever",
              "→ Symptoms:\nIncreased Body Temperature, Sweating and Shivering, Headache and Fatigue, Muscle Aches, Loss of Appetite, Irritability\n\n"
              "→ Prevention:\nGood Hygiene, Avoid Crowded Areas, Vaccination, Sanitize Surfaces, Boost Immunity, Proper Ventilation\n\n"
              "→ Hydration:\nWater, Oral Rehydration Solution (ORS), Coconut Water, Herbal Teas, Fruit Juices",
            ),
            const SizedBox(height: 15),
            _buildHealthTipCard(
              "2. Dengue Fever",
              "→ Symptoms:\nHigh fever, severe headache, pain behind the eyes, joint/muscle pain, nausea, vomiting, skin rash\n\n"
              "→ Hydration:\nDrink fluids like ORS (Oral Rehydration Solution), coconut water, or fruit juices to stay hydrated.\n\n"
              "→ Prevention:\nUse mosquito nets, apply insect repellents, wear long-sleeved clothing, and remove standing water around your home to reduce mosquito breeding.",
            ),
          ],
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
