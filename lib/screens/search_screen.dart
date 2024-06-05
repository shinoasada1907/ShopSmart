import 'dart:developer';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/models/product_model.dart';
import 'package:shopsmart/providers/products_provider.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/widgets/products/product_widget.dart';
import 'package:shopsmart/widgets/title_text.dart';

class SearchScreen extends StatefulWidget {
  static const routName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;
  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> listProductSearch = [];

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? category = ModalRoute.of(context)!.settings.arguments as String?;
    // ignore: unnecessary_null_comparison
    List<ProductModel> productList = category == null
        ? productsProvider.getProducts
        : productsProvider.findByCategory(categoryName: category);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.shoppingCart),
            ),
            title: TitlesTextWidget(
              label: category ?? 'Search Products',
            ),
          ),
          body: productList.isEmpty
              ? const Center(
                  child: TitlesTextWidget(label: 'No product found'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchTextController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                // setState(() {

                                // });
                                FocusScope.of(context).unfocus();
                                searchTextController.clear();
                              },
                              child: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            log('Value of the text is $value');
                            setState(() {
                              listProductSearch = productsProvider.seachProduct(
                                  searchText: value,
                                  passListProduct: productList);
                            });
                          },
                          onSubmitted: (value) {
                            log('Value of the text is $value');
                            log('Value of the controller text: ${searchTextController.text}');
                            setState(() {
                              listProductSearch = productsProvider.seachProduct(
                                  searchText: value,
                                  passListProduct: productList);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      if (searchTextController.text.isNotEmpty &&
                          listProductSearch.isEmpty) ...[
                        const TitlesTextWidget(label: 'No products found'),
                      ],
                      Expanded(
                        child: DynamicHeightGridView(
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          builder: (context, index) {
                            return ProductWidget(
                              productId: searchTextController.text.isNotEmpty
                                  ? listProductSearch[index].productId
                                  : productList[index].productId,
                            );
                          },
                          itemCount: searchTextController.text.isNotEmpty
                              ? listProductSearch.length
                              : productList.length,
                          crossAxisCount: 2,
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
