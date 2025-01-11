

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'otoinput.dart'; 
import 'registerpage.dart'; 


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();

  // Verify phone number and proceed with OTP or error handling
  void _verifyPhoneNumber(String phone) async {
    final url = Uri.parse("https://admin.kushinirestaurant.com/api/verify/");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"phone_number": phone}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data["user"] == true) {
          try {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('jwt_token', data["token"]["access"]);
            debugPrint('SharedPreferences initialized successfully');
          } catch (e) {
            debugPrint('Error initializing SharedPreferences: $e');
          }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpInputScreen(
              phoneNumber: phone,
              expectedOtp: data["otp"],
              userExists: data["user"],
              accessToken: data["token"]["access"],
            ),
          ),
        );
      } else {
        // User does not exist, show registration prompt
        _showErrorDialog(context, 'User Not Registered', 'Please register before logging in.');
      }
    } else {
      // Show error dialog if API request fails
      _showErrorDialog(context, 'Login Failed', 'Failed to verify phone number.');
    }
  }

  // Login function to handle form submission
  void _login() async {
    String name = _nameController.text.trim();
    String phone = _phonenumberController.text.trim();

    if (name.isNotEmpty && phone.isNotEmpty) {
      try {
        // Verify the phone number before proceeding
        _verifyPhoneNumber(phone);
      } catch (e) {
        // Show any exception error
        _showErrorDialog(context, 'Login Failed', e.toString());
      }
    } else {
      // Show error if any field is empty
      _showErrorDialog(context, 'Input Error', 'All fields are required.');
    }
  }

  // Show error dialog helper function
  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.centerLeft,
          colors: [Colors.black12, Color.fromARGB(255, 0, 0, 0)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "E",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "-commerce",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                const Text(
                  'You have been missed for a long time',
                  style: TextStyle(
                      color: Color.fromARGB(154, 255, 255, 255),
                      fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'NAME',
                          prefixIcon: Icon(Icons.person),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 5),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _phonenumberController,
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          prefixIcon: Icon(Icons.numbers),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 5),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            // Add Forgot password logic here
                          },
                          child: const Text(
                            'Forgot phone number?',
                            style: TextStyle(
                                fontFamily: 'Bona Nova SC',
                                fontSize: 15,
                                color: Colors.red),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: _login,
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Stack(
                        alignment: Alignment.center,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 193, 21, 21),
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              // Add Google Sign-In Logic Here
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registerpage(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Register Now",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
