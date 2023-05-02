import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../../common/utils/palette.dart';
import 'language_button_widgets/show_bottom_sheett.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.langBgColor,
      borderRadius: BorderRadius.circular(24.r),
      child: InkWell(
        onTap: () => BottomSheetWidget.show(context),
        borderRadius: BorderRadius.circular(24.r),
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.theme.langHightlightColor,
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.0.h,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:  [
              const Icon(
                Icons.language,
                color: Palette.greenDark,
              ),
              SizedBox(width: 8.w),
              const Text(
                AppConst.english,
                style: TextStyle(
                  color: Palette.greenDark,
                ),
              ),
              SizedBox(width: 8.w),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Palette.greenDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
