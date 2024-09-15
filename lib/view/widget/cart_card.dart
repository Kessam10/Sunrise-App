import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:item_by_category/servce/custom_option_provider.dart';
import 'package:item_by_category/view/widget/custom_option.dart';
import 'package:provider/provider.dart';
import 'package:item_by_category/servce/cart_provider.dart';

import '../../model/cart_model.dart';
import '../../model/custom_option_model.dart';

class CartCard extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final String id;
  final int initialQuantity;
  final Future<List<CustomOptionModel>> Function(String) fetchOptions;

  CartCard({
    required this.id,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    this.initialQuantity = 1,
    required this.fetchOptions,
    super.key,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late int counter;
  late double total;
  List<CustomOptionModel> option = [];
  bool isloading = true;

  @override
  void initState() {
    getOptions();
    counter = widget.initialQuantity;
    total = counter * double.parse(widget.productPrice);
    super.initState();
  }

  getOptions() async {
    option = await widget.fetchOptions(widget.id);
    setState(() {
      isloading = false;
    });
  }

  void _incrementCounter() {
    setState(() {
      counter++;
      total = counter * double.parse(widget.productPrice);
    });
    Provider.of<CartProvider>(context, listen: false)
        .updateQuantity(widget.id, counter);
  }

  void _decrementCounter() {
    if (counter > 1) {
      setState(() {
        counter--;
        total = counter * double.parse(widget.productPrice);
      });
      Provider.of<CartProvider>(context, listen: false)
          .updateQuantity(widget.id, counter);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CustomOptionProvider>(context);
    return isloading
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white12,
                ),
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
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Price: ${total.toStringAsFixed(2)} \$",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                              ),
                              GestureDetector(
                                onTap: () {
                                  final cartItem = CartItem(
                                    id: widget.id,
                                    productName:
                                        "${widget.productName}(custom)",
                                    productImage: widget.productImage,
                                    price: widget.productPrice,
                                  );
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .removeItem(widget.id);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar((SnackBar(
                                          duration: Duration(milliseconds: 500),
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            "Removed Successfuly",
                                            style: TextStyle(fontSize: 20),
                                          ))));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              option.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2.5,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Stack(
                                                  children: [
                                                    ListView.builder(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 100),
                                                        itemCount:
                                                            option.length,
                                                        itemBuilder:
                                                            (context, i) {
                                                          return OptionCard(
                                                              optionId: option[
                                                                      i]
                                                                  .product_id!,
                                                              optionName: option[
                                                                      i]
                                                                  .custom_option_name!,
                                                              optionPrice:
                                                                  option[i]
                                                                      .price!);
                                                        }),
                                                    Positioned(
                                                      left: 0,
                                                      right: 0,
                                                      bottom: 0,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        height: 100,
                                                        color: Colors.blue,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Total Price : ",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "\$${cart.totalPrice.toStringAsFixed(2)}",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    dialogType:
                                                                        DialogType
                                                                            .question,
                                                                    animType:
                                                                        AnimType
                                                                            .rightSlide,
                                                                    title:
                                                                        'Submit Edit',
                                                                    desc:
                                                                        'Just to confirm, are you certain about this custom options?',
                                                                    btnCancelOnPress:
                                                                        () {},
                                                                    descTextStyle: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .black),
                                                                    titleTextStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    btnOkOnPress:
                                                                        () {
                                                                      if (OptionCard
                                                                              .globalCounter >
                                                                          0) {
                                                                        final cartItem =
                                                                            CartItem(
                                                                          id: "${widget.id}",
                                                                          productName:
                                                                              "${widget.productName}(custom)",
                                                                          productImage:
                                                                              widget.productImage,
                                                                          price:
                                                                              widget.productPrice,
                                                                          quantity:
                                                                              1,
                                                                        );
                                                                        Provider.of<CartProvider>(context,
                                                                                listen: false)
                                                                            .handleCustomOption(cartItem);

                                                                        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                                                                            duration: Duration(milliseconds: 500),
                                                                            backgroundColor: Colors.black,
                                                                            content: Text(
                                                                              "Added Successfuly",
                                                                              style: TextStyle(fontSize: 20),
                                                                            ))));
                                                                        // cartItem
                                                                        //     .id = cartItem
                                                                        //         .id +
                                                                        //     "123";
                                                                      } else {
                                                                        AwesomeDialog(
                                                                          context:
                                                                              context,
                                                                          dialogType:
                                                                              DialogType.error,
                                                                          animType:
                                                                              AnimType.rightSlide,
                                                                          title:
                                                                              'Error',
                                                                          desc:
                                                                              'Please add at least one option to proceed.',
                                                                          btnOkOnPress:
                                                                              () {},
                                                                        )..show();
                                                                      }
                                                                    })
                                                                  ..show();
                                                              },
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: CupertinoColors
                                                                    .activeBlue,
                                                                elevation: 15,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  child: Text(
                                                                    "Submit Custom Edit ?",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.black,
                                        ),
                                        child: Icon(
                                          Icons.menu,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(width: 60),
                              GestureDetector(
                                onTap: _decrementCounter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                "$counter",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: _incrementCounter,
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
