import 'package:flutter/foundation.dart';
import 'package:shopping/models/cart_item.dart';
import 'package:shopping/providers/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existCartItem) => CartItem(
                id: existCartItem.id,
                title: existCartItem.title,
                price: existCartItem.price,
                quantity: existCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
                id: product.id,
                title: product.title,
                price: product.price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }
}
