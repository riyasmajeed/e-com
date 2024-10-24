// import 'package:comm/controll/product.dart';
// import 'package:comm/model/model.dart';
// import 'package:comm/view/productcard.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomePage extends StatelessWidget {
//   final ProductController controller = Get.put(ProductController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("E-Commerce App"),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (controller.error.isNotEmpty) {
//           return Center(child: Text(controller.error.value));
//         } else {
//           return ListView(
//             children: [
//               buildCategoryList("New Arrivals", controller.products),
//               buildCategoryList("Trending Products", controller.products),
//             ],
//           );
//         }
//       }),
//     );
//   }

//   Widget buildCategoryList(String title, List<Product> products) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.all(8),
//           child: Text(title, style: TextStyle(fontSize: 18)),
//         ),
//         SizedBox(
//           height: 200,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               return ProductCard(product: products[index]);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:comm/controll/product.dart';
import 'package:comm/view/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce Home',style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.w500,),),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
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
              childAspectRatio: 250,
              mainAxisExtent: 270,
            ),
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              final product = productController.products[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailsPage(product: product));
                },
                child: Stack(
                  children: [
                    Container(
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
                          // Image.network(
                          //    color: Colors.blue,
                          //  product.image,
                          //   height: 120,
                          //   width: 100,
                          //   fit: BoxFit.cover,
                           
                           
                          // ),
                          Container(
                            
                               color: Colors.blue,
                           child: Image.network(
                            "https://images.pexels.com/photos/1092644/pexels-photo-1092644.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                           ),
                           height: 120,
                            width: 100,

                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              product.name,
                              style: const TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\$${product.price}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "\$${(product.price * 1.1).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
