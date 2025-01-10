


import 'dart:convert';
import 'package:comm/view/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:comm/view/home.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }

  // Show error dialog
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

  // Handle API registration
  void _register() async {
    String firstName = _nameController.text.trim();
    String phoneNumber = _phonenumberController.text.trim();

    if (firstName.isNotEmpty && phoneNumber.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      final url = Uri.parse('https://admin.kushinirestaurant.com/api/login-register/');
      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'first_name': firstName,
            'phone_number': phoneNumber,
          }),
        );

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
         print(responseData);

          // Show success message using SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration Successful'),
              duration: Duration(seconds: 2), // Set how long the message will be displayed
            ),
          );

          // Navigate to Home screen after showing the message
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          });
        } else {
          // Handle server-side error
          _showErrorDialog(context, 'Registration Failed', 'Something went wrong. Please try again.');
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        // Handle network error
        _showErrorDialog(context, 'Network Error', 'Could not reach the server. Please check your connection.');
      }
    } else {
      _showErrorDialog(context, 'Input Error', 'All fields are required.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.centerLeft,
            colors: [
              Colors.black12,
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
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
                  const Text(
                    'Welcome!',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            prefixIcon: const Icon(Icons.person),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: const OutlineInputBorder(),
                            focusColor: Colors.red,
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _phonenumberController,
                          decoration: InputDecoration(
                            hintText: 'Phone number',
                            prefixIcon: Icon(Icons.numbers),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 5)),
                            focusColor: Colors.red,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        if (_isLoading)
                          const CircularProgressIndicator()
                        else
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: _register,
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  "CREATE",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
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
      ),
    );
  }
}
