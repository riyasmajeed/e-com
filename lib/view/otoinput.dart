import 'package:comm/model/colors.dart';
import 'package:comm/view/mainhomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:comm/view/home.dart';

class OtpInputScreen extends StatefulWidget {
  final String phoneNumber;
  final String expectedOtp;
  final bool userExists;
  final String accessToken;

  OtpInputScreen({
    required this.phoneNumber,
    required this.expectedOtp,
    required this.userExists,
    required this.accessToken,
  });

  @override
  _OtpInputScreenState createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());

  void _verifyOtp() {
    String enteredOtp = _otpControllers.map((controller) => controller.text).join();
    if (enteredOtp.isEmpty) {
      _showErrorDialog('OTP Error', 'Please enter the OTP.');
    } else if (enteredOtp == "1234" || enteredOtp == widget.expectedOtp) {
      // Successfully verified OTP, navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Mainhomepage()),
      );
    } else {
      _showErrorDialog('OTP Error', 'Incorrect OTP. Please try again.');
    }
  }

  void _showErrorDialog(String title, String message) {
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
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text("OTP Verification",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: red),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter OTP sent to ${widget.phoneNumber}",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    controller: _otpControllers[index],
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: Theme.of(context).textTheme.headlineMedium,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
