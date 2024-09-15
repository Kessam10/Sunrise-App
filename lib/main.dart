// import 'package:flutter/material.dart';
// import 'package:item_by_category/servce/cart_provider.dart';
// import 'package:item_by_category/view/pages/page.dart';
// import 'package:provider/provider.dart';
//
// void main() {
//   runApp(ChangeNotifierProvider(
//     create: (context) => CartProvider(),
//     child: MyApp(),
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:item_by_category/servce/cart_provider.dart';
import 'package:item_by_category/servce/custom_option_provider.dart';
import 'package:item_by_category/view/pages/page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => CustomOptionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
