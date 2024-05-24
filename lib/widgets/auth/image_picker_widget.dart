import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget(
      {super.key, required this.pickedImage, required this.function});

  final XFile? pickedImage;
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              18.0,
            ),
            child: pickedImage == null
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(
                        18.0,
                      ),
                    ),
                  )
                : Image.file(
                    File(
                      pickedImage!.path,
                    ),
                  ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.lightBlue,
            child: InkWell(
              onTap: () {
                function!();
              },
              splashColor: Colors.red,
              borderRadius: BorderRadius.circular(12.0),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  Icons.add_shopping_cart_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
