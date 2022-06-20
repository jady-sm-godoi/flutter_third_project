//stateless widget way with FutureBuilder for manage the state...

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/components/app_drawer.dart';
import 'package:udemy_shop/components/order_card.dart';
import 'package:udemy_shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus pedidos'),
      ),
      body: RefreshIndicator(
        child: FutureBuilder(
          future: Provider.of<OrderList>(
            context,
            listen: false,
          ).loadOrders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.error != null) {
              return const Center(
                child: Text('Ocorreu um erro, tente novamente mais tarde!'),
              );
            } else {
              return Consumer<OrderList>(
                builder: (context, orders, child) => ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, i) => OrderCard(order: orders.items[i]),
                ),
              );
            }
          },
        ),
        onRefresh: () => Provider.of<OrderList>(
          context,
          listen: false,
        ).refreshOrders(context),
      ),
      drawer: const AppDrawer(),
    );
  }
}
