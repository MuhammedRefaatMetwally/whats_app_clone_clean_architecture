import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/common/utils/page_const.dart';
import '../../widgets/global/custom_elevated_button.dart';
import '../../widgets/welcome_widgets/language_button.dart';
import '../../widgets/welcome_widgets/privacy_and_terms.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: 50.w,
                  vertical: 10.h,
                ),
                child: Image.asset(
                  AppConst.welcomeCircleImage,
                  color: context.theme.circleImageColor,
                ),
              ),
            ),
          ),
           SizedBox(height: 40.h),
          Expanded(
              child: Column(
                children: [
                    Text(
                    AppConst.welcomeWhatsAppText,
                    style:  TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const PrivacyAndTerms(),
                  CustomElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, PageConst.registerScreen),
                    text: AppConst.agreeAndContinueText,
                  ),
                   SizedBox(height: 50.h),
                  const LanguageButton(),
                ],
              ))
        ],
      ),
    );
  }
}
