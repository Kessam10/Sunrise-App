import 'package:item_by_category/model/hotel_group_model.dart';

List<HotelGroupModel> getGroup() {
  List<HotelGroupModel> hotelGroup = [];
  HotelGroupModel hotelGroupModel = new HotelGroupModel();

  hotelGroupModel.hotelGroup = "Hurghada";
  hotelGroup.add(hotelGroupModel);
  hotelGroupModel = new HotelGroupModel();

  hotelGroupModel.hotelGroup = "Marsa Alam";
  hotelGroup.add(hotelGroupModel);
  hotelGroupModel = new HotelGroupModel();

  hotelGroupModel.hotelGroup = "Sharm El sheikh";
  hotelGroup.add(hotelGroupModel);
  hotelGroupModel = new HotelGroupModel();

  hotelGroupModel.hotelGroup = "Alexandria";
  hotelGroup.add(hotelGroupModel);
  hotelGroupModel = new HotelGroupModel();

  hotelGroupModel.hotelGroup = "Zanzibar";
  hotelGroup.add(hotelGroupModel);
  hotelGroupModel = new HotelGroupModel();

  hotelGroupModel.hotelGroup = "Luxor";
  hotelGroup.add(hotelGroupModel);
  hotelGroupModel = new HotelGroupModel();

  hotelGroupModel.hotelGroup = "Aswan";
  hotelGroup.add(hotelGroupModel);
  hotelGroupModel = new HotelGroupModel();

  return hotelGroup;
}
