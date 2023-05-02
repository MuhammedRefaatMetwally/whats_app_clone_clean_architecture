import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../../common/utils/palette.dart';

class NewContactButtonWidget extends StatelessWidget {
  const NewContactButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration:  BoxDecoration(
                  color:  Palette.greenColor,
                  borderRadius: BorderRadius.all(Radius.circular(40.r))),
              child: const Icon(
                Icons.person_add,
                color: Colors.white,
              ),
            ),
             SizedBox(
              width: 14.w,
            ),
             Text(
              AppConst.newContact,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Icon(
          FontAwesomeIcons.qrcode,
          color:  Palette.greenColor,
        )
      ],
    );
  }
}
