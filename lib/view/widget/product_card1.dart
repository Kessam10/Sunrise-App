import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:item_by_category/model/cart_model.dart';
import 'package:item_by_category/servce/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductCard1 extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final String id;
  ProductCard1(
      {required this.id,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      super.key});

  @override
  State<ProductCard1> createState() => _ProductCard1State();
}

class _ProductCard1State extends State<ProductCard1> {
  bool is_btnActive = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white12),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://yourcart.sunrise-resorts.com/assets/uploads/products/${widget.productImage}",
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Center(child: Image.asset("images/noimage.jpeg")),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.productPrice + ' \$',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // is_btnActive
                            //     ? () {
                            //         setState(() {
                            //           is_btnActive = false;
                            //         });
                            final cartItem = CartItem(
                              id: widget.id,
                              productName: widget.productName,
                              productImage: widget.productImage,
                              price: widget.productPrice,
                            );
                            Provider.of<CartProvider>(context, listen: false)
                                .addItem(cartItem);
                            ScaffoldMessenger.of(context)
                                .showSnackBar((SnackBar(
                                    duration: Duration(milliseconds: 500),
                                    backgroundColor: Colors.black,
                                    content: Text(
                                      "Added Successfuly",
                                      style: TextStyle(fontSize: 20),
                                    ))));
                          }
                          // : null,
                          ,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            width: 100,
                            height: 30,
                            child: Center(
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
