import 'package:comm/controll/api.dart';
import 'package:comm/model/model.dart';
import 'package:get/get.dart';


class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = <Product>[].obs;
  var error = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var productData = await ApiService().fetchProducts();
      products.assignAll(productData);
    } catch (e) {
      error("Failed to fetch products");
    } finally {
      isLoading(false);
    }
  }
}
