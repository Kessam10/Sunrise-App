import 'package:flutter/material.dart';
import 'package:item_by_category/model/hotel_group_model.dart';
import 'package:item_by_category/model/hotel_model.dart';
import 'package:item_by_category/servce/hotel_api.dart';
import 'package:item_by_category/servce/hotel_group.dart';
import 'package:item_by_category/view/pages/resturant.dart';
import 'package:item_by_category/view/widget/hotel_Card.dart';
import 'package:item_by_category/view/widget/hotel_group_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HotelGroupModel> hotelGroup = [];
  List<HotelModel> hotels = [];
  bool _isLoading = true;
  String selectedGroup = ''; // Track the selected group

  @override
  void initState() {
    hotelGroup = getGroup();
    getHotel();
    super.initState();
  }

  getHotel() async {
    hotels = await HotelData().getHotels();
    setState(() {
      _isLoading = false;
    });
  }

  // Filter hotels by selected group
  List<HotelModel> getFilteredHotels() {
    if (selectedGroup.isEmpty) {
      return hotels; // Show all hotels if no group is selected
    }
    return hotels.where((hotel) => hotel.hotelGroup == selectedGroup).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Clear the selected group when tapping the free space
        setState(() {
          selectedGroup = '';
        });
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30, left: 5, right: 5),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hotelGroup.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGroup = hotelGroup[i].hotelGroup!;
                      });
                    },
                    child: Center(
                      child:
                          HotelGroupCard(hotelGroup: hotelGroup[i].hotelGroup!),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: getFilteredHotels().length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Resturant(id: hotels[i].id!),
                        ),
                      );
                    },
                    child: HotelCard(
                      hotelImage: getFilteredHotels()[i].hotelImage!,
                      hotelGroup: getFilteredHotels()[i].hotelGroup!,
                      hotelName: getFilteredHotels()[i].hotelName!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
