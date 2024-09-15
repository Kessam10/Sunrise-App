import 'package:flutter/material.dart';

class HotelGroupCard extends StatelessWidget {
  String hotelGroup;
  HotelGroupCard({required this.hotelGroup, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: 120,
            height: 80,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black38,
            ),
            height: 80,
            width: 120,
            child: Center(
              child: Text(
                hotelGroup,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
