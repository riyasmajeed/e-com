// import 'package:comm/controll/api.dart';
// import 'package:comm/model/model.dart';
// import 'package:get/get.dart';



// class ProductController extends GetxController {
//   var isLoading = true.obs;
//   var products = <Product>[].obs;

//   @override
//   void onInit() {
//     fetchProducts();
//     super.onInit();
//   }

//   void fetchProducts() async {
//     try {
//       isLoading(true);
//       var productData = await ApiService().fetchProducts();
//       products.assignAll(productData);
//     } catch (e) {
//       // Handle the error
//       print("Error fetching products: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
// }


import 'dart:convert';
import 'package:comm/controll/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var products = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
     try {
      isLoading(true);
      var productData = await ApiService().fetchProducts();
     products.assignAll(productData);
     } catch (e) {
//       // Handle the error
       print("Error fetching products: $e");
    } finally {
     isLoading(false);
    }
  }

  Future<void> toggleWishlist(int productId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    if (token == null) {
      Get.snackbar("Error", "Please log in to manage your wishlist.");
      return;
    }

    final url = Uri.parse("https://admin.kushinirestaurant.com/api/add-remove-wishlist/");
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({"product_id": productId}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Get.snackbar("Success", data["message"]);

      // Update the local product's `inWishlist` status
      final productIndex =
          products.indexWhere((product) => product.id == productId);
      if (productIndex != -1) {
        products[productIndex].inWishlist =
            !products[productIndex].inWishlist;
        products.refresh(); // Notify listeners to rebuild UI
      }
    } else {
      Get.snackbar("Error", "Failed to update wishlist.");
    }
  } catch (e) {
    Get.snackbar("Error", e.toString());
  }
}

}
