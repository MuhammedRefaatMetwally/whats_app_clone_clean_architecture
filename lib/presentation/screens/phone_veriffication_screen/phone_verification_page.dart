import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../common/utils/palette.dart';
import '../../widgets/phone_verificaion_widgets/pin_code_widget.dart';

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  <Widget>[
                const Text(AppConst.emptyText),
                Text(
                  AppConst.verifyPhoneNumber,
                  style: TextStyle(
                      fontSize: 18.sp,
                      color:  Palette.greenColor,
                      fontWeight: FontWeight.w500),
                ),
                const Icon(Icons.more_vert)
              ],
            ),
             SizedBox(
              height: 32.h,
            ),
             Text(
              AppConst.whatsDescription,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
             PinCodeWidget(),
          ],
        ),
      ),
    );
  }

}
