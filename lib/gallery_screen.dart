import 'package:flutter/material.dart';
import 'dart:io';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of image paths that you want to display
    List<String> imagePaths = [
      'assets/g1.jpg',
      'assets/g2.jpg',
      'assets/g3.jpg',
      'assets/g4.jpg',
      'assets/g2.jpg',
      'assets/gallery_images/image6.png',
      // Add more images here as needed
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF153448),
        title: const Text(
          'Gallery',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true, // Adds back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF153448), // Page background color
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns in the grid
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4, // Adjust aspect ratio to fit the layout
          ),
          itemCount: imagePaths.length, // Number of images
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300], // Placeholder color for loading
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePaths[index], // Load the image dynamically
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
