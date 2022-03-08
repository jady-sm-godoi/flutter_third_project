import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/models/product_list.dart';
import 'package:udemy_shop/pages/product_detail_page.dart';
import 'package:udemy_shop/pages/products_overview_page.dart';
import 'package:udemy_shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(fontFamily: 'Lato');
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.deepPurple,
            secondary: Colors.deepOrange,
            onPrimary: Colors.amber,
            onSecondary: Colors.green,
          ),
        ),
        home: ProductsOverviewPage(),
        routes: {AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage()},
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
