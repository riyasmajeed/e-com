import 'package:comm/model/model.dart';
import 'package:comm/view/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsPage(product: product));
      },
      child: Card(
        child: Container(
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("https://via.placeholder.com/150"), // Placeholder image
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(product.name, style: TextStyle(fontSize: 16)),
                    Text("Price: \$${product.price}"),
                    Text("Discounted: \$${(product.price * 0.9).toStringAsFixed(2)}"),
                    Text("Brand: ${product.brand}"),
                    Text("Rating: ${product.rating}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
