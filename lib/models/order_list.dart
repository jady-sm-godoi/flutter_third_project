import 'dart:math';

import 'package:flutter/material.dart';
import 'package:udemy_shop/models/cart.dart';
import 'package:udemy_shop/models/order.dart';
import 'package:udemy_shop/models/product.dart';

class OrderList extends ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}