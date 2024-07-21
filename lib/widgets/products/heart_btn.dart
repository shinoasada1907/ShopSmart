import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/wishlist_provider.dart';
import 'package:shopsmart/services/my_app_function.dart';

class HeartBottonWidget extends StatefulWidget {
  const HeartBottonWidget({
    super.key,
    this.bkgColor = Colors.transparent,
    this.size = 20,
    required this.productId,
    // this.isInWishlist = false,
  });
  final Color bkgColor;
  final double size;
  final String productId;
  // final bool? isInWishlist;
  @override
  State<HeartBottonWidget> createState() => _HeartBottonWidgetState();
}

class _HeartBottonWidgetState extends State<HeartBottonWidget> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: widget.bkgColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          try {
            // wishlistsProvider.addOrRemoveFromWishlist(
            //   productId: widget.productId,
            // );
            if (wishlistProvider.getWishlists.containsKey(widget.productId)) {
              await wishlistProvider.removeWishlistItemFromFirestore(
                wishlistId:
                    wishlistProvider.getWishlists[widget.productId]!.wishlistId,
                productId: widget.productId,
              );
            } else {
              await wishlistProvider.addToWishlistFirebase(
                productId: widget.productId,
                context: context,
              );
            }
            await wishlistProvider.fetchWishlist();
          } catch (e) {
            await MyAppFunctions.showErrorOrWarningDialog(
              context: context,
              subTitle: e.toString(),
              fct: () {},
            );
          } finally {
            setState(() {
              _isLoading = false;
            });
          }
        },
        style: IconButton.styleFrom(elevation: 10),
        icon: _isLoading
            ? const CircularProgressIndicator()
            : Icon(
                wishlistProvider.isProductInWishlist(
                        productId: widget.productId)
                    ? IconlyBold.heart
                    : IconlyLight.heart,
                size: widget.size,
                color: wishlistProvider.isProductInWishlist(
                        productId: widget.productId)
                    ? Colors.red
                    : Colors.grey,
              ),
      ),
    );
  }
}
