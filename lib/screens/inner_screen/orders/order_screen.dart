import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(
          label: 'Placed orders',
        ),
      ),
      body: isEmptyOrders
          ? EmptyBagWidget(
              imagePath: AssetsManager.orderBag,
              title: "No orders has been placed yet",
              subTitle: "",
              buttonText: "Shop now",
            )
          : ListView.separated(
              itemCount: 15,
              itemBuilder: (ctx, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrdersWidgetFree(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                    // thickness: 8,
                    // color: Colors.red,
                    );
              },
            ),
    );
  }
}
