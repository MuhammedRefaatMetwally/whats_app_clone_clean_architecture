import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';

 showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Alert!"),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.theme.greyColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 24,bottom: 24),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              btnText ?? "OK",
              style: TextStyle(
                color: context.theme.circleImageColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
