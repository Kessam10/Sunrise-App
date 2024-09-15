import 'package:flutter/cupertino.dart';

import '../model/custom_option_model.dart';

class CustomOptionProvider with ChangeNotifier {
  List<CustomOptionModel> _option = [];
  List<CustomOptionModel> get options => _option;

  void addItem(CustomOptionModel item) {
    _option.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _option.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _option.clear();
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    for (var option in _option) {
      if (option.id == id) {
        option.quantity = quantity;
        break;
      }
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var option in _option) {
      total += double.parse(option.price!) * option.quantity;
    }
    return total;
  }
}
