import 'dart:developer';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/widgets/products/product_widget.dart';
import 'package:shopsmart/widgets/title_text.dart';

class SearchScreen extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
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
            title: const TitlesTextWidget(
              label: 'Search Products',
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
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
                  },
                  onSubmitted: (value) {
                    log('Value of the text is $value');
                    log('Value of the controller text: ${searchTextController.text}');
                  },
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: DynamicHeightGridView(
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  builder: (context, index) {
                    return const ProductWidget();
                  },
                  itemCount: 200,
                  crossAxisCount: 2,
                ),
              ),
            ],
          )),
    );
  }
}
