import 'package:flutter/material.dart';
import '../model/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addEditedItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void handleCustomOption(CartItem item) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == item.id && _items[i].quantity > 1) {
        _items[i].quantity -= 1;
        addItem(item);
        item.id = "${_items[i].id}123";
        return;
      } else if (_items[i].id == item.id && _items[i].quantity == 1) {
        _items.removeAt(i);
        addItem(item);
        item.id = "${_items[i].id}123";
        return;
      }
    }
    notifyListeners();
  }

  void addItem(CartItem item) {
    bool itemExists = false;
    for (var existingItem in _items) {
      if (existingItem.id == item.id) {
        // Update the quantity if item already exists
        existingItem.quantity += item.quantity;
        itemExists = true;
        break;
      }
    }
    if (!itemExists) {
      _items.add(item);
    }
    notifyListeners();
  }

  void editItem(CartItem updatedItem) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == updatedItem.id) {
        _items[i] = updatedItem;
        // addEditedItem(updatedItem);
        break;
      }
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    for (var item in _items) {
      if (item.id == id) {
        item.quantity = quantity;
        break;
      }
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += double.parse(item.price) * item.quantity;
    }
    return total;
  }
}
