import 'package:flutter/material.dart';
import 'package:udemy_shop/components/product_item.dart';
import 'package:udemy_shop/data/dummy_data.dart';
import 'package:udemy_shop/models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> LoadedProducts = dummyProducts;

  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha loja',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: LoadedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) => ProductItem(
                product: LoadedProducts[i],
              )),
    );
  }
}
