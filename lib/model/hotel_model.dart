class HotelModel {
  String? hotelName;
  String? hotelImage;
  String? hotelGroup;
  String? id;

  HotelModel(
      {required this.hotelName,
      required this.hotelGroup,
      required this.hotelImage,
      required this.id});

  factory HotelModel.fromJson(Map<String, dynamic> jsonData) {
    return HotelModel(
        hotelName: jsonData['hotel_name'] ?? '',
        hotelGroup: jsonData['hotel_group'] ?? '',
        hotelImage: jsonData['image'] ?? '',
        id: jsonData['id'] ?? '');
  }
}
