import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/presentation/pages/phone_veriffication_page/widgets/pin_code_widget.dart';

import '../../../common/utils/palette.dart';

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(AppConst.emptyText),
                Text(
                  AppConst.verifyPhoneNumber,
                  style: TextStyle(
                      fontSize: 18,
                      color:  Palette.greenColor,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.more_vert)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              AppConst.whatsDescription,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
             PinCodeWidget(),
          ],
        ),
      ),
    );
  }

}
