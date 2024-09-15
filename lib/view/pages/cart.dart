// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:item_by_category/model/custom_option_model.dart';
// import 'package:item_by_category/model/product_model.dart';
// import 'package:item_by_category/model/restaurant_model.dart';
// import 'package:item_by_category/servce/cart_provider.dart';
// import 'package:item_by_category/servce/custom_option_api.dart';
// import 'package:item_by_category/servce/resturant_api.dart';
// import 'package:item_by_category/view/pages/category_producet.dart';
// import 'package:item_by_category/view/widget/cart_card.dart';
// import 'package:provider/provider.dart';
//
// class MyCart extends StatefulWidget {
//   final String id;
//   MyCart({required this.id});
//
//   @override
//   State<MyCart> createState() => _MyCartState();
// }
//
// class _MyCartState extends State<MyCart> {
//   List<RestaurantModel> rest = [];
//   List<CustomOptionModel> option = [];
//   List<ProductModel> product = [];
//   bool _isloading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     getRest();
//   }
//
//   getOptions() async {
//     option = await CustomOptionApi().getOptions(id: product.id);
//     setState(() {});
//   }
//
//   getRest() async {
//     rest = await ResturantData().getResturant(id: widget.id);
//     setState(() {
//       _isloading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Cart'),
//       ),
//       body: Stack(
//         children: [
//           ListView.builder(
//             padding: EdgeInsets.only(bottom: 100),
//             itemCount: cart.items.length,
//             itemBuilder: (context, i) {
//               return CartCard(
//                 id: cart.items[i].id,
//                 productImage: cart.items[i].productImage,
//                 productName: cart.items[i].productName,
//                 productPrice: cart.items[i].price,
//                 initialQuantity: cart.items[i]
//                     .quantity, // Add this line if using the quantity field
//               );
//             },
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               padding: EdgeInsets.all(10),
//               height: 100,
//               color: Colors.black,
//               alignment: Alignment.center,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Total Price : ",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "\$${cart.totalPrice.toStringAsFixed(2)}",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       AwesomeDialog(
//                         context: context,
//                         dialogType: DialogType.question,
//                         animType: AnimType.rightSlide,
//                         title: 'Submit Order',
//                         desc:
//                             'Just to confirm, are you certain about submitting the order?',
//                         btnCancelOnPress: () {},
//                         descTextStyle:
//                             TextStyle(fontSize: 18, color: Colors.black),
//                         titleTextStyle: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                         btnOkOnPress: () {
//                           Provider.of<CartProvider>(context, listen: false)
//                               .clearCart();
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   CategoryProduct(restaurantId: widget.id),
//                             ),
//                             (route) => false,
//                           );
//                           ScaffoldMessenger.of(context).showSnackBar((SnackBar(
//                               duration: Duration(seconds: 2),
//                               backgroundColor: Colors.black,
//                               content: Text(
//                                 "Submited Successfuly",
//                                 style: TextStyle(fontSize: 20),
//                               ))));
//                         },
//                       )..show();
//                     },
//                     child: Material(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Color.fromARGB(31, 158, 158, 158),
//                       elevation: 15,
//                       child: Container(
//                         padding: EdgeInsets.all(8),
//                         child: Text(
//                           "Submit Order ?",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:item_by_category/model/custom_option_model.dart';
import 'package:item_by_category/model/product_model.dart';
import 'package:item_by_category/model/restaurant_model.dart';
import 'package:item_by_category/servce/cart_provider.dart';
import 'package:item_by_category/servce/custom_option_api.dart';
import 'package:item_by_category/servce/resturant_api.dart';
import 'package:item_by_category/view/pages/category_producet.dart';
import 'package:item_by_category/view/widget/cart_card.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  final String id;
  MyCart({super.key, required this.id});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<RestaurantModel> rest = [];
  List<CustomOptionModel> option = [];
  List<ProductModel> product = [];
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    getRest();
  }

  Future<List<CustomOptionModel>> fetchOptions(String productId) async {
    return await CustomOptionApi().getOptions(id: productId);
  }

  getRest() async {
    rest = await ResturantData().getResturant(id: widget.id);
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(bottom: 100),
            itemCount: cart.items.length,
            itemBuilder: (context, i) {
              return CartCard(
                id: cart.items[i].id,
                productImage: cart.items[i].productImage,
                productName: cart.items[i].productName,
                productPrice: cart.items[i].price,
                initialQuantity: cart.items[i].quantity,
                fetchOptions: fetchOptions, // Pass the fetchOptions callback
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 100,
              color: Colors.black,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Price : ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${cart.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        title: 'Submit Order',
                        desc:
                            'Just to confirm, are you certain about submitting the order?',
                        btnCancelOnPress: () {},
                        descTextStyle:
                            TextStyle(fontSize: 18, color: Colors.black),
                        titleTextStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        btnOkOnPress: () {
                          if (cart.items.isNotEmpty) {
                            Provider.of<CartProvider>(context, listen: false)
                                .clearCart();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryProduct(restaurantId: widget.id),
                              ),
                              // (route) => false,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar((SnackBar(
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.black,
                                    content: Text(
                                      "Submitted Successfully",
                                      style: TextStyle(fontSize: 20),
                                    ))));
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'Please add at least one item to proceed.',
                              btnOkOnPress: () {},
                            )..show();
                          }
                        },
                      )..show();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(31, 158, 158, 158),
                      elevation: 15,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Submit Order ?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
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
  }
}
