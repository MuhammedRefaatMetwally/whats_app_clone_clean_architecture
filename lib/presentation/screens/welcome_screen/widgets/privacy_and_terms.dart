import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
