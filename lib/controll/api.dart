import 'package:comm/model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiService {
  static const String baseUrl = "https://fake-store-api.mock.beeceptor.com/api/products";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
