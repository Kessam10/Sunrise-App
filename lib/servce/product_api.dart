import 'package:dio/dio.dart';
import 'package:item_by_category/model/product_model.dart';

class ProductData {
  var dio = Dio();

  Future<List<ProductModel>> getProductsByCategory(
      {required String categoryId, required String resturantId}) async {
    String url =
        "https://yourcart.sunrise-resorts.com/clients/api/get_categories_with_product/$resturantId";
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        var jsonData = response.data;
        List<dynamic> categories = jsonData['categories'];
        List<ProductModel> productList = [];
        for (var category in categories) {
          List<dynamic> products = category['products'];
          for (var product in products) {
            ProductModel productModel = ProductModel.fromJson(product);
            productList.add(productModel);
          }
        }
        return productList;
      } else {
        print("Error: status code is ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    return List.empty();
  }
}
