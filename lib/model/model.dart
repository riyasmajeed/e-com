import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String brand;
  final double rating;
   final String image; 

  Product({
    required this.name,
    required this.price,
    required this.brand,
    required this.rating,
    required this.image
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      brand: json['brand'],
      rating: json['rating'].toDouble(),
      image: "https://images.pexels.com/photos/1092644/pexels-photo-1092644.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    );
  }
}
