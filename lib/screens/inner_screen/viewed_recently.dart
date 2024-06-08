import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/viewed_recently_provider.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/services/my_app_function.dart';
import 'package:shopsmart/widgets/empty_bag.dart';
import 'package:shopsmart/widgets/products/product_widget.dart';
import 'package:shopsmart/widgets/title_text.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routeName = '/ViewedRecentlyScreen';
  const ViewedRecentlyScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final viewedProductProvider = Provider.of<ViewedProductProvider>(context);
    return viewedProductProvider.getViewedProduct.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.orderBag,
              title: 'No viewed products yet',
              subTitle:
                  'Look like your cart is empty add something and  make me happy',
              buttonText: 'Shop now',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              title: TitlesTextWidget(
                label:
                    'Viewed recently (${viewedProductProvider.getViewedProduct.length})',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppFunctions.showErrorOrWarningDialog(
                        context: context,
                        isError: false,
                        subTitle: 'Clear viewed recently',
                        fct: () {
                          viewedProductProvider.removeLocalViewedProduct();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productId: viewedProductProvider.getViewedProduct.values
                        .toList()[index]
                        .productId,
                  ),
                );
              },
              itemCount: viewedProductProvider.getViewedProduct.length,
              crossAxisCount: 2,
            ),
          );
  }
}
