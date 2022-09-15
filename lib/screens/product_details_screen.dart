import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/products.dart';

import '../widgets/app_drawer.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const route = '/ProductDetailsScreen';

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<Products>(context).getProductById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //   Image.network(product.imageUrl, fit: BoxFit.cover),
            //   Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Text(
            //       product.description,
            //       style: Theme.of(context).textTheme.bodyText2,
            //     ),
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Text(
            //       product.price.toString(),
            //       style: Theme.of(context).textTheme.headline1,
            //     ),
            //   ),
            // ],
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontFamily: 'Anton',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
