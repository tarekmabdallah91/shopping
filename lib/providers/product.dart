import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/json_serializable.dart';
part 'product.g.dart';

// for Nested classes use annotation @JsonSerializable(explicitToJson: true)
@JsonSerializable()
class Product with ChangeNotifier {
  // 6th step 'with ChangeNotifier'
  String id;
  @JsonKey(required: true)
  final String title;
  @JsonKey(required: true)
  final String description;
  @JsonKey(defaultValue: 0)
  final double price;
  @JsonKey(required: true)
  final String imageUrl;
  @JsonKey(defaultValue: false)
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  /// A necessary factory constructor for creating a new User instance
  /// The constructor is named after the source class, in this flutter pub run build_runner build --delete-conflicting-outputscase
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // void toggleFavoriteStatus() {
  //   isFavorite = !isFavorite;
  //   notifyListeners(); // 10th step
  // }

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        Uri.https('alarmscontroller.firebaseio.com', '/products/$id.json');
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
