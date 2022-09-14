import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/products.dart';
import 'package:shopping/widgets/product_item.dart';

class ProductsGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 4th step : to get the object instance of the provider like productsData
    final productsData = Provider.of<Products>(context);
    // 5th step : to get the data like productsList
    final productsList = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) => ChangeNotifierProvider( // 7th step
        create: (context) => productsList[index], // 8th step
        child: ProductItem(
          // product: productsList[index], 9th step 
        ),
      ),
      itemCount: productsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
