import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/models/auth.dart';
import 'package:udemy_shop/pages/auth_page.dart';

import 'products_overview_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth _auth = Provider.of(context);
    return _auth.isAuth ? const ProductsOverviewPage() : const AuthPage();
  }
}
