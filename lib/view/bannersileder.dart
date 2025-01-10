import 'package:comm/controll/api.dart';
import 'package:comm/model/model.dart';
import 'package:comm/view/home.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCarouselScreen extends StatelessWidget {
  final BannerController bannerController = BannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Carousel"),
      ),
      body: FutureBuilder<List<Product>>(
        future: bannerController.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No products available"));
          } else {
            final products = snapshot.data!;
            return CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: products.map((product) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: 
                              
                              Image.network(
                               product.images.isNotEmpty ? product.images[1] : '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(child: CircularProgressIndicator());
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name,
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                           
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
