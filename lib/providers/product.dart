import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  // 6th step
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavouraite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavouraite = false,
  });

  void toggleIsFavouraiteStatus() {
    isFavouraite = !isFavouraite;
    notifyListeners(); // 10th step
  }
}
