import 'package:flutter/material.dart';
import '../widgets/products_grid_view.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const route = '/ProductsOverviewScreen';

  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping app"),
      ),
      body: ProductsGridView(),
    );
  }
}
