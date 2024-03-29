import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/components/app_drawer.dart';
import 'package:udemy_shop/components/badge.dart';
import 'package:udemy_shop/models/cart.dart';
import 'package:udemy_shop/models/product_list.dart';
import 'package:udemy_shop/utils/app_routes.dart';
import '../components/product_grid.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavorityOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

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
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(
                child: Text('apenas os favoritos'),
                value: FilterOptions.favorite,
              ),
              PopupMenuItem(
                child: Text('todos os produtos'),
                value: FilterOptions.all,
              )
            ],
            onSelected: (FilterOptions value) {
              setState(() {
                {
                  if (value == FilterOptions.favorite) {
                    _showFavorityOnly = true;
                  } else {
                    _showFavorityOnly = false;
                  }
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<ProductList>(
          context,
          listen: false,
        ).refreshProducts(context),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ProductGrid(
                showFavoriteOnly: _showFavorityOnly,
              ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
