import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:udemy_shop/exceptions/http_exception.dart';
import 'package:udemy_shop/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    _toggleFavorite();

    final response = await http.patch(
      Uri.parse('${Constants.PRODUCT_BASE_URL}/${id}.json'),
      body: jsonEncode({
        'isFavorite': isFavorite,
      }),
    );

    if (response.statusCode >= 400) {
      _toggleFavorite();
      notifyListeners();
      throw HttpException(
          msg: 'Não foi possível alterar o status do produto.',
          statusCode: response.statusCode);
    }
  }
}
