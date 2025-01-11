
// class Product {
//   final String name;
//   final double price;
//   final String brand;
//   final double rating;
//   final String image;

//   Product({
//     required this.name,
//     required this.price,
//     required this.brand,
//     required this.rating,
//     required this.image,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       name: json['name'] ?? 'Unknown', // Default to 'Unknown' if the field is missing
//       price: (json['price'] is int)
//           ? (json['price'] as int).toDouble()
//           : (json['price'] as double),
//       brand: json['brand'] ?? 'Generic', // Default brand if not provided
//       rating: json['rating']?.toDouble() ?? 0.0, // Safely convert and default to 0.0
//       image: json['image'] ?? '', // Empty string if no image is provided
//     );
//   }
// }

// class Product {
//   final int id;
//   final String name;
//   final double price;
//   final bool isActive;
//   final String brand;
//   final double rating;
//   final String image;

//   Product({required this.id, required this.name, required this.price, required this.isActive,required this.brand,
//    required this.rating,
//    required this.image,});

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       price: json['price'],
//       isActive: json['is_active'],
// brand: json['brand'] ,
//      rating: json['rating']?.toDouble() ?? 0.0, // Safely convert and default to 0.0
//       image: json['image'] 

//     );
//   }
// }


class Product {
  final int id;
  final List<String> images;
  bool inWishlist;
  final double avgRating;
  final double salePrice;
  final List<Addon> addons;
  final String name;
  

  Product({
    required this.id,
    required this.images,
    this.inWishlist = false,
    required this.avgRating,
    required this.salePrice,
    required this.addons,
      required this.name,

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var imagesList = json['images'] != null
        ? List<String>.from(json['images'])
        : <String>[];

    var addonsList = json['addons'] != null
        ? (json['addons'] as List)
            .map((addonJson) => Addon.fromJson(addonJson))
            .toList()
        : <Addon>[];

    return Product(
      id: json['id'],
      images: imagesList,
      inWishlist: json['in_wishlist'] ?? false,
      avgRating: json['avg_rating']?.toDouble() ?? 0.0,
      salePrice: json['sale_price']?.toDouble() ?? 0.0,
      addons: addonsList,
     name: json['name']?.toString() ?? '',
    );
  }
}

class Addon {
  final int id;
  final double price;
  final String name;
  final String description;
  final String featuredImage;
  final int stock;
  final bool isActive;
  final double taxRate;

  Addon({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
    required this.featuredImage,
    required this.stock,
    required this.isActive,
    required this.taxRate,
  });

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      id: json['id'],
      price: json['price']?.toDouble() ?? 0.0,
     name: json['name'] ?? '', 
      description: json['description'] ?? '',
      featuredImage: json['featured_image'] ?? '',
      stock: json['stock'] ?? 0,
      isActive: json['is_active'] ?? false,
      taxRate: json['tax_rate']?.toDouble() ?? 0.0,
    );
  }
}


class Banner {
  // Assuming a simple Banner class with required fields
  final String imageUrl;
  final String link;

  Banner({required this.imageUrl, required this.link});

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      imageUrl: json['imageUrl'] ?? '',
      link: json['link'] ?? '',
    );
  }
}
