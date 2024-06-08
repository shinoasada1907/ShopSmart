import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/wishlist_provider.dart';

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
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: widget.bkgColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          wishlistProvider.addOrRemoveFromWishlist(productId: widget.productId);
        },
        style: IconButton.styleFrom(elevation: 10),
        icon: Icon(
          wishlistProvider.isProductInWishlist(productId: widget.productId)
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: widget.size,
          color:
              wishlistProvider.isProductInWishlist(productId: widget.productId)
                  ? Colors.red
                  : Colors.grey,
        ),
      ),
    );
  }
}
