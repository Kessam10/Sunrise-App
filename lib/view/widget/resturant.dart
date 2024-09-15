import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ResturantCard extends StatelessWidget {
  String? restImage;
  ResturantCard({required this.restImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        width: MediaQuery.of(context).size.width / 2.5,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            imageUrl:
                "https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/$restImage",
            height: 150,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
          ),
        ),
      ),
    );
  }
}
