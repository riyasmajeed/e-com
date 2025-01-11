import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to register a user
Future<Map<String, dynamic>> registerUser(String firstName, String phoneNumber) async {
  final String baseUrl = 'https://admin.kushinirestaurant.com/api/login-register/';

  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'first_name': firstName,
        'phone_number': phoneNumber,
      }),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return {'success': true, 'data': responseData};
    } else {
      return {'success': false, 'message': 'Something went wrong. Please try again.'};
    }
  } catch (error) {
    // Handle any errors that occur during the API request
    return {'success': false, 'message': 'Could not reach the server. Please check your connection.'};
  }
}
