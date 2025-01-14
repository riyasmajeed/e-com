import 'package:comm/model/model.dart';
import 'package:flutter/material.dart';


class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name,style: TextStyle(fontSize: 28,    fontWeight: FontWeight.w500, // light
),)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.blue,
              child: Image.network(
               product.images.isNotEmpty ? product.images[0] : '',
              ),
            ), // Placeholder image
            SizedBox(height: 20),
            Text(product.name, style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text("Price: \$${product.salePrice}", style: TextStyle(fontSize: 20,    fontWeight: FontWeight.w500, // light
)),
            SizedBox(height: 10),
            Text("Discounted Price: \$${(product.salePrice * 0.9).toStringAsFixed(2)}", style: TextStyle(fontSize: 20,    fontWeight: FontWeight.w500, // light
)),
            SizedBox(height: 10),
            Text("Brand: ${product.name}", style: TextStyle(fontSize: 18,    fontWeight: FontWeight.w500, // light
)),
            SizedBox(height: 10),
            Text("Rating: ${product.avgRating}", style: TextStyle(fontSize: 18,    fontWeight: FontWeight.w500, // light
)),
          ],
        ),
      ),
    );
  }
}
