import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String phoneNumber = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');
      log('Retrieved Token: $token');

      if (token != null) {
        final url = Uri.parse(
            'https://admin.kushinirestaurant.com/api/user-data/');
        final response = await http.get(
          url,
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          log('API Response: $data');
          setState(() {
            name = data['name'] ?? 'No Name';
            phoneNumber = data['phone_number'] ?? 'No Phone Number';
            isLoading = false;
          });
        } else {
          log('API Error: ${response.statusCode} - ${response.body}');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        log('No JWT token found.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log('Exception: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Profile',   style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 28, fontWeight: FontWeight.w500),),
      centerTitle:true,),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
SizedBox(height: 20,),
                  Center(
                    child: Container(
                    height: 120,
                    width:120,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(58),
                      color: const Color.fromARGB(255, 0, 238, 255)
                    ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Name: $name', style: const TextStyle(fontSize: 25,color: Colors.red,),),
                  const SizedBox(height: 10),
                  Text('Phone Number: $phoneNumber',
                      style: const TextStyle(fontSize: 25,color: Colors.red)),
                ],
              ),
            ),
    );
  }
}
