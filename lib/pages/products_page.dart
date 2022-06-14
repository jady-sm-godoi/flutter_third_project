import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/components/app_drawer.dart';
import 'package:udemy_shop/components/product_item.dart';
import 'package:udemy_shop/models/product_list.dart';
import 'package:udemy_shop/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<ProductList>(
          context,
          listen: false,
        ).refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (context, i) => Column(
              children: [
                ProductItem(
                  product: products.items[i],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
