import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';

import '../../../../../common/utils/app_const.dart';
import '../../../../../common/utils/palette.dart';
import '../../../../widgets/global/custom_icon_button.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);


  static show(BuildContext context) =>showModalBottomSheet(
      context: context,
      builder: (context) =>const BottomSheetWidget());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 32,
            decoration: BoxDecoration(
              color: context.theme.greyColor!.withOpacity(.4),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 24),
              CustomIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.close,
              ),
              const SizedBox(width: 8),
               const Text(
                AppConst.appLanguage,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(
            thickness: .4,
            color: context.theme.greyColor!.withOpacity(.4),
          ),
          RadioListTile(
            value: true,
            groupValue: true,
            onChanged: (value) {},
            activeColor: Palette.greenDark,
            title: const Text(AppConst.english),
            subtitle: Text(
              AppConst.phonesLanguage,
              style: TextStyle(
                color: context.theme.greyColor,
              ),
            ),
          ),
          RadioListTile(
            value: true,
            groupValue: false,
            onChanged: (value) {},
            activeColor: Palette.greenDark,
            title: const Text(AppConst.txt),
            subtitle: Text(
              AppConst.amharic,
              style: TextStyle(
                color: context.theme.greyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
