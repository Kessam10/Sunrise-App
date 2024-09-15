import 'package:flutter/material.dart';
import 'package:item_by_category/model/category_model.dart';
import 'package:item_by_category/model/hotel_model.dart';
import 'package:item_by_category/model/restaurant_model.dart';
import 'package:item_by_category/servce/hotel_api.dart';
import 'package:item_by_category/servce/resturant_api.dart';
import 'package:item_by_category/view/pages/category_producet.dart';
import 'package:item_by_category/view/widget/resturant.dart';

class Resturant extends StatefulWidget {
  final String id; // Made non-nullable for consistency
  Resturant({required this.id, super.key});

  @override
  State<Resturant> createState() => _ResturantState();
}

class _ResturantState extends State<Resturant> {
  List<CategoryModel> category = [];
  List<RestaurantModel> rest = [];
  bool _isloading = true;
  List<HotelModel> hotels = [];

  @override
  void initState() {
    super.initState();
    getRest();
  }

  getRest() async {
    rest.clear();
    rest = await ResturantData().getResturant(id: widget.id);
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: rest.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
              ),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryProduct(
                          restaurantId: rest[i].code!,
                        ),
                      ),
                    );
                  },
                  child: ResturantCard(restImage: rest[i].restaurantlogo!),
                );
              },
            ),
    );
  }
}
