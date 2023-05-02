import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';
import '../utils/palette.dart';


class ShowLoadingDialog extends StatelessWidget {
  const ShowLoadingDialog({Key? key, required this.message}) : super(key: key);
 final String message;
  static void show(BuildContext context,String message)=>showDialog(
      context: context,
      barrierDismissible: false, builder: (BuildContext context)=>  ShowLoadingDialog(message: message,));

@override
  Widget build(BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const CircularProgressIndicator(
                    color: Palette.greenDark,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 15,
                        color: context.theme.greyColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}

