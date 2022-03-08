import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/models/product_list.dart';
import '../components/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

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
            onSelected: (FilterOptions value) => {
              if (value == FilterOptions.Favorite)
                {provider.showFavorite()}
              else
                {provider.showAll()}
            },
          )
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
