import 'package:flutter/material.dart';
import '../widgets/products_grid_view.dart';

enum MenuItemsValues {
  favouraitesOnly,
  allItems,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const route = '/ProductsOverviewScreen';

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  PopupMenuItem buildMenuItem(
      String title, MenuItemsValues value, Function onTap) {
    return PopupMenuItem(
      value: value,
      onTap: () => onTap,
      child: Text(title),
    );
  }

  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping app"),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => <PopupMenuItem>[
              buildMenuItem("Favouraites Only", MenuItemsValues.favouraitesOnly,
                  () => {}),
              buildMenuItem("All items", MenuItemsValues.allItems, () => {}),
            ],
            onSelected: (value) {
              setState(() {
                _showOnlyFavorites = value == MenuItemsValues.favouraitesOnly;
              });
            },
          )
        ],
      ),
      body: ProductsGridView(_showOnlyFavorites),
    );
  }
}
