import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const route = '/CartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  'Total: ',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                Spacer(),
                Consumer<Cart>(
                  builder: (_, cart, child) => Text('\$${cart.totalPrice}'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Order now!'),
                )
              ],
            )),
      ),
    );
  }
}
