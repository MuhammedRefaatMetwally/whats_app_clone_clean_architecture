import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/common/extension/custom_theme_extension.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/common/utils/page_const.dart';
import '../../widgets/global/custom_elevated_button.dart';
import '../registeration_screen/registeration_screen.dart';
import 'widgets/language_button.dart';
import 'widgets/privacy_and_terms.dart';

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
                child: Image.asset(
                  AppConst.welcomeCircleImage,
                  color: context.theme.circleImageColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
              child: Column(
                children: [
                   const Text(
                    AppConst.welcomeWhatsAppText,
                    style:  TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const PrivacyAndTerms(),
                  CustomElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, PageConst.registerScreen),
                    text: AppConst.agreeAndContinueText,
                  ),
                  const SizedBox(height: 50),
                  const LanguageButton(),
                ],
              ))
        ],
      ),
    );
  }
}
