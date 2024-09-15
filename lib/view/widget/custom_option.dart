// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:item_by_category/servce/custom_option_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../servce/cart_provider.dart';
//
// class OptionCard extends StatefulWidget {
//   final String optionName;
//   final String optionPrice;
//   final String optionId;
//   int initialQuantity;
//
//   static int counter = 0; // Add this line
//
//   OptionCard({
//     required this.optionName,
//     required this.optionPrice,
//     required this.optionId,
//     this.initialQuantity = 0,
//     super.key,
//   });
//
//   @override
//   State<OptionCard> createState() => _OptionCardState();
// }
//
// class _OptionCardState extends State<OptionCard> {
//   late int counter;
//   late double total;
//
//   @override
//   void initState() {
//     counter = widget.initialQuantity;
//     total = counter * double.parse(widget.optionPrice);
//     super.initState();
//   }
//
//   void _incrementCounter() {
//     setState(() {
//       counter++;
//       total = counter * double.parse(widget.optionPrice);
//     });
//     Provider.of<CustomOptionProvider>(context, listen: false)
//         .updateQuantity(widget.optionId, counter);
//   }
//
//   void _decrementCounter() {
//     if (counter > 0) {
//       setState(() {
//         counter--;
//         total = counter * double.parse(widget.optionPrice);
//       });
//       Provider.of<CustomOptionProvider>(context, listen: false)
//           .updateQuantity(widget.optionId, counter);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Material(
//         elevation: 10.0,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white12,
//           ),
//           margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(widget.optionName, style: TextStyle(fontSize: 20)),
//               SizedBox(height: 10),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "\$${total.toStringAsFixed(2)}",
//                     style: TextStyle(fontSize: 18, color: Colors.blue),
//                   ),
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: _decrementCounter,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: Colors.black,
//                           ),
//                           child: Icon(
//                             Icons.remove,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Text(
//                         "$counter",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       GestureDetector(
//                         onTap: _incrementCounter,
//                         child: Container(
//                           margin: EdgeInsets.only(right: 20),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: Colors.black,
//                           ),
//                           child: Icon(
//                             Icons.add,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:item_by_category/servce/custom_option_provider.dart';
import 'package:provider/provider.dart';

class OptionCard extends StatefulWidget {
  final String optionName;
  final String optionPrice;
  final String optionId;
  int initialQuantity;

  static int globalCounter = 0;

  OptionCard({
    required this.optionName,
    required this.optionPrice,
    required this.optionId,
    this.initialQuantity = 0,
    super.key,
  });

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  late int counter;
  late double total;

  @override
  void initState() {
    counter = widget.initialQuantity;
    total = counter * double.parse(widget.optionPrice);
    OptionCard.globalCounter += counter;
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      counter++;
      total = counter * double.parse(widget.optionPrice);
      OptionCard.globalCounter++;
    });
    Provider.of<CustomOptionProvider>(context, listen: false)
        .updateQuantity(widget.optionId, counter);
  }

  void _decrementCounter() {
    if (counter > 0) {
      setState(() {
        counter--;
        total = counter * double.parse(widget.optionPrice);
        OptionCard.globalCounter--;
      });
      Provider.of<CustomOptionProvider>(context, listen: false)
          .updateQuantity(widget.optionId, counter);
    }
  }

  @override
  void dispose() {
    OptionCard.globalCounter -= counter;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white12,
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.optionName, style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  Row(
                    children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
