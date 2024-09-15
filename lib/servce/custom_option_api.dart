import 'package:dio/dio.dart';

import '../model/custom_option_model.dart';

class CustomOptionApi {
  var dio = Dio();
  List<CustomOptionModel> custom = [];

  Future<List<CustomOptionModel>> getOptions({required String id}) async {
    String url =
        "https://yourcart.sunrise-resorts.com/clients/api/product_custom_option/$id";
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        var jsonData = response.data;
        List<dynamic> data = jsonData['custom_option'];
        List<CustomOptionModel> emptyList = [];
        for (var i in data) {
          CustomOptionModel customOptionModel = CustomOptionModel.fromJson(i);
          emptyList.add(customOptionModel);
        }
        return emptyList;
      } else {
        print("error status code : ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    return List.empty();
  }
}
