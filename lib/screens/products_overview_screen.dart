import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const route = '/ProductsOverviewScreen';

  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping app"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) => ProductItem(
          product: DummyData.dummyData[index],
        ),
        itemCount: DummyData.dummyData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
