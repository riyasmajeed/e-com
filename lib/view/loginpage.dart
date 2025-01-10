// // 

// import 'package:comm/model/colors.dart';
// import 'package:comm/view/home.dart';
// import 'package:comm/view/otoinput.dart';
// import 'package:comm/view/registerpage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phonenumberController = TextEditingController();

//   void _verifyPhoneNumber(String phone) async {
//     final url = Uri.parse("https://admin.kushinirestaurant.com/api/verify/");
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({"phone_number": phone}),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => OtpInputScreen(
//             phoneNumber: phone,
//             expectedOtp: data["otp"],
//             userExists: data["user"],
//             accessToken: data["token"]["access"],
//           ),
//         ),
//       );
//     } else {
//       _showErrorDialog(context, 'Login Failed', 'Failed to verify phone number.');
//     }
//   }

//   void _login() async {
//     String Name = _nameController.text.trim();
//     String Phonenumber = _phonenumberController.text.trim();

//     if (Name.isNotEmpty && Phonenumber.isNotEmpty) {
//       try {
//         // Verify the phone number before proceeding
//         _verifyPhoneNumber(Phonenumber);
//       } catch (e) {
//         _showErrorDialog(context, 'Login Failed', e.toString());
//       }
//     } else {
//       _showErrorDialog(context, 'Input Error', 'All fields are required.');
//     }
//   }

//   void _showErrorDialog(BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phonenumberController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/netfliximage.jpg'), fit: BoxFit.cover)),
//         child: Container(
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.centerLeft,
//                   colors: [
//                 Colors.black12,
//                 Color.fromARGB(255, 0, 0, 0)
//               ])),
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 110),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "E",
//                           style: TextStyle(
//                             fontSize: 50,
//                             color: red,
//                             fontWeight: FontWeight.w900,
//                           ),
//                         ),
//                         Text(
//                           "-commerce",
//                           style: TextStyle(
//                             fontSize: 35,
//                             color: red,
//                             fontWeight: FontWeight.w900,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 50),
//                     Text(
//                       'Welcome Back !',
//                       style: TextStyle(color: Colors.white, fontSize: 22),
//                     ),
//                     Text(
//                       'you have been missed for long time',
//                       style: TextStyle(
//                           color: const Color.fromARGB(154, 255, 255, 255),
//                           fontSize: 15),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 25, right: 25, top: 25),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           TextFormField(
//                             controller: _nameController,
//                             decoration: InputDecoration(
//                               hintText: 'NAME',
//                               prefixIcon: Icon(Icons.person),
//                               hintStyle: TextStyle(color: Colors.white),
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(width: 5)),
//                               focusColor: red,
//                             ),
//                             keyboardType: TextInputType.name,
//                             textInputAction: TextInputAction.next,
//                             cursorColor: Colors.white,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           const SizedBox(height: 10),
//                           TextFormField(
//                             controller: _phonenumberController,
//                             decoration: InputDecoration(
//                               hintText: 'Phone number',
//                               prefixIcon: Icon(Icons.numbers),
//                               hintStyle: TextStyle(color: Colors.white),
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(width: 5)),
//                               focusColor: red,
//                             ),
//                             keyboardType: TextInputType.number,
//                             textInputAction: TextInputAction.next,
//                             cursorColor: Colors.white,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10, bottom: 10),
//                             child: InkWell(
//                               onTap: () {
//                                 // Navigator.push(
//                                 //     // context,
//                                 //     // MaterialPageRoute(
//                                 //     //     builder: (Builder) =>
//                                 //     //         Forgotpassword())
//                                              //             );
//                               },
//                               child: Text(
//                                 'Forgot phonenumber ?',
//                                 style: TextStyle(
//                                     fontFamily: 'Bona Nova SC',
//                                     fontSize: 15,
//                                     color: red),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(10)),
//                             child: TextButton(
//                               onPressed: _login, // Use the login function here
//                               child: Padding(
//                                 padding: EdgeInsets.all(12.0),
//                                 child: Text(
//                                   "Login",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 15),
//                           Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Divider(
//                                 color: const Color.fromARGB(255, 193, 21, 21),
//                                 thickness: 1,
//                               ),
//                               Container(
//                                 color: Color.fromARGB(255, 0, 0, 0),
//                                 padding: EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: Text(
//                                   'Or continue with',
//                                   style: TextStyle(color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   // Add Google Sign-In Logic Here
//                                 },
//                                 child: Container(
//                                   height: 60,
//                                   width: 60,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           InkWell(
//                             onTap: () {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (Builder) => Registerpage()));
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Center(
//                                     child: Text(
//                                   "Don't have an account? ",
//                                   style: TextStyle(color: Colors.white),
//                                 )),
//                                 Center(
//                                     child: Text(
//                                   "Register Now ",
//                                   style: TextStyle(color: red),
//                                 )),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'otoinput.dart'; 
import 'registerpage.dart'; // Ensure you import the RegisterPage

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();

  // void _verifyPhoneNumber(String phone) async {
  //   final url = Uri.parse("https://admin.kushinirestaurant.com/api/verify/");
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({"phone_number": phone}),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => OtpInputScreen(
  //           phoneNumber: phone,
  //           expectedOtp: data["otp"],
  //           userExists: data["user"],
  //           accessToken: data["token"]["access"],
  //         ),
  //       ),
  //     );
  //   } else {
  //     _showErrorDialog(context, 'Login Failed', 'Failed to verify phone number.');
  //   }
  // }

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
      // User exists, proceed to OTP verification
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
      // User does not exist, show message
      _showErrorDialog(context, 'User Not Registered', 'Please register before logging in.');
    }
  } else {
    _showErrorDialog(context, 'Login Failed', 'Failed to verify phone number.');
  }
}

  void _login() async {
    String Name = _nameController.text.trim();
    String Phonenumber = _phonenumberController.text.trim();

    if (Name.isNotEmpty && Phonenumber.isNotEmpty) {
      try {
        // Verify the phone number before proceeding
        _verifyPhoneNumber(Phonenumber);
      } catch (e) {
        _showErrorDialog(context, 'Login Failed', e.toString());
      }
    } else {
      _showErrorDialog(context, 'Input Error', 'All fields are required.');
    }
  }

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
      decoration: BoxDecoration(
          
              ),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.centerLeft,
                colors: [
              Colors.black12,
              Color.fromARGB(255, 0, 0, 0)
            ])),
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
                  SizedBox(height: 50),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Text(
                    'You have been missed for a long time',
                    style: TextStyle(
                        color: const Color.fromARGB(154, 255, 255, 255),
                        fontSize: 15),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'NAME',
                            prefixIcon: Icon(Icons.person),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 5)),
                            focusColor: Colors.red,
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: InkWell(
                            onTap: () {
                              // Add Forgot password logic here
                            },
                            child: Text(
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
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Divider(
                              color: const Color.fromARGB(255, 193, 21, 21),
                              thickness: 1,
                            ),
                            Container(
                              color: Color.fromARGB(255, 0, 0, 0),
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
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
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Registerpage(),
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Don't have an account? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Register Now",
                                  style: TextStyle(color: Colors.red),
                                ),
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
      ),
    );
  }
}
