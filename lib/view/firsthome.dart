import 'package:comm/view/bannersileder.dart'; // Assuming this handles the banner carousel
import 'package:comm/view/home.dart'; // Assuming HomePage widget is in this file
import 'package:flutter/material.dart';

class firstHomeScreen extends StatefulWidget {
  const firstHomeScreen({super.key});

  @override
  State<firstHomeScreen> createState() => _firstHomeScreenState();
}

class _firstHomeScreenState extends State<firstHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black, // Set background to black
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18), // Padding for overall content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Left-align the content
              children: [
                // Product Carousel for displaying banners or featured items
               
                
                SizedBox(height: 20), // Space between sections
                
                // HomePage is your main content page
               

                // You can add more sections here if needed, like categories, offers, etc.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
