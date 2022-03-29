import 'package:flutter/material.dart';
import 'package:udemy_shop/models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  const CartItemCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(cartItem.name);
  }
}
