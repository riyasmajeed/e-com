

import 'package:comm/controll/product.dart';
import 'package:comm/view/bannersileder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());
@override
  void initState() {
    ProductCarouselScreen();
    super.initState();
  }
  @override

  
  Widget build(BuildContext context) {
    return Scaffold(
        
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'E-Commerce Home',
          style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 28, fontWeight: FontWeight.w500),
        ),
          
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: 
          Obx(() {
            if (productController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (productController.products.isEmpty) {
              return const Center(child: Text("No products available"));
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  childAspectRatio: 250 / 270,
                  mainAxisExtent: 270,
                ),
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  final product = productController.products[index];
          
                  return GestureDetector(
                    onTap: () {
                      // Navigate to Product Details Page (if available)
                      // Get.to(() => ProductDetailsPage(product: product));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30,
                                  width: 65,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      '10% OFF',
                                      style: TextStyle(color: Colors.black, fontSize: 10),
                                    ),
                                  ),
                                ),
                                const Icon(Icons.favorite, color: Colors.grey, size: 22),
                              ],
                            ),
                          ),
                          // Product Image
                          Image.network(
                            product.images.isNotEmpty ? product.images[0] : '',
                            height: 120,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "${product.name}",
                              style: const TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\$${product.salePrice}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "\$${(product.salePrice * 1.1).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          // Addons List
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Column(
                          //     children: product.addons.map((addon) {
                          //       return ListTile(
                          //         leading: Image.network(
                          //           addon.featuredImage,
                          //           height: 40,
                          //           width: 40,
                          //           fit: BoxFit.cover,
                          //         ),
                          //         title: Text(addon.name),
                          //         subtitle: Text(addon.description),
                          //         trailing: Text("\$${addon.price}"),
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
        
      
    );
  }
}
