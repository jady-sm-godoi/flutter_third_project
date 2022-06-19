import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop/components/app_drawer.dart';
import 'package:udemy_shop/components/order_card.dart';
import 'package:udemy_shop/models/order_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders().then((value) {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus pedidos'),
      ),
      body: RefreshIndicator(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, i) => OrderCard(order: orders.items[i]),
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
