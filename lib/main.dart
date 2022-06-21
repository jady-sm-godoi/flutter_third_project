import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/models/cart.dart';
import 'package:udemy_shop/models/order_list.dart';
import 'package:udemy_shop/models/product_list.dart';
import 'package:udemy_shop/pages/auth_page.dart';
import 'package:udemy_shop/pages/cart_page.dart';
import 'package:udemy_shop/pages/orders_page.dart';
import 'package:udemy_shop/pages/product_detail_page.dart';
import 'package:udemy_shop/pages/product_form_page.dart';
import 'package:udemy_shop/pages/products_overview_page.dart';
import 'package:udemy_shop/pages/products_page.dart';
import 'package:udemy_shop/utils/app_routes.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(fontFamily: 'Lato');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.deepPurple,
            primaryVariant: Colors.deepPurple[100],
            secondary: Colors.deepOrange,
            onPrimary: Colors.amber,
            onSecondary: Colors.green,
          ),
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.AUTH: (ctx) => const AuthPage(),
          AppRoutes.HOME: (ctx) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
