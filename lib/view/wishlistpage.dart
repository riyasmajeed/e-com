import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comm/controll/product.dart';

class WishlistPage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    final wishlistItems = productController.products.where((product) => product.inWishlist).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: wishlistItems.isEmpty
          ? const Center(child: Text("Your wishlist is empty"))
          : ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final product = wishlistItems[index];
                return ListTile(
                  leading: Image.network(   product.images.isNotEmpty ? product.images[0] : '', height: 50, width: 50, fit: BoxFit.cover),
                  title: Text(product.name ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  subtitle: Text("\$${product.salePrice}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      productController.toggleWishlist(product.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}
