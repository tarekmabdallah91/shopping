import 'package:flutter/material.dart';
import 'package:shopping/screens/product_details_screen.dart';
import 'package:shopping/screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const appTitle = "Shopping App";

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato'),
      initialRoute: '/',
      routes: {
        '/' : (context) => const ProductsOverviewScreen(),
        ProductDetailsScreen.route:(context) => const ProductDetailsScreen(),
      },
    );
  }
}
