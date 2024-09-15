import 'package:dio/dio.dart';
import 'package:item_by_category/model/hotel_model.dart';
import 'package:item_by_category/servce/hotel_api.dart';

class HotelData {
  var dio = Dio();
  List<HotelModel> hotels = [];

  Future<List<HotelModel>> getHotels() async {
    String url =
        "https://yourcart.sunrise-resorts.com/clients/api/get_hotels/623";
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        var jsonData = response.data;
        List<dynamic> data = jsonData['hotels'];
        List<HotelModel> emptyList = [];
        for (var i in data) {
          HotelModel hotelModel = HotelModel.fromJson(i);
          emptyList.add(hotelModel);
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
