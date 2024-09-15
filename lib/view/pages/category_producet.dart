// import 'package:flutter/material.dart';
// import 'package:item_by_category/model/category_model.dart';
// import 'package:item_by_category/model/product_model.dart';
// import 'package:item_by_category/servce/category_api.dart';
// import 'package:item_by_category/servce/product_api.dart';
// import 'package:item_by_category/view/pages/cart.dart';
// import 'package:item_by_category/view/widget/product_card1.dart';
//
// class CategoryProduct extends StatefulWidget {
//   final String restaurantId;
//
//   CategoryProduct({required this.restaurantId, Key? key}) : super(key: key);
//
//   @override
//   _CategoryProductState createState() => _CategoryProductState();
// }
//
// class _CategoryProductState extends State<CategoryProduct> {
//   ScrollController _scrollController = ScrollController();
//   int _currentScrollIndex = 0;
//   List<CategoryModel> categories = [];
//   List<ProductModel> products = [];
//   bool _isLoading = true;
//   final _containerHeight = 120.0;
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//     _scrollController.addListener(_updateCurrentScrollIndex);
//   }
//
//   void _updateCurrentScrollIndex() {
//     _currentScrollIndex = _scrollController.offset ~/ _containerHeight;
//   }
//
//   void _onCategoryTap(int i) {
//     final categoryId = categories[i].id;
//     final productIndex =
//         products.indexWhere((product) => product.categoryId == categoryId);
//
//     if (productIndex != -1) {
//       _scrollController.animateTo(
//         productIndex * _containerHeight,
//         duration: Duration(seconds: 1),
//         curve: Curves.easeIn,
//       );
//       setState(() {
//         _currentScrollIndex = i;
//       });
//     }
//   }
//
//   fetchCategories() async {
//     categories.clear();
//     categories = await CategoryData().getCategory(id: widget.restaurantId);
//     if (categories.isNotEmpty) {
//       fetchProducts(categories.first.id!);
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   fetchProducts(String categoryId) async {
//     products.clear();
//     products = await ProductData().getProductsByCategory(
//         categoryId: categoryId, resturantId: widget.restaurantId);
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 SizedBox(
//                   height: 90,
//                   width: double.infinity,
//                   child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: categories.length,
//                       itemBuilder: (context, i) {
//                         return InkWell(
//                           onTap: () {
//                             _onCategoryTap(i);
//                           },
//                           child: Container(
//                             width: 150,
//                             height: 50,
//                             margin: EdgeInsets.all(15),
//                             alignment: Alignment.center,
//                             decoration: i == _currentScrollIndex
//                                 ? BoxDecoration(
//                                     border: Border(
//                                         bottom: BorderSide(
//                                             color: Colors.grey, width: 2)))
//                                 : null,
//                             child: Text(
//                               categories[i].categoryName!,
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MyCart(
//                             id: widget.restaurantId), // Pass the restaurantId
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width / 2,
//                     decoration: BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Center(
//                         child: Text(
//                       "Go to Cart",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     )),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     controller: _scrollController,
//                     itemCount: products.length,
//                     itemBuilder: (context, i) {
//                       return Container(
//                         height: _containerHeight,
//                         alignment: Alignment.center,
//                         child: ProductCard1(
//                           id: products[i].id!,
//                           productImage: products[i].productImage!,
//                           productPrice: products[i].price!,
//                           productName: products[i].productName!,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:item_by_category/model/category_model.dart';
import 'package:item_by_category/model/product_model.dart';
import 'package:item_by_category/servce/category_api.dart';
import 'package:item_by_category/servce/product_api.dart';
import 'package:item_by_category/view/pages/cart.dart';
import 'package:item_by_category/view/widget/product_card1.dart';
import 'package:provider/provider.dart';

import '../../servce/cart_provider.dart';

class CategoryProduct extends StatefulWidget {
  final String restaurantId;

  CategoryProduct({required this.restaurantId, Key? key}) : super(key: key);

  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  ScrollController _scrollController = ScrollController();
  int _currentScrollIndex = 0;
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  bool _isLoading = true;
  final _containerHeight = 120.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    _scrollController.addListener(_updateCurrentScrollIndex);
  }

  void _updateCurrentScrollIndex() {
    setState(() {
      _currentScrollIndex = _scrollController.offset ~/ _containerHeight;
    });
  }

  void _onCategoryTap(int i) {
    final categoryId = categories[i].id;
    final productIndex =
        products.indexWhere((product) => product.categoryId == categoryId);

    if (productIndex != -1) {
      _scrollController.animateTo(
        productIndex * _containerHeight,
        duration: Duration(seconds: 1),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentScrollIndex = i;
      });
    }
  }

  fetchCategories() async {
    categories.clear();

    categories = await CategoryData().getCategory(id: widget.restaurantId);
    if (categories.isNotEmpty) {
      fetchProducts(categories.first.id!);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  fetchProducts(String categoryId) async {
    products.clear();
    Provider.of<CartProvider>(context, listen: false).clearCart();

    products = await ProductData().getProductsByCategory(
        categoryId: categoryId, resturantId: widget.restaurantId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            _onCategoryTap(i);
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            margin: EdgeInsets.all(15),
                            alignment: Alignment.center,
                            decoration: i == _currentScrollIndex
                                ? BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey, width: 2)))
                                : null,
                            child: Text(
                              categories[i].categoryName!,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCart(
                            id: widget.restaurantId), // Pass the restaurantId
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Go to Cart",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: products.length,
                    itemBuilder: (context, i) {
                      return Container(
                        height: _containerHeight,
                        alignment: Alignment.center,
                        child: ProductCard1(
                          id: products[i].id!,
                          productImage: products[i].productImage!,
                          productPrice: products[i].price!,
                          productName: products[i].productName!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
