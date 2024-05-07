import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class HeartBottonWidget extends StatefulWidget {
  const HeartBottonWidget({
    super.key,
    this.bkgColor = Colors.transparent,
    this.size = 20,
  });
  final Color bkgColor;
  final double size;
  @override
  State<HeartBottonWidget> createState() => _HeartBottonWidgetState();
}

class _HeartBottonWidgetState extends State<HeartBottonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.bkgColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {},
        style: IconButton.styleFrom(elevation: 10),
        icon: Icon(
          IconlyLight.heart,
          size: widget.size,
        ),
      ),
    );
  }
}
