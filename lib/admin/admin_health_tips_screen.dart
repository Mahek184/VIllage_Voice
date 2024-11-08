// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AdminHealthTipsScreen extends StatefulWidget {
  const AdminHealthTipsScreen({Key? key}) : super(key: key);

  @override
  _AdminHealthTipsScreenState createState() => _AdminHealthTipsScreenState();
}

class _AdminHealthTipsScreenState extends State<AdminHealthTipsScreen> {
  // List of health tips
  List<Map<String, String>> healthTips = [
    {
      "title": "1. Fever",
      "content":
          "→ Symptoms:\nIncreased Body Temperature, Sweating and Shivering, Headache and Fatigue, Muscle Aches, Loss of Appetite, Irritability\n\n"
              "→ Prevention:\nGood Hygiene, Avoid Crowded Areas, Vaccination, Sanitize Surfaces, Boost Immunity, Proper Ventilation\n\n"
              "→ Hydration:\nWater, Oral Rehydration Solution (ORS), Coconut Water, Herbal Teas, Fruit Juices",
    },
    {
      "title": "2. Dengue Fever",
      "content":
          "→ Symptoms:\nHigh fever, severe headache, pain behind the eyes, joint/muscle pain, nausea, vomiting, skin rash\n\n"
              "→ Hydration:\nDrink fluids like ORS (Oral Rehydration Solution), coconut water, or fruit juices to stay hydrated.\n\n"
              "→ Prevention:\nUse mosquito nets, apply insect repellents, wear long-sleeved clothing, and remove standing water around your home to reduce mosquito breeding.",
    },
  ];

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
        centerTitle: false,
      ),
      body: Container(
        color: const Color(0xFF153448),
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: healthTips.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Stack(
                    children: [
                      _buildHealthTipCard(
                        healthTips[index]["title"]!,
                        healthTips[index]["content"]!,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            _editHealthTip(index);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Add and Delete buttons positioned at bottom right
            Positioned(
              bottom: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      _deleteHealthTip();
                    },
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    backgroundColor: const Color(0xFF6EABC6),
                    onPressed: () {
                      _showAddHealthTipDialog();
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
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
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // Method to show dialog for adding a new health tip
  void _showAddHealthTipDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Health Tip"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(labelText: "Content"),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                _addHealthTip(titleController.text, contentController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to handle adding a health tip
  void _addHealthTip(String title, String content) {
    setState(() {
      healthTips.add({
        "title": "$title ${healthTips.length + 1}",
        "content": content,
      });
    });
  }

  // Method to handle deleting a health tip
  void _deleteHealthTip() {
    setState(() {
      if (healthTips.isNotEmpty) {
        healthTips.removeLast();
      }
    });
  }

  // Method to handle editing a health tip
  void _editHealthTip(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController titleController = TextEditingController(text: healthTips[index]["title"]);
        TextEditingController contentController = TextEditingController(text: healthTips[index]["content"]);

        return AlertDialog(
          title: const Text("Edit Health Tip"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: "Content"),
                maxLines: 5,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  healthTips[index]["title"] = titleController.text;
                  healthTips[index]["content"] = contentController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AdminHealthTipsScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
