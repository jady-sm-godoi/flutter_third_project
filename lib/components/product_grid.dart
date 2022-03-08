import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/components/product_item.dart';
import 'package:udemy_shop/models/product.dart';
import 'package:udemy_shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> LoadedProducts =
        Provider.of<ProductList>(context).items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: LoadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: LoadedProducts[i],
              child: ProductItem(),
            ));
  }
}
