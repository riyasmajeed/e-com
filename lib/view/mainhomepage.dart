import 'package:comm/view/firsthome.dart';
import 'package:comm/view/home.dart';
import 'package:flutter/material.dart';

class Mainhomepage extends StatefulWidget {
  const Mainhomepage({super.key});

  @override
  State<Mainhomepage> createState() => _MainhomepageState();
}

class _MainhomepageState extends State<Mainhomepage> {
  int currentTab = 0; // This keeps track of the selected tab
  List<Widget> screens = [
   HomePage(),
    Scaffold(body: Center(child: Text('Screen 2'))),
    firstHomeScreen(), // Assuming this is a defined screen
    // CartScreen(), // Add this screen when it's available
    Scaffold(body: Center(child: Text('Screen 5'))),
  ];

  // Function to handle tab changes
  void onTabTapped(int index) {
    setState(() {
      currentTab = index; // Update the selected tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body that switches screens
      body: screens[currentTab],
      
      // Bottom Navigation Bar with custom colors and icons
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab, // Set the current tab based on selected index
        onTap: onTabTapped, // Update the current tab when a tab is tapped
        selectedItemColor: const Color.fromARGB(255, 255, 0, 0), // Color for the selected item
        unselectedItemColor: Colors.grey, // Color for the unselected items
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Background color of the bottom navigation bar
        type: BottomNavigationBarType.fixed, // Set to fixed for multiple items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
