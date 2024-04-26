import 'package:shopsmart/models/categories_model.dart';
import 'package:shopsmart/services/assets_manager.dart';

class AppConstant {
  static const String imageUrl =
      "https://i.pinimg.com/564x/b5/3a/95/b53a9533010db2ea5a3458ca1edf553c.jpg";
  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2
  ];
  static List<CategoriesModel> categoriesList = [
    CategoriesModel(
      id: 'Phones',
      image: AssetsManager.mobiles,
      name: 'Phones',
    ),
    CategoriesModel(
      id: 'PC',
      image: AssetsManager.pc,
      name: 'PC',
    ),
    CategoriesModel(
      id: 'Electronics',
      image: AssetsManager.electronics,
      name: 'Electronics',
    ),
    CategoriesModel(
      id: 'Watches',
      image: AssetsManager.watch,
      name: 'Watches',
    ),
    CategoriesModel(
      id: 'Clothes',
      image: AssetsManager.fashion,
      name: 'Clothes',
    ),
    CategoriesModel(
      id: 'Shoes',
      image: AssetsManager.shoes,
      name: 'Shoes',
    ),
    CategoriesModel(
      id: 'Books',
      image: AssetsManager.book,
      name: 'Books',
    ),
    CategoriesModel(
      id: 'Cosmetics',
      image: AssetsManager.cosmetics,
      name: 'Cosmetics',
    ),
  ];
}
