class RestaurantModel {
  String? restaurantName;
  String? restaurantlogo;
  String? code;

  RestaurantModel(
      {required this.code,
      required this.restaurantName,
      required this.restaurantlogo});

  factory RestaurantModel.fromJson(Map<String, dynamic> jsonData) {
    return RestaurantModel(
        restaurantName: jsonData['restaurant_name'] ?? '',
        restaurantlogo: jsonData['logo'] ?? '',
        code: jsonData['code'] ?? '');
  }
}
