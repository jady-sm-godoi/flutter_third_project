import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/models/product_list.dart';
import '../components/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewPage extends StatefulWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavorityOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha loja',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.menu),
              itemBuilder: (_) => const [
                    PopupMenuItem(
                      child: Text('apenas os favoritos'),
                      value: FilterOptions.Favorite,
                    ),
                    PopupMenuItem(
                      child: Text('todos os produtos'),
                      value: FilterOptions.All,
                    )
                  ],
              onSelected: (FilterOptions value) {
                setState(() {
                  {
                    if (value == FilterOptions.Favorite) {
                      _showFavorityOnly = true;
                    } else {
                      _showFavorityOnly = false;
                    }
                  }
                });
              })
        ],
      ),
      body: ProductGrid(
        showFavoriteOnly: _showFavorityOnly,
      ),
    );
  }
}
