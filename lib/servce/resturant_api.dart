import 'package:dio/dio.dart';
import 'package:item_by_category/model/restaurant_model.dart';

class ResturantData {
  var dio = Dio();
  List<RestaurantModel> resturant = [];

  Future<List<RestaurantModel>> getResturant({required String id}) async {
    String url =
        "https://yourcart.sunrise-resorts.com/clients/api/getHotelRestaurants/$id";
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        var jsonData = response.data;
        List<dynamic> data = jsonData['restaurants'];
        List<RestaurantModel> emptyList = [];

        for (var i in data) {
          RestaurantModel restaurantModel = RestaurantModel.fromJson(i);
          emptyList.add(restaurantModel);
        }
        return emptyList;
      }
    } catch (e) {
      print(e);
    }
    return List.empty();
  }
}
