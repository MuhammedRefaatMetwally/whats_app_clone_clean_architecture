import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: AppConst.readOurText,
          style: TextStyle(
            color: context.theme.greyColor,
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: AppConst.privacyPolicy,
              style: TextStyle(
                color: context.theme.blueColor,
              ),
            ),
            const TextSpan(text: AppConst.tapAgreeAndContinue),
            TextSpan(
              text: AppConst.termOfServices,
              style: TextStyle(
                color: context.theme.blueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
