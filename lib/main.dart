import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/models/auth.dart';
import 'package:udemy_shop/models/cart.dart';
import 'package:udemy_shop/models/order_list.dart';
import 'package:udemy_shop/models/product_list.dart';
import 'package:udemy_shop/pages/auth_or_home_page.dart';
import 'package:udemy_shop/pages/cart_page.dart';
import 'package:udemy_shop/pages/orders_page.dart';
import 'package:udemy_shop/pages/product_detail_page.dart';
import 'package:udemy_shop/pages/product_form_page.dart';
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
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (context, auth, previousProductList) {
            return ProductList(
              auth.userId ?? '',
              auth.token ?? '',
              previousProductList?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (context, auth, previousOrderList) {
            return OrderList(auth.token ?? '', auth.userId ?? '',
                previousOrderList?.items ?? []);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.deepPurple,
            tertiary: Colors.deepPurple[100],
            secondary: Colors.deepOrange,
            onPrimary: Colors.amber,
            onSecondary: Colors.green,
          ),
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => const OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
