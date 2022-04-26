import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/models/cart.dart';
import 'package:udemy_shop/models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  const CartItemCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 5,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Tem certeza?'),
            content:
                const Text('Você quer tirar esse produto do seu carrinho?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Sim'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('Não'),
              )
            ],
          ),
        );
      },
      onDismissed: (_) => {
        Provider.of<Cart>(context, listen: false).removeItem(cartItem.productId)
      },
      child: Card(
        shadowColor: Theme.of(context).colorScheme.primary,
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 5,
        ),
        child: ListTile(
          title: Text(cartItem.name),
          subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
          trailing: Text('${cartItem.quantity} un.'),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FittedBox(child: Text('R\$ ${cartItem.price}')),
            ),
          ),
        ),
      ),
    );
  }
}
