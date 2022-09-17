import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/providers/product.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

// 2nd step
class Products with ChangeNotifier {
  List<Product> _items = [
    //   Product(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   ),
    //   Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   ),
    //   Product(
    //     id: 'p3',
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl:
    //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   ),
    //   Product(
    //     id: 'p4',
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ),
  ];

  List<Product> get getFavouraitesOnly {
    return _items.where((element) => element.isFavorite).toList();
  }

  void removeProductFromFavouraites(Product product) {
    getFavouraitesOnly.removeWhere((element) => product.id == element.id);
  }

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https('alarmscontroller.firebaseio.com', '/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        Map<String, dynamic> productMap = jsonDecode(prodData);
        var product = Product.fromJson(productMap);
        loadedProducts.add(product);
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Product getProductById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  // void addProduct(Product product) {
  //   product.id = DateTime.now().toString();
  //   _items.add(product);
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) async {
    final url = Uri.https('alarmscontroller.firebaseio.com', '/products.json');
    try {
      String productJson = jsonEncode(product);
      final response = await http.post(
        url,
        body: json.encode(productJson),
      );
      product.id = json.decode(response.body)['name'];
      _items.add(product);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // void updateProduct(String id, Product newProduct) {
  //   final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     _items[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {
  //     print('...');
  //   }
  // }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          Uri.https('alarmscontroller.firebaseio.com', '/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  // void removeProductById(String id) {
  //   _items.removeWhere((prod) => prod.id == id);
  //   notifyListeners();
  // }

  Future<void> removeProductById(String id) async {
    final url =
        Uri.https('alarmscontroller.firebaseio.com', '/products/$id.json');
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      notifyListeners();
      throw HttpException('Could not delete product.');
    } else {
      final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
      var existingProduct = _items[existingProductIndex];
      _items.removeAt(existingProductIndex);
    }
  }
}
