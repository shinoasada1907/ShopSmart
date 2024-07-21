import 'package:flutter/material.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';

class MyAppFunctions {
  static Future<void> showErrorOrWarningDialog({
    required BuildContext context,
    required String subTitle,
    required Function fct,
    bool isError = true,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                isError ? AssetsManager.error : AssetsManager.warning,
                height: 60,
                width: 60,
              ),
              const SizedBox(
                height: 16,
              ),
              SubtitleTextWidget(
                label: subTitle,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: !isError,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const SubtitleTextWidget(
                        label: 'Cancel',
                        color: Colors.green,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fct();
                      Navigator.pop(context);
                    },
                    child: const SubtitleTextWidget(
                      label: 'OK',
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static Future<void> imagePickerDialog(
      {required BuildContext context,
      required Function cameraFct,
      required Function galleryFct,
      required Function removeFct}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const SubtitleTextWidget(label: 'Choose option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: () {
                    cameraFct();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'),
                ),
                TextButton.icon(
                  onPressed: () {
                    galleryFct();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery'),
                ),
                TextButton.icon(
                  onPressed: () {
                    removeFct();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                  label: const Text('Remove'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
