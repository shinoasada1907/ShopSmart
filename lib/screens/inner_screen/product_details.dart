import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart/consts/app_constants.dart';
import 'package:shopsmart/widgets/app_name_text.dart';
import 'package:shopsmart/widgets/products/heart_btn.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';
import 'package:shopsmart/widgets/title_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/ProductDetailsScreen';
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.canPop(context) ? Navigator.pop(context) : null;
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: const AppNameTextWidget(
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: AppConstant.imageUrl,
              height: size.height * 0.38,
              width: double.infinity,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Title' * 18,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const SubtitleTextWidget(
                        label: '1500.00\$',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeartBottonWidget(
                          bkgColor: Colors.blue.shade100,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight - 10,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              icon:
                                  const Icon(Icons.add_shopping_cart_outlined),
                              label: const Text('Add to cart'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitlesTextWidget(label: 'About this item'),
                      SubtitleTextWidget(label: 'In Phone')
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SubtitleTextWidget(label: 'Description' * 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
