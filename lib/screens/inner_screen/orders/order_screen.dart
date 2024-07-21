import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/models/order_model.dart';
import 'package:shopsmart/providers/order_provider.dart';
import 'package:shopsmart/screens/inner_screen/orders/order_widget.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/widgets/empty_bag.dart';
import 'package:shopsmart/widgets/title_text.dart';

class OrdersScreenFree extends StatelessWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({super.key});

  final bool isEmptyOrders = true;

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderProvicer>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(
          label: 'Placed orders',
        ),
      ),
      body: FutureBuilder<List<OrdersModelAdvanced>>(
        future: ordersProvider.fetchOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: SelectableText(
                snapshot.error.toString(),
              ),
            );
          } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
            return EmptyBagWidget(
                imagePath: AssetsManager.orderBag,
                title: 'No orders has been placed yet',
                subTitle: '',
                buttonText: 'Shop now');
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: OrdersWidgetFree(
                  ordersModelAdvanced: ordersProvider.getOrders[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                  // thickness: 8,
                  // color: Colors.red,
                  );
            },
          );
        },
      ),
    );
  }
}
