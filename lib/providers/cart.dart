import 'package:flutter/foundation.dart';
import 'package:shopping/models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(
    String productId,
    String title,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existCartItem) => CartItem(
                id: existCartItem.id,
                title: existCartItem.title,
                price: existCartItem.price,
                quantity: existCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: productId,
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }
}
