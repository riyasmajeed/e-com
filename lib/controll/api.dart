import 'package:comm/model/model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// class ApiService {
//   static const String baseUrl = "https://admin.kushinirestaurant.com/api/products/";

//   Future<List<Product>> fetchProducts() async {
//     final response = await http.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       return (jsonDecode(response.body) as List)
//           .map((data) => Product.fromJson(data))
//           .toList();
//     } else {
//       throw Exception("Failed to load products");
//     }
//   }
// }

// class ApiService {
//   static const String baseUrl = "https://admin.kushinirestaurant.com/api/products/"; // Replace with your API URL

//   /// Fetches the product list from the API
//   Future<List<Product>> fetchProducts() async {
//     try {
//       // Make a GET request to the API
//       final response = await http.get(Uri.parse(baseUrl));

//       // Check if the response is successful
//       if (response.statusCode == 200) {
//         // Decode the JSON response into a list of dynamic objects
       
//         final List<dynamic> data = jsonDecode(response.body);

//         // Convert the list of JSON objects into a list of Product models
//         return data.map((json) => Product.fromJson(json)).toList();
//       } else {
//         // Handle the error if the API response status code is not 200
//         throw Exception("Failed to load products. Status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       // Handle any exceptions that occur during the API call
//       throw Exception("Error fetching products: $e");
//     }
//   }
// }


class ApiService {
  static const String baseUrl = "https://admin.kushinirestaurant.com/api/products/";

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error fetching products: $e");
    }
  }
}

class BannerController {
 static const String baseUrl = "https://admin.kushinirestaurant.com/api/banners/";

 Future<List<Product>> fetchProducts() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Error fetching products: $e");
  }
}

}

