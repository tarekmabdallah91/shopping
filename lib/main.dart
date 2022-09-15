import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/products.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/product_details_screen.dart';
import 'package:shopping/screens/products_overview_screen.dart';

import 'providers/orders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const appTitle = "Shopping App";

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // 3rd step using it and it's main func. 'create'
          create: (BuildContext context) => Products(),
        ),
        ChangeNotifierProvider(
          // 3rd step using it and it's main func. 'create'
          create: (BuildContext context) => Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
            ).copyWith(
              secondary: Colors.deepPurpleAccent,
            ),
            fontFamily: 'Lato'),
        initialRoute: '/',
        routes: {
          '/': (context) => ProductsOverviewScreen(),
          ProductDetailsScreen.route: (context) => const ProductDetailsScreen(),
          CartScreen.route:(context) => const CartScreen(),
        },
      ),
    );
  }
}
