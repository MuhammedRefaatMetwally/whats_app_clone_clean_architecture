import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';
import '../../../../../common/utils/app_const.dart';
import '../../../../../common/utils/palette.dart';
import '../../global/custom_icon_button.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);


  static show(BuildContext context) =>showModalBottomSheet(
      context: context,
      builder: (context) =>const BottomSheetWidget());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.h,
            width: 32.w,
            decoration: BoxDecoration(
              color: context.theme.greyColor!.withOpacity(.4),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
           SizedBox(height: 24.h),
          Row(
            children: [
               SizedBox(width: 24.w),
              CustomIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.close,
              ),
               SizedBox(width: 8.w),
                Text(
                AppConst.appLanguage,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
           SizedBox(height: 8.h),
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
