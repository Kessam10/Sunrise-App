import 'package:dio/dio.dart';
import 'package:item_by_category/model/category_model.dart';

class CategoryData {
  var dio = Dio();
  List<CategoryModel> category = [];

  Future<List<CategoryModel>> getCategory({required String id}) async {
    String url =
        "https://yourcart.sunrise-resorts.com/clients/api/get_categories_with_product/$id";
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        var jsonData = response.data;
        List<dynamic> data = jsonData['categories'];
        List<CategoryModel> emptyList = [];
        for (var i in data) {
          CategoryModel categoryModel = CategoryModel.fromJson(i);
          emptyList.add(categoryModel);
        }
        return emptyList;
      } else {
        print("error status code is ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    return List.empty();
  }
}
