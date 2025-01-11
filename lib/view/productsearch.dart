import 'package:comm/controll/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class ProductSearchPage extends StatelessWidget {
  // Instantiate the controller
  final Productsearch productController = Get.put(Productsearch());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Search Products', style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 28, fontWeight: FontWeight.w500)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (query) {
                productController.searchProducts(query);
              },
              decoration: InputDecoration(
                hintText: 'Search for products...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Displaying the product list or no products found message
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (productController.products.isEmpty) {
                  return Center(child: Text(productController.noProductsMessage.value));
                }
                return ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return ListTile(
                       leading: Image.network(   product.images.isNotEmpty ? product.images[0] : '', height: 50, width: 50, fit: BoxFit.cover),
                      title: Text(product.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      subtitle: Text('Price: \$${product.salePrice}'),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}